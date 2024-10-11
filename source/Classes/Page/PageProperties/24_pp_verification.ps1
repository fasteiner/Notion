class pp_verification : PageProperties
# https://developers.notion.com/reference/page-property-values#verification
{
    [verification_state] $state
    [user] $verified_by
    [string] $date

    #Constructors
    pp_verification($Value)
    {
        $this.state = [Enum]::Parse([state], $Value.state)
        $this.verified_by = [user]::new($Value.verified_by)
        $this.date = Get-Date $Value.date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    pp_verification($state, $verified_by, $date)
    {
        $this.state = [Enum]::Parse([state], $state)
        $this.verified_by = [user]::new($verified_by)
        $this.date = Get-Date $date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    #Methods
    static [pp_verification] ConvertFromObject($Value)
    {
        return [pp_verification]::new($Value)
    }
}
