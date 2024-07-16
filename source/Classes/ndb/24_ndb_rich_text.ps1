class ndb_rich_text {
    $type = "rich_text"
    $rich_text = @()
    ndb_rich_text($text) {
        $this.rich_text += [ndb_text]::new($text)
    }
}
