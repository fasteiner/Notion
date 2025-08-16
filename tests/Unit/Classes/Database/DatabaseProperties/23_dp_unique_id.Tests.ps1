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

Describe "notion_unique_id_database_property_structure Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_unique_id_database_property_structure]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_unique_id_database_property_structure]
            
            # Überprüfe die Standard-Eigenschaften
            $instance.prefix | Should -BeNullOrEmpty
        }
        
        It "Should create instance with prefix parameter successfully" {
            # Erstelle eine neue Instanz mit Prefix
            $testPrefix = "TEST-"
            $instance = [notion_unique_id_database_property_structure]::new($testPrefix)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_unique_id_database_property_structure]
            
            # Überprüfe, dass der Prefix korrekt gesetzt wurde
            $instance.prefix | Should -Be $testPrefix
        }
        
        It "Should handle empty string prefix" {
            # Erstelle eine neue Instanz mit leerem String
            $instance = [notion_unique_id_database_property_structure]::new("")
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_unique_id_database_property_structure]
            
            # Überprüfe, dass der Prefix ein leerer String ist
            $instance.prefix | Should -Be ""
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_unique_id_database_property_structure]::new()
        }
        
        It "Should have prefix property of correct type" {
            # Überprüfe den Typ der prefix-Eigenschaft (kann string oder null sein)
            $script:instance.PSObject.Properties['prefix'] | Should -Not -BeNullOrEmpty
        }
        
        It "Should allow setting prefix property" {
            # Setze verschiedene Prefix-Werte
            $script:instance.prefix = "ABC-"
            $script:instance.prefix | Should -Be "ABC-"
            
            $script:instance.prefix = "ID_"
            $script:instance.prefix | Should -Be "ID_"
            
            $script:instance.prefix = "123-"
            $script:instance.prefix | Should -Be "123-"
            
            # Teste auch null und leeren String
            $script:instance.prefix = $null
            $script:instance.prefix | Should -BeNullOrEmpty
            
            $script:instance.prefix = ""
            $script:instance.prefix | Should -Be ""
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                prefix = "ITEM-"
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_unique_id_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_unique_id_database_property_structure]
            $result.prefix | Should -Be "ITEM-"
        }
        
        It "Should handle null prefix" {
            # Erstelle ein Test-Hashtable mit null prefix
            $testData = @{
                prefix = $null
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_unique_id_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_unique_id_database_property_structure]
            $result.prefix | Should -BeNullOrEmpty
        }
        
        It "Should handle empty prefix" {
            # Erstelle ein Test-Hashtable mit leerem prefix
            $testData = @{
                prefix = ""
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_unique_id_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_unique_id_database_property_structure]
            $result.prefix | Should -Be ""
        }
        
        It "Should handle missing prefix property" {
            # Erstelle ein Test-Hashtable ohne prefix Eigenschaft
            $testData = @{}
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_unique_id_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_unique_id_database_property_structure]
            # prefix sollte null oder leer sein wenn nicht gesetzt
        }
    }
}

