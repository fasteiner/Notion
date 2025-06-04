Set-Location "$env:USERPROFILE\Documents\PowerShell\Modules.DEV\TSNotion"
./build.ps1 -tasks minibuild
$version = dotnet-gitversion /showvariable MajorMinorPatch /nocache
$ModuleFile = ".\output\module\Notion\$version\Notion.psd1"
Import-Module $ModuleFile
