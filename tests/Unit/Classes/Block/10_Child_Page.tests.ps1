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

Describe "notion_child_page_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_child_page_block" {
            $block = [notion_child_page_block]::new()
            $block | Should -BeOfType "notion_child_page_block"
            $block.type | Should -Be "child_page"
            ($block.child_page.GetType().Name) | Should -Be "child_page_structure"
            $block.child_page.title | Should -BeNullOrEmpty
        }

        It "Should create a notion_child_page_block with title" {
            $block = [notion_child_page_block]::new("My Page")
            $block.child_page.title | Should -Be "My Page"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                child_page = @{
                    title = "Converted Page"
                }
            }
            $block = [notion_child_page_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_child_page_block"
            ($block.child_page.GetType().Name) | Should -Be "child_page_structure"
            $block.child_page.title | Should -Be "Converted Page"
        }
    }
}
