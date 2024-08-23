class emoji
{
    [icontype]$type = "emoji"
    [string]$emoji

    emoji($emoji)
    {
        # if ($emoji.Length -ne 1)
        # {
        #     throw [System.ArgumentException]::new("The emoji must be a single character.")
        # }
        $this.emoji = $emoji
    }
}
