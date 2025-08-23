# Import the module containing the notion_created_by_database_property class
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

Describe "notion_created_by_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_created_by_database_property with default constructor" {
            # Create a new instance using the default constructor
            $createdByProperty = [notion_created_by_database_property]::new()
            
            # Verify the object is of the correct type
            $createdByProperty | Should -BeOfType "notion_created_by_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $createdByProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $createdByProperty.type | Should -Be "created_by"
            
            # Verify the created_by property is initialized as an empty hashtable
            $createdByProperty.created_by | Should -BeOfType "hashtable"
            $createdByProperty.created_by.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have created_by property as hashtable" {
            # Create a new instance
            $createdByProperty = [notion_created_by_database_property]::new()
            
            # Verify the created_by property is a hashtable
            $createdByProperty.created_by | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $createdByProperty.created_by.Count | Should -Be 0
        }
        
        It "Should allow modification of created_by property" {
            # Create a new instance
            $createdByProperty = [notion_created_by_database_property]::new()
            
            # Add some test data to the created_by hashtable
            $createdByProperty.created_by["user_id"] = "12345678-1234-1234-1234-123456789012"
            $createdByProperty.created_by["name"] = "Test User"
            
            # Verify the data was added successfully
            $createdByProperty.created_by["user_id"] | Should -Be "12345678-1234-1234-1234-123456789012"
            $createdByProperty.created_by["name"] | Should -Be "Test User"
            $createdByProperty.created_by.Count | Should -Be 2
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing created_by information
            $mockObject = [PSCustomObject]@{
                type       = "created_by"
                created_by = @{
                    user_id = "12345678-1234-1234-1234-123456789012"
                    name    = "Test User"
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_created_by_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_created_by_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "created_by"
            
            # Verify the created_by property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.created_by | Should -BeOfType "hashtable"
            $convertedProperty.created_by.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_created_by_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_created_by_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "created_by"
            
            # Verify the created_by property is initialized as empty hashtable
            $convertedProperty.created_by | Should -BeOfType "hashtable"
            $convertedProperty.created_by.Count | Should -Be 0
        }
        
        It "Should convert from hashtable and return default instance" {
            # Test with a hashtable input containing user information
            $hashInput = @{
                type       = "created_by"
                created_by = @{ 
                    user_id = "87654321-4321-4321-4321-210987654321"
                    email   = "test@example.com"
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_created_by_database_property]::ConvertFromObject($hashInput)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_created_by_database_property"
            
            # Verify the type property is set correctly (always "created_by" regardless of input)
            $convertedProperty.type | Should -Be "created_by"
            
            # Note: The ConvertFromObject method always returns a new default instance
            # It doesn't preserve the input data, so created_by should be empty
            $convertedProperty.created_by.Count | Should -Be 0
        }
        
        It "Should convert from complex object with nested properties" {
            # Test with a more complex object structure
            $complexObject = [PSCustomObject]@{
                id         = "property-123"
                type       = "created_by"
                created_by = [PSCustomObject]@{
                    object     = "user"
                    id         = "user-456"
                    name       = "Complex User"
                    avatar_url = "https://example.com/avatar.png"
                    type       = "person"
                    person     = @{
                        email = "complex@example.com"
                    }
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_created_by_database_property]::ConvertFromObject($complexObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_created_by_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "created_by"
            
            # The method returns a fresh instance, so created_by should be empty
            $convertedProperty.created_by.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $createdByProperty = [notion_created_by_database_property]::new()
            
            # Verify inheritance
            $createdByProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $createdByProperty = [notion_created_by_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $createdByProperty.type | Should -Be "created_by"
        }
        
        It "Should call base constructor with correct type parameter" {
            # Create a new instance
            $createdByProperty = [notion_created_by_database_property]::new()
            
            # Verify that the base constructor was called with "created_by" parameter
            # This is evidenced by the type property being set correctly
            $createdByProperty.type | Should -Be "created_by"
            $createdByProperty.type | Should -Not -BeNullOrEmpty
        }
    }
}
