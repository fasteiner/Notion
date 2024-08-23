class notion_hosted_file
# https://developers.notion.com/reference/file-object#notion-hosted-files
{
    [string]$url
    [string]$expiry_time

    notion_hosted_file([string]$url, [string]$expiry_time)
    {
        $this.url = $url
        $this.expiry_time = Get-Date $expiry_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }
    notion_hosted_file([System.Object]$Value)
    {
        $this.url = $Value.url
        $this.expiry_time = Get-Date $Value.expiry_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }
}
