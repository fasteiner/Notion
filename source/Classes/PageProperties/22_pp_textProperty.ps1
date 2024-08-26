class pp_textProperty : PageProperties
{
    [string] $content
    pp_textProperty($content)
    {
        $this.content = $content
    }
}
