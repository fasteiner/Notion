Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "notion_equation_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_equation_block" {
            $block = [notion_equation_block]::new()
            $block | Should -BeOfType "notion_equation_block"
            $block.type | Should -Be "equation"
            $block.equation | Should -BeNullOrEmpty
        }

        It "Should create a notion_equation_block with expression" {
            $block = [notion_equation_block]::new("E=mc^2")
            $block.equation.getType().Name | Should -Be "equation_structure"
            $block.equation.expression | Should -Be "E=mc^2"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                equation = [PSCustomObject]@{
                    expression = "a^2 + b^2 = c^2"
                }
            }
            $block = [notion_equation_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_equation_block"
            ($block.equation.GetType().Name) | Should -Be "equation_structure"
            $block.equation.expression | Should -Be "a^2 + b^2 = c^2"
        }
    }
}
