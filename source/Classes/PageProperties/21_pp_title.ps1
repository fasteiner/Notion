class pp_title : PageProperties
{
    $type = "title"
    $title = @()

    pp_title([pp_text]$text)
    {
        $this.title += $text
    }
}
