class notion_user : System.IComparable, System.IEquatable[object]
{
    # https://developers.notion.com/reference/user
    [string]$object = "user"
    [string]$id
    [string]$type
    [string]$name
    [string]$avatar_url

    notion_user()
    {
    }

    notion_user([object]$user)
    {
        $this.id = $user.id
        $this.type = $user.type
        $this.name = $user.name
        $this.avatar_url = $user.avatar_url
    }

    notion_user([string]$id)
    {
        $this.id = $id
    }

    [int] CompareTo([object]$other)
    {
        if ($null -eq $other)
        {
            return 1
        }
        if ($other -isnot [notion_user])
        {
            throw [System.ArgumentException]::new("The argument must be a user object.")
        }
        # Compare this instance with other based on id, name, type and avatar_url
        if ($this.id -eq $other.id -and $this.name -eq $other.name -and $this.type -eq $other.type -and $this.avatar_url -eq $other.avatar_url)
        {
            return 0
        }
        else
        {
            return -1
        }
    }
    [bool] Equals([object]$other)
    {
        # Check if the other object is a user and if it is equal to this instance
        if ($other -is [notion_user])
        {
            return $this.CompareTo($other) -eq 0
        }
        return $false
    }

    static [notion_user] ConvertFromObject($Value)
    {
        $user = [notion_user]::new()
        $user.id = $Value.id
        $user.type = $Value.type
        $user.name = $Value.name
        $user.avatar_url = $Value.avatar_url
        return $user
    }
}
