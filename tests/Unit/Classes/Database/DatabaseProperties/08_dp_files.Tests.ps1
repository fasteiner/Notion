# Import the module containing the notion_files_database_property class
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

Describe "notion_files_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_files_database_property with default constructor" {
            # Create a new instance using the default constructor
            $filesProperty = [notion_files_database_property]::new()
            
            # Verify the object is of the correct type
            $filesProperty | Should -BeOfType "notion_files_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $filesProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $filesProperty.type | Should -Be "files"
            
            # Verify the files property is initialized as an empty hashtable
            $filesProperty.files | Should -BeOfType "hashtable"
            $filesProperty.files.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have files property as hashtable" {
            # Create a new instance
            $filesProperty = [notion_files_database_property]::new()
            
            # Verify the files property is a hashtable
            $filesProperty.files | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $filesProperty.files.Count | Should -Be 0
        }
        
        It "Should allow modification of files property" {
            # Create a new instance
            $filesProperty = [notion_files_database_property]::new()
            
            # Add some test data to the files hashtable
            $filesProperty.files["file1"] = @{
                name = "document.pdf"
                url = "https://example.com/document.pdf"
                type = "file"
            }
            $filesProperty.files["file2"] = @{
                name = "image.png"
                url = "https://example.com/image.png"
                type = "external"
            }
            
            # Verify the data was added successfully
            $filesProperty.files["file1"]["name"] | Should -Be "document.pdf"
            $filesProperty.files["file2"]["name"] | Should -Be "image.png"
            $filesProperty.files.Count | Should -Be 2
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing files information
            $mockObject = [PSCustomObject]@{
                type = "files"
                files = @{
                    file_list = @(
                        @{
                            name = "test.pdf"
                            url = "https://example.com/test.pdf"
                        }
                    )
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_files_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_files_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "files"
            
            # Verify the files property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.files | Should -BeOfType "hashtable"
            $convertedProperty.files.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_files_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_files_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "files"
            
            # Verify the files property is initialized as empty hashtable
            $convertedProperty.files | Should -BeOfType "hashtable"
            $convertedProperty.files.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $filesProperty = [notion_files_database_property]::new()
            
            # Verify inheritance
            $filesProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $filesProperty = [notion_files_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $filesProperty.type | Should -Be "files"
        }
    }
}
