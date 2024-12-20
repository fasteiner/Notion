class url_property_base : PropertiesBase
{
    [string] $url

    url_property_base($url) : base("url")
    {
        $this.url = $url
    }

    static [url_property_base] ConvertFromObject($Value)
    {
        return [url_property_base]::new($Value.url)
    }
}
