class page_parent
{
    # https://developers.notion.com/reference/parent-object
    [page_parent_type]$type
    #BUG: Wie bekomme ich nur das eine, oder das anderer Property?
    [string]$page_id
    [string]$database_id

    # [page_parent]::new(@{type="page_id"; page_id="1234"})
    # [page_parent]::new(@{type="database_id"; database_id="1234"})
    page_parent([System.Object]$value)
    {
        switch ($Value.type)
        {
            "page_id"
            { 
                Write-Host "page_id"
                $this.type = "page_id"
                $this.page_id = $Value.page_id
            }
            "database_id"
            {
                Write-Host "databse_id"
                $this.type = "database_id"
                $this.database_id = $Value.database_id
            }
            default
            {
                throw "Invalid type"
            }
        }
    }
}
