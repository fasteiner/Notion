# Import the module containing the notion_phone_number_database_property class
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

Describe "notion_phone_number_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_phone_number_database_property with default constructor" {
            # Create a new instance using the default constructor
            $phoneProperty = [notion_phone_number_database_property]::new()
            
            # Verify the object is of the correct type
            $phoneProperty | Should -BeOfType "notion_phone_number_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $phoneProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $phoneProperty.type | Should -Be "phone_number"
            
            # Verify the phone_number property is initialized as an empty hashtable
            $phoneProperty.phone_number | Should -BeOfType "hashtable"
            $phoneProperty.phone_number.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have phone_number property as hashtable" {
            # Create a new instance
            $phoneProperty = [notion_phone_number_database_property]::new()
            
            # Verify the phone_number property is a hashtable
            $phoneProperty.phone_number | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $phoneProperty.phone_number.Count | Should -Be 0
        }
        
        It "Should allow modification of phone_number property" {
            # Create a new instance
            $phoneProperty = [notion_phone_number_database_property]::new()
            
            # Add some test data to the phone_number hashtable
            $phoneProperty.phone_number["number"] = "+49 123 456789"
            $phoneProperty.phone_number["country_code"] = "+49"
            $phoneProperty.phone_number["verified"] = $true
            
            # Verify the data was added successfully
            $phoneProperty.phone_number["number"] | Should -Be "+49 123 456789"
            $phoneProperty.phone_number["country_code"] | Should -Be "+49"
            $phoneProperty.phone_number["verified"] | Should -Be $true
            $phoneProperty.phone_number.Count | Should -Be 3
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing phone_number information
            $mockObject = [PSCustomObject]@{
                type = "phone_number"
                phone_number = @{
                    number = "+1 555 123-4567"
                    verified = $false
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_phone_number_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_phone_number_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "phone_number"
            
            # Verify the phone_number property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.phone_number | Should -BeOfType "hashtable"
            $convertedProperty.phone_number.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_phone_number_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_phone_number_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "phone_number"
            
            # Verify the phone_number property is initialized as empty hashtable
            $convertedProperty.phone_number | Should -BeOfType "hashtable"
            $convertedProperty.phone_number.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $phoneProperty = [notion_phone_number_database_property]::new()
            
            # Verify inheritance
            $phoneProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $phoneProperty = [notion_phone_number_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $phoneProperty.type | Should -Be "phone_number"
        }
    }
}
