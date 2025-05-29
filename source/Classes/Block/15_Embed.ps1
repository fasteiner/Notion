class embed_structure
{
    [string] $url = $null
    [rich_text[]] $caption = @()
    
    embed_structure()
    {

    }
    embed_structure([string] $url)
    {
        $this.url = $url
    }

    embed_structure([string] $url, $caption)
    {
        $this.url = $url
        $this.caption = [rich_text]::ConvertFromObjects($caption)
    }
    
    static [embed_structure] ConvertFromObject($Value)
    {
        if ($Value -is [embed_structure])
        {
            return $Value
        }
        if ($Value -is [string])
        {
            return [embed_structure]::new($Value)
        }
        $embed_structure = [embed_structure]::new($Value.url, $Value.caption)
        return $embed_structure
    }
}
class notion_embed_block : notion_block
# https://developers.notion.com/reference/block#embed
{
    [notion_blocktype] $type = "embed"
    [embed_structure] $embed

    notion_embed_block()
    {
        $this.embed = [embed_structure]::new()
    }
    notion_embed_block([string] $url)
    {
        $this.embed = [embed_structure]::new($url)
    }

    notion_embed_block([string] $url, $caption)
    {
        $this.embed = [embed_structure]::new($url, $caption)
    }
    
    static [notion_embed_block] ConvertFromObject($Value)
    {
        $embed_Obj = [notion_embed_block]::new()
        $embed_Obj.embed = [embed_structure]::ConvertFromObject($Value.embed)
        return $embed_Obj
    }
}
