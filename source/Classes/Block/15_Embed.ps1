class Embed : Block
# https://developers.notion.com/reference/block#embed
{
    [blocktype] $type = "embed"
    [string] $url = $null

    embed(){

    }
    embed([string] $url){
        $this.url = $url
    }
    
    static [Embed] ConvertFromObject($Value)
    {
        $Embed = [Embed]::new()
        $Embed.url = $Value.url
        return $Embed
    }
}