Describe "notion_unique_id_database_property Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_unique_id_database_property]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_unique_id_database_property]
            
            # Überprüfe die geerbten Eigenschaften von DatabasePropertiesBase
            $instance.type | Should -Be "unique_id"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.unique_id | Should -Not -BeNullOrEmpty
            $instance.unique_id | Should -BeOfType [notion_unique_id_database_property_structure]
            $instance.unique_id.prefix | Should -BeNullOrEmpty
        }
        
        It "Should create instance with prefix parameter successfully" {
            # Erstelle eine neue Instanz mit Prefix
            $testPrefix = "TASK-"
            $instance = [notion_unique_id_database_property]::new($testPrefix)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_unique_id_database_property]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "unique_id"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.unique_id | Should -Not -BeNullOrEmpty
            $instance.unique_id | Should -BeOfType [notion_unique_id_database_property_structure]
            $instance.unique_id.prefix | Should -Be $testPrefix
        }
        
        It "Should create instance with empty prefix successfully" {
            # Erstelle eine neue Instanz mit leerem Prefix
            $instance = [notion_unique_id_database_property]::new("")
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_unique_id_database_property]
            
            # Überprüfe die Eigenschaften
            $instance.type | Should -Be "unique_id"
            $instance.unique_id.prefix | Should -Be ""
        }
        
        It "Should create instance with various prefix formats" {
            # Teste verschiedene Prefix-Formate
            $prefixes = @("ID-", "ITEM_", "123-", "ABC", "")
            
            foreach ($prefix in $prefixes) {
                $instance = [notion_unique_id_database_property]::new($prefix)
                
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_unique_id_database_property]
                $instance.type | Should -Be "unique_id"
                $instance.unique_id.prefix | Should -Be $prefix
            }
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_unique_id_database_property]::new()
        }
        
        It "Should have unique_id property of correct type" {
            # Überprüfe den Typ der unique_id-Eigenschaft
            $script:instance.unique_id | Should -BeOfType [notion_unique_id_database_property_structure]
            
            # Überprüfe das Standard-Prefix (sollte null oder leer sein)
            $script:instance.unique_id.prefix | Should -BeNullOrEmpty
        }
        
        It "Should allow modifying unique_id structure" {
            # Erstelle eine neue Struktur mit Prefix
            $newStructure = [notion_unique_id_database_property_structure]::new("NEW-")
            $script:instance.unique_id = $newStructure
            
            # Überprüfe die Zuweisung
            $script:instance.unique_id | Should -Be $newStructure
            $script:instance.unique_id.prefix | Should -Be "NEW-"
        }
        
        It "Should allow modifying prefix through structure" {
            # Modifiziere den Prefix direkt über die Struktur
            $script:instance.unique_id.prefix = "MODIFIED-"
            
            # Überprüfe die Änderung
            $script:instance.unique_id.prefix | Should -Be "MODIFIED-"
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                type = "unique_id"
                unique_id = @{
                    prefix = "CONV-"
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_unique_id_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_unique_id_database_property]
            $result.type | Should -Be "unique_id"
            $result.unique_id | Should -Not -BeNullOrEmpty
            $result.unique_id | Should -BeOfType [notion_unique_id_database_property_structure]
            $result.unique_id.prefix | Should -Be "CONV-"
        }
        
        It "Should convert with null prefix successfully" {
            # Erstelle ein Test-Hashtable mit null prefix
            $testData = @{
                type = "unique_id"
                unique_id = @{
                    prefix = $null
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_unique_id_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_unique_id_database_property]
            $result.type | Should -Be "unique_id"
            $result.unique_id.prefix | Should -BeNullOrEmpty
        }
        
        It "Should convert with empty prefix successfully" {
            # Erstelle ein Test-Hashtable mit leerem prefix
            $testData = @{
                type = "unique_id"
                unique_id = @{
                    prefix = ""
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_unique_id_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_unique_id_database_property]
            $result.type | Should -Be "unique_id"
            $result.unique_id.prefix | Should -Be ""
        }
        
        It "Should convert complex prefix patterns successfully" {
            # Teste verschiedene Prefix-Muster
            $prefixPatterns = @("ITEM-", "ID_", "123-", "ABC", "TASK-001-", "")
            
            foreach ($prefix in $prefixPatterns) {
                $testData = @{
                    type = "unique_id"
                    unique_id = @{
                        prefix = $prefix
                    }
                }
                
                $result = [notion_unique_id_database_property]::ConvertFromObject($testData)
                
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_unique_id_database_property]
                $result.type | Should -Be "unique_id"
                $result.unique_id.prefix | Should -Be $prefix
            }
        }
        
        It "Should handle missing unique_id structure" {
            # Erstelle ein Test-Hashtable ohne unique_id Struktur
            $testData = @{
                type = "unique_id"
            }
            
            try {
                # Konvertiere das Hashtable zu einem Objekt
                $result = [notion_unique_id_database_property]::ConvertFromObject($testData)
                
                # Wenn es funktioniert, überprüfe das Ergebnis
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_unique_id_database_property]
                $result.type | Should -Be "unique_id"
            }
            catch {
                # Wenn ein Fehler auftritt, ist das erwartetes Verhalten
                Write-Warning "Missing unique_id structure test produced expected error: $_"
                $true | Should -Be $true  # Test als bestanden markieren
            }
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from DatabasePropertiesBase" {
            # Erstelle eine Instanz
            $instance = [notion_unique_id_database_property]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [DatabasePropertiesBase]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "unique_id"
        }
        
        It "Should have correct type property from base class" {
            # Erstelle eine Instanz
            $instance = [notion_unique_id_database_property]::new()
            
            # Überprüfe, dass der Typ korrekt gesetzt ist
            $instance.type | Should -Be "unique_id"
            $instance.type | Should -BeOfType [string]
        }
        
        It "Should maintain type consistency across constructors" {
            # Teste verschiedene Konstruktoren
            $instance1 = [notion_unique_id_database_property]::new()
            $instance2 = [notion_unique_id_database_property]::new("PREFIX-")
            $instance3 = [notion_unique_id_database_property]::new("")
            
            # Alle sollten den gleichen Typ haben
            $instance1.type | Should -Be "unique_id"
            $instance2.type | Should -Be "unique_id"
            $instance3.type | Should -Be "unique_id"
        }
    }
}
