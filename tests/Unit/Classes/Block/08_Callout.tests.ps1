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

Describe "notion_callout_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_callout_block" {
            $block = [notion_callout_block]::new()
            $block | Should -BeOfType "notion_callout_block"
            $block.type | Should -Be "callout"
            $block.callout.gettype().Name | Should -Be "callout_structure"
            $block.callout.rich_text | Should -BeNullOrEmpty
            $block.callout.icon | Should -BeNullOrEmpty
            $block.callout.color | Should -Be "default"
        }

        It "Should create from rich_text array and emoji string" {
            $rt = [rich_text_text]::new("Callout text")
            $block = [notion_callout_block]::new(@($rt), "💡", "blue_background")
            $block.callout.rich_text[0].plain_text | Should -Be "Callout text"
            $block.callout.icon.emoji | Should -Be "💡"
            $block.callout.color | Should -Be "blue_background"
        }

        It "Should create from rich_text array and notion_emoji" {
            $rt = [rich_text_text]::new("Emoji object callout")
            $emoji = [notion_emoji]::new("📢")
            $block = [notion_callout_block]::new(@($rt), $emoji, "green_background")
            $block.callout.rich_text[0].plain_text | Should -Be "Emoji object callout"
            $block.callout.icon.emoji | Should -Be "📢"
            $block.callout.color | Should -Be "green_background"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object with emoji icon" {
            $emoji = @{
                type  = "emoji"
                emoji = "🔥"
            }
            $mock = [PSCustomObject]@{
                callout = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted callout" }
                            plain_text = "Converted callout"
                        })
                    icon      = $emoji
                    color     = "red_background"
                }
            }
            $block = [notion_callout_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_callout_block"
            $block.callout.rich_text[0].plain_text | Should -Be "Converted callout"
            $block.callout.icon.emoji | Should -Be "🔥"
            $block.callout.color | Should -Be "red_background"
        }
    }
}
