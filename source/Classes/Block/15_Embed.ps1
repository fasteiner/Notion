class embed_structure
{
    [string] $url = $null
    
    embed_structure()
    {

    }
    embed_structure([string] $url)
    {
        $this.url = $url
    }
    
    static [embed_structure] ConvertFromObject($Value)
    {
        $embed_structure = [embed_structure]::new()
        $embed_structure.url = $Value.url
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
    
    static [notion_embed_block] ConvertFromObject($Value)
    {
        $embed_Obj = [notion_embed_block]::new()
        $embed_Obj.embed = [embed_structure]::ConvertFromObject($Value.embed)
        return $embed_Obj
    }
}
