# FILE: notion_formula_database_property.Class.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g., with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Clean re-import of the module under test
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    # Import Sampler-built module (no version folder for class tests)
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}


InModuleScope -ModuleName $global:moduleName {
    Describe "notion_formula_database_property Tests" {

        Context "Constructors" {
            It "Default ctor should set base type 'formula' and empty structure" {
                $p = [notion_formula_database_property]::new()

                $p | Should -BeOfType "notion_formula_database_property"
                $p.type.ToString() | Should -Be "formula"
                $p.formula.getType().Name | Should -Be "notion_formula_database_property_structure"
                $p.formula.expression | Should -BeNullOrEmpty
            }

            It "Ctor with expression should set nested structure" {
                $p = [notion_formula_database_property]::new("prop('Score') / 100")

                $p.type.ToString() | Should -Be "formula"
                $p.formula.expression | Should -Be "prop('Score') / 100"
            }
        }

        Context "ConvertFromObject()" {
            It "Should convert PSCustomObject with nested formula structure" {
                $mock = [pscustomobject]@{
                    type    = "formula"
                    formula = [pscustomobject]@{ expression = "prop('A') - prop('B')" }
                }

                $p = [notion_formula_database_property]::ConvertFromObject($mock)

                $p | Should -BeOfType "notion_formula_database_property"
                $p.type.ToString() | Should -Be "formula"
                $p.formula.getType().Name | Should -Be "notion_formula_database_property_structure"
                $p.formula.expression | Should -Be "prop('A') - prop('B')"
            }

            It "Should return same instance when already typed" {
                $orig = [notion_formula_database_property]::new("prop('Q')")
                $res = [notion_formula_database_property]::ConvertFromObject($orig)

                [object]::ReferenceEquals($orig, $res) | Should -BeTrue
            }

            It "Should Write-Error and return default instance when formula is missing" {
                $mock = [pscustomobject]@{ type = "formula" }

                $result, $errs = & {
                    $Error.Clear()
                    $r = [notion_formula_database_property]::ConvertFromObject($mock)
                    , $r, $Error.Clone()
                }

                $result | Should -BeOfType "notion_formula_database_property"
                $result.type.ToString() | Should -Be "formula"
                $result.formula.getType().Name | Should -Be "notion_formula_database_property_structure"
                $result.formula.expression | Should -BeNullOrEmpty
                ($errs.Count -ge 1) | Should -BeTrue
            }

            It "Should set .formula `$null if nested ConvertFromObject fails" {
                # Nested structure lacks 'expression' -> returns $null
                $mock = [pscustomobject]@{
                    type    = "formula"
                    formula = [pscustomobject]@{ something = "wrong" }
                }

                $p = [notion_formula_database_property]::ConvertFromObject($mock)

                $p | Should -BeOfType "notion_formula_database_property"
                $p.type.ToString() | Should -Be "formula"
                $p.formula | Should -BeNullOrEmpty
            }
        }
    }
}
