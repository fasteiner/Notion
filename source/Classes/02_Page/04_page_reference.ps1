class notion_page_reference{
    [string] $id

    notion_page_reference([string]$id)
    {
        $this.id = $id
    }

    static [notion_page_reference] ConvertFromObject($Value)
    {
        return [notion_page_reference]::new($Value.id)
    }
}
