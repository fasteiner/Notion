class ndb_text {
    [ndb_textProperty] $text

    ndb_text([string] $content) {
        $this.text = [ndb_textProperty]::new()
        $this.text.content = $content
    }
}
