class notion_bot_user : notion_user
# https://developers.notion.com/reference/user#bots
{
    $bot
    $owner
    [string] $workspace_name

    notion_bot_user()
    {
        Write-Warning "This object is for display only."
    }

    static [notion_bot_user] ConvertFromObject ($Value)
    {
        $obj = [PSCustomObject]::new()
        $obj = $Value.bot
        $obj.owner = $Value.owner
        $obj.owner.type = [Enum]::Parse([bot_owner_type], $Value.owner.type)
        $obj.workspace_name = $Value.workspace_name
        return $obj
    }
}
