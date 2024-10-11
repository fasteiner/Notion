class annotation
# https://developers.notion.com/reference/rich-text#the-annotation-object
{
    [bool] $bold = $false
    [bool] $italic = $false
    [bool] $strikethrough = $false
    [bool] $underline = $false
    [bool] $code = $false
    [notion_color] $color = "default"
    annotation()
    {
        
    }
    # annotation with format option
    # [annotation]::new("bold")
    # [annotation]::new(@("bold","code"))
    annotation($annotations)
    {
        if (!$annotations) {
            return
        }
        $this.bold = $annotations.bold
        $this.italic = $annotations.italic
        $this.strikethrough = $annotations.strikethrough
        $this.underline = $annotations.underline
        $this.code = $annotations.code
        $this.color = [Enum]::Parse([notion_color], $annotations.color)
    }
    annotation([bool]$bold,[bool]$italic,[bool]$strikethrough,[bool]$underline,[bool]$code,[notion_color]$color)
    {
        $this.bold = $bold
        $this.italic = $italic
        $this.strikethrough = $strikethrough
        $this.underline = $underline
        $this.code = $code
        $this.color = $color
    }

    #BUG: color is not working
    #([notion_color].GetEnumNames()) {
    #            {"blue" -or "blue_background" -or "brown" -or "brown_background" -or "default" -or "gray" -or "gray_background" -or "green" -or "green_background" -or "orange" -or "orange_background" -or "yellow" -or "pink" -or "pink_background" -or "purple" -or "purple_background" -or "red" -or "red_background" -or "yellow_background"} {
    #                $this.color = [notion_color]$_
    #            }

    static [annotation] ConvertFromObject($Value)
    {
        return [annotation]::new($Value)
    }
}
