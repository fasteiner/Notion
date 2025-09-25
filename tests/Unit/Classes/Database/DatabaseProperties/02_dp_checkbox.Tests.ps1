# Import the module containing the notion_checkbox_database_property class
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

Describe "notion_checkbox_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_checkbox_database_property with default constructor" {
            # Create a new instance using the default constructor
            $checkboxProperty = [notion_checkbox_database_property]::new()
            
            # Verify the object is of the correct type
            $checkboxProperty | Should -BeOfType "notion_checkbox_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $checkboxProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $checkboxProperty.type | Should -Be "checkbox"
            
            # Verify the checkbox property is initialized as an empty hashtable
            $checkboxProperty.checkbox | Should -BeOfType "hashtable"
            $checkboxProperty.checkbox.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have checkbox property as hashtable" {
            # Create a new instance
            $checkboxProperty = [notion_checkbox_database_property]::new()
            
            # Verify the checkbox property is a hashtable
            $checkboxProperty.checkbox | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $checkboxProperty.checkbox.Count | Should -Be 0
        }
        
        It "Should allow modification of checkbox property" {
            # Create a new instance
            $checkboxProperty = [notion_checkbox_database_property]::new()
            
            # Add some test data to the checkbox hashtable
            $checkboxProperty.checkbox["test_key"] = "test_value"
            
            # Verify the data was added successfully
            $checkboxProperty.checkbox["test_key"] | Should -Be "test_value"
            $checkboxProperty.checkbox.Count | Should -Be 1
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object
            $mockObject = [PSCustomObject]@{
                type     = "checkbox"
                checkbox = @{}
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_checkbox_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_checkbox_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "checkbox"
            
            # Verify the checkbox property is initialized as empty hashtable
            $convertedProperty.checkbox | Should -BeOfType "hashtable"
            $convertedProperty.checkbox.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_checkbox_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_checkbox_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "checkbox"
            
            # Verify the checkbox property is initialized as empty hashtable
            $convertedProperty.checkbox | Should -BeOfType "hashtable"
        }
        
        It "Should convert from hashtable and return default instance" {
            # Test with a hashtable input
            $hashInput = @{
                type     = "checkbox"
                checkbox = @{ some_property = "some_value" }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_checkbox_database_property]::ConvertFromObject($hashInput)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_checkbox_database_property"
            
            # Verify the type property is set correctly (always "checkbox" regardless of input)
            $convertedProperty.type | Should -Be "checkbox"
            
            # Note: The ConvertFromObject method always returns a new default instance
            # It doesn't preserve the input data, so checkbox should be empty
            $convertedProperty.checkbox.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $checkboxProperty = [notion_checkbox_database_property]::new()
            
            # Verify inheritance
            $checkboxProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $checkboxProperty = [notion_checkbox_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $checkboxProperty.type | Should -Be "checkbox"
        }
    }
}
