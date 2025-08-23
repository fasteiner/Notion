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
    Describe "notion_select_database_property Tests" {
        Context "Constructor Tests" {
            It "Should create a notion_select_database_property with default constructor" {
                # Create a new instance using the default constructor
                $selectProperty = [notion_select_database_property]::new()
                
                # Verify the object is of the correct type
                $selectProperty.GetType().Name | Should -Be "notion_select_database_property"
                
                # Verify it inherits from DatabasePropertiesBase
                $selectProperty -is [DatabasePropertiesBase] | Should -Be $true
                
                # Verify the type property is set correctly
                $selectProperty.type | Should -Be "select"
                
                # Verify the select property is initialized correctly
                $selectProperty.select | Should -Not -BeNullOrEmpty
                $selectProperty.select.GetType().Name | Should -Be "notion_select_database_property_structure"
                $selectProperty.select.options.Count | Should -Be 0
            }
            
            It "Should create a notion_select_database_property with name parameter" {
                # Create a new instance with a name parameter
                $selectProperty = [notion_select_database_property]::new("Test Option")
                
                # Verify the object is of the correct type
                $selectProperty.GetType().Name | Should -Be "notion_select_database_property"
                
                # Verify the type property is set correctly
                $selectProperty.type | Should -Be "select"
                
                # Verify the select property contains the added option
                $selectProperty.select | Should -Not -BeNullOrEmpty
                $selectProperty.select.options.Count | Should -Be 1
                $selectProperty.select.options[0].GetType().Name | Should -Be "notion_select"
            }
        }
        
        Context "Property Tests" {
            It "Should have select property as notion_select_database_property_structure" {
                # Create a new instance
                $selectProperty = [notion_select_database_property]::new()
                
                # Verify the select property is of correct type
                $selectProperty.select.GetType().Name | Should -Be "notion_select_database_property_structure"
                
                # Verify it's initially empty
                $selectProperty.select.options.Count | Should -Be 0
            }
            
            It "Should allow adding options via select structure" {
                # Create a new instance
                $selectProperty = [notion_select_database_property]::new()
                
                # Add an option to the select structure
                $selectProperty.select.add("New Option")
                
                # Verify the option was added successfully
                $selectProperty.select.options.Count | Should -Be 1
                $selectProperty.select.options[0].GetType().Name | Should -Be "notion_select"
            }
            
            It "Should allow multiple options to be added" {
                # Create a new instance
                $selectProperty = [notion_select_database_property]::new()
                
                # Add multiple options
                $selectProperty.select.add("Option A")
                $selectProperty.select.add("Option B")
                $selectProperty.select.add("Option C")
                
                # Verify all options were added
                $selectProperty.select.options.Count | Should -Be 3
                $selectProperty.select.options[0].GetType().Name | Should -Be "notion_select"
                $selectProperty.select.options[1].GetType().Name | Should -Be "notion_select"
                $selectProperty.select.options[2].GetType().Name | Should -Be "notion_select"
            }
        }
        
        Context "ConvertFromObject Tests" {
            It "Should convert from object with select options" {
                # Test with a select object containing options
                $mockObject = [PSCustomObject]@{
                    type   = "select"
                    select = [PSCustomObject]@{
                        options = @(
                            [PSCustomObject]@{
                                name  = "Option 1"
                                color = "blue"
                                id    = "test-id-1"
                            },
                            [PSCustomObject]@{
                                name  = "Option 2"
                                color = "red"
                                id    = "test-id-2"
                            }
                        )
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_select_database_property]::ConvertFromObject($mockObject)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_select_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "select"
                
                # Verify the select options were converted
                $convertedProperty.select | Should -Not -BeNullOrEmpty
                $convertedProperty.select.options.Count | Should -Be 2
                $convertedProperty.select.options[0].GetType().Name | Should -Be "notion_select"
                $convertedProperty.select.options[1].GetType().Name | Should -Be "notion_select"
            }
            
            It "Should convert from object with empty select structure" {
                # Test with empty select structure
                $mockObject = [PSCustomObject]@{
                    type   = "select"
                    select = [PSCustomObject]@{
                        options = @()
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_select_database_property]::ConvertFromObject($mockObject)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_select_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "select"
                
                # Verify the select structure is empty
                $convertedProperty.select.options.Count | Should -Be 0
            }
            
            It "Should convert from hashtable input" {
                # Test with a hashtable input
                $hashInput = @{
                    type   = "select"
                    select = @{
                        options = @(
                            @{
                                name  = "Hash Option"
                                color = "green"
                                id    = "hash-id"
                            }
                        )
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_select_database_property]::ConvertFromObject($hashInput)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_select_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "select"
                
                # Verify the option was converted
                $convertedProperty.select.options.Count | Should -Be 1
                $convertedProperty.select.options[0].GetType().Name | Should -Be "notion_select"
            }
        }
        
        Context "Inheritance Tests" {
            It "Should inherit from DatabasePropertiesBase" {
                # Create a new instance
                $selectProperty = [notion_select_database_property]::new()
                
                # Verify inheritance
                $selectProperty -is [DatabasePropertiesBase] | Should -Be $true
            }
            
            It "Should have type property from base class" {
                # Create a new instance
                $selectProperty = [notion_select_database_property]::new()
                
                # Verify the type property exists and is set correctly by base constructor
                $selectProperty.type | Should -Be "select"
                $selectProperty.type.GetType().Name | Should -Be "notion_database_property_type"
            }
        }
    }
}
