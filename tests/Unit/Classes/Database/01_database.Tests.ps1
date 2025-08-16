# FILE: notion_database.Class.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g., with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName) {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Ensure a clean import of the module under test
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    # Import the built module (Sampler output layout without version folder)
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "notion_database Tests" {
    Context "Constructor ([notion_parent], [rich_text[]], [notion_databaseproperties])" {
        It "Should create with rich_text[] title and typed properties" {
            # Arrange
            $parent = [notion_parent]::ConvertFromObject(@{
                type    = "page_id"
                page_id = "11111111-2222-3333-4444-555555555555"
            })

            $titleArray = @([rich_text_text]::new("RT Title"))  # rich_text[]

            $propsTyped = [notion_databaseproperties]::ConvertFromObject(@{
                Name = @{
                    type  = "title"
                    title = @{}
                }
            })

            # Act
            $db = [notion_database]::new($parent, $titleArray, $propsTyped)

            # Assert
            $db | Should -BeOfType "notion_database"
            $db.object | Should -Be "database"
            $db.parent.type | Should -Be "page_id"
            $db.parent.page_id | Should -Be "11111111-2222-3333-4444-555555555555"

            $db.title | Should -Not -BeNullOrEmpty
            $db.title[0].plain_text | Should -Be "RT Title"

            $db.properties | Should -BeOfType "notion_databaseproperties"
            ($db.properties.ContainsKey("Name")) | Should -BeTrue

            # created_time is set in ctor and formatted as UTC ISO 8601
            $db.created_time | Should -Match "^\d{4}-\d{2}-\d{2}T.*Z$"
        }
    }

    Context "Constructor ([notion_parent], [string], [notion_databaseproperties])" {
        It "Should create and wrap string title into rich_text_text" {
            # Arrange
            $parent = [notion_parent]::ConvertFromObject(@{
                type    = "page_id"
                page_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
            })

            $propsTyped = [notion_databaseproperties]::ConvertFromObject(@{
                Name = @{
                    type  = "title"
                    title = @{}
                }
            })

            # Act
            $db = [notion_database]::new($parent, "String Title", $propsTyped)

            # Assert
            $db | Should -BeOfType "notion_database"
            $db.title | Should -Not -BeNullOrEmpty
            $db.title[0].plain_text | Should -Be "String Title"
            $db.parent.page_id | Should -Be "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
        }
    }

    Context "Default constructor ()" {
        It "Should set created_time and leave optional fields unset" {
            # Act
            $db = [notion_database]::new()

            # Assert
            $db | Should -BeOfType "notion_database"
            $db.created_time | Should -Match "^\d{4}-\d{2}-\d{2}T.*Z$"

            # Optional/unset by default
            $db.parent | Should -BeNullOrEmpty
            $db.properties | Should -BeNullOrEmpty
            $db.title | Should -BeNullOrEmpty
            $db.archived | Should -Be $false
            $db.in_trash | Should -Be $false
            $db.is_inline | Should -Be $false
        }
    }

    Context "ConvertFromObject()" {
        It "Should map fields and convert nested objects/arrays correctly" {
            # Arrange: minimal mock object structure returned by the API
            $mock = [PSCustomObject]@{
                id               = "db123"
                created_time     = "2025-08-01T12:34:56.000Z"
                created_by       = [PSCustomObject]@{ id = "user1"; name = "Tester" }
                last_edited_time = "2025-08-02T10:00:00.000Z"
                last_edited_by   = [PSCustomObject]@{ id = "user2"; name = "Editor" }
                title            = @(
                    [PSCustomObject]@{
                        type = "text"
                        text = [PSCustomObject]@{ content = "API Title" }
                        plain_text = "API Title"
                    }
                )
                description      = @(
                    [PSCustomObject]@{
                        type = "text"
                        text = [PSCustomObject]@{ content = "Desc" }
                        plain_text = "Desc"
                    }
                )
                icon             = $null
                cover            = $null
                properties       = @{}   # empty set is fine for class-level test
                parent           = [PSCustomObject]@{
                    type    = "page_id"
                    page_id = "99999999-8888-7777-6666-555555555555"
                }
                url              = "https://www.notion.so/some-db"
                archived         = $false
                in_trash         = $false
                is_inline        = $false
                public_url       = $null
            }

            # Act
            $db = [notion_database]::ConvertFromObject($mock)

            # Assert: identity mapping
            $db.id | Should -Be "db123"
            $db.url | Should -Be "https://www.notion.so/some-db"

            # Nested conversions
            $db.parent.type | Should -Be "page_id"
            $db.parent.page_id | Should -Be "99999999-8888-7777-6666-555555555555"

            # rich_text arrays
            $db.title[0].plain_text | Should -Be "API Title"
            $db.description[0].plain_text | Should -Be "Desc"

            # booleans
            $db.archived | Should -BeFalse
            $db.in_trash | Should -BeFalse
            $db.is_inline | Should -BeFalse

            # properties converted to typed container
            $db.properties | Should -BeOfType "notion_databaseproperties"
        }
    }

    Context "Edge cases" {
        It "Should handle empty properties and null icon/cover gracefully" {
            # Arrange
            $mock = [PSCustomObject]@{
                properties = @{}
                title      = @()
                description= @()
                parent     = [PSCustomObject]@{
                    type    = "workspace"
                    workspace = $true
                }
            }

            # Act
            $db = [notion_database]::ConvertFromObject($mock)

            # Assert
            $db | Should -BeOfType "notion_database"
            $db.properties | Should -BeOfType "notion_databaseproperties"
            $db.title | Should -BeNullOrEmpty
            $db.description | Should -BeNullOrEmpty
            $db.parent.type | Should -Be "workspace"
        }
    }
}
