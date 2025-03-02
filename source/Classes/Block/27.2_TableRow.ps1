class TableRow_structure
{
    [rich_text[]]$cells = @()

    #OverloadDefinitions
    #new row with 1 cell
    # [tablerow]::new()
    TableRow()
    {

    }
    #new row with array of cells
    # [tablerow]::new( @( [tablecell]::new("a") , [tablecell]::new("b") ) )|convertto-json -EnumsAsStrings -Depth 5

    TableRow ([object] $object)
    {
        # for each property add a cell
        # if not a list
        if($object -is [TableRow_structure] -and $object.cells){
            $this.cells = $object.cells
        }
        if ($object -isnot [System.Array] -and $object.cells)
        {
            $object.cells.foreach{
                $this.AddCell($_)
            }
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
        $this.AddCell($cellcontent, [annotation]::new())

    }

    AddCell([object]$cellcontent, [object]$annotations)
    {
        [annotation] $anno = [annotation]::new($annotations)
        if($cellcontent -is [string])
        {
            $this.cells += [rich_text_text]::new($cellcontent, $anno)
        }
        elseif ($cellcontent -is [rich_text]) {
            if($annotations.type -ne $null){
                Write-Warning "Both annotations and rich_text object provided. Using only the rich_text object. Add the annotations to the rich_text object instead."
            }
            $this.cells += $cellcontent
        }
        else{
            $this.cells += [rich_text_text]::new($cellcontent, $anno)
        }
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
        if($object -is [array])
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
