class pp_title {
    $type = "title"
    $title = @()

    pp_title([pp_text]$text) {
        $this.title += $text
    }
}
