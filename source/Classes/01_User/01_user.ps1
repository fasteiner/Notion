class user
{
    # https://developers.notion.com/reference/user
    [string]$object = "user"
    [string]$id
    [string]$type
    [string]$name
    [string]$avatar_url

    user()
    {
    }

    user([object]$user)
    {
        $this.id = $user.id
        $this.type = $user.type
        $this.name = $user.name
        $this.avatar_url = $user.avatar_url
    }

    user([string]$id)
    {
        $this.id = $id
    }

    static [user] ConvertFromObject($Value)
    {
        $user = [user]::new()
        $user.id = $Value.id
        $user.type = $Value.type
        $user.name = $Value.name
        $user.avatar_url = $Value.avatar_url
        return $user
    }
}
