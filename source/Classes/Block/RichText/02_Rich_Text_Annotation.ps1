class notion_annotation
# https://developers.notion.com/reference/rich-text#the-annotation-object
{
    [bool] $bold = $false
    [bool] $italic = $false
    [bool] $strikethrough = $false
    [bool] $underline = $false
    [bool] $code = $false
    [notion_color] $color = "default"
    notion_annotation()
    {
        
    }
    # notion_annotation with format option
    # [notion_annotation]::new("bold")
    # [notion_annotation]::new(@("bold","code"))
    notion_annotation($annotations)
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
    notion_annotation([bool]$bold,[bool]$italic,[bool]$strikethrough,[bool]$underline,[bool]$code,[notion_color]$color)
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

    static [notion_annotation] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_annotation]::ConvertFromObject($($Value | ConvertTo-Json))"
        $annotation = [notion_annotation]::new()
        if(!$Value)
        {
            return $null
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
