# #############################################################################################################
# Title: Add-TSLogToFile
# Description:
# 07/2024 Hello
# # Minimum Powershell Version: 7
# #Requires -Version "7"
# #############################################################################################################
function Add-TSNotionLogToFile
{
    <#
    .SYNOPSIS
    Add-TSNotionLogToFile -filename <filename> -level <DEBUG | INFO | WARNING |ERROR> -message <string|array|object>

    .DESCRIPTION
    Long description

    .PARAMETER filename
    Name of file the log file to be written

    .PARAMETER level
    Type of loglevel: DEBUG | INFO | WARNING |ERROR

    .PARAMETER message
    text, array or object to be displayed/written to logfile/written to JSON file

    .PARAMETER DN
    Active Directory: Distinguished Name

    .PARAMETER Typeofaction
    Type of AD mofification: creation | modify | delete | member-added | member-removed

    .PARAMETER Objectclass
    Type of affected AD object: user | group

    .PARAMETER ADchange
    Boolean Param if a change has been done on AD

    .PARAMETER requestID
    If launched from a request: ID of the Request

    .PARAMETER Service
    Service that is launching the command

    .PARAMETER expandObject
    If the message is an object, it will be expanded to all properties

    .EXAMPLE
    Add-TSNotionLogToFile -filename $log -level INFO  -message "someting was successful"

    .EXAMPLE
    Add-TSNotionLogToFile -filename $log -level DEBUG -message "try to ADD Member: $($MEMBER)..."

    .EXAMPLE
    $Error | Add-TSNotionLogToFile -filename $log -level ERROR

    .EXAMPLE
    "Some text", $object | Add-TSNotionLogToFile -filename $log -level ERROR

    #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $false)]
        [string]$filename,
        [ValidateSet('DEBUG', 'INFO', 'WARN', 'ERROR', 'VERBOSE')]
        [Parameter(Mandatory = $true)]
        [string]$level,
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [object]$message,
        [string]$DN,
        [ValidateSet('creation', 'modify', 'delete', 'member-added', 'member-removed')]
        [Parameter(Mandatory = $false)]
        [string]$Typeofaction,
        [ValidateSet('user', 'group')]
        [Parameter(Mandatory = $false)]
        [string]$Objectclass,
        [ValidateSet('true', 'false')]
        [Parameter(Mandatory = $false)]
        [switch]$ADchange,
        [Parameter(Mandatory = $false)]
        [string]$requestID = $json.requestID,
        [Parameter(Mandatory = $false)]
        # https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2#null-coalescing-operator-
        # Selects the second value if first one is empty
        [string]$Service = $json.requestType,
        [switch]$expandObject
    )
    process
    {
        #BUG: ParameterSet for Azure Changes
        if ($global:logOFF)
        {
            return
        }
        switch ($level)
        {
            "VERBOSE"
            {
                if ($env:LEVEL -ne "VERBOSE")
                {
                    return
                }
                $color = "Cyan"
                break
            }
            "DEBUG"
            {
                if ($env:LEVEL -ne "DEBUG" -and $env:LEVEL -ne "VERBOSE")
                {
                    return
                }
                $color = "DarkMagenta"
                break
            }
            "WARN"
            {
                $color = "Yellow"
                break
            }
            "ERROR"
            {
                $color = "Red"
                break
            }
            default
            {
                $color = "white"
            }
        }
        if ($message.GetType().Name -notlike "*string*")
        {
            if ($expandObject -eq $true)
            {
                $message = "`n$($message | Select-Object * | Out-String)"
            }
            else
            {
                $message = "`n$($message | Out-String)"
            }
        }
        if (-not [string]::IsNullOrEmpty($filename))
        {
            $mutex = New-Object System.Threading.Mutex($false, "Global\Add-TSNotionLogToFile")
            $mutex.WaitOne() | Out-Null
                (Get-Date).ToString() + " - " + $level + " - " + $message >> $filename
            #json log
            if ($ADchange -eq $true)
            {
                if (!(Test-Path -Path $jsonlogPath))
                {
                    try
                    {
                        $null = New-Item -Path $jsonlogPath -ItemType Directory
                        Write-Host ("Path: ""{0}"" was created." -f $jsonlogPath)
                    }
                    catch
                    {
                        Write-Host ("Path: ""{0}"" couldn't be created." -f $jsonlogPath)
                    }
                }
                else
                {
                    Write-Verbose ("Path: ""{0}"" already exists." -f $jsonlogPath)
                }
                $time = $(Get-Date -Format dd.MM.yyyy-HH:mm:ss)
                [string]$logFilejson = '{0}\{1}_{2}.json' -f $jsonlogPath, $(Get-Date -Format 'yyyyMMdd'), ($env:taskID ?? $Service)
                [array]$output = @(New-Object psobject -Property @{Name = "$Service"; Type = "$level"; RequestID = "$requestID"; Text = "$message"; Time = "$time"; <#InitiatedBy = "$InitiatedBy"; Targetuser = "$TargetUserId"; #>DN = "$DN"; Typeofaction = "$Typeofaction"; Objectclass = "$Objectclass"; ADchange = "$ADchange" })
                if ((Test-Path -Path $logFilejson -PathType leaf))
                {
                    Add-Content -Path $logFilejson -Value ", "
                }
                Add-Content -Path $logFilejson -Value $($output | ConvertTo-Json)
            }
            $mutex.ReleaseMutex() | Out-Null
        }
        Write-Host "$($level) - $($message)" -ForegroundColor $color
    }
}
