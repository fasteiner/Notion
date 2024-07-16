class ndb_title {
    $type = "title"
    $title = @()

    ndb_title([ndb_text]$text) {
        $this.title += $text
    }
}
