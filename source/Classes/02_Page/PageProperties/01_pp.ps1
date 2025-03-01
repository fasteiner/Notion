class notion_pageproperties : hashtable
# https://developers.notion.com/reference/page-property-values
{
    #[notion_page_property_type] $Type

    notion_pageproperties()
    {
    }

    [void] Add([object] $Key, [object] $Value)
    {
        if (-not ($Value -is [PagePropertiesBase]))
        {
            Write-Error "Value must be of type PagePropertiesBase" -Category InvalidType -TargetObject $Value -RecommendedAction "Use a class that inherits from PagePropertiesBase"
        }
        # Call the base Add method
        ([hashtable] $this).Add($Key, $Value)
    }

    static [notion_pageproperties] ConvertFromObject($Value)
    {
        $pageproperties = [notion_pageproperties]::new()
        foreach ($key in $Value.PSObject.Properties.Name)
        {
            $pageproperties.Add($key, [PagePropertiesBase]::ConvertFromObject($Value.$key))
        }
        return $pageproperties
    }

    
}
