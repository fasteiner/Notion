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
    Describe "notion_unique_id_database_property Tests" {
        Context "Constructor Tests" {
            It "Should create a notion_unique_id_database_property with default constructor" {
                # Create a new instance using the default constructor
                $uniqueIdProperty = [notion_unique_id_database_property]::new()
                
                # Verify the object is of the correct type
                $uniqueIdProperty.GetType().Name | Should -Be "notion_unique_id_database_property"
                
                # Verify it inherits from DatabasePropertiesBase
                $uniqueIdProperty -is [DatabasePropertiesBase] | Should -Be $true
                
                # Verify the type property is set correctly
                $uniqueIdProperty.type | Should -Be "unique_id"
                
                # Verify the unique_id property is initialized as an empty hashtable
                $uniqueIdProperty.unique_id.getType().Name | Should -Be "notion_unique_id_database_property_structure"
                $uniqueIdProperty.unique_id.Count | Should -Be 1
            }
        }
        
        Context "Property Tests" {
                        
            It "Should allow modification of unique_id property" {
                # Create a new instance
                $uniqueIdProperty = [notion_unique_id_database_property]::new()
                
                # Add some test data to the unique_id hashtable
                $uniqueIdProperty.unique_id.prefix = "ID-"
                
                # Verify the data was added successfully
                $uniqueIdProperty.unique_id.prefix | Should -Be "ID-"
                $uniqueIdProperty.unique_id.Count | Should -Be 1
            }
        }
        
        Context "ConvertFromObject Tests" {
            It "Should convert from any object and return default instance" {
                # Test with a simple object
                $mockObject = [PSCustomObject]@{
                    type      = "unique_id"
                    unique_id = @{}
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_unique_id_database_property]::ConvertFromObject($mockObject)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_unique_id_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "unique_id"
                
                # Verify the unique_id property is initialized as empty hashtable
                $convertedProperty.unique_id.getType().Name | Should -Be "notion_unique_id_database_property_structure"
                $convertedProperty.unique_id.Count | Should -Be 1
            }
            
            It "Should convert from object with unique_id configuration" {
                # Test with a unique_id object containing configuration
                $mockObject = [PSCustomObject]@{
                    type      = "unique_id"
                    unique_id = [PSCustomObject]@{
                        prefix = "TASK-"
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_unique_id_database_property]::ConvertFromObject($mockObject)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_unique_id_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "unique_id"
                
                # Verify the unique_id property is a hashtable (implementation may vary)
                $convertedProperty.unique_id.getType().Name | Should -Be "notion_unique_id_database_property_structure"
            }
            
            It "Should convert from hashtable input" {
                # Test with a hashtable input
                $hashInput = @{
                    type      = "unique_id"
                    unique_id = @{ 
                        prefix = "REQ-"
                        start  = 1000
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_unique_id_database_property]::ConvertFromObject($hashInput)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_unique_id_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "unique_id"
                
                # Note: The ConvertFromObject method behavior may vary based on implementation
                $convertedProperty.unique_id.getType().Name | Should -Be "notion_unique_id_database_property_structure"
            }
        }
        
        Context "Inheritance Tests" {
            It "Should inherit from DatabasePropertiesBase" {
                # Create a new instance
                $uniqueIdProperty = [notion_unique_id_database_property]::new()
                
                # Verify inheritance
                $uniqueIdProperty -is [DatabasePropertiesBase] | Should -Be $true
            }
            
            It "Should have type property from base class" {
                # Create a new instance
                $uniqueIdProperty = [notion_unique_id_database_property]::new()
                
                # Verify the type property exists and is set correctly by base constructor
                $uniqueIdProperty.type | Should -Be "unique_id"
                $uniqueIdProperty.type.GetType().Name | Should -Be "notion_database_property_type"
            }
        }
    }
}
