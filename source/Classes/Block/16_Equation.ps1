class Equation : Block
# https://developers.notion.com/reference/block#equation
{
    [blocktype] $type = "equation"
    [string] $expression = $null
    
    static [Equation] ConvertFromObject($Value)
    {
        $Equation = [Equation]::new()
        $Equation.expression = $Value.expression
        return $Equation
    }
}
