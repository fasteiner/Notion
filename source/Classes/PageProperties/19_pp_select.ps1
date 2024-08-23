class pp_select {
    [string]$type = "select"
    [PSCustomObject]$select
    pp_select ($name) {
        $this.select = [pp_nameProperty]::new($name)
    }
}
