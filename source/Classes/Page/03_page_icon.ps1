class page_icon
{
    # https://developers.notion.com/reference/page#page-object-properties
    
    #BUG: ist beim erstellen vorhanden, aber leer?!?!
    [notion_file] $file
    [emoji] $emoji

    page_icon($Value)
    {
        switch ($Value.type)
        {
            #TODO: Welche Parameter hat notion_file bei icon?
            "notion_file"
            {
                $this.file = [notion_file]::new($Value.file) 
            }
            "emoji"
            {
                $this.emoji = [emoji]::new($Value.emoji) 
            }
        }
    }

    static [page_icon] ConvertFromObject($Value)
    {
        return [page_icon]::new($Value)
    }
}
