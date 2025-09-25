# Import the module containing the notion_comment class
Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

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

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru

}

Describe "notion_comment Tests" {
    Context "Constructor Tests" {
        It "Should create a default notion_comment" {
            $comment = [notion_comment]::new()

            $comment | Should -BeOfType "notion_comment"
            $comment.object | Should -Be "comment"
            $comment.id | Should -Not -BeNullOrEmpty
            { [datetime]::ParseExact($comment.created_time, "yyyy-MM-ddTHH:mm:ss.fffZ", $null) } | Should -Not -Throw
            $comment.rich_text.Count | Should -Be 0
        }

        It "Should create a notion_comment with a specific id" {
            $expectedId = "comment-id"

            $comment = [notion_comment]::new($expectedId)

            $comment.id | Should -Be $expectedId
            $comment.object | Should -Be "comment"
        }

        It "Should convert inputs to their expected types" {
            $parentObject = [PSCustomObject]@{
                type    = "page_id"
                page_id = "page-123"
            }
            $discussionId = "discussion-456"
            $createdTime = "2024-01-01T12:00:00Z"
            $lastEditedTime = "2024-01-02T13:00:00Z"
            $createdBy = [notion_user]::new("user-789")
            $richTextInput = "This is a comment"

            $comment = [notion_comment]::new($parentObject, $discussionId, $createdTime, $lastEditedTime, $createdBy, $richTextInput)

            $comment.parent | Should -BeOfType "notion_page_parent"
            $comment.parent.page_id | Should -Be $parentObject.page_id
            $comment.discussion_id | Should -Be $discussionId
            $comment.created_by | Should -Be $createdBy
            $comment.rich_text.Count | Should -Be 1
            $comment.rich_text[0] | Should -BeOfType "rich_text_text"
            $comment.rich_text[0].plain_text | Should -Be $richTextInput
            $comment.last_edited_time | Should -Be $comment.created_time
        }

        It "Should create a notion_comment with explicit values" {
            $id = "comment-123"
            $parent = [notion_page_parent]::new("page-xyz")
            $discussionId = "discussion-abc"
            $createdTime = "2024-02-03T10:20:30.123Z"
            $lastEditedTime = "2024-02-04T11:21:31.456Z"
            $createdBy = [notion_user]::new("user-xyz")
            $richText = [rich_text_text]::new("Explicit comment")

            $comment = [notion_comment]::new($id, $parent, $discussionId, $createdTime, $lastEditedTime, $createdBy, $richText)

            $comment.id | Should -Be $id
            $comment.parent | Should -Be $parent
            $comment.discussion_id | Should -Be $discussionId
            $comment.created_time | Should -Be $createdTime
            $comment.last_edited_time | Should -Be $lastEditedTime
            $comment.created_by | Should -Be $createdBy
            $comment.rich_text.Count | Should -Be 1
            $comment.rich_text[0].plain_text | Should -Be "Explicit comment"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from a PSCustomObject to notion_comment" {
            $parent = [notion_page_parent]::new("page-555")
            $createdBy = [notion_user]::new("user-321")
            $richTextObjects = @(
                [PSCustomObject]@{
                    type = "text"
                    text = [PSCustomObject]@{
                        content = "Converted comment"
                        link    = $null
                    }
                    plain_text  = "Converted comment"
                    annotations = $null
                    href        = $null
                }
            )
            $createdTimeString = "2024-03-05T09:08:07Z"
            $lastEditedTimeString = "2024-03-05T10:11:12Z"

            $inputObject = [PSCustomObject]@{
                id               = "comment-555"
                parent           = $parent
                discussion_id    = "discussion-555"
                created_time     = $createdTimeString
                last_edited_time = $lastEditedTimeString
                created_by       = $createdBy
                rich_text        = $richTextObjects
            }

            $comment = [notion_comment]::ConvertfromObject($inputObject)

            $expectedCreatedTime = InModuleScope $global:moduleName {
                ConvertTo-NotionFormattedDateTime -InputDate $using:createdTimeString -fieldName "created_time"
            }

            $expectedLastEditedTime = InModuleScope $global:moduleName {
                ConvertTo-NotionFormattedDateTime -InputDate $using:lastEditedTimeString -fieldName "last_edited_time"
            }

            $comment | Should -BeOfType "notion_comment"
            $comment.id | Should -Be $inputObject.id
            $comment.parent | Should -Be $parent
            $comment.discussion_id | Should -Be $inputObject.discussion_id
            $comment.created_by | Should -Be $createdBy
            $comment.created_time | Should -Be $expectedCreatedTime
            $comment.last_edited_time | Should -Be $expectedLastEditedTime
            $comment.rich_text.Count | Should -Be $richTextObjects.Count
            $comment.rich_text[0] | Should -BeOfType "rich_text_text"
            $comment.rich_text[0].plain_text | Should -Be $richTextObjects[0].plain_text
        }
    }
}
