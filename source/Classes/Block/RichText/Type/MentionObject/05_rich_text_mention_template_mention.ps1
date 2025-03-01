class rich_text_mention_template_mention_structure_base
{
    [string] $type = "template_mention_date"

}
class rich_text_mention_template_mention_template_mention_date_structure : rich_text_mention_template_mention_structure_base{
    [datetime] $template_mention_date = ""

    rich_text_mention_template_mention_template_mention_date_structure() : base("template_mention_date")
    {
    }
    rich_text_mention_template_mention_template_mention_date_structure([string]$template_mention_date) : base("template_mention_date")
    {
        [datetime]$date = get-date
        if([datetime]::TryParse($template_mention_date, [ref]$date)){
            $this.template_mention_date = $date
        }
        else{
            Write-Error "String is not a valid date" -Category InvalidData -TargetObject $template_mention_date -RecommendedAction "Please provide a valid date string"
        }
    }
    rich_text_mention_template_mention_template_mention_date_structure([datetime] $template_mention_date) : base("template_mention_date")
    {
        $this.template_mention_date = $template_mention_date
    }

    static [rich_text_mention_template_mention_template_mention_date_structure] ConvertFromObject($value)
    {
        return [rich_text_mention_template_mention_template_mention_date_structure]::new($value.template_mention_date)
    }
}

class rich_text_mention_template_mention_template_mention_user_structure : rich_text_mention_template_mention_structure_base{
    [string] $template_mention_user = "me"

    rich_text_mention_template_mention_template_mention_user_structure() : base("template_mention_user")
    {
    }
    rich_text_mention_template_mention_template_mention_user_structure($template_mention_user) : base("template_mention_user")
    {
        if($template_mention_user -eq "me"){
            $this.template_mention_user = $template_mention_user
        }
        else{
            Write-Error "Only 'me' is allowed as a user in the current API Version: $script:NotionAPIVersion" -Category InvalidData -TargetObject $template_mention_user -RecommendedAction "Please provide 'me' as a user"
        }
    }

    static [rich_text_mention_template_mention_template_mention_user_structure] ConvertFromObject($value)
    {
        return [rich_text_mention_template_mention_template_mention_user_structure]::new($value.template_mention_user)
    }
}


class rich_text_mention_template_mention : rich_text_mention_base
# https://developers.notion.com/reference/rich-text#mention
{
    [rich_text_mention_template_mention_structure_base] $template_mention
    

    rich_text_mention_template_mention():base("template_mention")
    {
    }

    rich_text_mention_template_mention([rich_text_mention_template_mention_structure_base] $template_mention) :base("template_mention")
    {
        $this.template_mention = $template_mention
    }

    rich_text_mention_template_mention([string] $template_mention_unknown) :base("template_mention")
    {
        # is this a date or a user?
        [datetime]$date = Get-Date
        if ([datetime]::TryParse($template_mention_unknown, [ref]$date)) {
            $this.template_mention = [rich_text_mention_template_mention_template_mention_date_structure]::new($template_mention_unknown)
        } else {
            $this.template_mention = [rich_text_mention_template_mention_template_mention_user_structure]::new($template_mention_unknown)
        }
    }

    static [rich_text_mention_template_mention] ConvertFromObject($value)
    {
        return [rich_text_mention_template_mention]::new($value.template_mention)
    }
}
