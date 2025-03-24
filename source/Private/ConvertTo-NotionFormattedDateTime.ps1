function ConvertTo-NotionFormattedDateTime {
    <#
    .SYNOPSIS
        Converts an input date to a specified Notion formatted date-time string.
    
    .DESCRIPTION
        The ConvertTo-NotionFormattedDateTime function takes an input date and converts it to a Notion formatted date-time string. 
        The input date can be a string or a datetime object. If the input is a string, the function attempts to parse it into a datetime object. 
        If the parsing fails, an error is logged.
    
    .PARAMETER InputDate
        The date to be converted. This parameter is mandatory.
    
    .PARAMETER fieldName
        The name of the field for logging purposes. This parameter is optional and defaults to "not_provided". This parameter is used for logging purposes.
    
    .EXAMPLE
        ConvertTo-NotionFormattedDateTime -InputDate "2023-10-01T12:34:56Z"
        Converts the input string date to the default Notion formatted date-time string.
    
    .NOTES
        If the input date is already a datetime object, it is directly converted to the specified format.
        If the input date is a string, the function attempts to parse it. If parsing fails, an error is logged.
        If the input type is neither string nor datetime, an error is logged and $null is returned.
    
    .OUTPUTS
        Returns a formatted date-time string if the conversion is successful.
        Returns $null if the conversion fails.
    
    .LINK
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
        https://docs.microsoft.com/en-us/dotnet/api/system.datetime.tostring
    #>
    [cmdletbinding()]
    [OutputType([String])]
    param (
        [Parameter(Mandatory = $true)]
        $InputDate,
        [Parameter(Mandatory = $false)]
        $fieldName = "not_provided"
        )
    $Format = "yyyy-MM-ddTHH:mm:ss.fffZ"

    # Check if the input is already a datetime object
    if ($InputDate -is [datetime]) {
        return $InputDate.ToUniversalTime().ToString($Format)
    }
    # Check if the input is a string and attempt to parse it
    elseif ($InputDate -is [string]) {
        $dateObj = [datetime]::UtcNow
        if ([datetime]::TryParse($InputDate, [ref]$dateObj)) {
            return $dateObj.ToUniversalTime().toString($Format)
        }
        else {
            # Log an error for invalid format
            Write-Error "Invalid date time format in field $fieldName" -Category InvalidData -TargetObject $value -RecommendedAction "Please provide a valid datetime format"
            return $null
        }
    }
    else {
        # Handle cases where the type is neither string nor datetime
        Write-Error "Invalid input type for field $fieldName" -Category InvalidData -TargetObject $value -RecommendedAction "Please provide a valid datetime format"
        return $null
    }
}
