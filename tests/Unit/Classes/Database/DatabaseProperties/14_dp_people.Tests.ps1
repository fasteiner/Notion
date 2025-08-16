# Import the module containing the notion_people_database_property class
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

Describe "notion_people_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_people_database_property with default constructor" {
            # Create a new instance using the default constructor
            $peopleProperty = [notion_people_database_property]::new()
            
            # Verify the object is of the correct type
            $peopleProperty | Should -BeOfType "notion_people_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $peopleProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $peopleProperty.type | Should -Be "people"
            
            # Verify the people property is initialized as an empty hashtable
            $peopleProperty.people | Should -BeOfType "hashtable"
            $peopleProperty.people.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have people property as hashtable" {
            # Create a new instance
            $peopleProperty = [notion_people_database_property]::new()
            
            # Verify the people property is a hashtable
            $peopleProperty.people | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $peopleProperty.people.Count | Should -Be 0
        }
        
        It "Should allow modification of people property" {
            # Create a new instance
            $peopleProperty = [notion_people_database_property]::new()
            
            # Add some test data to the people hashtable
            $peopleProperty.people["person1"] = @{
                id    = "12345678-1234-1234-1234-123456789012"
                name  = "John Doe"
                email = "john@example.com"
            }
            $peopleProperty.people["person2"] = @{
                id    = "87654321-4321-4321-4321-210987654321"
                name  = "Jane Smith"
                email = "jane@example.com"
            }
            
            # Verify the data was added successfully
            $peopleProperty.people["person1"]["name"] | Should -Be "John Doe"
            $peopleProperty.people["person2"]["name"] | Should -Be "Jane Smith"
            $peopleProperty.people.Count | Should -Be 2
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing people information
            $mockObject = [PSCustomObject]@{
                type   = "people"
                people = @{
                    users = @(
                        @{
                            id   = "12345678-1234-1234-1234-123456789012"
                            name = "Test User"
                        }
                    )
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_people_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_people_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "people"
            
            # Verify the people property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.people | Should -BeOfType "hashtable"
            $convertedProperty.people.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_people_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_people_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "people"
            
            # Verify the people property is initialized as empty hashtable
            $convertedProperty.people | Should -BeOfType "hashtable"
            $convertedProperty.people.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $peopleProperty = [notion_people_database_property]::new()
            
            # Verify inheritance
            $peopleProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $peopleProperty = [notion_people_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $peopleProperty.type | Should -Be "people"
        }
    }
}
