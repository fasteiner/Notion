class PageProperties
{
    #[PagePropertyType] $Type

    PageProperties()
    {
    }

    addproperty([string]$PropertyName, $Property)
    {
        $this."$PropertyName" = 1#["$property"]::new($Property)
    }

    # "Ordernumber": {
    #     "id": "C%3E%3FU",
    #     "type": "number",
    #     "number": 10000
    # }

    # addProperty($Property, [string] $type)
    # {
    #     $out = $Property
    #     if ($Property.type)
    #     {
    #         $out = $out | Select-Object -ExcludeProperty "type"
    #     }
    #     $this."$type" += @{
    #         "type" = $type
    #         "$type" = $out
    #     }
    # }
    # addProperty($Property)
    # {
    #     $out = $Property
    #     $type = $Property.type
    #     # remove type property from Property object
    #     if ($Property.type)
    #     {
    #         $out = $out | Select-Object -ExcludeProperty "type"
    #     }
    #     $this."$type" += @{
    #         "type"  = $type
    #         "$type" = $out
    #     }
    # }
    
    # static ConvertFromObject($Values)
    # {
    #     foreach ($Value in $Values.properties.psobject.properties.name)
    #     {
    #         Write-Host "Value: $Value"
    #         #$this.$Value = @()
    #         $PageProperties = [PageProperties]::new()
    #         $PageProperties.$Value.type = $Values.$Value.type
    #     }
    # }
}
