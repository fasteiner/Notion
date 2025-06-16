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

Describe "notion_to_do_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_to_do_block" {
            $block = [notion_to_do_block]::new()
            $block | Should -BeOfType "notion_to_do_block"
            $block.type | Should -Be "to_do"
            $block.to_do | Should -BeNullOrEmpty
        }

        It "Should create a notion_to_do_block with rich_text only" {
            $rt = [rich_text_text]::new("Task 1")
            $block = [notion_to_do_block]::new(@($rt))
            $block.to_do | Should -Not -BeNullOrEmpty
            ($block.to_do.GetType().Name) | Should -Be "to_do_structure"
            $block.to_do.rich_text[0].plain_text | Should -Be "Task 1"
            $block.to_do.checked | Should -BeFalse
            $block.to_do.color.ToString() | Should -Be "default"
        }

        It "Should create a notion_to_do_block with all parameters" {
            $rt = [rich_text_text]::new("Task 2")
            $block = [notion_to_do_block]::new(@($rt), $true, "green")
            $block.to_do.checked | Should -BeTrue
            $block.to_do.color.ToString() | Should -Be "green"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                to_do = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                        type = "text"
                        text = @{ content = "Converted task" }
                        plain_text = "Converted task"
                    })
                    checked = $true
                    color = "blue"
                }
            }
            $block = [notion_to_do_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_to_do_block"
            ($block.to_do.GetType().Name) | Should -Be "to_do_structure"
            $block.to_do.rich_text[0].plain_text | Should -Be "Converted task"
            $block.to_do.checked | Should -BeTrue
            $block.to_do.color.ToString() | Should -Be "blue"
        }

        It "Should default to 'default' color if not provided" {
            $mock = [PSCustomObject]@{
                to_do = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                        type = "text"
                        text = @{ content = "No color task" }
                        plain_text = "No color task"
                    })
                    checked = $false
                }
            }
            $block = [notion_to_do_block]::ConvertFromObject($mock)
            $block.to_do.color.ToString() | Should -Be "default"
        }
    }
}
