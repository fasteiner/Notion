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

    [string] ToJson([bool]$compress = $false)
    {
        $json = @{
            bold = $this.bold
            italic = $this.italic
            strikethrough = $this.strikethrough
            underline = $this.underline
            code = $this.code
            color = $this.color.ToString()
        }
        return $json | ConvertTo-Json -Compress:$compress -EnumsAsStrings
    }

    static [annotation] ConvertFromObject($Value)
    {
        Write-Verbose "[annotation]::ConvertFromObject($($Value | ConvertTo-Json))"
        $annotation = [annotation]::new()
        if(!$Value)
        {
            return $annotation
        }
        $annotation.bold = $Value.bold
        $annotation.italic = $Value.italic
        $annotation.strikethrough = $Value.strikethrough
        $annotation.underline = $Value.underline
        $annotation.code = $Value.code
        $annotation.color = [Enum]::Parse([notion_color], $Value.color)
        return $annotation
    }
}
