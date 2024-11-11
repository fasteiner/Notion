class rich_text_mention_date_structure
{
    [DateTime] $start
    [DateTime] $end

    rich_text_mention_date_structure()
    {
    }
    rich_text_mention_date_structure($start)
    {
        $this.start = $start
    }
    rich_text_mention_date_structure($start, $end)
    {
        $this.start = $start
        $this.end = $end
    }

    static [rich_text_mention_date_structure] ConvertFromObject($value)
    {
        return [rich_text_mention_date_structure]::new($value.start, $value.end)
    }
}


class rich_text_mention_date : rich_text_mention_base
# https://developers.notion.com/reference/rich-text#mention
{
    [rich_text_mention_date_structure] $date
    

    rich_text_mention_date() :base("date")
    {
        
    }

    rich_text_mention_date([rich_text_mention_date_structure] $date) :base("date")
    {
        $this.date = Get-Date $date -Format "yyyy-MM-dd"
    }

    rich_text_mention_date($start) :base("date")
    {
        $this.date = [rich_text_mention_date_structure]::new($start)
    }
    rich_text_mention_date($start, $end) :base("date")
    {
        $this.date = [rich_text_mention_date_structure]::new($start, $end)
    }

    static [rich_text_mention_date] ConvertFromObject($value)
    {
        return [rich_text_mention_date]::new($value.date)
    }
}
