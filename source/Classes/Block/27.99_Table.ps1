class Table_structure
{
    [int] $table_width = 0
    [bool] $has_column_header = $false
    [bool] $has_row_header = $false

    Table_structure()
    {
    }

    Table_structure ([int] $table_width)
    {
        $this.table_width = $table_width
    }

    Table_structure ([int] $table_width, [bool] $has_column_header, [bool] $has_row_header)
    {
        $this.table_width = $table_width
        $this.has_column_header = $has_column_header
        $this.has_row_header = $has_row_header
    }


    # Table_structure ([int] $table_width, [int] $table_height)
    # {
    #     $this.table_width = $table_width
    # }

    # Table_structure ([notion_table_row_block[]] $rows, [bool] $has_column_header, [bool] $has_row_header)
    # {
    # }

    static [Table_structure] ConvertFromObject($Value)
    {
        $Table_structure_Obj = [Table_structure]::new()
        $Table_structure_Obj.table_width = $Value.table.table_width
        $Table_structure_Obj.has_column_header = $Value.table.has_column_header
        $Table_structure_Obj.has_row_header = $Value.table.has_row_header
        return $Table_structure_Obj
    }
}
class notion_table_block : notion_block
# https://developers.notion.com/reference/block#table
{
    [notion_blocktype] $type = "table"
    [Table_structure] $table

    #Table with 1 row and 1 column
    notion_table_block()
    {
        $this.table = [Table_structure]::new()
    }

    #Table with 1 row and $table_width columns
    # notion_table_block ([int] $table_width)
    # {
    #     $this.table_width = $table_width
    #     for ($i = 0; $i -lt $table_width; $i++)
    #     {
    #         $this.children[0].cells += [TableCell]::new()
    #     }
    # }

    #$NotionTable = [NotionTable]::new($TableData, $has_column_header, $has_row_header)
    # notion_table_block ([pscustomobject[]] $TableData, [bool] $has_column_header, [bool] $has_row_header)
    # {
    #     $this.table_width = $TableData[0].psobject.properties.name.Count
    #     $this.has_column_header = $has_column_header
    #     $this.has_row_header = $has_row_header
    #     if (($has_row_header -eq $false) -and ($has_column_header -eq $true))
    #     {
    #         # add first row with column header
    #         $this.AddRow([notion_table_row_block]::new($TableData[0].psobject.properties.name))
    #         # add data rows
    #         for ($i = 0; $i -lt $TableData.Count; $i++)
    #         {
    #             $this.AddRow([notion_table_row_block]::new($TableData[$i]))
    #         }
    #     }
    #     elseif (($has_row_header -eq $true) -and ($has_column_header -eq $false))
    #     {
    #         # rotate table
    #         $headers = $TableData[0].psobject.properties.name
    #         $data = @()
    #         foreach ($header in $headers)
    #         {
    #             $data = @()
    #             $data += $header
    #             for ($i = 0; $i -lt $TableData.Count; $i++)
    #             {
    #                 # select attribute values
    #                 $data += $TableData."$($header)"
    #             }
    #             $this.AddRow([notion_table_row_block]::new($data))
    #         }
    #     }
    #     else
    #     {
    #         throw "Not implemented"
    #     }
    # }

    #Table with $table_height rows and $table_width columns
    # notion_table_block::new(2,3) => table with 2 rows and 3 empty columns
    Create ([int] $table_width, [int] $table_height)
    {
        #Factory method to create a table with $table_height rows and $table_width columns
        $this.table_width = $table_width
        $this.rows = @()
        for ($i = 0; $i -lt $table_height; $i++)
        {
            $cells = @()
            for ($i = 0; $i -lt $table_width; $i++)
            {
                $cells += [rich_text_text]::new("")
            }
            $this.rows += [notion_table_row_block]::new($cells)
        }
        Write-Debug "Rows :$($this.rows.count)"
    }

    #Table with rowarray
    # notion_table_block::new(@([notion_table_row_block]::new(),[notion_table_row_block]::new()))
    notion_table_block ([notion_table_row_block[]] $rows)
    {
        $this.children = $rows
        $this.table = [Table_structure]::new($rows[0].table_row.cells.count)
    }

    #Table with rowarray and columnheader or rowheader
    # notion_table_block::new(@([notion_table_row_block]::new(),[notion_table_row_block]::new()), $true, $false)
    notion_table_block ([notion_table_row_block[]] $rows, [bool] $has_column_header, [bool] $has_row_header)
    {
        $this.children = $rows
        $this.table = [Table_structure]::new($rows[0].table_row.cells.count, $has_column_header, $has_row_header)
    }

    # #adds a row to the table
    # # notion_table_block::AddRow([notion_table_row_block]::new())
    # AddRow ([notion_table_row_block] $row)
    # {
    #     $this.children += @{
    #         "type"      = "table_row"
    #         "table_row" = $row
    #     }
    # }
    # #adds a the array of cells to a new row of the table
    # # notion_table_block::AddRow(@([tablecell]::new(),[tablecell]::new()))
    # AddRow ([rich_text[]] $cells)
    # {
    #     $this.AddRow([notion_table_row_block]::new($cells))
    # }

    static [notion_table_block] ConvertFromObject($Value)
    {
        $Table_Obj = [notion_table_block]::new()
        $Table_Obj.table = [Table_structure]::ConvertFromObject($Value.table)
        return $Table_Obj
    }
}
