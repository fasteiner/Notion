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
        
        Creates a code block with the specified text and language.

    .EXAMPLE
        New-NotionCodeBlock -Text '$a = 1' -Caption 'Example' -Language 'powershell'

        Creates a code block with the specified text, caption, and language.

    .EXAMPLE
        New-NotionCodeBlock

        Creates an empty code block.

    .OUTPUTS
        [notion_code_block]

    .NOTES
    https://developers.notion.com/reference/block#code
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType([notion_code_block])]
    param (
        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Code text for the code block.')]
        $Text,

        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Caption to be displayed above the code block.')]
        $Caption,

        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Programming language for syntax highlighting in the code block.Values are abap | arduino | bash | basic | c | clojure | coffeescript | c++ | c# | css | dart | diff | docker | elixir | elm | erlang | flow | fortran | f# | gherkin | glsl | go | graphql | groovy | haskell | html | java | javascript | json | julia | kotlin | latex | less | lisp | livescript | lua | makefile | markdown | markup | matlab | mermaid | nix | objective|c | ocaml | pascal | perl | php | plain text | powershell | prolog | protobuf | python | r | reason | ruby | rust | sass | scala | scheme | scss | shell | sql | swift | typescript | vb.net | verilog | vhdl | visual basic | webassembly | xml | yaml | java/c/c++/c#')]
        $Language
    )

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
