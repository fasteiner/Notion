# FILE: New-NotionDatabase.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    # Resolve project path relative to this test file
    $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    # Resolve project name if not already set (Sampler helper)
    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Ensure gitversion alias is available
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    # Ensure fresh import of module under test
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    # Import module version from output folder
    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionDatabase" {
    InModuleScope $moduleName {

        Context "Validation & error handling" {
            It "Should throw when -parent_obj is missing" {
                # Define minimal properties
                $props = @{
                    Name = @{
                        type  = "title"
                        title = @{}
                    }
                }
                # Expect error because parent_obj is mandatory
                { New-NotionDatabase -properties $props } | Should -Throw -ErrorId * -Because "Parent object is required"
            }
        }

        Context "Creation with simple string title" {
            It "Should create a Notion database from hashtable parent, string title, and hashtable properties" {
                # Simulate parent hashtable
                $parent = @{
                    type    = "page_id"
                    page_id = "12345678-1234-1234-1234-1234567890ab"
                }
                # Simulate properties hashtable
                $props = @{
                    Name = @{
                        type  = "title"
                        title = @{}
                    }
                }

                # Act
                $db = New-NotionDatabase -parent_obj $parent -title "My New Database" -properties $props

                # Assert base object type
                $db | Should -Not -BeNullOrEmpty
                $db | Should -BeOfType "notion_database"

                # Parent conversion assertions
                $db.parent | Should -Not -BeNullOrEmpty
                $db.parent.type | Should -Be "page_id"
                $db.parent.page_id | Should -Be "12345678-1234-1234-1234-1234567890ab"

                # Title conversion assertions (rich_text[])
                $db.title | Should -Not -BeNullOrEmpty
                $db.title[0].plain_text | Should -Be "My New Database"

                # Properties conversion assertions
                $db.properties | Should -BeOfType "notion_databaseproperties"
                ($db.properties.ContainsKey("Name")) | Should -BeTrue
                $db.properties["Name"].type | Should -Be "title"

                # Basic object metadata
                $db.object | Should -Be "database"
                $db.created_time | Should -Match "^\d{4}-\d{2}-\d{2}T"
            }
        }

        Context "Creation with rich_text style title object" {
            It "Should accept a rich_text-like title object and convert it" {
                # Simulate parent hashtable
                $parent = @{
                    type    = "page_id"
                    page_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
                }
                # Minimal rich_text hashtable input (converted via [rich_text]::ConvertFromObjects)
                $titleObjects = @(
                    @{
                        type = "text"
                        text = @{ content = "Rich Title" }
                    }
                )
                # Properties hashtable
                $props = @{
                    Name = @{
                        type  = "title"
                        title = @{}
                    }
                }

                # Act
                $db = New-NotionDatabase -parent_obj $parent -title $titleObjects -properties $props

                # Assert
                $db | Should -Not -BeNullOrEmpty
                $db | Should -BeOfType "notion_database"
                $db.title | Should -Not -BeNullOrEmpty
                $db.title[0].plain_text | Should -Be "Rich Title"
            }
        }

        Context "Creation with pre-converted notion_databaseproperties" {
            It "Should keep the already-typed notion_databaseproperties instance" {
                # Parent as hashtable
                $parent = @{
                    type    = "page_id"
                    page_id = "00000000-1111-2222-3333-444444444444"
                }
                # Raw hashtable properties
                $rawProps = @{
                    Name = @{
                        type  = "title"
                        title = @{}
                    }
                }
                # Convert to notion_databaseproperties type
                $typedProps = [notion_databaseproperties]::ConvertFromObject($rawProps)

                # Act
                $db = New-NotionDatabase -parent_obj $parent -title "Typed Props DB" -properties $typedProps

                # Assert
                $db | Should -Not -BeNullOrEmpty
                $db.properties | Should -BeOfType "notion_databaseproperties"
                ($db.properties.ContainsKey("Name")) | Should -BeTrue
                $db.title[0].plain_text | Should -Be "Typed Props DB"
            }
        }

        Context "Data integrity" {
            It "Should not archive or trash a newly created database by default" {
                # Parent as hashtable
                $parent = @{
                    type    = "page_id"
                    page_id = "feedface-dead-beef-cafe-babecafebabe"
                }
                # Properties hashtable
                $props = @{
                    Name = @{
                        type  = "title"
                        title = @{}
                    }
                }

                # Act
                $db = New-NotionDatabase -parent_obj $parent -title "Defaults Check" -properties $props

                # Assert that default values are false
                $db.archived | Should -Be $false
                $db.in_trash | Should -Be $false
                $db.is_inline | Should -Be $false
            }
        }
    }
}
