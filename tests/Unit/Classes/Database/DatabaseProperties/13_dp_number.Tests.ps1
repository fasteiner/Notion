# Import Pester (test framework) – the module under test is imported in BeforeDiscovery
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    # Resolve project root (4 levels up from this test file)
    $projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    <#
    If tests are run outside the build script (e.g. Invoke-Pester directly),
    the parent scope might not have set $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assume the project folder name equals the project/module name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Ensure a clean module context before importing
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    # Import the built module from output
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

InModuleScope -ModuleName $global:moduleName {

    Describe "notion_number_database_property Tests" {
    
        Context "Constructor Tests" {
        
            It "Should create default instance successfully" {
                # Create a new instance using the default constructor
                $instance = [notion_number_database_property]::new()
            
                # Verify the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_number_database_property]
            
                # Verify inherited properties from DatabasePropertiesBase
                $instance.type | Should -Be "number"
            
                # Verify specific properties
                $instance.number | Should -Not -BeNullOrEmpty
                $instance.number.getType().Name | Should -Be "notion_number_database_property_structure"
                $instance.number.format | Should -Be ([notion_database_property_format_type]::number)
            }
        
            It "Should create instance with null parameter successfully" {
                # Create a new instance with null parameter
                $instance = [notion_number_database_property]::new($null)
            
                # Verify the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_number_database_property]
            
                # Verify inherited properties
                $instance.type | Should -Be "number"
            
                # Verify specific properties (should create default structure)
                $instance.number | Should -Not -BeNullOrEmpty
                $instance.number.gettype().Name | Should -Be "notion_number_database_property_structure"
                $instance.number.format | Should -Be ([notion_database_property_format_type]::number)
            }
                
            It "Should create instance with hashtable parameter successfully" {
                # Build sample hashtable
                $numberData = @{
                    format = "percent"
                }
            
                # Create new instance with hashtable
                $instance = [notion_number_database_property]::new($numberData)
            
                # Verify the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_number_database_property]
            
                # Verify inherited properties
                $instance.type | Should -Be "number"
            
                # Verify specific properties
                $instance.number | Should -Not -BeNullOrEmpty
                $instance.number.getType().Name | Should -Be "notion_number_database_property_structure"
                $instance.number.format | Should -Be ([notion_database_property_format_type]::percent)
            }
        }
    
        Context "Property Tests" {
            BeforeEach { $script:instance = [notion_number_database_property]::new() }
            It "Should expose number structure with default format" {
                $script:instance.number.GetType().Name | Should -Be "notion_number_database_property_structure"
                $script:instance.number.format        | Should -Be ([notion_database_property_format_type]::number)
            }
            It "Should allow changing number format" {
                $script:instance.number.format = [notion_database_property_format_type]::euro
                $script:instance.number.format | Should -Be ([notion_database_property_format_type]::euro)
            }
        }
    
        Context "ConvertFromObject Tests" {
        
            It "Should convert from hashtable successfully" {
                # Build sample hashtable with expected structure
                $testData = @{
                    type   = "number"
                    number = @{
                        format = "euro"
                    }
                }
            
                # Convert hashtable to object
                $result = [notion_number_database_property]::ConvertFromObject($testData)
            
                # Verify result
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_number_database_property]
                $result.type | Should -Be "number"
                $result.number | Should -Not -BeNullOrEmpty
                $result.number.gettype().Name | Should -Be "notion_number_database_property_structure"
                $result.number.format | Should -Be ([notion_database_property_format_type]::euro)
            }
        
            It "Should convert with percent format successfully" {
                # Build sample hashtable with percent format
                $testData = @{
                    type   = "number"
                    number = @{
                        format = "percent"
                    }
                }
            
                # Convert hashtable to object
                $result = [notion_number_database_property]::ConvertFromObject($testData)
            
                # Verify result
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_number_database_property]
                $result.type | Should -Be "number"
                $result.number.format | Should -Be ([notion_database_property_format_type]::percent)
            }
        
            It "Should convert with default number format successfully" {
                # Build sample hashtable with default number format
                $testData = @{
                    type   = "number"
                    number = @{
                        format = "number"
                    }
                }
            
                # Convert hashtable to object
                $result = [notion_number_database_property]::ConvertFromObject($testData)
            
                # Verify result
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_number_database_property]
                $result.type | Should -Be "number"
                $result.number.format | Should -Be ([notion_database_property_format_type]::number)
            }
        }
    
        Context "Inheritance Tests" {
        
            It "Should inherit from DatabasePropertiesBase" {
                # Create an instance
                $instance = [notion_number_database_property]::new()
            
                # Verify inheritance
                $instance | Should -BeOfType [DatabasePropertiesBase]
            
                # Verify inherited properties
                $instance.type | Should -Be "number"
            }
        
            It "Should have correct type property from base class" {
                # Create an instance
                $instance = [notion_number_database_property]::new()
            
                # Verify correct type value
                $instance.type | Should -Be "number"
                $instance.type | Should -BeOfType [notion_database_property_type]
            }
        }
    }

}
