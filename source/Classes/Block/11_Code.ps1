class Code : Block
# https://developers.notion.com/reference/block#code
{
    #TODO: definition correct? 
    [blocktype] $type = "code"
    [rich_text[]] $caption
    [rich_text[]] $rich_text
    #TODO: make sure this is only modified by the setLanguage method
    [string] $private:language

    code(){
        
    }

    code([string] $text, [string] $language)
    {
        if (-not [Code]::IsValidLanguage($language)) {
            throw "Invalid language: $language"
        }
        $this.caption = [rich_text]::new($text)
        $this.rich_text = [rich_text]::new($text)
        $this.language = $language
    }

    code([string] $text, [string] $language, [notion_color] $color)
    {
        if (-not [Code]::IsValidLanguage($language)) {
            throw "Invalid language: $language"
        }
        $this.caption = [rich_text]::new($text, $color)
        $this.rich_text = [rich_text]::new($text, $color)
        $this.language = $language
    }

    static [bool] IsValidLanguage([string]$language) {
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

    static [Code] ConvertFromObject($Value)
    {
        $Code = [Code]::new()
        $Code.caption = [rich_text]::ConvertFromObject($Value.code.caption)
        $Code.rich_text = [rich_text]::ConvertFromObject($Value.code.rich_text)
        if (-not [Code]::IsValidLanguage($Value.code.language)) {
            throw "Invalid language: $($Value.code.language)"
        }
        $Code.language = $Value.code.language
        return $Code
    }

    [string] getLanguage() {
        return $this.language
    }
    setLanguage([string] $language) {
        if (-not [Code]::IsValidLanguage($language)) {
            throw "Invalid language: $language"
        }
        $this.language = $language
    }
}
