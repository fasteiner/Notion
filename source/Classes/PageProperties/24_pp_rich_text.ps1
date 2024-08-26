class pp_rich_text : PageProperties
{
    $type = "rich_text"
    $rich_text = @()
    pp_rich_text($text)
    {
        $this.rich_text += [pp_text]::new($text)
    }
}
