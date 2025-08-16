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

Describe "notion_status_group Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_status_group]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_status_group]
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_status_group]::new()
        }
        
        It "Should have properties of correct types" {
            # Überprüfe die Eigenschaftstypen (alle können null sein)
            # id, name, color sind strings, option_ids ist string array
            $script:instance.PSObject.Properties['id'] | Should -Not -BeNullOrEmpty
            $script:instance.PSObject.Properties['name'] | Should -Not -BeNullOrEmpty
            $script:instance.PSObject.Properties['color'] | Should -Not -BeNullOrEmpty
            $script:instance.PSObject.Properties['option_ids'] | Should -Not -BeNullOrEmpty
        }
        
        It "Should allow setting properties" {
            # Setze alle Eigenschaften
            $script:instance.id = "test-group-id"
            $script:instance.name = "Test Group"
            $script:instance.color = "blue"
            $script:instance.option_ids = @("option1", "option2", "option3")
            
            # Überprüfe die gesetzten Werte
            $script:instance.id | Should -Be "test-group-id"
            $script:instance.name | Should -Be "Test Group"
            $script:instance.color | Should -Be "blue"
            $script:instance.option_ids | Should -Be @("option1", "option2", "option3")
            $script:instance.option_ids.Count | Should -Be 3
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                id = "test-group-id"
                name = "Test Status Group"
                color = "red"
                option_ids = @("opt1", "opt2", "opt3")
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_status_group]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_status_group]
            $result.id | Should -Be "test-group-id"
            $result.name | Should -Be "Test Status Group"
            $result.color | Should -Be "red"
            $result.option_ids | Should -Be @("opt1", "opt2", "opt3")
            $result.option_ids.Count | Should -Be 3
        }
        
        It "Should handle empty option_ids array" {
            # Erstelle ein Test-Hashtable mit leerer option_ids
            $testData = @{
                id = "test-empty-group"
                name = "Empty Group"
                color = "green"
                option_ids = @()
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_status_group]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_status_group]
            $result.id | Should -Be "test-empty-group"
            $result.name | Should -Be "Empty Group"
            $result.color | Should -Be "green"
            $result.option_ids | Should -Be @()
            $result.option_ids.Count | Should -Be 0
        }
    }
}

Describe "notion_status_database_property_structure Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_status_database_property_structure]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_status_database_property_structure]
            
            # Überprüfe die Standard-Eigenschaften
            $instance.options | Should -Not -BeNullOrEmpty
            $instance.options | Should -BeOfType [System.Array]
            $instance.options.Count | Should -Be 0
            $instance.groups | Should -Not -BeNullOrEmpty
            $instance.groups | Should -BeOfType [System.Array]
            $instance.groups.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_status_database_property_structure]::new()
        }
        
        It "Should have options property of correct type" {
            # Überprüfe den Typ der options-Eigenschaft
            $script:instance.options | Should -BeOfType [System.Array]
            $script:instance.options.Count | Should -Be 0
        }
        
        It "Should have groups property of correct type" {
            # Überprüfe den Typ der groups-Eigenschaft
            $script:instance.groups | Should -BeOfType [System.Array]
            $script:instance.groups.Count | Should -Be 0
        }
        
        It "Should allow setting options and groups" {
            # Erstelle Test-Daten
            $testOptions = @([notion_status]::new(), [notion_status]::new())
            $testGroups = @([notion_status_group]::new(), [notion_status_group]::new())
            
            # Setze die Arrays
            $script:instance.options = $testOptions
            $script:instance.groups = $testGroups
            
            # Überprüfe die Zuweisung
            $script:instance.options.Count | Should -Be 2
            $script:instance.groups.Count | Should -Be 2
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                options = @(
                    @{
                        id = "status1"
                        name = "Status 1"
                        color = "blue"
                    },
                    @{
                        id = "status2"
                        name = "Status 2"
                        color = "red"
                    }
                )
                groups = @(
                    @{
                        id = "group1"
                        name = "Group 1"
                        color = "green"
                        option_ids = @("status1")
                    },
                    @{
                        id = "group2"
                        name = "Group 2"
                        color = "yellow"
                        option_ids = @("status2")
                    }
                )
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_status_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_status_database_property_structure]
            $result.options | Should -Not -BeNullOrEmpty
            $result.options.Count | Should -Be 2
            $result.options[0] | Should -BeOfType [notion_status]
            $result.options[1] | Should -BeOfType [notion_status]
            $result.groups | Should -Not -BeNullOrEmpty
            $result.groups.Count | Should -Be 2
            $result.groups[0] | Should -BeOfType [notion_status_group]
            $result.groups[1] | Should -BeOfType [notion_status_group]
        }
        
        It "Should handle empty arrays" {
            # Erstelle ein Test-Hashtable mit leeren Arrays
            $testData = @{
                options = @()
                groups = @()
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_status_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_status_database_property_structure]
            $result.options.Count | Should -Be 0
            $result.groups.Count | Should -Be 0
        }
    }
}

