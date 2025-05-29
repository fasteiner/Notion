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

    code_structure($text, [string] $language)
    {
        if (-not [code_structure]::IsValidLanguage($language))
        {
            throw "Invalid language: $language"
        }
        $this.rich_text = [rich_text]::ConvertFromObjects($text)
        $this.language = $language
    }

    code_structure($text, $caption, [string] $language)
    {
        if (-not [code_structure]::IsValidLanguage($language))
        {
            throw "Invalid language: $language"
        }
        $this.caption = [rich_text]::ConvertFromObjects($text)
        $this.rich_text = [rich_text]::ConvertFromObjects($text)
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
        if (-not [code_structure]::IsValidLanguage($language))
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
class notion_code_block : notion_block
# https://developers.notion.com/reference/block#code
{
    [notion_blocktype] $type = "code"
    [code_structure] $code

    notion_code_block()
    {
        $this.code = [code_structure]::new()
    }

    notion_code_block($text, [string] $language)
    {
        $this.code = [code_structure]::new($text, $language)
    }

    notion_code_block($text, $caption, [string] $language)
    {
        $this.code = [code_structure]::new($text, $caption, $language)
    }

    [string] getLanguage()
    {
        return $this.code.getLanguage()
    }
    
    setLanguage([string] $language)
    {
        if (-not [code_structure]::IsValidLanguage($language))
        {
            throw "Invalid language: $language"
        }
        $this.code.setLanguage($language)
    }

    static [notion_code_block] ConvertFromObject($Value)
    {
        $code_Obj = [notion_code_block]::new()
        $code_Obj.code = [code_structure]::ConvertFromObject($Value.code)
        return $code_Obj
    }
}
