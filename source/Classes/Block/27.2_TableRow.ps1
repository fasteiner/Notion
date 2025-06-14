class TableRow_structure
{
    [rich_text[][]]$cells = @()

    #OverloadDefinitions
    #new row with 1 cell
    # [tablerow]::new()
    TableRow_structure()
    {

    }
    #new row with array of cells
    # [tablerow]::new( @( [tablecell]::new("a") , [tablecell]::new("b") ) )|convertto-json -EnumsAsStrings -Depth 5

    TableRow_structure ([object] $object)
    {
        # for each property add a cell
        # if not a list
        if ($object -is [TableRow_structure] -and $object.cells)
        {
            $this.cells = $object.cells
        }
        if ($object -isnot [System.Array] -and $object.cells)
        {
            $object.cells.foreach({
                    $this.AddCell($_)
                })
        }
        else
        {
            Write-Debug "TableData $($object |Out-String )"
            foreach ($item in $object)
            {
                $this.AddCell($item)
                Write-Debug "Added cell $($this.cells[0].count) content: $($item)"
            }
        }
    }
    # Overloaded AddCell methods

    AddCell([object]$cellcontent)
    {
        [rich_text[]] $cell = @()
        if ($cellcontent -is [string] -or $cellcontent -is [int] -or $cellcontent -is [double] -or $cellcontent -is [bool] -or $cellcontent -is [datetime])
        {
            $cell += [rich_text_text]::new($cellcontent.ToString())
        }
        elseif ($cellcontent -is [rich_text])
        {
            $cell += $cellcontent
        }
        elseif ($cellcontent -is [array])
        {
            $cellcontent.foreach({
                    $cell += [rich_text]::ConvertFromObject($_)
                })
        }
        else
        {
            $cell += [rich_text]::ConvertFromObject($cellcontent)
        }
        $this.cells += $cell
    }

    static [TableRow_structure] ConvertFromObject($Value)
    {
        $table_row_Obj = [TableRow_structure]::new()
        $Value.cells.foreach({
                $table_row_Obj.AddCell($_)
            })
        return $table_row_Obj
    }
}

class notion_table_row_block : notion_block
{
    [notion_blocktype] $type = "table_row"
    [TableRow_structure] $table_row

    notion_table_row_block()
    {
        $this.table_row = [TableRow_structure]::new()
    }

    notion_table_row_block([object] $object)
    {
        if ($object -is [array])
        {
            # if array of cells
            $this.table_row = [TableRow_structure]::new($object)
        }
        else
        {
            # if object with properties (full object)
            $this.table_row = [TableRow_structure]::ConvertFromObject($object)
        }
    }

    

    static [notion_table_row_block] ConvertFromObject($Value)
    {
        $table_row_Obj = [notion_table_row_block]::new()
        $table_row_Obj.table_row = [TableRow_structure]::new($Value.cells)
        return $table_row_Obj
    }
}
