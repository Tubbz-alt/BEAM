[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

Set-ExecutionPolicy -Scope CurrentUser Unrestricted

$ErrorOccured = $false
try 
{ 
    $ErrorActionPreference = 'Stop'
    Get-ChildItem -Recurse | Unblock-File

    New-Item "$env:LOCALAPPDATA\Beam" -ItemType directory -Force | Out-Null
    New-Item "$env:LOCALAPPDATA\Beam\Temp" -ItemType directory -Force | Out-Null
    New-Item "$env:LOCALAPPDATA\Beam\MKS" -ItemType directory -Force | Out-Null
    New-Item "$env:LOCALAPPDATA\Beam\MKS\bin" -ItemType directory -Force | Out-Null
    New-Item "$env:LOCALAPPDATA\Beam\MKS\Templates" -ItemType directory -Force | Out-Null

    Remove-Item "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Recurse -ErrorAction Ignore

    New-Item "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -ItemType directory | Out-Null
    New-ItemProperty -Path "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Name "Name" -Value "MKS BEAM"  -PropertyType "String" | Out-Null
    New-ItemProperty -Path "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Name "FileName" -Value "$env:LOCALAPPDATA\Beam\RHINOBEAM.rhp"  -PropertyType "String" | Out-Null

    Copy-Item "RHINOBEAM.rhp" "$env:LOCALAPPDATA\Beam\" -ErrorAction Ignore
    Copy-Item "REVITBEAM.dll" "$env:LOCALAPPDATA\Beam" -ErrorAction Ignore
    Copy-Item "MKS.addin" "$env:LOCALAPPDATA\Beam" -ErrorAction Ignore
    Copy-Item "GHBEAM.gha" "$env:LOCALAPPDATA\Beam\" -ErrorAction Ignore
    Copy-Item "Newtonsoft.Json.dll" "$env:LOCALAPPDATA\Beam" -ErrorAction Ignore
    Copy-Item "RestSharp.dll" "$env:LOCALAPPDATA\Beam" -ErrorAction Ignore
    Copy-Item "Newtonsoft.Json.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\" -ErrorAction Ignore
    Copy-Item "MKS\pkg.json" "$env:LOCALAPPDATA\Beam\MKS\" -ErrorAction Ignore
    Copy-Item "MKS\bin\MKS.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\" -ErrorAction Ignore
    Copy-Item "MKS\bin\MKS.customization.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\" -ErrorAction Ignore
    
    Copy-Item -Path "Templates\*" -Destination "$env:LOCALAPPDATA\Beam\Templates\ -Recurse -ErrorAction Ignore
}
catch
{
    [System.Windows.Forms.Messagebox]::Show("There was an error. Close Rhino and Revit or perform a total manual install. Visit github.com/MKSDTECH/BEAM/wiki")
    $ErrorOccured=$true
}

if(!$ErrorOccured) 
{
    [System.Windows.Forms.Messagebox]::Show("Beam Installed Correctly")
}
