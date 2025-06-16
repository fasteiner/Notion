
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

Describe "notion_toggle_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_toggle_block" {
            $block = [notion_toggle_block]::new()
            $block | Should -BeOfType "notion_toggle_block"
            $block.type | Should -Be "toggle"
            $block.toggle | Should -BeNullOrEmpty
        }

        It "Should create a notion_toggle_block with rich_text only" {
            $rt = [rich_text_text]::new("Toggle content")
            $block = [notion_toggle_block]::new(@($rt))
            $block.toggle | Should -Not -BeNullOrEmpty
            ($block.toggle.GetType().Name) | Should -Be "Toggle_structure"
            $block.toggle.rich_text[0].plain_text | Should -Be "Toggle content"
            $block.toggle.color.ToString() | Should -Be "default"
        }

        It "Should create a notion_toggle_block with rich_text and color" {
            $rt = [rich_text_text]::new("Colored toggle")
            $block = [notion_toggle_block]::new(@($rt), "pink")
            $block.toggle.color.ToString() | Should -Be "pink"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                toggle = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                        type = "text"
                        text = @{ content = "Converted toggle" }
                        plain_text = "Converted toggle"
                    })
                    color = "gray_background"
                }
            }
            $block = [notion_toggle_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_toggle_block"
            ($block.toggle.GetType().Name) | Should -Be "Toggle_structure"
            $block.toggle.rich_text[0].plain_text | Should -Be "Converted toggle"
            $block.toggle.color.ToString() | Should -Be "gray_background"
        }

        It "Should default to 'default' color if not provided" {
            $mock = [PSCustomObject]@{
                toggle = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                        type = "text"
                        text = @{ content = "No color toggle" }
                        plain_text = "No color toggle"
                    })
                }
            }
            $block = [notion_toggle_block]::ConvertFromObject($mock)
            $block.toggle.color.ToString() | Should -Be "default"
        }
    }
}
