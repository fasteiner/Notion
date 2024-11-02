class rich_text_equation : rich_text
{
    [string] $expression = ""

    rich_text_equation()
    {
    }

    rich_text_equation($expression)
    {
        $this.expression = $expression
    }

    rich_text_equation($expression, $link)
    {
        $this.expression = $expression
    }

    static [rich_text_equation] ConvertFromObject($Value)
    {
        $rich_text_equation = [rich_text_equation]::new()
        $rich_text_equation.expression = $Value.expression
        return $rich_text_equation
    }
    
}
