class equation_structure
{
    [string] $expression = $null

    equation_structure()
    { 
    }

    equation_structure([string] $expression)
    {
        $this.expression = $expression
    }

    static [equation_structure] ConvertFromObject($Value)
    {
        $equation_structure = [equation_structure]::new()
        $equation_structure.expression = $Value.expression
        return $equation_structure
    }
}
class equation : block
# https://developers.notion.com/reference/block#equation
{
    [blocktype] $type = "equation"
    [equation_structure] $equation
    
    equation()
    { 
        $this.equation = [equation_structure]::new()
    }

    equation([string] $expression)
    {
        $this.equation = [equation_structure]::new([string] $expression)
    }
    
    static [equation] ConvertFromObject($Value)
    {
        $equation_Obj = [equation]::new()
        $equation_Obj.equation = [equation_structure]::ConvertFromObject($Value.equation)
        return $equation_Obj
    }
}
