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

Describe "notion_child_database_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_child_database_block" {
            $block = [notion_child_database_block]::new()
            $block | Should -BeOfType "notion_child_database_block"
            $block.type | Should -Be "child_database"
            $block.child_database.getType().Name  | Should -Be "child_database_structure"
            $block.child_database.title | Should -BeNullOrEmpty
        }

        It "Should create a notion_child_database_block with title" {
            $block = [notion_child_database_block]::new("My Database")
            $block.child_database.title | Should -Be "My Database"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                child_database = @{
                    title = "Converted Title"
                }
            }
            $block = [notion_child_database_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_child_database_block"
            $block.child_database.title | Should -Be "Converted Title"
        }
    }
}
