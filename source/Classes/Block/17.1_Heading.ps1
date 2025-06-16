class Heading_structure
{
    #https://developers.notion.com/reference/block#headings
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [boolean] $is_toggleable


    Heading_structure()
    {
        $this.rich_text = @()
    }

    # Generates a Heading_structure block with content and a specified level
    # [Heading_structure]::new(1, "Hallo")
    Heading_structure($text)
    {
        $this.is_toggleable = $false
        $this.addRichText($text)
    }

    # Generates a Heading_structure block with content class rich_text and toggleable
    # [Heading_structure]::new(1, [rich_text]::new("Hallo"), $true)
    Heading_structure($content, [bool] $is_toggleable)
    {
        $this.is_toggleable = $is_toggleable
        $this.addRichText($content)
    }

    Heading_structure($text, $color)
    {
        $this.is_toggleable = $false
        $this.color = [Enum]::Parse([notion_color], $color)
        $this.addRichText($text)
    }

    Heading_structure($text, $color, [bool] $is_toggleable)
    {
        $this.is_toggleable = $is_toggleable
        $this.color = [Enum]::Parse([notion_color], $color)
        $this.addRichText($text)
    }

    [void] addRichText($richtext)
    {
        $this.rich_text += [rich_text]::ConvertFromObjects($richtext)
    }

    static [Heading_structure] ConvertFromObject($Value)
    {
        $Heading_structure = [Heading_structure]::new()
        $Heading_structure.rich_text = [rich_text]::ConvertFromObjects($Value.rich_text)
        $Heading_structure.color = [Enum]::Parse([notion_color], $Value.color)
        $Heading_structure.is_toggleable = $Value.is_toggleable
        return $Heading_structure
    }

}

class notion_heading_block : notion_block
{
    [notion_blocktype] $type
    
    notion_heading_block([string] $type) : base ()   
    {
        $this.type = $type
    }

    static [notion_heading_block] Create([int]$level, $text, $color, [bool]$is_toggleable)
    {
        $heading = $null

        switch ($level) 
        {
            1
            {
                $heading = [notion_heading_1_block]::new($text, $color, $is_toggleable) 
            }
            2
            {
                $heading = [notion_heading_2_block]::new($text, $color, $is_toggleable) 
            }
            3
            {
                $heading = [notion_heading_3_block]::new($text, $color, $is_toggleable) 
            }
            default
            {
                Write-Error "Invalid heading level: $level. Supported levels are 1, 2, or 3." -Category InvalidData -TargetObject $level 
            }
        }
        return $heading
    }

    static [notion_heading_block] ConvertFromObject($Value)
    {
        # based on the type of the block, we create the corresponding block object
        $heading = $null
        switch ($Value.type)
        {
            "heading_1"
            {
                $heading = [notion_heading_1_block]::ConvertFromObject($Value) 
            }
            "heading_2"
            {
                $heading = [notion_heading_2_block]::ConvertFromObject($Value) 
            }
            "heading_3"
            {
                $heading = [notion_heading_3_block]::ConvertFromObject($Value) 
            }
        }
        return $heading
    }
}
