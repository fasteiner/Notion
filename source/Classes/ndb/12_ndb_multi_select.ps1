class ndb_multi_select {
    $type = "multi_select"
    $multi_select = @()

    ndb_multi_select($name) {
        $this.multi_select += [ndb_nameProperty]::new($name)
    }
}
