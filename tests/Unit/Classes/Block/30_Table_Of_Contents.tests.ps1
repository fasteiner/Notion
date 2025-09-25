
Import-Module Pester -DisableNameChecking

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

Describe "notion_table_of_contents_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_table_of_contents_block" {
            $block = [notion_table_of_contents_block]::new()
            $block | Should -BeOfType "notion_table_of_contents_block"
            $block.type | Should -Be "table_of_contents"
            $block.table_of_contents.GetType().Name | Should -Be "Table_Of_Contents_structure"
        }

        It "Should create a notion_table_of_contents_block with color" {
            $block = [notion_table_of_contents_block]::new("brown")
            $block.table_of_contents | Should -Not -BeNullOrEmpty
            ($block.table_of_contents.GetType().Name) | Should -Be "Table_Of_Contents_structure"
            $block.table_of_contents.color.ToString() | Should -Be "brown"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object with color" {
            $mock = [PSCustomObject]@{
                table_of_contents = [PSCustomObject]@{
                    color = "orange_background"
                }
            }
            $block = [notion_table_of_contents_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_table_of_contents_block"
            ($block.table_of_contents.GetType().Name) | Should -Be "Table_Of_Contents_structure"
            $block.table_of_contents.color.ToString() | Should -Be "orange_background"
        }

        It "Should default to 'default' color if not provided" {
            $mock = [PSCustomObject]@{
                table_of_contents = [PSCustomObject]@{}
            }
            $block = [notion_table_of_contents_block]::ConvertFromObject($mock)
            $block.table_of_contents.color.ToString() | Should -Be "default"
        }
    }
}
