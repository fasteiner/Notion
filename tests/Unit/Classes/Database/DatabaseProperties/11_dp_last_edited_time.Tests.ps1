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

Describe "notion_last_edited_time_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_last_edited_time_database_property with default constructor" {
            # Create a new instance using the default constructor
            $lastEditedTimeProperty = [notion_last_edited_time_database_property]::new()
            
            # Verify the object is of the correct type
            $lastEditedTimeProperty | Should -BeOfType "notion_last_edited_time_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $lastEditedTimeProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $lastEditedTimeProperty.type | Should -Be "last_edited_time"
            
            # Verify the last_edited_time property is initialized as an empty hashtable
            $lastEditedTimeProperty.last_edited_time | Should -BeOfType "hashtable"
            $lastEditedTimeProperty.last_edited_time.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have last_edited_time property as hashtable" {
            # Create a new instance
            $lastEditedTimeProperty = [notion_last_edited_time_database_property]::new()
            
            # Verify the last_edited_time property is a hashtable
            $lastEditedTimeProperty.last_edited_time | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $lastEditedTimeProperty.last_edited_time.Count | Should -Be 0
        }
        
        It "Should allow modification of last_edited_time property" {
            # Create a new instance
            $lastEditedTimeProperty = [notion_last_edited_time_database_property]::new()
            
            # Add some test data to the last_edited_time hashtable
            $lastEditedTimeProperty.last_edited_time["timestamp"] = "2025-08-16T15:30:00.000Z"
            $lastEditedTimeProperty.last_edited_time["format"] = "iso"
            
            # Verify the data was added successfully
            $lastEditedTimeProperty.last_edited_time["timestamp"] | Should -Be "2025-08-16T15:30:00.000Z"
            $lastEditedTimeProperty.last_edited_time["format"] | Should -Be "iso"
            $lastEditedTimeProperty.last_edited_time.Count | Should -Be 2
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing last_edited_time information
            $mockObject = [PSCustomObject]@{
                type = "last_edited_time"
                last_edited_time = @{
                    timestamp = "2025-08-16T15:30:00.000Z"
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_last_edited_time_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_last_edited_time_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "last_edited_time"
            
            # Verify the last_edited_time property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.last_edited_time | Should -BeOfType "hashtable"
            $convertedProperty.last_edited_time.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_last_edited_time_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_last_edited_time_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "last_edited_time"
            
            # Verify the last_edited_time property is initialized as empty hashtable
            $convertedProperty.last_edited_time | Should -BeOfType "hashtable"
            $convertedProperty.last_edited_time.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $lastEditedTimeProperty = [notion_last_edited_time_database_property]::new()
            
            # Verify inheritance
            $lastEditedTimeProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $lastEditedTimeProperty = [notion_last_edited_time_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $lastEditedTimeProperty.type | Should -Be "last_edited_time"
        }
    }
}
