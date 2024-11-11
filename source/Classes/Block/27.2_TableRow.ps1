class TableRow
{
    $cells = @()

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
        if ($object -isnot [System.Array])
        {
            foreach ($property in $object.psobject.properties)
            {
                $this.AddCell($property.value)
                Write-Debug "Added cell $($this.cells[0].count) content: $($property.value)"
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
    AddCell()
    {
        $this.cells += , ([System.Collections.ArrayList](, ([TableCell]::new())))
    }

    AddCell([string]$cellcontent)
    {
        $this.cells += , ([System.Collections.ArrayList](, ([TableCell]::new($cellcontent))))

    }

    AddCell($cellcontent, [annotation]$annotations)
    {
        $this.cells += , ([System.Collections.ArrayList](, ([TableCell]::new($cellcontent, $annotations))))
    }
}
