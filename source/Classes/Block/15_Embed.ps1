class Embed : Block
# https://developers.notion.com/reference/block#embed
{
    [blocktype] $type = "embed"
    [string] $url = $null
    
    static [Embed] ConvertFromObject($Value)
    {
        $Embed = [Embed]::new()
        $Embed.url = $Value.url
        return $Embed
    }
}
