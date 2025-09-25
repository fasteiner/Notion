# FILE: Bookmark/New-NotionBookmarkBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    if (-not $ProjectName) {
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionBookmarkBlock" {
    InModuleScope $moduleName {
        It "Should create an empty bookmark block" {
            $result = New-NotionBookmarkBlock

            $result | Should -BeOfType "notion_bookmark_block"
            $result.type | Should -Be ([notion_blocktype]::bookmark)
            $result.bookmark.url | Should -BeNullOrEmpty
        }

        It "Should create a bookmark block with url and caption" {
            $result = New-NotionBookmarkBlock -Url "https://example.com" -Caption "Example Caption"

            $result | Should -BeOfType "notion_bookmark_block"
            $result.type | Should -Be ([notion_blocktype]::bookmark)
            $result.bookmark.url | Should -Be "https://example.com"
            $result.bookmark.caption[0].plain_text | Should -Be "Example Caption"
        }
    }
}
