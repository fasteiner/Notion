# FILE: ToDo/New-NotionToDoBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionToDoBlock" {
    InModuleScope $moduleName {
        #TODO: check if empty string is allowed over API / how the object should look like

        # It "Should create an empty to-do block" {
        #     $result = New-NotionToDoBlock -RichText ""

        #     $result | Should -BeOfType "notion_to_do_block"
        #     $result.type | Should -Be ([notion_blocktype]::to_do)
        #     $result.to_do.rich_text | Should -Not -BeNullOrEmpty
        #     $result.to_do.rich_text.plain_text | Should -Be ""
        #     $result.to_do.checked | Should -BeFalse
        # }

        It "Should create a to-do block with text" {
            $result = New-NotionToDoBlock -RichText "Buy milk"

            $result.to_do.rich_text[0].plain_text | Should -Be "Buy milk"
            $result.to_do.checked | Should -BeFalse
        }

        It "Should create a to-do block with checked state" {
            $result = New-NotionToDoBlock -RichText "Submit report" -Checked

            $result.to_do.rich_text[0].plain_text | Should -Be "Submit report"
            $result.to_do.checked | Should -BeTrue
        }

        It "Should create a to-do block with default color when not specified" {
            $result = New-NotionToDoBlock -RichText "Default color task"

            $result.to_do.rich_text[0].plain_text | Should -Be "Default color task"
            $result.to_do.color | Should -Be ([notion_color]::default)
        }

        It "Should create a to-do block with specified color" {
            $result = New-NotionToDoBlock -RichText "Red task" -Color ([notion_color]::red)

            $result.to_do.rich_text[0].plain_text | Should -Be "Red task"
            $result.to_do.color | Should -Be ([notion_color]::red)
        }

        It "Should create a to-do block with blue_background color" {
            $result = New-NotionToDoBlock -RichText "Blue background task" -Color ([notion_color]::blue_background)

            $result.to_do.rich_text[0].plain_text | Should -Be "Blue background task"
            $result.to_do.color | Should -Be ([notion_color]::blue_background)
        }

        It "Should handle all color parameters and checked state together" {
            $result = New-NotionToDoBlock -RichText "Complete and green" -Checked -Color ([notion_color]::green)

            $result.to_do.rich_text[0].plain_text | Should -Be "Complete and green"
            $result.to_do.checked | Should -BeTrue
            $result.to_do.color | Should -Be ([notion_color]::green)
        }
    }
}
