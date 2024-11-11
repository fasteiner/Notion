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
        $embed_structure = [embed]::new()
        $embed_structure.url = $Value.url
        return $embed_structure
    }
}
class embed : block
# https://developers.notion.com/reference/block#embed
{
    [blocktype] $type = "embed"
    [embed_structure] $embed

    embed()
    {
        $this.embed = [embed_structure]::new()
    }
    embed([string] $url)
    {
        $this.embed = [embed_structure]::new($url)
    }
    
    static [embed] ConvertFromObject($Value)
    {
        $embed_Obj = [embed]::new()
        $embed_Obj.embed = [embed_structure]::ConvertFromObject($Value.embed)
        return $embed_Obj
    }
}
