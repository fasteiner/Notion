class rich_text_equation_structure 
{
    [string] $expression = ""
    
    rich_text_equation_structure()
    {
    }
    
    rich_text_equation_structure($expression)
    {
        $this.expression = $expression
    }
    
    rich_text_equation_structure($expression, $link)
    {
        $this.expression = $expression
    }
    
    static [rich_text_equation_structure] ConvertFromObject($Value)
    {
        $rich_text_equation_structure = [rich_text_equation_structure]::new()
        $rich_text_equation_structure.expression = $Value.expression
        return $rich_text_equation_structure
    }
    
}

class rich_text_equation : rich_text{
# https://developers.notion.com/reference/rich-text#equation
    [rich_text_equation_structure] $equation
    
    rich_text_equation():base("equation")
    {
    }
    
    rich_text_equation([rich_text_equation_structure] $equation) :base("equation")
    {
        $this.equation = $equation
    }
    
    rich_text_equation([string] $content) :base("equation")
    {
        $this.equation = [rich_text_equation_structure]::new($content)
    }

    [string] ToJson([bool]$compress = $false)
    {
        $json = @{
            type = $this.type
            equation = @{
                expression = $this.equation.expression
            }
            annotations = $this.annotations.ToJson()
            plain_text = $this.plain_text
            href = $this.href
        }
        return $json | ConvertTo-Json -Compress:$compress
    }
    
    static [rich_text_equation] ConvertFromObject($Value)
    {
        #TODO: Implement this
        return $null
    }
}
