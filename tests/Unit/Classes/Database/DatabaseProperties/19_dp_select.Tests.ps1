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

Describe "notion_select_database_property_structure Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_select_database_property_structure]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_select_database_property_structure]
            
            # Überprüfe die Standard-Eigenschaften
            $instance.options | Should -Not -BeNullOrEmpty
            $instance.options | Should -BeOfType [System.Array]
            $instance.options.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_select_database_property_structure]::new()
        }
        
        It "Should have options property of correct type" {
            # Überprüfe den Typ der options-Eigenschaft
            $script:instance.options | Should -BeOfType [System.Array]
            
            # Überprüfe, dass es anfangs leer ist
            $script:instance.options.Count | Should -Be 0
        }
        
        It "Should allow adding items via add method" {
            # Teste die add-Methode
            $script:instance.add("Test Option")
            
            # Überprüfe, dass das Element hinzugefügt wurde
            $script:instance.options.Count | Should -Be 1
            $script:instance.options[0] | Should -BeOfType [notion_select]
        }
        
        It "Should throw error when adding more than 100 items" {
            # Füge 100 Elemente hinzu
            for ($i = 1; $i -le 100; $i++) {
                $script:instance.add("Option $i")
            }
            
            # Das 101. Element sollte einen Fehler werfen
            { $script:instance.add("Option 101") } | Should -Throw "*must have 100 items or less*"
        }
        
        It "Should add multiple items successfully" {
            # Füge mehrere Elemente hinzu
            $script:instance.add("Option A")
            $script:instance.add("Option B")
            $script:instance.add("Option C")
            
            # Überprüfe, dass alle Elemente hinzugefügt wurden
            $script:instance.options.Count | Should -Be 3
            $script:instance.options[0] | Should -BeOfType [notion_select]
            $script:instance.options[1] | Should -BeOfType [notion_select]
            $script:instance.options[2] | Should -BeOfType [notion_select]
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
            $result = [notion_select_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_select_database_property_structure]
            $result.options | Should -Not -BeNullOrEmpty
            $result.options.Count | Should -Be 2
            $result.options[0] | Should -BeOfType [notion_select]
            $result.options[1] | Should -BeOfType [notion_select]
        }
        
        It "Should handle empty options array" {
            # Erstelle ein Test-Hashtable mit leerer options-Array
            $testData = @{
                options = @()
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_select_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_select_database_property_structure]
            $result.options | Should -Not -BeNullOrEmpty
            $result.options.Count | Should -Be 0
        }
    }
}

Describe "notion_select_database_property Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_select_database_property]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_select_database_property]
            
            # Überprüfe die geerbten Eigenschaften von DatabasePropertiesBase
            $instance.type | Should -Be "select"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.select | Should -Not -BeNullOrEmpty
            $instance.select | Should -BeOfType [notion_select_database_property_structure]
            $instance.select.options.Count | Should -Be 0
        }
        
        It "Should create instance with name parameter successfully" {
            # Erstelle eine neue Instanz mit Namen
            $instance = [notion_select_database_property]::new("Test Option")
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_select_database_property]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "select"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.select | Should -Not -BeNullOrEmpty
            $instance.select | Should -BeOfType [notion_select_database_property_structure]
            $instance.select.options.Count | Should -Be 1
            $instance.select.options[0] | Should -BeOfType [notion_select]
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_select_database_property]::new()
        }
        
        It "Should have select property of correct type" {
            # Überprüfe den Typ der select-Eigenschaft
            $script:instance.select | Should -BeOfType [notion_select_database_property_structure]
            
            # Überprüfe, dass options anfangs leer ist
            $script:instance.select.options.Count | Should -Be 0
        }
        
        It "Should allow adding items via select structure" {
            # Teste das Hinzufügen über die Struktur
            $script:instance.select.add("New Option")
            
            # Überprüfe, dass das Element hinzugefügt wurde
            $script:instance.select.options.Count | Should -Be 1
            $script:instance.select.options[0] | Should -BeOfType [notion_select]
        }
        
        It "Should allow multiple items to be added" {
            # Füge mehrere Elemente hinzu
            $script:instance.select.add("Option A")
            $script:instance.select.add("Option B")
            $script:instance.select.add("Option C")
            
            # Überprüfe, dass alle Elemente hinzugefügt wurden
            $script:instance.select.options.Count | Should -Be 3
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                type = "select"
                select = @{
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
            $result = [notion_select_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_select_database_property]
            $result.type | Should -Be "select"
            $result.select | Should -Not -BeNullOrEmpty
            $result.select | Should -BeOfType [notion_select_database_property_structure]
            $result.select.options.Count | Should -Be 2
            $result.select.options[0] | Should -BeOfType [notion_select]
            $result.select.options[1] | Should -BeOfType [notion_select]
        }
        
        It "Should handle empty select structure" {
            # Erstelle ein Test-Hashtable mit leerer select Struktur
            $testData = @{
                type = "select"
                select = @{
                    options = @()
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_select_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_select_database_property]
            $result.type | Should -Be "select"
            $result.select.options.Count | Should -Be 0
        }
        
        It "Should handle single option correctly" {
            # Erstelle ein Test-Hashtable mit einer Option
            $testData = @{
                type = "select"
                select = @{
                    options = @(
                        @{
                            name = "Single Option"
                            color = "green"
                            id = "test-single-id"
                        }
                    )
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_select_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_select_database_property]
            $result.type | Should -Be "select"
            $result.select.options.Count | Should -Be 1
            $result.select.options[0] | Should -BeOfType [notion_select]
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from DatabasePropertiesBase" {
            # Erstelle eine Instanz
            $instance = [notion_select_database_property]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [DatabasePropertiesBase]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "select"
        }
        
        It "Should have correct type property from base class" {
            # Erstelle eine Instanz
            $instance = [notion_select_database_property]::new()
            
            # Überprüfe, dass der Typ korrekt gesetzt ist
            $instance.type | Should -Be "select"
            $instance.type | Should -BeOfType [string]
        }
    }
}
