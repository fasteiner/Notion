# Import the module containing the notion_last_edited_time_database_property class
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    # Get the project path by going up 4 levels from the test file
    $projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Remove any previously loaded module to ensure clean test
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    # Import the module under test
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "notion_relation_database_property_structure Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_relation_database_property_structure]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property_structure]
            
            # Überprüfe die Standard-Eigenschaften
            $instance.database_id | Should -BeNullOrEmpty
            $instance.synced_property_id | Should -BeNullOrEmpty
            $instance.synced_property_name | Should -BeNullOrEmpty
        }
        
        It "Should create instance with database_id successfully" {
            # Erstelle eine neue Instanz mit database_id
            $testDatabaseId = "test-database-id-123"
            $instance = [notion_relation_database_property_structure]::new($testDatabaseId)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property_structure]
            
            # Überprüfe die Eigenschaften
            $instance.database_id | Should -Be $testDatabaseId
            $instance.synced_property_id | Should -BeNullOrEmpty
            $instance.synced_property_name | Should -BeNullOrEmpty
        }
        
        It "Should create instance with all parameters successfully" {
            # Erstelle eine neue Instanz mit allen Parametern
            $testDatabaseId = "test-database-id-456"
            $testSyncedPropertyId = "test-synced-property-id-789"
            $testSyncedPropertyName = "Test Synced Property"
            
            $instance = [notion_relation_database_property_structure]::new($testDatabaseId, $testSyncedPropertyId, $testSyncedPropertyName)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property_structure]
            
            # Überprüfe alle Eigenschaften
            $instance.database_id | Should -Be $testDatabaseId
            $instance.synced_property_id | Should -Be $testSyncedPropertyId
            $instance.synced_property_name | Should -Be $testSyncedPropertyName
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_relation_database_property_structure]::new()
        }
        
        It "Should have properties of correct types" {
            # Überprüfe die Eigenschaftstypen
            $script:instance.database_id | Should -BeOfType [object]  # kann string oder null sein
            $script:instance.synced_property_id | Should -BeOfType [object]  # kann string oder null sein
            $script:instance.synced_property_name | Should -BeOfType [object]  # kann string oder null sein
        }
        
        It "Should allow setting properties" {
            # Setze die Eigenschaften
            $script:instance.database_id = "new-database-id"
            $script:instance.synced_property_id = "new-synced-id"
            $script:instance.synced_property_name = "New Synced Name"
            
            # Überprüfe die gesetzten Werte
            $script:instance.database_id | Should -Be "new-database-id"
            $script:instance.synced_property_id | Should -Be "new-synced-id"
            $script:instance.synced_property_name | Should -Be "New Synced Name"
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                id = "test-database-id"
                synced_property_id = "test-synced-id"
                synced_property_name = "Test Synced Property"
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_relation_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_relation_database_property_structure]
            $result.database_id | Should -Be "test-database-id"
            $result.synced_property_id | Should -Be "test-synced-id"
            $result.synced_property_name | Should -Be "Test Synced Property"
        }
        
        It "Should handle missing optional properties" {
            # Erstelle ein Test-Hashtable mit nur der ID
            $testData = @{
                id = "test-database-id-only"
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_relation_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_relation_database_property_structure]
            $result.database_id | Should -Be "test-database-id-only"
            # Die anderen Eigenschaften könnten null oder leer sein
        }
    }
}

