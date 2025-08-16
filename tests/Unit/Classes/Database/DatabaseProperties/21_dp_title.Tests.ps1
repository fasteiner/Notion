# Import the module containing the notion_title_database_property class
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

Describe "notion_title_database_property Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_title_database_property with default constructor" {
            # Create a new instance using the default constructor
            $titleProperty = [notion_title_database_property]::new()
            
            # Verify the object is of the correct type
            $titleProperty | Should -BeOfType "notion_title_database_property"
            
            # Verify it inherits from DatabasePropertiesBase
            $titleProperty | Should -BeOfType "DatabasePropertiesBase"
            
            # Verify the type property is set correctly
            $titleProperty.type | Should -Be "title"
            
            # Verify the title property is initialized as an empty hashtable
            $titleProperty.title | Should -BeOfType "hashtable"
            $titleProperty.title.Count | Should -Be 0
        }
    }
    
    Context "Property Tests" {
        It "Should have title property as hashtable" {
            # Create a new instance
            $titleProperty = [notion_title_database_property]::new()
            
            # Verify the title property is a hashtable
            $titleProperty.title | Should -BeOfType "hashtable"
            
            # Verify it's initially empty
            $titleProperty.title.Count | Should -Be 0
        }
        
        It "Should allow modification of title property" {
            # Create a new instance
            $titleProperty = [notion_title_database_property]::new()
            
            # Add some test data to the title hashtable (should be array of rich_text according to TODO comment)
            $titleProperty.title["content"] = @(
                @{
                    type = "text"
                    text = @{
                        content = "Main Title"
                        link = $null
                    }
                    annotations = @{
                        bold = $true
                        italic = $false
                        strikethrough = $false
                        underline = $false
                        code = $false
                        color = "default"
                    }
                    plain_text = "Main Title"
                    href = $null
                }
            )
            
            # Verify the data was added successfully
            $titleProperty.title["content"].Count | Should -Be 1
            $titleProperty.title["content"][0]["text"]["content"] | Should -Be "Main Title"
            $titleProperty.title.Count | Should -Be 1
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from any object and return default instance" {
            # Test with a simple object containing title information
            $mockObject = [PSCustomObject]@{
                type = "title"
                title = @{
                    content = @(
                        @{
                            type = "text"
                            text = @{
                                content = "Sample Title"
                            }
                            plain_text = "Sample Title"
                        }
                    )
                }
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_title_database_property]::ConvertFromObject($mockObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_title_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "title"
            
            # Verify the title property is initialized as empty hashtable
            # Note: The ConvertFromObject method always returns a new default instance
            $convertedProperty.title | Should -BeOfType "hashtable"
            $convertedProperty.title.Count | Should -Be 0
        }
        
        It "Should convert from null and return default instance" {
            # Call the static ConvertFromObject method with null
            $convertedProperty = [notion_title_database_property]::ConvertFromObject($null)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_title_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "title"
            
            # Verify the title property is initialized as empty hashtable
            $convertedProperty.title | Should -BeOfType "hashtable"
            $convertedProperty.title.Count | Should -Be 0
        }
        
        It "Should convert from complex object with rich text array" {
            # Test with a more complex object structure
            $complexObject = [PSCustomObject]@{
                id = "property-title"
                type = "title"
                title = @(
                    @{
                        type = "text"
                        text = @{
                            content = "Complex Title"
                            link = $null
                        }
                        annotations = @{
                            bold = $false
                            italic = $true
                            strikethrough = $false
                            underline = $false
                            code = $false
                            color = "blue"
                        }
                        plain_text = "Complex Title"
                        href = $null
                    }
                )
            }
            
            # Call the static ConvertFromObject method
            $convertedProperty = [notion_title_database_property]::ConvertFromObject($complexObject)
            
            # Verify the converted object is of the correct type
            $convertedProperty | Should -BeOfType "notion_title_database_property"
            
            # Verify the type property is set correctly
            $convertedProperty.type | Should -Be "title"
            
            # The method returns a fresh instance, so title should be empty
            $convertedProperty.title.Count | Should -Be 0
        }
    }
    
    Context "Inheritance Tests" {
        It "Should inherit from DatabasePropertiesBase" {
            # Create a new instance
            $titleProperty = [notion_title_database_property]::new()
            
            # Verify inheritance
            $titleProperty | Should -BeOfType "DatabasePropertiesBase"
        }
        
        It "Should have type property from base class" {
            # Create a new instance
            $titleProperty = [notion_title_database_property]::new()
            
            # Verify the type property exists and is set correctly by base constructor
            $titleProperty.type | Should -Be "title"
        }
    }
}
