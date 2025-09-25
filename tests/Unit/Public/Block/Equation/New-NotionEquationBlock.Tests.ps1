# FILE: Equation/New-NotionEquationBlock.Tests.ps1
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

Describe "New-NotionEquationBlock" {
    InModuleScope $moduleName {
        It "Should create an empty equation block" {
            $result = New-NotionEquationBlock

            $result | Should -BeOfType "notion_equation_block"
            $result.type | Should -Be ([notion_blocktype]::equation)
            $result.equation.expression | Should -BeNullOrEmpty
        }

        It "Should create an equation block with expression" {
            $result = New-NotionEquationBlock -Expression '\\frac{a}{b}'

            $result | Should -BeOfType "notion_equation_block"
            $result.equation.expression | Should -Be "\\frac{a}{b}"
        }
    }
}
