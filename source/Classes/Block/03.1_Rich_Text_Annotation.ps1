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
    annotation([hashtable] $annotations)
    {
        switch ($annotations)
        {
            "bold"
            {
                $this.bold = $true 
            }
            "italic"
            {
                $this.italic = $true
            }
            "strikethrough"
            {
                $this.strikethrough = $true
            }
            "underline"
            {
                $this.underline = $true
            }
            "code"
            {
                $this.code = $true
            }
        }
    }

    #BUG: color is not working
    #([notion_color].GetEnumNames()) {
    #            {"blue" -or "blue_background" -or "brown" -or "brown_background" -or "default" -or "gray" -or "gray_background" -or "green" -or "green_background" -or "orange" -or "orange_background" -or "yellow" -or "pink" -or "pink_background" -or "purple" -or "purple_background" -or "red" -or "red_background" -or "yellow_background"} {
    #                $this.color = [notion_color]$_
    #            }

    static ConvertFromObject($Value)
    {
        $annotations = [annotation]::new()
        foreach ($annotation in $Value)
        {
            $annotations += [annotation]::new($annotation)
        }
    }
}
