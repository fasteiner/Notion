class Divider : Block
# https://developers.notion.com/reference/block#divider
{
    [blocktype] $type = "divider"
    [string] $url = $null

    divider(){

    }

    divider([string] $url){
        $this.url = $url
    }
    
    static [Divider] ConvertFromObject($Value)
    {
        $Divider = [Divider]::new()
        $Divider.url = $Value.url
        return $Divider
    }
}
