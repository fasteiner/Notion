# Import the module containing the notion_created_time_database_property class
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

Describe "notion_created_time_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_created_time_database_property with default constructor" {
            # Create a new instance using the default constructor
            $createdTimeProperty = [notion_created_time_database_property]::new()
            
            # Verify the object is of the correct type
            $createdTimeProperty | Should -BeOfType "notion_created_time_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $createdTimeProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $createdTimeProperty.type | Should -Be "created_time"
            
            # Verify the created_time property is initialized as an empty hashtable
            $createdTimeProperty.created_time | Should -BeOfType "hashtable"
            $createdTimeProperty.created_time.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have created_time property as hashtable" {
            # Create a new instance
            $createdTimeProperty = [notion_created_time_database_property]::new()
            
            # Verify the created_time property is a hashtable
            $createdTimeProperty.created_time | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $createdTimeProperty.created_time.Count | Should -Be 0
        }
        
        It "Should allow modification of created_time property" {
            # Create a new instance
            $createdTimeProperty = [notion_created_time_database_property]::new()
            
            # Add some test data to the created_time hashtable
            $createdTimeProperty.created_time["timestamp"] = "2025-08-16T10:30:00.000Z"
            $createdTimeProperty.created_time["format"] = "iso"
            
            # Verify the data was added successfully
            $createdTimeProperty.created_time["timestamp"] | Should -Be "2025-08-16T10:30:00.000Z"
            $createdTimeProperty.created_time["format"] | Should -Be "iso"
            $createdTimeProperty.created_time.Count | Should -Be 2
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing created_time information
            $mockObject = [PSCustomObject]@{
                type = "created_time"
                created_time = @{
                    timestamp = "2025-08-16T10:30:00.000Z"
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_created_time_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_created_time_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "created_time"
            
            # Verify the created_time property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.created_time | Should -BeOfType "hashtable"
            $convertedProperty.created_time.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_created_time_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_created_time_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "created_time"
            
            # Verify the created_time property is initialized as empty hashtable
            $convertedProperty.created_time | Should -BeOfType "hashtable"
            $convertedProperty.created_time.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $createdTimeProperty = [notion_created_time_database_property]::new()
            
            # Verify inheritance
            $createdTimeProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $createdTimeProperty = [notion_created_time_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $createdTimeProperty.type | Should -Be "created_time"
        }
    }
}