Describe "notion_database_relation_base Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create instance with type successfully" {
            # Erstelle eine neue Instanz mit Typ
            $instance = [notion_database_relation_base]::new("single_property")
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_relation_base]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "single_property"
            $instance.database_id | Should -BeNullOrEmpty
        }
        
        It "Should create instance with database_id and type successfully" {
            # Erstelle eine neue Instanz mit database_id und Typ
            $testDatabaseId = "test-database-id"
            $instance = [notion_database_relation_base]::new($testDatabaseId, "dual_property")
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_relation_base]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "dual_property"
            $instance.database_id | Should -Be $testDatabaseId
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert single_property type successfully" {
            # Erstelle ein Test-Hashtable für single_property
            $testData = @{
                database_id = "test-db-id"
                type = "single_property"
                single_property = @{
                    id = "test-single-id"
                    synced_property_id = "test-synced-id"
                    synced_property_name = "Test Single Property"
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_database_relation_base]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_database_single_relation]
            $result.type | Should -Be "single_property"
            $result.database_id | Should -Be "test-db-id"
        }
        
        It "Should convert dual_property type successfully" {
            # Erstelle ein Test-Hashtable für dual_property
            $testData = @{
                database_id = "test-db-id-dual"
                type = "dual_property"
                dual_property = @{
                    id = "test-dual-id"
                    synced_property_id = "test-synced-id-dual"
                    synced_property_name = "Test Dual Property"
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_database_relation_base]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_database_dual_relation]
            $result.type | Should -Be "dual_property"
            $result.database_id | Should -Be "test-db-id-dual"
        }
    }
}

Describe "notion_database_single_relation Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_database_single_relation]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_single_relation]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "single_property"
            $instance.database_id | Should -BeNullOrEmpty
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.single_property | Should -Not -BeNullOrEmpty
            $instance.single_property | Should -BeOfType [notion_relation_database_property_structure]
        }
        
        It "Should create instance with structure parameter successfully" {
            # Erstelle eine Relation-Struktur
            $relationStructure = [notion_relation_database_property_structure]::new("test-db-id", "test-sync-id", "Test Sync Name")
            
            # Erstelle eine neue Instanz mit der Struktur
            $instance = [notion_database_single_relation]::new($relationStructure)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_single_relation]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "single_property"
            $instance.single_property | Should -Be $relationStructure
        }
        
        It "Should create instance with all parameters successfully" {
            # Erstelle eine neue Instanz mit allen Parametern
            $testDatabaseId = "test-database-id"
            $testSyncedPropertyId = "test-synced-id"
            $testSyncedPropertyName = "Test Synced Property"
            
            $instance = [notion_database_single_relation]::new($testDatabaseId, $testSyncedPropertyId, $testSyncedPropertyName)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_single_relation]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "single_property"
            $instance.database_id | Should -Be $testDatabaseId
            $instance.single_property | Should -Not -BeNullOrEmpty
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from notion_database_relation_base" {
            # Erstelle eine Instanz
            $instance = [notion_database_single_relation]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [notion_database_relation_base]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "single_property"
        }
    }
}

Describe "notion_database_dual_relation Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_database_dual_relation]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_dual_relation]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "dual_property"
            $instance.database_id | Should -BeNullOrEmpty
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.dual_property | Should -Not -BeNullOrEmpty
            $instance.dual_property | Should -BeOfType [notion_relation_database_property_structure]
        }
        
        It "Should create instance with structure parameter successfully" {
            # Erstelle eine Relation-Struktur
            $relationStructure = [notion_relation_database_property_structure]::new("test-db-id", "test-sync-id", "Test Sync Name")
            
            # Erstelle eine neue Instanz mit der Struktur
            $instance = [notion_database_dual_relation]::new($relationStructure)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_dual_relation]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "dual_property"
            $instance.dual_property | Should -Be $relationStructure
        }
        
        It "Should create instance with all parameters successfully" {
            # Erstelle eine neue Instanz mit allen Parametern
            $testDatabaseId = "test-database-id-dual"
            $testSyncedPropertyId = "test-synced-id-dual"
            $testSyncedPropertyName = "Test Synced Property Dual"
            
            $instance = [notion_database_dual_relation]::new($testDatabaseId, $testSyncedPropertyId, $testSyncedPropertyName)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_database_dual_relation]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "dual_property"
            $instance.database_id | Should -Be $testDatabaseId
            $instance.dual_property | Should -Not -BeNullOrEmpty
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from notion_database_relation_base" {
            # Erstelle eine Instanz
            $instance = [notion_database_dual_relation]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [notion_database_relation_base]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "dual_property"
        }
    }
}

