class pp_rich_text : PageProperties
{
    # $type = "rich_text"
    [rich_text[]] $rich_text
    
    pp_rich_text($text)
    {
        $this.rich_text = [pp_text]::new($text)
    }

    add($text)
    {
        $this.rich_text += [pp_text]::new($text)
    }

    static [pp_rich_text] ConvertFromObject($Value)
    {
        if ($Value -is [string])
        {
            return [pp_rich_text]::new($Value)
        }
        if ($Value -is [object[]])
        {
            $rich_text = @()
            foreach ($text in $Value)
            {
                $rich_text += [pp_text]::new($text)
            }
            return [pp_rich_text]::new($rich_text)
        }
        return [pp_rich_text]::new($Value)
    }
}
[rich_text]::new($Value)
