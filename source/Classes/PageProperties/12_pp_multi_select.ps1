class pp_multi_select {
    $type = "multi_select"
    $multi_select = @()

    pp_multi_select($name) {
        $this.multi_select += [pp_nameProperty]::new($name)
    }
}
