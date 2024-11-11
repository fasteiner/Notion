class bot
# https://developers.notion.com/reference/user#bots
{
    $bot
    $owner
    [string] $workspace_name

    bot()
    {
        Write-Warning "This object is for display only."
    }

    static [bot] ConvertFromObject ($Value)
    {
        $obj = [PSCustomObject]::new()
        $obj = $Value.bot
        $obj.owner = $Value.owner
        $obj.owner.type = [Enum]::Parse([bot_owner_type], $Value.owner.type)
        $obj.workspace_name = $Value.workspace_name
        return $obj
    }
}
