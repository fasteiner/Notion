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

Describe "notion_bulleted_list_item_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_bulleted_list_item_block" {
            $block = [notion_bulleted_list_item_block]::new()
            $block | Should -BeOfType "notion_bulleted_list_item_block"
            $block.type | Should -Be "bulleted_list_item"
            $block.bulleted_list_item.rich_text | Should -BeNullOrEmpty
        }

        It "Should create from string and color" {
            $block = [notion_bulleted_list_item_block]::new("Bullet text", "yellow")
            $block.bulleted_list_item.rich_text[0].plain_text | Should -Be "Bullet text"
            $block.bulleted_list_item.color | Should -Be "yellow"
        }

        It "Should create from rich_text array and color" {
            $rt = [rich_text_text]::new("Rich bullet")
            $block = [notion_bulleted_list_item_block]::new(@($rt), "gray")
            $block.bulleted_list_item.rich_text[0].plain_text | Should -Be "Rich bullet"
            $block.bulleted_list_item.color | Should -Be "gray"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                bulleted_list_item = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted bullet" }
                            plain_text = "Converted bullet"
                        })
                    color     = "purple"
                }
            }
            $block = [notion_bulleted_list_item_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_bulleted_list_item_block"
            $block.bulleted_list_item.rich_text[0].plain_text | Should -Be "Converted bullet"
            $block.bulleted_list_item.color | Should -Be "purple"
        }
    }
}
