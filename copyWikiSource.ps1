function Copy-WikiFolder
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Path,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DestinationPath,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force
    )

    Write-Verbose -Message ($script:localizedData.CopyWikiFoldersMessage -f ($Path -join ''', '''))

    $wikiFiles = Get-ChildItem -Recurse -Path $Path

    foreach ($file in $wikiFiles)
    {
        Write-Verbose -Message ($script:localizedData.CopyFileMessage -f $file.Name)

        if ($file.DirectoryName -eq $Path)
        {
            $destination = $DestinationPath
        }
        else
        {
            $destination = Join-Path -Path $DestinationPath -ChildPath ($file.DirectoryName -replace [regex]::Escape($Path), '')
        }

        if ($file.PSIsContainer)
        {
            # Ensure folder exists
            if (-not (Test-Path -LiteralPath $destination)) {
                New-Item -ItemType Directory -Path $destination -Force | Out-Null
            }
        }
        else
        {
            # Ensure parent folder exists
            $destinationParent = Split-Path -Parent (Join-Path $destination $file.Name)
            if (-not (Test-Path -LiteralPath $destinationParent)) {
                New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
            }

            Copy-Item -Path $file.FullName -Destination $destination -Force:$Force
        }
    }
}