Describe "notion_status_database_property Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_status_database_property]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_status_database_property]
            
            # Überprüfe die geerbten Eigenschaften von DatabasePropertiesBase
            $instance.type | Should -Be "status"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.status | Should -Not -BeNullOrEmpty
            $instance.status | Should -BeOfType [notion_status_database_property_structure]
            $instance.status.options.Count | Should -Be 0
            $instance.status.groups.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_status_database_property]::new()
        }
        
        It "Should have status property of correct type" {
            # Überprüfe den Typ der status-Eigenschaft
            $script:instance.status | Should -BeOfType [notion_status_database_property_structure]
            
            # Überprüfe, dass options und groups anfangs leer sind
            $script:instance.status.options.Count | Should -Be 0
            $script:instance.status.groups.Count | Should -Be 0
        }
        
        It "Should allow modifying status structure" {
            # Erstelle eine neue Struktur
            $newStructure = [notion_status_database_property_structure]::new()
            $script:instance.status = $newStructure
            
            # Überprüfe die Zuweisung
            $script:instance.status | Should -Be $newStructure
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                type = "status"
                status = @{
                    options = @(
                        @{
                            id = "status1"
                            name = "In Progress"
                            color = "blue"
                        },
                        @{
                            id = "status2"
                            name = "Done"
                            color = "green"
                        }
                    )
                    groups = @(
                        @{
                            id = "group1"
                            name = "Active"
                            color = "blue"
                            option_ids = @("status1")
                        },
                        @{
                            id = "group2"
                            name = "Completed"
                            color = "green"
                            option_ids = @("status2")
                        }
                    )
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_status_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_status_database_property]
            $result.type | Should -Be "status"
            $result.status | Should -Not -BeNullOrEmpty
            $result.status | Should -BeOfType [notion_status_database_property_structure]
            $result.status.options.Count | Should -Be 2
            $result.status.groups.Count | Should -Be 2
            $result.status.options[0] | Should -BeOfType [notion_status]
            $result.status.groups[0] | Should -BeOfType [notion_status_group]
        }
        
        It "Should handle empty status structure" {
            # Erstelle ein Test-Hashtable mit leerer status Struktur
            $testData = @{
                type = "status"
                status = @{
                    options = @()
                    groups = @()
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_status_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_status_database_property]
            $result.type | Should -Be "status"
            $result.status.options.Count | Should -Be 0
            $result.status.groups.Count | Should -Be 0
        }
        
        It "Should convert complex status structure" {
            # Erstelle ein Test-Hashtable mit komplexerer Struktur
            $testData = @{
                type = "status"
                status = @{
                    options = @(
                        @{ id = "s1"; name = "Not Started"; color = "gray" },
                        @{ id = "s2"; name = "In Progress"; color = "blue" },
                        @{ id = "s3"; name = "Review"; color = "yellow" },
                        @{ id = "s4"; name = "Done"; color = "green" }
                    )
                    groups = @(
                        @{
                            id = "g1"
                            name = "To Do"
                            color = "gray"
                            option_ids = @("s1")
                        },
                        @{
                            id = "g2"
                            name = "In Progress"
                            color = "blue"
                            option_ids = @("s2", "s3")
                        },
                        @{
                            id = "g3"
                            name = "Complete"
                            color = "green"
                            option_ids = @("s4")
                        }
                    )
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_status_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_status_database_property]
            $result.type | Should -Be "status"
            $result.status.options.Count | Should -Be 4
            $result.status.groups.Count | Should -Be 3
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from DatabasePropertiesBase" {
            # Erstelle eine Instanz
            $instance = [notion_status_database_property]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [DatabasePropertiesBase]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "status"
        }
        
        It "Should have correct type property from base class" {
            # Erstelle eine Instanz
            $instance = [notion_status_database_property]::new()
            
            # Überprüfe, dass der Typ korrekt gesetzt ist
            $instance.type | Should -Be "status"
            $instance.type | Should -BeOfType [string]
        }
    }
}
