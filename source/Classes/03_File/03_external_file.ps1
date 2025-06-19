class notion_external_file_structure
# https://developers.notion.com/reference/file-object#external-files
{
    [string] $url

    # [notion_external_file]::new("http://..")
    notion_external_file_structure([string]$url)
    {
        $this.url = $url
    }

    static [notion_external_file_structure] ConvertFromObject($Value)
    {        
        Write-Verbose "[notion_external_file_structure]::ConvertFromObject($($Value | ConvertTo-Json))"
        return [notion_external_file_structure]::new($Value.url)
    }
}

class notion_external_file : notion_file
{
    [notion_external_file_structure] $external

    notion_external_file():base("external")
    {
    }

    notion_external_file([string]$url):base("external")
    {
        $this.external = [notion_external_file_structure]::new($url)
    }

    notion_external_file([string]$name, $url):base("external", $name)
    {
        $this.external = [notion_external_file_structure]::new($url)
    }

    notion_external_file([string]$name, $caption, [string]$url):base("external", $name, $caption)
    {
        $this.external = [notion_external_file_structure]::new($url)
    }


    static [notion_external_file] ConvertFromObject($Value)
    {
        if (!$value)
        {
            Write-Verbose "[notion_external_file]::ConvertFromObject() - Value is null or empty"
            return $null
        }
        if ($Value -is [notion_external_file])
        {
            Write-Verbose "[notion_external_file]::ConvertFromObject() - Value is already a notion_external_file object"
            return $Value
        }
        if ($value -is [string])
        {
            Write-Verbose "[notion_external_file]::ConvertFromObject() - Value is a string, creating new notion_external_file with URL: $Value"
            return [notion_external_file]::new($Value)
        }
        if (-not $value.external)
        {
            Write-Error "Value does not contain 'external' property. Cannot convert to notion_external_file." -Category InvalidData -RecommendedAction "Ensure the input object has the 'external' property."
            return $null
        }
        Write-Verbose "[notion_external_file]::ConvertFromObject($($Value | ConvertTo-Json))"
        $notionFileOb = [notion_external_file]::new()
        $notionFileOb.external = [notion_external_file_structure]::ConvertFromObject($Value.external)
        $notionFileOb.type = $Value.type
        $notionFileOb.caption = [rich_text]::ConvertFromObjects($Value.caption)
        $notionFileOb.name = $Value.name
        return $notionFileOb
    }
}
