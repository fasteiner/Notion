Describe "notion_table_block Tests" {
    BeforeDiscovery {
        $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

        if (-not $ProjectName) {
            $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
        }

        Write-Debug "ProjectName: $ProjectName"
        $global:moduleName = $ProjectName
        Set-Alias -Name gitversion -Value dotnet-gitversion
        $script:version = (gitversion /showvariable MajorMinorPatch)

        Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
        $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
    }

    Context "notion_table_block Constructors" {
        It "should create default notion_table_block" {
            $block = [notion_table_block]::new()
            $block.type | Should -Be "table"
            $block.table.gettype().Name | Should -Be "Table_structure"
        }

        It "should create notion_table_block with rows" {
            $row = [notion_table_row_block]::new(@([rich_text_text]::new("A"), [rich_text_text]::new("B")))
            $block = [notion_table_block]::new(@($row))
            $block.table.table_width | Should -Be 2
            $block.table.children.Count | Should -Be 1
        }

        It "should create notion_table_block with rows and headers" {
            $row = [notion_table_row_block]::new(@([rich_text_text]::new("X")))
            $block = [notion_table_block]::new(@($row), $true, $false)
            $block.table.has_column_header | Should -BeTrue
            $block.table.has_row_header | Should -BeFalse
        }
    }

    Context "notion_table_block Methods" {
        It "should add a row to the table" {
            $block = [notion_table_block]::new()
            $row = [notion_table_row_block]::new()
            $block.addRow($row)
            $block.table.children.Count | Should -Be 1
        }
    }

    Context "ConvertFromObject Tests" {
        It "should convert from object correctly" {
            $object = [PSCustomObject]@{
                table = [PSCustomObject]@{
                    table_width = 3
                    has_column_header = $true
                    has_row_header = $false
                }
            }
            $block = [notion_table_block]::ConvertFromObject($object)
            $block | Should -BeOfType "notion_table_block"
            $block.table.table_width | Should -Be 3
            $block.table.has_column_header | Should -BeTrue
            $block.table.has_row_header | Should -BeFalse
        }
    }

    Context "Edge Cases" {
        It "should handle table with 0 width" {
            $block = [notion_table_block]::new()
            $block.table.table_width | Should -Be 0
        }

        It "should handle empty rows array" {
            $block = [notion_table_block]::new()
            $block.table.children | Should -BeNullOrEmpty
        }
    }
}
