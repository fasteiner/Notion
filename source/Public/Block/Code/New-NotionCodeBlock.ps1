function New-NotionCodeBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion code block object.

    .DESCRIPTION
        This function creates a new instance of the notion_code_block class.
        You can create an empty code block, provide code text and language, or provide code text, caption, and language.

    .PARAMETER Text
        The code text to be included in the code block.

    .PARAMETER Caption
        The caption (rich_text[] or object) to be displayed above the code block.

    .PARAMETER Language
        The programming language for syntax highlighting in the code block.

    .EXAMPLE
        New-NotionCodeBlock -Text '$a = 1' -Language 'powershell'

    .EXAMPLE
        New-NotionCodeBlock -Text '$a = 1' -Caption 'Example' -Language 'powershell'

    .EXAMPLE
        New-NotionCodeBlock

    .OUTPUTS
        notion_code_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Code text for the code block.')]
        $Text,

        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Caption to be displayed above the code block.')]
        $Caption,

        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Programming language for syntax highlighting in the code block.')]
        $Language
    )

    $Text = [rich_text]::ConvertFromObject($Text)
    $Caption = [rich_text]::ConvertFromObject($Caption)
    $Language = [code_structure]::ConvertFromObject($Language)

    if ($PSBoundParameters.ContainsKey('Text') -and $PSBoundParameters.ContainsKey('Caption') -and $PSBoundParameters.ContainsKey('Language'))
    {
        $obj = [notion_code_block]::new($Text, $Caption, $Language)
    }
    elseif ($PSBoundParameters.ContainsKey('Text') -and $PSBoundParameters.ContainsKey('Language'))
    {
        $obj = [notion_code_block]::new($Text, $Language)
    }
    else
    {
        $obj = [notion_code_block]::new()
    }
    return $obj
}
