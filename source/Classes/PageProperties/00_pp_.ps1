class PageProperties
{
    [PagePropertyType] $Type

    PageProperties()
    {
    }

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
}
