# FILE: Quote/New-NotionQuoteBlock.Tests.ps1
Import-Module Pester

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

Describe "New-NotionQuoteBlock" {
    InModuleScope $moduleName {
        It "Should create an empty quote block" {
            $result = New-NotionQuoteBlock

            $result | Should -BeOfType "notion_quote_block"
            $result.type | Should -Be ([notion_blocktype]::quote)
            $result.quote.rich_text | Should -BeNullOrEmpty
        }

        It "Should create a quote block with text and color" {
            $result = New-NotionQuoteBlock -RichText "Example quote" -Color "gray"

            $result | Should -BeOfType "notion_quote_block"
            $result.quote.rich_text[0].plain_text | Should -Be "Example quote"
            $result.quote.color | Should -Be ([notion_color]::gray)
        }
    }
}
