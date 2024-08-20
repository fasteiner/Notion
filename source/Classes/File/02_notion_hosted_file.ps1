class notion_hosted_file {
    [string]$url
    [string]$expiry_time

    notion_hosted_file($url, $expiry_time)
    {
        $this.url = $url
        $this.expiry_time = Get-Date $expiry_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }
}
