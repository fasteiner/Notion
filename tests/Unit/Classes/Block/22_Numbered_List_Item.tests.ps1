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

Describe "notion_numbered_list_item_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_numbered_list_item_block" {
            $block = [notion_numbered_list_item_block]::new()
            $block | Should -BeOfType "notion_numbered_list_item_block"
            $block.type | Should -Be "numbered_list_item"
            $block.numbered_list_item | Should -BeNullOrEmpty
        }

        It "Should create a notion_numbered_list_item_block with rich_text" {
            $rt = [rich_text_text]::new("Item 1")
            $block = [notion_numbered_list_item_block]::new(@($rt))
            $block.numbered_list_item | Should -Not -BeNullOrEmpty
            ($block.numbered_list_item.GetType().Name) | Should -Be "numbered_list_item_structure"
            $block.numbered_list_item.rich_text[0].plain_text | Should -Be "Item 1"
            $block.numbered_list_item.color.ToString() | Should -Be "default"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                numbered_list_item = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                        type = "text"
                        text = @{ content = "Converted item" }
                        plain_text = "Converted item"
                    })
                    color = "red"
                }
            }
            $block = [notion_numbered_list_item_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_numbered_list_item_block"
            ($block.numbered_list_item.GetType().Name) | Should -Be "numbered_list_item_structure"
            $block.numbered_list_item.rich_text[0].plain_text | Should -Be "Converted item"
            $block.numbered_list_item.color.ToString() | Should -Be "red"
        }

        It "Should default to 'default' color if none provided" {
            $mock = [PSCustomObject]@{
                numbered_list_item = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                        type = "text"
                        text = @{ content = "No color item" }
                        plain_text = "No color item"
                    })
                }
            }
            $block = [notion_numbered_list_item_block]::ConvertFromObject($mock)
            $block.numbered_list_item.color.ToString() | Should -Be "default"
        }
    }
}
