class verification_property_base_structure
{
    [notion_property_base_verification_state] $state
    [notion_user] $verified_by
    [string] $date

    #Constructors
    verification_property_base_structure($Value)
    {
        $this.state = [Enum]::Parse([notion_property_base_verification_state], $Value.state)
        $this.verified_by = [notion_user]::new($Value.verified_by)
        $this.date = Get-Date $Value.date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    verification_property_base_structure($state, $verified_by, $date)
    {
        $this.state = [Enum]::Parse([notion_property_base_verification_state], $state)
        $this.verified_by = [notion_user]::new($verified_by)
        $this.date = Get-Date $date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    #Methods
    static [verification_property_base_structure] ConvertFromObject($Value)
    {
        return [verification_property_base_structure]::new($Value.state, $Value.verified_by, $Value.date)
    }
}

class verification_property_base : PropertiesBase
{
    [verification_property_base_structure] $verification

    verification_property_base() : base("verification")
    {
        $this.verification = [verification_property_base_structure]::new()
    }

    verification_property_base($state, $verified_by, $date) : base("verification")
    {
        $this.verification = [verification_property_base_structure]::new($state, $verified_by, $date)
    }

    static [verification_property_base] ConvertFromObject($Value)
    {
        return [verification_property_base]::new($Value.verification.state, $Value.verification.verified_by, $Value.verification.date)
    }
}
