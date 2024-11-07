class code_structure
{
    #TODO: definition correct?
    [rich_text[]] $caption
    [rich_text[]] $rich_text
    #TODO: make sure this is only modified by the setLanguage method
    [string] $private:language

    code_structure()
    {

    }

    code_structure([string] $text, [string] $language)
    {
        if (-not [code]::IsValidLanguage($language))
        {
            throw "Invalid language: $language"
        }
        $this.caption = [rich_text]::new($text)
        $this.rich_text = [rich_text]::new($text)
        $this.language = $language
    }

    code_structure([string] $text, [string] $language, [notion_color] $color)
    {
        if (-not [code]::IsValidLanguage($language))
        {
            throw "Invalid language: $language"
        }
        $this.caption = [rich_text]::new($text, $color)
        $this.rich_text = [rich_text]::new($text, $color)
        $this.language = $language
    }

    static [bool] IsValidLanguage([string]$language)
    {
        $validLanguages = @(
            "abap", "arduino", "bash", "basic", "c", "clojure", "coffeescript", "c++", "c#", "css", "dart", "diff", 
            "docker", "elixir", "elm", "erlang", "flow", "fortran", "f#", "gherkin", "glsl", "go", "graphql", 
            "groovy", "haskell", "html", "java", "javascript", "json", "julia", "kotlin", "latex", "less", "lisp", 
            "livescript", "lua", "makefile", "markdown", "markup", "matlab", "mermaid", "nix", "objective-c", 
            "ocaml", "pascal", "perl", "php", "plain text", "powershell", "prolog", "protobuf", "python", "r", 
            "reason", "ruby", "rust", "sass", "scala", "scheme", "scss", "shell", "sql", "swift", "typescript", 
            "vb.net", "verilog", "vhdl", "visual basic", "webassembly", "xml", "yaml", "java/c/c++/c#"
        )
        return $validLanguages -contains $language
    }

    [string] getLanguage()
    {
        return $this.language
    }
    
    setLanguage([string] $language)
    {
        if (-not [code]::IsValidLanguage($language))
        {
            throw "Invalid language: $language"
        }
        $this.language = $language
    }

    static [code_structure] ConvertFromObject($Value)
    {
        $code_structure = [code_structure]::new()
        $code_structure.caption = $Value.caption.ForEach({ [rich_text]::ConvertFromObject($_) })
        $code_structure.rich_text = $Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        if (-not [code_structure]::IsValidLanguage($Value.language))
        {
            throw "Invalid language: $($Value.language)"
        }
        $code_structure.language = $Value.language
        return $code_structure
    }
}
class code : Block
# https://developers.notion.com/reference/block#code
{
    [blocktype] $type = "code"
    [code_structure] $code

    code(){
        $this.code = [code_structure]::new()
    }

    code([string] $text, [string] $language)
    {
        $this.code = [code_structure]::new($text, $language)
    }

    code([string] $text, [string] $language, [notion_color] $color)
    {
        $this.code = [code_structure]::new($text, $language, $color)
    }

    [string] getLanguage() {
        return $this.code.getLanguage()
    }
    
    setLanguage([string] $language) {
        if (-not [code]::IsValidLanguage($language)) {
            throw "Invalid language: $language"
        }
        $this.code.setLanguage($language)
    }

    static [code] ConvertFromObject($Value)
    {
        $codeObj = [code]::new()
        $codeObj.code = [code_structure]::ConvertFromObject($Value.code)
        return $codeObj
    }
}
