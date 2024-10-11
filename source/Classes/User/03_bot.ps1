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
        $bot = [PSCustomObject]::new()
        $bot = $Value.bot
        $bot.owner = $Value.owner
        $bot.owner.type = [Enum]::Parse([bot_owner_type], $Value.owner.type)
        $bot.workspace_name = $Value.workspace_name
        return $bot
    }
}
