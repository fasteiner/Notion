function Copy-WikiContent 
{
    <#
    .SYNOPSIS
        Copies all files from a source directory (recursively) into a destination directory, flattening the structure.
    
    .DESCRIPTION
        The Copy-WikiContent function copies all files from the specified source directory and its subdirectories
        into the specified destination directory. All files are placed directly in the destination directory,
        and any existing files with the same name will be overwritten.
    
    .PARAMETER SourcePath
        The path to the source directory containing files to copy.
    
    .PARAMETER DestinationPath
        The path to the destination directory where files will be copied.
    
    .EXAMPLE
        Copy-WikiContent -SourcePath "C:\Docs\Wiki" -DestinationPath "C:\Build\WikiFlat"
    
    .NOTES
        If multiple files with the same name exist in different subdirectories, only the last one copied will remain.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SourcePath,

        [Parameter(Mandatory = $true)]
        [string]$DestinationPath
    )

    if (-not (Test-Path -Path $DestinationPath))
    {
        New-Item -ItemType Directory -Path $DestinationPath | Out-Null
    }

    # Alle Dateien rekursiv holen und flach ins Ziel kopieren
    Get-ChildItem -Path $SourcePath -File -Recurse | ForEach-Object {
        $destFile = Join-Path $DestinationPath $_.Name
        Copy-Item -Path $_.FullName -Destination $destFile -Force
    }
}
