class rich_text_mention_page_structure
{
    [string] $id = ""

    rich_text_mention_page_structure() 
    {
    }
    rich_text_mention_page_structure($id)
    {
        $this.id = $id
    }

    static [rich_text_mention_page_structure] ConvertFromObject($value)
    {
        [rich_text_mention_page_structure] $struct = [rich_text_mention_page_structure]::new()
        $struct.id = $value.id
        return $struct
    }
}

class rich_text_mention_page : rich_text_mention_base
# https://developers.notion.com/reference/rich-text#mention
{
    [rich_text_mention_page_structure] $page
    

    rich_text_mention_page():base("page")
    {
    }

    rich_text_mention_page([rich_text_mention_page_structure] $page) :base("page")
    {
        $this.page = $page
    }

    rich_text_mention_page([string] $id) :base("page")
    {
        $this.page = [rich_text_mention_page_structure]::new($id)
    }

    static [rich_text_mention_page] ConvertFromObject($value)
    {
        return [rich_text_mention_page]::new($value.page)
    }
}
