class external_file
# https://developers.notion.com/reference/file-object#external-files
{
    [string] $url

    # [external_file]::new("http://..")
    external_file([string]$url)
    {
        $this.url = $url
    }

    static [external_file] ConvertFromObject($Value)
    {
        return [external_file]::new($Value.url)
    }
}
