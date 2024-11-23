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
class notion_equation_block : notion_block
# https://developers.notion.com/reference/block#equation
{
    [notion_blocktype] $type = "equation"
    [equation_structure] $equation
    
    equation()
    { 
        $this.equation = [equation_structure]::new()
    }

    equation([string] $expression)
    {
        $this.equation = [equation_structure]::new([string] $expression)
    }
    
    static [notion_equation_block] ConvertFromObject($Value)
    {
        $equation_Obj = [notion_equation_block]::new()
        $equation_Obj.equation = [equation_structure]::ConvertFromObject($Value.equation)
        return $equation_Obj
    }
}
