# Import the module containing the notion_rich_text_database_property class
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

Describe "notion_rich_text_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_rich_text_database_property with default constructor" {
            # Create a new instance using the default constructor
            $richTextProperty = [notion_rich_text_database_property]::new()
            
            # Verify the object is of the correct type
            $richTextProperty | Should -BeOfType "notion_rich_text_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $richTextProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $richTextProperty.type | Should -Be "rich_text"
            
            # Verify the rich_text property is initialized as an empty hashtable
            $richTextProperty.rich_text | Should -BeOfType "hashtable"
            $richTextProperty.rich_text.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have rich_text property as hashtable" {
            # Create a new instance
            $richTextProperty = [notion_rich_text_database_property]::new()
            
            # Verify the rich_text property is a hashtable
            $richTextProperty.rich_text | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $richTextProperty.rich_text.Count | Should -Be 0
        }
        
        It "Should allow modification of rich_text property" {
            # Create a new instance
            $richTextProperty = [notion_rich_text_database_property]::new()
            
            # Add some test data to the rich_text hashtable
            $richTextProperty.rich_text["content"] = @(
                @{
                    type        = "text"
                    text        = @{
                        content = "Hello World"
                        link    = $null
                    }
                    annotations = @{
                        bold   = $true
                        italic = $false
                    }
                }
            )
            
            # Verify the data was added successfully
            $richTextProperty.rich_text["content"].Count | Should -Be 1
            $richTextProperty.rich_text["content"][0]["text"]["content"] | Should -Be "Hello World"
            $richTextProperty.rich_text.Count | Should -Be 1
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing rich_text information
            $mockObject = [PSCustomObject]@{
                type      = "rich_text"
                rich_text = @{
                    content = @(
                        @{
                            type = "text"
                            text = @{
                                content = "Sample text"
                            }
                        }
                    )
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_rich_text_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_rich_text_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "rich_text"
            
            # Verify the rich_text property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.rich_text | Should -BeOfType "hashtable"
            $convertedProperty.rich_text.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_rich_text_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_rich_text_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "rich_text"
            
            # Verify the rich_text property is initialized as empty hashtable
            $convertedProperty.rich_text | Should -BeOfType "hashtable"
            $convertedProperty.rich_text.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $richTextProperty = [notion_rich_text_database_property]::new()
            
            # Verify inheritance
            $richTextProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $richTextProperty = [notion_rich_text_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $richTextProperty.type | Should -Be "rich_text"
        }
    }
}
