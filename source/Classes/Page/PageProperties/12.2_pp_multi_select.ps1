class pp_multi_select : pp_multi_select_item
# https://developers.notion.com/reference/page-property-values#multi-select
{
    [pp_multi_select_item[]] $multi_select

    pp_multi_select($color, $name)
    {
        $this.multi_select = [pp_multi_select_item]::new($color, $name)
    }

    add($color, $name)
    {
        if ($multi_select.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The multi_select property must have 100 items or less.")
        }
        $this.multi_select += [pp_multi_select_item]::new($color, $name)
    }

    static [pp_multi_select] ConvertFromObject($Value)
    {
        if ($Value -is [string])
        {
            return [pp_multi_select]::new($Value)
        }
        if ($Value -is [object[]])
        {
            $pp_multi_select = @()
            foreach ($item in $Value)
            {
                $pp_multi_select += [pp_multi_select_item]::new($item.color, $item.name)
            }
            return [pp_multi_select]::new($pp_multi_select)
        }
        # Not all code path returns value within method.
        return [pp_multi_select]::new($Value)
    }
}