Describe "notion_relation_database_property Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_relation_database_property]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property]
            
            # Überprüfe die geerbten Eigenschaften von DatabasePropertiesBase
            $instance.type | Should -Be "relation"
        }
        
        It "Should create instance with null relation successfully" {
            # Erstelle eine neue Instanz mit null
            $instance = [notion_relation_database_property]::new($null)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "relation"
            $instance.relation | Should -BeNullOrEmpty
        }
        
        It "Should create instance with relation object successfully" {
            # Erstelle eine Relation
            $relation = [notion_database_single_relation]::new()
            
            # Erstelle eine neue Instanz mit der Relation
            $instance = [notion_relation_database_property]::new($relation)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "relation"
            $instance.relation | Should -Be $relation
        }
        
        It "Should create single_property relation instance successfully" {
            # Erstelle eine neue Instanz für single_property
            $testDatabaseId = "test-database-id"
            $testSyncedPropertyId = "test-synced-id"
            $testSyncedPropertyName = "Test Synced Property"
            
            $instance = [notion_relation_database_property]::new($testDatabaseId, "single_property", $testSyncedPropertyId, $testSyncedPropertyName)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "relation"
            $instance.relation | Should -Not -BeNullOrEmpty
            $instance.relation | Should -BeOfType [notion_database_single_relation]
            $instance.relation.type | Should -Be "single_property"
        }
        
        It "Should create dual_property relation instance successfully" {
            # Erstelle eine neue Instanz für dual_property
            $testDatabaseId = "test-database-id-dual"
            $testSyncedPropertyId = "test-synced-id-dual"
            $testSyncedPropertyName = "Test Synced Property Dual"
            
            $instance = [notion_relation_database_property]::new($testDatabaseId, "dual_property", $testSyncedPropertyId, $testSyncedPropertyName)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_relation_database_property]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "relation"
            $instance.relation | Should -Not -BeNullOrEmpty
            $instance.relation | Should -BeOfType [notion_database_dual_relation]
            $instance.relation.type | Should -Be "dual_property"
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_relation_database_property]::new()
        }
        
        It "Should have relation property that can be set" {
            # Erstelle eine Relation und setze sie
            $relation = [notion_database_single_relation]::new()
            $script:instance.relation = $relation
            
            # Überprüfe die Zuweisung
            $script:instance.relation | Should -Be $relation
            $script:instance.relation | Should -BeOfType [notion_database_single_relation]
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert single_property relation successfully" {
            # Erstelle ein Test-Hashtable für single_property relation
            $testData = @{
                type = "relation"
                relation = @{
                    database_id = "test-db-id"
                    type = "single_property"
                    single_property = @{
                        id = "test-single-id"
                        synced_property_id = "test-synced-id"
                        synced_property_name = "Test Single Property"
                    }
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_relation_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_database_single_relation]  # Note: ConvertFromObject returns relation object directly
        }
        
        It "Should convert dual_property relation successfully" {
            # Erstelle ein Test-Hashtable für dual_property relation
            $testData = @{
                type = "relation"
                relation = @{
                    database_id = "test-db-id-dual"
                    type = "dual_property"
                    dual_property = @{
                        id = "test-dual-id"
                        synced_property_id = "test-synced-id-dual"
                        synced_property_name = "Test Dual Property"
                    }
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_relation_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_database_dual_relation]  # Note: ConvertFromObject returns relation object directly
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from DatabasePropertiesBase" {
            # Erstelle eine Instanz
            $instance = [notion_relation_database_property]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [DatabasePropertiesBase]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "relation"
        }
        
        It "Should have correct type property from base class" {
            # Erstelle eine Instanz
            $instance = [notion_relation_database_property]::new()
            
            # Überprüfe, dass der Typ korrekt gesetzt ist
            $instance.type | Should -Be "relation"
            $instance.type | Should -BeOfType [string]
        }
    }
}
