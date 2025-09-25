# FILE: Heading/New-NotionHeadingBlock.Tests.ps1
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

Describe "New-NotionHeadingBlock" {
    InModuleScope $moduleName {
        It "Should create a level 1 heading block" {
            $result = New-NotionHeadingBlock -Text "Heading" -Level 1

            $result | Should -BeOfType "notion_heading_1_block"
            $result.type | Should -Be ([notion_blocktype]::heading_1)
            $result.heading_1.rich_text[0].plain_text | Should -Be "Heading"
            $result.heading_1.color | Should -Be ([notion_color]::default)
        }

        It "Should create a level 2 heading block with color and toggle" {
            $result = New-NotionHeadingBlock -Text "Section" -Color blue -Level 2 -is_toggleable

            $result | Should -BeOfType "notion_heading_2_block"
            $result.type | Should -Be ([notion_blocktype]::heading_2)
            $result.heading_2.rich_text[0].plain_text | Should -Be "Section"
            $result.heading_2.color | Should -Be ([notion_color]::blue)
            $result.heading_2.is_toggleable | Should -BeTrue
        }
    }
}
