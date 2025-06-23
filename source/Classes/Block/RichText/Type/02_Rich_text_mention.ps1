class rich_text_mention_base
{
    [rich_text_mention_type] $type
    
    rich_text_mention_base()
    {
    }
    rich_text_mention_base([rich_text_mention_type] $type)
    {
        $this.type = $type
    }
}


class rich_text_mention : rich_text
{
    # https://developers.notion.com/reference/rich-text#mention
    [rich_text_mention_base] $mention
    

    rich_text_mention():base("mention")
    {
    }
    rich_text_mention([rich_text_mention_type] $type) :base("mention")
    {
        $this.type = $type

    }

    [string] ToJson([bool]$compress = $false)
    {
        $json = @{
            type = $this.type
        }
        switch ($this.type)
        {
            "database"
            { 
                $json.mention = $this.database.ToJson()
            }
            "date"
            { 
                $json.mention = $this.date.ToJson()
            }
            "link_preview"
            { 
                $json.mention = $this.link_preview.ToJson()
            }
            "page"
            { 
                $json.mention = $this.page.ToJson()
            }
            "template_mention"
            { 
                $json.mention = $this.template_mention.ToJson()
            }
            "user"
            { 
                $json.mention = $this.user.ToJson()
            }
            Default
            {
            }
        }
        $json.annotations = $this.annotations.ToJson()
        $json.plain_text = $this.plain_text
        $json.href = $this.href
        return $json | ConvertTo-Json -Compress:$compress
    }

    #TODO: Implement a factory method to create rich_text_mention objects based on type

    # static [rich_text_mention] Create ([string] $mentionType, [string] $identifier)
    # {
    #     $mentionObj = $null

    #     switch ($mentionType.ToLower())
    #     {
    #         "user"
    #         {
    #             $mentionObj = [rich_text_mention_user]::new($identifier)
    #         }
    #         "page"
    #         {
    #             $mentionObj = [rich_text_mention_page]::new($identifier)
    #         }
    #         "date"
    #         {
    #             $mentionObj = [rich_text_mention_date]::new($identifier)
    #         }
    #         # Add more mention types as needed
    #         default
    #         {
    #             throw "Unsupported mention type: $mentionType"
    #         }
    #     }

    #     $mentionRichText = [rich_text_mention]::new($mentionType)
    #     $mentionRichText.mention = $mentionObj
    #     $mentionRichText.plain_text = "@$identifier"

    #     return $mentionRichText
    # }

    
    static [rich_text_mention] ConvertFromObject($Value)
    {
        $rich_text = [rich_text_mention]::New()
        $rich_text.type = $Value.type
        
        switch ($Value.mention.type)
        {
            "database"
            { 
                $rich_text.mention = [rich_text_mention_database]::ConvertFromObject($Value.mention.database)
            }
            "date"
            { 
                $rich_text.mention = [rich_text_mention_date]::ConvertFromObject($Value.mention.date)
            }
            "link_preview"
            { 
                $rich_text.mention = [rich_text_mention_link_preview]::ConvertFromObject($Value.mention.link_preview)
            }
            "page"
            { 
                $rich_text.mention = [rich_text_mention_page]::ConvertFromObject($Value.mention.page)
            }
            "template_mention"
            { 
                $rich_text.mention = [rich_text_mention_template_mention]::ConvertFromObject($Value.mention.template_mention)
            }
            "user"
            { 
                $rich_text.mention = [rich_text_mention_user]::ConvertFromObject($Value.mention.user)
            }
            Default
            {
            }
        }
        return $rich_text
    }
}
