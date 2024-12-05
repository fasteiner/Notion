class rich_text_mention_user : rich_text_mention_base
# https://developers.notion.com/reference/rich-text#mention
{
    [notion_user] $user
    

    rich_text_mention_user():base("user")
    {
    }

    rich_text_mention_user([notion_user] $user) :base("user")
    {
        $this.user = $user
    }

    rich_text_mention_user([string] $id) :base("user")
    {
        $this.user = [notion_user]::new($id)
    }

    static [rich_text_mention_user] ConvertFromObject($value)
    {
        $rich_text_mention_user = [rich_text_mention_user]::new()
        $rich_text_mention_user.user = [notion_user]::ConvertFromObject($value)
        return $rich_text_mention_user
    }
}
