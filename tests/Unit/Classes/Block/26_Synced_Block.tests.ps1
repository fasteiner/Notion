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

Describe "notion_synced_block Tests" {
    Context "Constructor Tests" {
        It "Should create an original synced block" {
            $block = [notion_synced_block]::new()
            $block | Should -BeOfType "notion_synced_block"
            $block.type | Should -Be "synced_block"
            ($block.synced_block.GetType().Name) | Should -Be "Synced_Block_structure"
            $block.synced_block.synced_from | Should -BeNullOrEmpty
            $block.synced_block.children | Should -BeNullOrEmpty
        }

        It "Should create a duplicate synced block with block_id" {
            $block = [notion_synced_block]::new([PSCustomObject]@{ block_id = "abc123" })
            $block.synced_block.synced_from.block_id | Should -Be "abc123"
        }
    }

    Context "AddChild Tests" {
        It "Should add a child to an original synced block" {
            $block = [notion_synced_block]::new()
            $child = [notion_paragraph_block]::new(@([rich_text_text]::new("Child text")))
            $block.AddChild($child)
            $block.synced_block.children.Count | Should -Be 1
            ($block.synced_block.children[0].GetType().Name) | Should -Be "notion_paragraph_block"
        }

        It "Should not add a child to a duplicate synced block" {
            $block = [notion_synced_block]::new([PSCustomObject]@{ block_id = "abc123" })
            $child = [notion_paragraph_block]::new(@([rich_text_text]::new("Should not add")))
            $ErrorActionPreference = "SilentlyContinue"
            $block.AddChild($child)
            $ErrorActionPreference = "Continue"
            $Error[0].Exception.Message | Should -Match "Cannot add child to synced block, as this is a duplicate synced block."
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object with synced_from" {
            $mock = [PSCustomObject]@{
                synced_block = [PSCustomObject]@{
                    synced_from = [PSCustomObject]@{
                        block_id = "xyz789"
                    }
                }
            }
            $block = [notion_synced_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_synced_block"
            $block.synced_block.synced_from.block_id | Should -Be "xyz789"
        }

        It "Should convert from object without synced_from" {
            $mock = [PSCustomObject]@{
                synced_block = [PSCustomObject]@{}
            }
            $block = [notion_synced_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_synced_block"
            $block.synced_block.synced_from | Should -BeNullOrEmpty
        }
    }
}
