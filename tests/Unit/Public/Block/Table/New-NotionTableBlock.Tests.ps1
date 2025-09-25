Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionTableBlock" {
    InModuleScope $moduleName {

        # Test for parameter set conflict
        It "Should throw an error when both TableData and -empty_table are specified" {
            { New-NotionTableBlock -TableData @( @(1, 2) ) -empty_table } | Should -Throw
        }

        # Test for error on invalid TableData
        It "Should throw an error when TableData is empty" {
            { $ErrorActionPreference = "Stop" ; New-NotionTableBlock -TableData @() } | Should -Throw
        }

        It "Should throw an error when TableData is not an array" {
            { $ErrorActionPreference = "Stop" ; New-NotionTableBlock -TableData $null } | Should -Throw
            { $ErrorActionPreference = "Stop" ; New-NotionTableBlock -TableData 'string' } | Should -Throw
        }

        # Test for valid table creation
        It "Should create a Notion table block with valid data" {
            $data = @( @("Cell1", "Cell2"), @("Cell3", "Cell4") )
            $result = New-NotionTableBlock -TableData $data
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_table_block]
            $result.table.children | Should -Not -BeNullOrEmpty
            $result.table.children.Count | Should -Be 2
            $rowcount = 0
            foreach ($row in $result.table.children)
            {
                $row | Should -BeOfType [notion_table_row_block]
                $row.table_row.cells | Should -Not -BeNullOrEmpty
                $row.table_row.cells.Count | Should -Be 2
                $cellcount = 0
                foreach ($cell in $row.table_row.cells)
                {
                    $cell | Should -BeOfType [rich_text_text]
                    $cell.plain_text | Should -Be $data[$rowcount][$cellcount]
                    $cellcount++
                }
                $rowcount++
            }
        }

        # Test for has_column_header
        It "Should create a table block with column header" {
            $data = @( @("Header1", "Header2"), @("Cell1", "Cell2") )
            $result = New-NotionTableBlock -TableData $data -has_column_header
            $result.table.has_column_header | Should -Be $true
            $result.table.has_row_header | Should -Be $false
            # verify the data
            $rowCount = 0
            foreach ($row in $result.table.children)
            {
                $row | Should -BeOfType [notion_table_row_block]
                $row.table_row.cells | Should -Not -BeNullOrEmpty
                $row.table_row.cells.Count | Should -Be 2
                $cellCount = 0
                foreach ($cell in $row.table_row.cells)
                {
                    $cell | Should -BeOfType [rich_text_text]
                    $cell.plain_text | Should -Be $data[$rowCount][$cellCount]
                    $cellCount++
                }
                $rowcount++
            }
        }

        # Test for has_row_header
        It "Should create a table block with row header" {
            $data = @( @("Header1", "Cell1"), @("Header2", "Cell2") )
            $result = New-NotionTableBlock -TableData $data -has_row_header -NoPivot
            $result.table.has_row_header | Should -Be $true
            $result.table.has_column_header | Should -Be $false
            # verify the data
            $rowCount = 0
            foreach ($row in $result.table.children)
            {
                $row | Should -BeOfType [notion_table_row_block]
                $row.table_row.cells | Should -Not -BeNullOrEmpty
                $row.table_row.cells.Count | Should -Be 2
                $cellCount = 0
                foreach ($cell in $row.table_row.cells)
                {
                    $cell | Should -BeOfType [rich_text_text]
                    $cell.plain_text | Should -Be $data[$rowCount][$cellCount]
                    $cellCount++
                }
                $rowCount++
            }
        }

        # Test for hashtable input
        It "Should create a table block from hashtable array" {
            $tabledata = @(
                @{ Col1 = 'A'; Col2 = 'B' },
                @{ Col1 = 'C'; Col2 = 'D' }
            )
            $result = New-NotionTableBlock -TableData $tabledata
            $result | Should -BeOfType "notion_table_block"
            # is automatically set by the function
            $result.table.has_column_header | Should -Be $true
            # should have 3 rows: 2 data rows + 1 header row
            $result.table.children.Count | Should -Be 3
            $expected = @(
                @($tabledata.Keys | Sort-Object -Unique ),
                @("A", "B"),
                @("C", "D")
            )
            $rowCount = 0
            foreach ($row in $result.table.children)
            {
                $row | Should -BeOfType [notion_table_row_block]
                $row.table_row.cells | Should -Not -BeNullOrEmpty
                $row.table_row.cells.Count | Should -Be 2
                $cellCount = 0
                foreach ($cell in $row.table_row.cells)
                {
                    $cell | Should -BeOfType [rich_text_text]
                    $cell.plain_text | Should -Be $expected[$rowCount][$cellCount]
                    $cellCount++
                }
                $rowCount++
            }
        }

        # # Test for hashtable input
        It "Should create a table block from ordered hashtable array" {
            $tabledata = @(
                [ordered]@{ Col2 = 'A'; Col1 = 'B' },
                [ordered]@{ Col2 = 'C'; Col1 = 'D' }
            )
            $result = New-NotionTableBlock -TableData $tabledata
            $result | Should -BeOfType "notion_table_block"
            # is automatically set by the function
            $result.table.has_column_header | Should -Be $true
            # should have 3 rows: 2 data rows + 1 header row
            $result.table.children.Count | Should -Be 3
            $expected = @(
                @($tabledata.Keys),
                @("A", "B"),
                @("C", "D")
            )
            $rowCount = 0
            foreach ($row in $result.table.children)
            {
                $row | Should -BeOfType [notion_table_row_block]
                $row.table_row.cells | Should -Not -BeNullOrEmpty
                $row.table_row.cells.Count | Should -Be 2
                $cellCount = 0
                foreach ($cell in $row.table_row.cells)
                {
                    $cell | Should -BeOfType [rich_text_text]
                    $cell.plain_text | Should -Be $expected[$rowCount][$cellCount]
                    $cellCount++
                }
                $rowCount++
            }
        }

        # # Test for empty table
        It "Should create an empty Notion table block when -empty_table is specified" {
            $result = New-NotionTableBlock -empty_table
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [notion_table_block]
        }

        # Test for hashtable input with unsorted keys
        It "Should create a table block from hashtable array with unsorted keys" {
            $tabledata = @(
                @{ ColB = '1'; ColA = '2' },
                @{ ColB = '3'; ColA = '4' }
            )
            $result = New-NotionTableBlock -TableData $tabledata
            $result | Should -BeOfType "notion_table_block"
            $result.table.has_column_header | Should -Be $true
            $result.table.children.Count | Should -Be 3
            $headers = @($tabledata[0].Keys | Sort-Object)
            $expected = @(
                $headers,
                @($tabledata[0][$headers[0]], $tabledata[0][$headers[1]]),
                @($tabledata[1][$headers[0]], $tabledata[1][$headers[1]])
            )
            $rowCount = 0
            foreach ($row in $result.table.children)
            {
                $row | Should -BeOfType [notion_table_row_block]
                $row.table_row.cells | Should -Not -BeNullOrEmpty
                $row.table_row.cells.Count | Should -Be 2
                $cellCount = 0
                foreach ($cell in $row.table_row.cells)
                {
                    $cell | Should -BeOfType [rich_text_text]
                    $cell.plain_text | Should -Be $expected[$rowCount][$cellCount]
                    $cellCount++
                }
                $rowCount++
            }
        }

        # Test for single-row hashtable array
        It "Should create a table block from single-row hashtable array" {
            $tabledata = @(
                @{ Col1 = 'A'; Col2 = 'B' }
            )
            $result = New-NotionTableBlock -TableData $tabledata
            $result | Should -BeOfType "notion_table_block"
            $result.table.has_column_header | Should -Be $true
            $result.table.children.Count | Should -Be 2
            $headers = @($tabledata[0].Keys | Sort-Object)
            $expected = @(
                $headers,
                @($tabledata[0][$headers[0]], $tabledata[0][$headers[1]])
            )
            $rowCount = 0
            foreach ($row in $result.table.children)
            {
                $row | Should -BeOfType [notion_table_row_block]
                $row.table_row.cells | Should -Not -BeNullOrEmpty
                $row.table_row.cells.Count | Should -Be 2
                $cellCount = 0
                foreach ($cell in $row.table_row.cells)
                {
                    $cell | Should -BeOfType [rich_text_text]
                    $cell.plain_text | Should -Be $expected[$rowCount][$cellCount]
                    $cellCount++
                }
                $rowCount++
            }
        }

        # Test for empty hashtable array
        It "Should throw for empty hashtable array" {
            $tabledata = @()
            { $ErrorActionPreference = "Stop" ; New-NotionTableBlock -TableData $tabledata } | Should -Throw
        }
        
        It "Should throw for hashtable and both headers" {
            $tabledata = @(
                @{ Col1 = 'A'; Col2 = 'B' }
            )
            { $ErrorActionPreference = "Stop" ; New-NotionTableBlock -TableData $tabledata -has_column_header -has_row_header } | Should -Throw
        }

        # Test for array of arrays with only one row
        It "Should create a table block from single-row array of arrays" {
            $data = @(, @("A", "B"))
            $result = New-NotionTableBlock -TableData $data
            $result | Should -BeOfType [notion_table_block]
            $result.table.children.Count | Should -Be 1
            $row = $result.table.children[0]
            $row | Should -BeOfType [notion_table_row_block]
            $row.table_row.cells.Count | Should -Be 2
            $row.table_row.cells[0].plain_text | Should -Be "A"
            $row.table_row.cells[1].plain_text | Should -Be "B"
        }

        # Test for array of arrays with only one column
        It "Should create a table block from array of arrays with one column" {
            $data = @(@("A"), @("B"))
            $result = New-NotionTableBlock -TableData $data
            $result | Should -BeOfType [notion_table_block]
            $result.table.children.Count | Should -Be 2
            $result.table.children[0].table_row.cells.Count | Should -Be 1
            $result.table.children[0].table_row.cells[0].plain_text | Should -Be "A"
            $result.table.children[1].table_row.cells[0].plain_text | Should -Be "B"
        }
    }
}
