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

Describe "notion_multi_select_database_property_structure Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_multi_select_database_property_structure]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            
            # Überprüfe die Standard-Eigenschaften
            $instance.options | Should -Not -BeNullOrEmpty
            $instance.options | Should -BeOfType [System.Array]
            $instance.options.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_multi_select_database_property_structure]::new()
        }
        
        It "Should have options property of correct type" {
            # Überprüfe den Typ der options-Eigenschaft
            $script:instance.options | Should -BeOfType [System.Array]
            
            # Überprüfe, dass es anfangs leer ist
            $script:instance.options.Count | Should -Be 0
        }
        
        It "Should allow adding items via add method" {
            # Teste die add-Methode
            $script:instance.add([notion_property_color]::blue, "Test Option")
            
            # Überprüfe, dass das Element hinzugefügt wurde
            $script:instance.options.Count | Should -Be 1
            $script:instance.options[0] | Should -BeOfType [notion_multi_select_item]
            $script:instance.options[0].name | Should -Be "Test Option"
            $script:instance.options[0].color | Should -Be ([notion_property_color]::blue)
        }
        
        It "Should throw error when adding more than 100 items" {
            # Füge 100 Elemente hinzu
            for ($i = 1; $i -le 100; $i++) {
                $script:instance.add([notion_property_color]::blue, "Option $i")
            }
            
            # Das 101. Element sollte einen Fehler werfen
            { $script:instance.add([notion_property_color]::red, "Option 101") } | Should -Throw "*must have 100 items or less*"
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                options = @(
                    @{
                        name = "Option 1"
                        color = "blue"
                        id = "test-id-1"
                    },
                    @{
                        name = "Option 2"
                        color = "red"
                        id = "test-id-2"
                    }
                )
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_multi_select_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_multi_select_database_property_structure]
            $result.options | Should -Not -BeNullOrEmpty
            $result.options.Count | Should -Be 2
            $result.options[0] | Should -BeOfType [notion_multi_select_item]
            $result.options[0].name | Should -Be "Option 1"
            $result.options[1].name | Should -Be "Option 2"
        }
        
        It "Should handle empty options array" {
            # Erstelle ein Test-Hashtable mit leerer options-Array
            $testData = @{
                options = @()
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_multi_select_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_multi_select_database_property_structure]
            $result.options | Should -Not -BeNullOrEmpty
            $result.options.Count | Should -Be 0
        }
    }
}

Describe "notion_multi_select_database_property Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_multi_select_database_property]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_multi_select_database_property]
            
            # Überprüfe die geerbten Eigenschaften von DatabasePropertiesBase
            $instance.type | Should -Be "multi_select"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.multi_select | Should -Not -BeNullOrEmpty
            $instance.multi_select | Should -BeOfType [notion_multi_select_database_property_structure]
            $instance.multi_select.options.Count | Should -Be 0
        }
        
        It "Should create instance with color and name successfully" {
            # Erstelle eine neue Instanz mit Farbe und Name
            $instance = [notion_multi_select_database_property]::new([notion_property_color]::blue, "Test Option")
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_multi_select_database_property]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "multi_select"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.multi_select | Should -Not -BeNullOrEmpty
            $instance.multi_select | Should -BeOfType [System.Array]
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_multi_select_database_property]::new()
        }
        
        It "Should have multi_select property of correct type" {
            # Überprüfe den Typ der multi_select-Eigenschaft
            $script:instance.multi_select | Should -BeOfType [notion_multi_select_database_property_structure]
            
            # Überprüfe, dass options anfangs leer ist
            $script:instance.multi_select.options.Count | Should -Be 0
        }
        
        It "Should allow adding items via add method" {
            # Teste die add-Methode auf der Hauptklasse
            $script:instance.add([notion_property_color]::green, "New Option")
            
            # Überprüfe, dass das Element hinzugefügt wurde
            $script:instance.multi_select.options.Count | Should -Be 1
            $script:instance.multi_select.options[0] | Should -BeOfType [notion_multi_select_item]
            $script:instance.multi_select.options[0].name | Should -Be "New Option"
            $script:instance.multi_select.options[0].color | Should -Be ([notion_property_color]::green)
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                type = "multi_select"
                multi_select = @{
                    options = @(
                        @{
                            name = "Option A"
                            color = "blue"
                            id = "test-id-a"
                        },
                        @{
                            name = "Option B"
                            color = "red"
                            id = "test-id-b"
                        }
                    )
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_multi_select_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_multi_select_database_property]
            $result.type | Should -Be "multi_select"
            $result.multi_select | Should -Not -BeNullOrEmpty
            $result.multi_select | Should -BeOfType [notion_multi_select_database_property_structure]
            $result.multi_select.options.Count | Should -Be 2
            $result.multi_select.options[0].name | Should -Be "Option A"
            $result.multi_select.options[1].name | Should -Be "Option B"
        }
        
        It "Should handle empty multi_select structure" {
            # Erstelle ein Test-Hashtable mit leerer multi_select Struktur
            $testData = @{
                type = "multi_select"
                multi_select = @{
                    options = @()
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_multi_select_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_multi_select_database_property]
            $result.type | Should -Be "multi_select"
            $result.multi_select.options.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from DatabasePropertiesBase" {
            # Erstelle eine Instanz
            $instance = [notion_multi_select_database_property]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [DatabasePropertiesBase]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "multi_select"
        }
        
        It "Should have correct type property from base class" {
            # Erstelle eine Instanz
            $instance = [notion_multi_select_database_property]::new()
            
            # Überprüfe, dass der Typ korrekt gesetzt ist
            $instance.type | Should -Be "multi_select"
            $instance.type | Should -BeOfType [string]
        }
    }
}
