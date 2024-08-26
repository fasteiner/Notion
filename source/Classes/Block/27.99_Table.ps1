class Table
{
    $type = "table"
    [int] $table_width = $null
    [System.Collections.ArrayList] $children = @()
    [bool] $has_column_header = $false
    [bool] $has_row_header = $false

    #Table with 1 row and 1 column
    Table()
    {
        $this.table_width = 1
    }

    #Table with 1 row and $table_width columns
    Table ([int] $table_width)
    {
        $this.table_width = $table_width
        for ($i = 0; $i -lt $table_width; $i++)
        {
            $this.children[0].cells += [TableCell]::new()
        }
    }

    #$NotionTable = [NotionTable]::new($TableData, $has_column_header, $has_row_header)
    Table ([pscustomobject[]] $TableData, [bool] $has_column_header, [bool] $has_row_header)
    {
        $this.table_width = $TableData[0].psobject.properties.name.Count
        $this.has_column_header = $has_column_header
        $this.has_row_header = $has_row_header
        if (($has_row_header -eq $false) -and ($has_column_header -eq $true))
        {
            # add first row with column header
            $this.AddRow([TableRow]::new($TableData[0].psobject.properties.name))
            # add data rows
            for ($i = 0; $i -lt $TableData.Count; $i++)
            {
                $this.AddRow([TableRow]::new($TableData[$i]))
            }
        }
        elseif (($has_row_header -eq $true) -and ($has_column_header -eq $false))
        {
            # rotate table
            $headers = $TableData[0].psobject.properties.name
            $data = @()
            foreach ($header in $headers)
            {
                $data = @()
                $data += $header
                for ($i = 0; $i -lt $TableData.Count; $i++)
                {
                    # select attribute values
                    $data += $TableData."$($header)"
                }
                $this.AddRow([TableRow]::new($data))
            }
        }
        else
        {
            throw "Not implemented"
        }
    }

    #Table with $table_height rows and $table_width columns
    # [table]::new(2,3) => table with 2 rows and 3 empty columns
    #TODO
    Table ([int] $table_width, [int] $table_height)
    {
        $this.table_width = $table_width
        $cells = @()
        for ($i = 0; $i -lt $table_width; $i++)
        {
            $cells += [TableCell]::new()
        }
        Write-Host "Cells :$($cells.count)"
        $this.rows = @()
        for ($i = 0; $i -lt $table_height; $i++)
        {
            $this.rows += [TableRow]::new($cells)
        }
        write-host "Rows :$($this.rows.count)"
    }

    #Table with rowarray
    # [table]::new(@([tablerow]::new(),[tablerow]::new()))
    Table ([TableRow[]] $rows)
    {
        $this.children = $rows
    }

    #Table with rowarray and columnheader or rowheader
    # [table]::new(@([tablerow]::new(),[tablerow]::new()), $true, $false)
    Table ([TableRow[]] $rows, [bool] $has_column_header, [bool] $has_row_header)
    {
        $this.children = $rows
        $this.has_column_header = $has_column_header
        $this.has_row_header = $has_row_header
    }

    #adds a row to the table
    # [table]::AddRow([tablerow]::new())
    AddRow ([TableRow] $row)
    {
        $this.children += @{
            "type"      = "table_row"
            "table_row" = $row
        }
    }
    #adds a the array of cells to a new row of the table
    # [table]::AddRow(@([tablecell]::new(),[tablecell]::new()))
    AddRow ([TableCell[]] $cells)
    {
        $this.AddRow([TableRow]::new($cells))
    }

    # enables column header
    # $table.has_column_header()
    #BUG: has_column_header is not working
    has_column_header ()
    {
        $this.has_column_header = $true
    }

    # enables row header
    # $table.has_row_header()
    #BUG: has_row_header is not working
    has_row_header ()
    {
        $this.has_row_header = $true
    }

    # Aus ShopWare kommt ein Array of CustomObjects
}