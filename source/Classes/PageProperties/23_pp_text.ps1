class pp_text : PageProperties
{
    [pp_textProperty] $text

    pp_text([string] $content)
    {
        $this.text = [pp_textProperty]::new()
        $this.text.content = $content
    }
}
