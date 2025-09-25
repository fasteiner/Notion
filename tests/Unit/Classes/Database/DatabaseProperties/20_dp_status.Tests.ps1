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
    Describe "notion_status_database_property Tests" {
        Context "Constructor Tests" {
            It "Should create a notion_status_database_property with default constructor" {
                # Create a new instance using the default constructor
                $statusProperty = [notion_status_database_property]::new()
                
                # Verify the object is of the correct type
                $statusProperty.GetType().Name | Should -Be "notion_status_database_property"
                
                # Verify it inherits from DatabasePropertiesBase
                $statusProperty -is [DatabasePropertiesBase] | Should -Be $true
                
                # Verify the type property is set correctly
                $statusProperty.type | Should -Be "status"
                
                # Verify the status property is initialized correctly
                $statusProperty.status | Should -Not -BeNullOrEmpty
                $statusProperty.status.GetType().Name | Should -Be "notion_status_database_property_structure"
                $statusProperty.status.options.Count | Should -Be 0
            }
            
            It "Should create a notion_status_database_property with name parameter" {
                # Create a new instance with a name parameter
                $statusProperty = [notion_status_database_property]::new("Test Status")
                
                # Verify the object is of the correct type
                $statusProperty.GetType().Name | Should -Be "notion_status_database_property"
                
                # Verify the type property is set correctly
                $statusProperty.type | Should -Be "status"
                
                # Verify the status property contains the added option
                $statusProperty.status | Should -Not -BeNullOrEmpty
                $statusProperty.status.options.Count | Should -Be 1
                $statusProperty.status.options[0] | Should -BeOfType [notion_status]
            }
        }
        
        Context "Property Tests" {
            It "Should have status property as notion_status_database_property_structure" {
                # Create a new instance
                $statusProperty = [notion_status_database_property]::new()
                
                # Verify the status property is of correct type
                $statusProperty.status.GetType().Name | Should -Be "notion_status_database_property_structure"
                
                # Verify it's initially empty
                $statusProperty.status.options.Count | Should -Be 0
            }
            
            It "Should allow adding status options via status structure" {
                # Create a new instance
                $statusProperty = [notion_status_database_property]::new()
                
                # Add a status option to the status structure
                $statusProperty.status.add("In Progress")
                
                # Verify the option was added successfully
                $statusProperty.status.options.Count | Should -Be 1
                $statusProperty.status.options[0] | Should -BeOfType [notion_status]
            }
            
            It "Should allow multiple status options to be added" {
                # Create a new instance
                $statusProperty = [notion_status_database_property]::new()
                
                # Add multiple status options
                $statusProperty.status.add("Not Started")
                $statusProperty.status.add("In Progress")
                $statusProperty.status.add("Completed")
                
                # Verify all options were added
                $statusProperty.status.options.Count | Should -Be 3
                $statusProperty.status.options[0] | Should -BeOfType [notion_status]
                $statusProperty.status.options[1].GetType().Name | Should -Be "notion_status"
                $statusProperty.status.options[2].GetType().Name | Should -Be "notion_status"
            }
        }
        
        Context "ConvertFromObject Tests" {
            It "Should convert from object with status options" {
                # Test with a status object containing options
                $mockObject = [PSCustomObject]@{
                    type   = "status"
                    status = [PSCustomObject]@{
                        options = @(
                            [PSCustomObject]@{
                                name  = "Not Started"
                                color = "gray"
                                id    = "test-id-1"
                            },
                            [PSCustomObject]@{
                                name  = "In Progress"
                                color = "blue"
                                id    = "test-id-2"
                            }
                        )
                        groups  = @(
                            [PSCustomObject]@{
                                name       = "To-do"
                                color      = "gray"
                                id         = "group-id-1"
                                option_ids = @("test-id-1")
                            }
                        )
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_status_database_property]::ConvertFromObject($mockObject)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_status_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "status"
                
                # Verify the status options were converted
                $convertedProperty.status | Should -Not -BeNullOrEmpty
                $convertedProperty.status.options.Count | Should -Be 2
                $convertedProperty.status.options[0].GetType().Name | Should -Be "notion_status"
                $convertedProperty.status.options[1].GetType().Name | Should -Be "notion_status"
            }
            
            It "Should convert from object with empty status structure" {
                # Test with empty status structure
                $mockObject = [PSCustomObject]@{
                    type   = "status"
                    status = [PSCustomObject]@{
                        options = @()
                        groups  = @()
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_status_database_property]::ConvertFromObject($mockObject)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_status_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "status"
                
                # Verify the status structure is empty
                $convertedProperty.status.options.Count | Should -Be 0
            }
            
            It "Should convert from hashtable input" {
                # Test with a hashtable input
                $hashInput = @{
                    type   = "status"
                    status = @{
                        options = @(
                            @{
                                name  = "Hash Status"
                                color = "green"
                                id    = "hash-id"
                            }
                        )
                        groups  = @()
                    }
                }
                
                # Call the static ConvertFromObject method
                $convertedProperty = [notion_status_database_property]::ConvertFromObject($hashInput)
                
                # Verify the converted object is of the correct type
                $convertedProperty.GetType().Name | Should -Be "notion_status_database_property"
                
                # Verify the type property is set correctly
                $convertedProperty.type | Should -Be "status"
                
                # Verify the option was converted
                $convertedProperty.status.options.Count | Should -Be 1
                $convertedProperty.status.options[0].GetType().Name | Should -Be "notion_status"
            }
        }
        
        Context "Inheritance Tests" {
            It "Should inherit from DatabasePropertiesBase" {
                # Create a new instance
                $statusProperty = [notion_status_database_property]::new()
                
                # Verify inheritance
                $statusProperty -is [DatabasePropertiesBase] | Should -Be $true
            }
            
            It "Should have type property from base class" {
                # Create a new instance
                $statusProperty = [notion_status_database_property]::new()
                
                # Verify the type property exists and is set correctly by base constructor
                $statusProperty.type | Should -Be "status"
                $statusProperty.type.GetType().Name | Should -Be "notion_database_property_type"
            }
        }
    }
}
