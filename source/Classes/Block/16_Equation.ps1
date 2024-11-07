class equation_structure
{
    [string] $expression = $null

    equation_structure() { }

    equation_structure([string] $expression)
    {
        $this.expression = $expression
    }

    static [equation_structure] ConvertFromObject($Value)
    {
        $equation_structure = [equation]::new()
        $equation_structure.expression = $Value.expression
        return $equation_structure
    }
}
class equation : Block
# https://developers.notion.com/reference/block#equation
{
    [blocktype] $type = "equation"
    [string] $equation
    
    equation() { 
        $this.equation = [equation_structure]::new()
    }

    equation([string] $expression)
    {
        $this.equation = [equation_structure]::new([string] $expression)
    }
    
    static [equation] ConvertFromObject($Value)
    {
        return [equation_structure]::ConvertFromObject($Value.equation)
    }
}
