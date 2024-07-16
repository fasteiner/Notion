class ndb_select {
    [string]$type = "select"
    [PSCustomObject]$select
    ndb_select ($name) {
        $this.select = [ndb_nameProperty]::new($name)
    }
}
