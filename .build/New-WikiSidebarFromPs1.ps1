function New-WikiSidebarFromPs1
{
    <#
    .SYNOPSIS
        Generates a Markdown sidebar (_Sidebar.md) for a wiki from a directory structure of PowerShell scripts and/or markdown files.
    
    .DESCRIPTION
        The New-WikiSidebarFromPs1 function scans specified source directories for command and class files (by default, .ps1 and .md).
        It builds a hierarchical sidebar in Markdown format, grouping files and folders, and writes the result to a sidebar file
        (default: _Sidebar.md) in the wiki source path. You can exclude files by pattern.
    
    .PARAMETER CommandsSourcePath
        Path to the directory containing command files (e.g., .ps1 scripts).
    
    .PARAMETER ClassesSourcePath
        Path to the directory containing class files (e.g., .md files).
    
    .PARAMETER WikiDestinationPath
        Path to the root of the wiki where the sidebar file will be written.
    
    .PARAMETER SidebarFile
        Name of the sidebar file to generate (default: _Sidebar.md).
    
    .PARAMETER ExcludeFiles
        Array of wildcard patterns for files to exclude (default: '*.local.*', 'zz*.ps1').
    
    .EXAMPLE
        New-WikiSidebarFromPs1 -CommandsSourcePath "C:\MyModule\Public" -ClassesSourcePath "C:\MyModule\Classes" -WikiSourcePath "C:\MyModule\Wiki"
    
    .NOTES
        - The sidebar groups commands and classes in collapsible sections.
        - Only files matching the specified extension are included.
        - Excluded files are filtered by name pattern.
        - The function is recursive and preserves folder hierarchy.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$CommandsSourcePath,
        [Parameter(Mandatory = $true)]
        [string]$ClassesSourcePath,
        [Parameter(Mandatory = $true)]
        [string]$WikiSourcePath,
        [Parameter(Mandatory = $true)]
        [string]$WikiDestinationPath,
        [Parameter(Mandatory = $true)]
        $EnumSourcePath,
        [Parameter()]
        [string]$SidebarFile = "_Sidebar.md",
        [Parameter()]
        [string[]]$ExcludeFiles = @('*.local.*', 'zz*.ps1')
    )

    function Build-Sidebar
    {
        <#
        .SYNOPSIS
            Recursively builds a Markdown-formatted sidebar section from a directory tree.

        .DESCRIPTION
            The Build-Sidebar function scans the specified directory for files matching the given extension,
            excludes files by pattern, and recursively processes subdirectories. It generates a Markdown
            list representing the folder and file hierarchy, suitable for use in a wiki sidebar.

        .PARAMETER CurrentPath
            The directory path to scan for files and subdirectories.

        .PARAMETER Depth
            The current indentation depth / folder level (used for nested folders, default: 0).

        .PARAMETER FileExtension
            The file extension to include (default: 'ps1', can be 'md').

        .PARAMETER ExcludeFiles
            Array of wildcard patterns for files to exclude from the sidebar.

        .OUTPUTS
            [string] A Markdown-formatted string representing the sidebar section for the given directory.

        .NOTES
            - Only files matching the specified extension are included.
            - Excluded files are filtered by name pattern.
            - The function is recursive and preserves folder hierarchy.
        #>
        param (
            [Parameter(Mandatory = $true)]
            [string]$CurrentPath,
            [Parameter()]
            [int]$Depth = 0,
            [Parameter(Mandatory = $true)]
            [ValidateSet('ps1', 'md')]
            [string]$FileExtension,
            [Parameter()]
            [string[]]$ExcludeFiles,
            [switch]$noList

        )
        $listChar = "-"
        $br = ""
        if ($noList)
        {
            $listChar = ""
            $br = "<br>"
        }

        $indent = '  ' * $Depth
        $sidebar = ""

        # take files from current directory first
        $files = (Get-ChildItem -Path $CurrentPath -Filter "*.$FileExtension" -File)
        foreach ($filter in $ExcludeFiles)
        {
            $files = $files.Where({ $_.Name -notlike $filter })
        }
        
        
        $files = $files | Sort-Object Name
        
        foreach ($file in $files)
        {
            #remove number prefix from file name
            $cleanBaseName = $file.BaseName -replace '^[^_]*_', ''
            $sidebar += "`n$indent$listChar [$cleanBaseName]($($file.BaseName))$br"
        }

        # Danach die Unterverzeichnisse
        $dirs = Get-ChildItem -Path $CurrentPath -Directory | Sort-Object Name
        foreach ($dir in $dirs)
        {
            #create folder / parent entry
            $sidebar += "`n$indent$listChar $($dir.Name)$br"
            #create sub items
            $sidebar += Build-Sidebar -CurrentPath $dir.FullName -Depth ($Depth + 1) -FileExtension $FileExtension -ExcludeFiles $ExcludeFiles
        }
        return $sidebar
    }

    $sidebar = "# Notion Module`n"
    $sidebar += Build-Sidebar -CurrentPath $WikiSourcePath -ExcludeFiles $ExcludeFiles -FileExtension 'md' -noList
    $sidebar += "`n`n<details><summary>Commands`n`n</summary>`n"
    $sidebar += Build-Sidebar -CurrentPath $CommandsSourcePath -ExcludeFiles $ExcludeFiles -FileExtension 'ps1'
    $sidebar += "</details>`n"
    $sidebar += "`n<details><summary>Classes`n`n</summary>`n"
    $sidebar += Build-Sidebar -CurrentPath $ClassesSourcePath -FileExtension 'md' -ExcludeFiles $ExcludeFiles
    $sidebar += "</details>`n"
    $sidebar += "`n<details><summary>Enums`n`n</summary>`n"
    $sidebar += Build-Sidebar -CurrentPath $EnumSourcePath -FileExtension 'md' -ExcludeFiles $ExcludeFiles
    $sidebar += "</details>`n"

    $sidebarFilePath = Join-Path $WikiDestinationPath $SidebarFile
    Set-Content -Path $sidebarFilePath -Value $sidebar
}

#New-WikiSidebarFromPs1 -SourcePathPs1 "C:\Users\subo\Documents\PowerShell\Modules.DEV\Brevo\source\Public" -OutputPath "C:\Users\subo\Documents\PowerShell\Modules.DEV\Brevo\output\WikiContent"
