class notion_page_parent : notion_parent{
    # https://developers.notion.com/reference/parent-object#page-parent
    [string] $page_id

    notion_page_parent() : base("page_id")
    {
    }

    notion_page_parent([string]$page_id) : base("page_id")
    {
        $this.page_id = $page_id
    }

    static [notion_page_parent] ConvertFromObject($Value)
    {
        return [notion_page_parent]::new($Value.page_id)
    }
}
