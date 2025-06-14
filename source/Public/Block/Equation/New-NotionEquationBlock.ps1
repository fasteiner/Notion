function New-NotionEquationBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion equation block object.

    .DESCRIPTION
        This function creates a new instance of the notion_equation_block class.
        You can create an empty equation block or provide an expression for the equation.

    .PARAMETER Expression
        The LaTeX expression to be displayed in the equation block.

    .EXAMPLE
        New-NotionEquationBlock -Expression "\frac{a}{b}"

    .EXAMPLE
        New-NotionEquationBlock

    .OUTPUTS
        notion_equation_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', HelpMessage = 'A KaTeX compatible string.')]
        [string]$Expression
    )

    if ($PSCmdlet.ParameterSetName -eq 'Default')
    {
        $obj = [notion_equation_block]::new($Expression)
    }
    else
    {
        $obj = [notion_equation_block]::new()
    }
    return $obj
}
