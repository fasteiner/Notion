# FILE: Code/New-NotionCodeBlock.Tests.ps1
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

Describe "New-NotionCodeBlock" {
    InModuleScope $moduleName {
        It "Should create an empty code block" {
            $result = New-NotionCodeBlock

            $result | Should -BeOfType "notion_code_block"
            $result.type | Should -Be ([notion_blocktype]::code)
            $result.code.rich_text | Should -BeEmpty
        }

        It "Should create a code block with text and language" {
            $result = New-NotionCodeBlock -Text '$value = 1' -Language 'powershell'

            $result | Should -BeOfType "notion_code_block"
            $result.code.rich_text[0].plain_text | Should -Be '$value = 1'
            $result.code.language | Should -Be 'powershell'
        }

        It "Should create a code block with caption" {
            $caption = New-NotionRichText -Text 'Example snippet'
            $result = New-NotionCodeBlock -Text 'Write-Output "Hello"' -Caption $caption -Language 'powershell'

            $result | Should -BeOfType "notion_code_block"
            $result.code.caption[0].plain_text | Should -Be 'Example snippet'
        }
    }
}
