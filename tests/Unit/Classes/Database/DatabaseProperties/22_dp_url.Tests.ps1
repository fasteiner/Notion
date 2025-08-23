# Import the module containing the notion_url_database_property class
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

Describe "notion_url_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_url_database_property with default constructor" {
            # Create a new instance using the default constructor
            $urlProperty = [notion_url_database_property]::new()
            
            # Verify the object is of the correct type
            $urlProperty | Should -BeOfType "notion_url_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $urlProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $urlProperty.type | Should -Be "url"
            
            # Verify the url property is initialized as an empty hashtable
            $urlProperty.url | Should -BeOfType "hashtable"
            $urlProperty.url.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have url property as hashtable" {
            # Create a new instance
            $urlProperty = [notion_url_database_property]::new()
            
            # Verify the url property is a hashtable
            $urlProperty.url | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $urlProperty.url.Count | Should -Be 0
        }
        
        It "Should allow modification of url property" {
            # Create a new instance
            $urlProperty = [notion_url_database_property]::new()
            
            # Add some test data to the url hashtable
            $urlProperty.url["address"] = "https://www.example.com"
            $urlProperty.url["display_text"] = "Example Website"
            $urlProperty.url["validated"] = $true
            
            # Verify the data was added successfully
            $urlProperty.url["address"] | Should -Be "https://www.example.com"
            $urlProperty.url["display_text"] | Should -Be "Example Website"
            $urlProperty.url["validated"] | Should -Be $true
            $urlProperty.url.Count | Should -Be 3
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing url information
            $mockObject = [PSCustomObject]@{
                type = "url"
                url = @{
                    address = "https://notion.so"
                    validated = $true
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_url_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_url_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "url"
            
            # Verify the url property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.url | Should -BeOfType "hashtable"
            $convertedProperty.url.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_url_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_url_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "url"
            
            # Verify the url property is initialized as empty hashtable
            $convertedProperty.url | Should -BeOfType "hashtable"
            $convertedProperty.url.Count | Should -Be 0
        }
        
        It "Should convert from object with complex url data" {
            # Test with a more complex object structure
            $complexObject = [PSCustomObject]@{
                id = "property-url"
                type = "url"
                url = @{
                    address = "https://github.com/microsoft/vscode"
                    title = "Visual Studio Code Repository"
                    description = "Code editing. Redefined."
                    favicon = "https://github.com/favicon.ico"
                    validated = $true
                    last_checked = "2025-08-16T10:30:00.000Z"
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_url_database_property]::ConvertFromObject($complexObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_url_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "url"
            
            # The method returns a fresh instance, so url should be empty
            $convertedProperty.url.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $urlProperty = [notion_url_database_property]::new()
            
            # Verify inheritance
            $urlProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $urlProperty = [notion_url_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $urlProperty.type | Should -Be "url"
            $urlProperty.type | Should -BeOfType [notion_database_property_type]
        }
    }
}
