class rich_text_mention_user : rich_text_mention_base
# https://developers.notion.com/reference/rich-text#mention
{
    [user] $user
    

    rich_text_mention_user():base("user")
    {
    }

    rich_text_mention_user([user] $user) :base("user")
    {
        $this.user = $user
    }

    rich_text_mention_user([string] $id) :base("user")
    {
        $this.user = [user]::new($id)
    }

    static [rich_text_mention_user] ConvertFromObject($value)
    {
        $rich_text_mention_user = [rich_text_mention_user]::new()
        $rich_text_mention_user.user = [user]::ConvertFromObject($value.user)
        return $rich_text_mention_user
    }
}
