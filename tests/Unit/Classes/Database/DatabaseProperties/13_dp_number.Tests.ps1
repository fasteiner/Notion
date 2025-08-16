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

Describe "notion_number_database_property_structure Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_number_database_property_structure]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_number_database_property_structure]
            
            # Überprüfe die Standard-Eigenschaften
            $instance.format | Should -Be ([notion_database_property_format_type]::number)
        }
        
        It "Should create instance with format parameter successfully" {
            # Erstelle eine neue Instanz mit einem spezifischen Format
            $instance = [notion_number_database_property_structure]::new([notion_database_property_format_type]::percent)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_number_database_property_structure]
            
            # Überprüfe, dass das Format korrekt gesetzt wurde
            $instance.format | Should -Be ([notion_database_property_format_type]::percent)
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_number_database_property_structure]::new()
        }
        
        It "Should have format property of correct type" {
            # Überprüfe den Typ der format-Eigenschaft
            $script:instance.format | Should -BeOfType [notion_database_property_format_type]
            
            # Überprüfe den Standard-Wert
            $script:instance.format | Should -Be ([notion_database_property_format_type]::number)
        }
        
        It "Should allow setting different format values" {
            # Teste verschiedene Format-Werte
            $script:instance.format = [notion_database_property_format_type]::currency
            $script:instance.format | Should -Be ([notion_database_property_format_type]::currency)
            
            $script:instance.format = [notion_database_property_format_type]::percent
            $script:instance.format | Should -Be ([notion_database_property_format_type]::percent)
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                format = "percent"
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_number_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_number_database_property_structure]
            $result.format | Should -Be ([notion_database_property_format_type]::percent)
        }
        
        It "Should convert number format successfully" {
            # Erstelle ein Test-Hashtable mit number Format
            $testData = @{
                format = "number"
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_number_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_number_database_property_structure]
            $result.format | Should -Be ([notion_database_property_format_type]::number)
        }
        
        It "Should convert currency format successfully" {
            # Erstelle ein Test-Hashtable mit currency Format
            $testData = @{
                format = "currency"
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_number_database_property_structure]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_number_database_property_structure]
            $result.format | Should -Be ([notion_database_property_format_type]::currency)
        }
    }
}

Describe "notion_number_database_property Tests" {
    
    Context "Constructor Tests" {
        
        It "Should create default instance successfully" {
            # Erstelle eine neue Instanz mit dem Standard-Konstruktor
            $instance = [notion_number_database_property]::new()
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_number_database_property]
            
            # Überprüfe die geerbten Eigenschaften von DatabasePropertiesBase
            $instance.type | Should -Be "number"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.number | Should -Not -BeNullOrEmpty
            $instance.number | Should -BeOfType [notion_number_database_property_structure]
            $instance.number.format | Should -Be ([notion_database_property_format_type]::number)
        }
        
        It "Should create instance with null parameter successfully" {
            # Erstelle eine neue Instanz mit null Parameter
            $instance = [notion_number_database_property]::new($null)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_number_database_property]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "number"
            
            # Überprüfe die spezifischen Eigenschaften (sollte Standard-Struktur erstellen)
            $instance.number | Should -Not -BeNullOrEmpty
            $instance.number | Should -BeOfType [notion_number_database_property_structure]
            $instance.number.format | Should -Be ([notion_database_property_format_type]::number)
        }
        
        It "Should create instance with structure parameter successfully" {
            # Erstelle zuerst eine Struktur
            $numberStructure = [notion_number_database_property_structure]::new([notion_database_property_format_type]::currency)
            
            # Erstelle eine neue Instanz mit der Struktur
            $instance = [notion_number_database_property]::new($numberStructure)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_number_database_property]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "number"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.number | Should -Be $numberStructure
            $instance.number.format | Should -Be ([notion_database_property_format_type]::currency)
        }
        
        It "Should create instance with hashtable parameter successfully" {
            # Erstelle ein Test-Hashtable
            $numberData = @{
                format = "percent"
            }
            
            # Erstelle eine neue Instanz mit dem Hashtable
            $instance = [notion_number_database_property]::new($numberData)
            
            # Überprüfe, dass die Instanz erstellt wurde
            $instance | Should -Not -BeNullOrEmpty
            $instance | Should -BeOfType [notion_number_database_property]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "number"
            
            # Überprüfe die spezifischen Eigenschaften
            $instance.number | Should -Not -BeNullOrEmpty
            $instance.number | Should -BeOfType [notion_number_database_property_structure]
            $instance.number.format | Should -Be ([notion_database_property_format_type]::percent)
        }
    }
    
    Context "Property Tests" {
        
        BeforeEach {
            # Erstelle eine neue Instanz für jeden Test
            $script:instance = [notion_number_database_property]::new()
        }
        
        It "Should have number property of correct type" {
            # Überprüfe den Typ der number-Eigenschaft
            $script:instance.number | Should -BeOfType [notion_number_database_property_structure]
            
            # Überprüfe das Standard-Format
            $script:instance.number.format | Should -Be ([notion_database_property_format_type]::number)
        }
        
        It "Should allow modifying number structure" {
            # Modifiziere die number-Struktur
            $script:instance.number.format = [notion_database_property_format_type]::currency
            
            # Überprüfe die Änderung
            $script:instance.number.format | Should -Be ([notion_database_property_format_type]::currency)
        }
    }
    
    Context "ConvertFromObject Tests" {
        
        It "Should convert from hashtable successfully" {
            # Erstelle ein Test-Hashtable mit der erwarteten Struktur
            $testData = @{
                type = "number"
                number = @{
                    format = "currency"
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_number_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_number_database_property]
            $result.type | Should -Be "number"
            $result.number | Should -Not -BeNullOrEmpty
            $result.number | Should -BeOfType [notion_number_database_property_structure]
            $result.number.format | Should -Be ([notion_database_property_format_type]::currency)
        }
        
        It "Should convert with percent format successfully" {
            # Erstelle ein Test-Hashtable mit percent Format
            $testData = @{
                type = "number"
                number = @{
                    format = "percent"
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_number_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_number_database_property]
            $result.type | Should -Be "number"
            $result.number.format | Should -Be ([notion_database_property_format_type]::percent)
        }
        
        It "Should convert with default number format successfully" {
            # Erstelle ein Test-Hashtable mit Standard number Format
            $testData = @{
                type = "number"
                number = @{
                    format = "number"
                }
            }
            
            # Konvertiere das Hashtable zu einem Objekt
            $result = [notion_number_database_property]::ConvertFromObject($testData)
            
            # Überprüfe das Ergebnis
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_number_database_property]
            $result.type | Should -Be "number"
            $result.number.format | Should -Be ([notion_database_property_format_type]::number)
        }
    }
    
    Context "Inheritance Tests" {
        
        It "Should inherit from DatabasePropertiesBase" {
            # Erstelle eine Instanz
            $instance = [notion_number_database_property]::new()
            
            # Überprüfe die Vererbung
            $instance | Should -BeOfType [DatabasePropertiesBase]
            
            # Überprüfe die geerbten Eigenschaften
            $instance.type | Should -Be "number"
        }
        
        It "Should have correct type property from base class" {
            # Erstelle eine Instanz
            $instance = [notion_number_database_property]::new()
            
            # Überprüfe, dass der Typ korrekt gesetzt ist
            $instance.type | Should -Be "number"
            $instance.type | Should -BeOfType [string]
        }
    }
}
