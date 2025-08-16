# Import the module containing the notion_last_edited_by_database_property class
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

Describe "notion_last_edited_by_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_last_edited_by_database_property with default constructor" {
            # Create a new instance using the default constructor
            $lastEditedByProperty = [notion_last_edited_by_database_property]::new()
            
            # Verify the object is of the correct type
            $lastEditedByProperty | Should -BeOfType "notion_last_edited_by_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $lastEditedByProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $lastEditedByProperty.type | Should -Be "last_edited_by"
            
            # Verify the last_edited_by property is initialized as an empty hashtable
            $lastEditedByProperty.last_edited_by | Should -BeOfType "hashtable"
            $lastEditedByProperty.last_edited_by.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have last_edited_by property as hashtable" {
            # Create a new instance
            $lastEditedByProperty = [notion_last_edited_by_database_property]::new()
            
            # Verify the last_edited_by property is a hashtable
            $lastEditedByProperty.last_edited_by | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $lastEditedByProperty.last_edited_by.Count | Should -Be 0
        }
        
        It "Should allow modification of last_edited_by property" {
            # Create a new instance
            $lastEditedByProperty = [notion_last_edited_by_database_property]::new()
            
            # Add some test data to the last_edited_by hashtable
            $lastEditedByProperty.last_edited_by["user_id"] = "87654321-4321-4321-4321-210987654321"
            $lastEditedByProperty.last_edited_by["name"] = "Last Editor"
            
            # Verify the data was added successfully
            $lastEditedByProperty.last_edited_by["user_id"] | Should -Be "87654321-4321-4321-4321-210987654321"
            $lastEditedByProperty.last_edited_by["name"] | Should -Be "Last Editor"
            $lastEditedByProperty.last_edited_by.Count | Should -Be 2
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing last_edited_by information
            $mockObject = [PSCustomObject]@{
                type = "last_edited_by"
                last_edited_by = @{
                    user_id = "87654321-4321-4321-4321-210987654321"
                    name = "Last Editor"
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_last_edited_by_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_last_edited_by_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "last_edited_by"
            
            # Verify the last_edited_by property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.last_edited_by | Should -BeOfType "hashtable"
            $convertedProperty.last_edited_by.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_last_edited_by_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_last_edited_by_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "last_edited_by"
            
            # Verify the last_edited_by property is initialized as empty hashtable
            $convertedProperty.last_edited_by | Should -BeOfType "hashtable"
            $convertedProperty.last_edited_by.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $lastEditedByProperty = [notion_last_edited_by_database_property]::new()
            
            # Verify inheritance
            $lastEditedByProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $lastEditedByProperty = [notion_last_edited_by_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $lastEditedByProperty.type | Should -Be "last_edited_by"
        }
    }
}
