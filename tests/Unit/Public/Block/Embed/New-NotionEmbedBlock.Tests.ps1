# FILE: Embed/New-NotionEmbedBlock.Tests.ps1
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

Describe "New-NotionEmbedBlock" {
    InModuleScope $moduleName {
        It "Should create an empty embed block" {
            $result = New-NotionEmbedBlock

            $result | Should -BeOfType "notion_embed_block"
            $result.type | Should -Be ([notion_blocktype]::embed)
            $result.embed.url | Should -BeNullOrEmpty
        }

        It "Should create an embed block with url and caption" {
            $result = New-NotionEmbedBlock -Url "https://example.com" -Caption "Example"

            $result | Should -BeOfType "notion_embed_block"
            $result.embed.url | Should -Be "https://example.com"
            $result.embed.caption[0].plain_text | Should -Be "Example"
        }

        It "Should create an embed block with only url" {
            $result = New-NotionEmbedBlock -Url "https://example.com"

            $result | Should -BeOfType "notion_embed_block"
            $result.embed.url | Should -Be "https://example.com"
            $result.embed.caption | Should -BeNullOrEmpty
        }


    }
}
