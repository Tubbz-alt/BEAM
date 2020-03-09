# Load assembly
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

$ErrorOccured = $false
try 
{ 
    $ErrorActionPreference = 'Stop'
    Get-ChildItem -Recurse | Unblock-File
    #Uninstall
    Remove-Item "C:\ProgramData\Autodesk\Revit\Addins\2018\MKS.addin" -ErrorAction Ignore
    Remove-Item "C:\ProgramData\Autodesk\Revit\Addins\2019\MKS.addin" -ErrorAction Ignore
    Remove-Item "C:\ProgramData\Autodesk\Revit\Addins\2018\MKS" -Recurse -ErrorAction Ignore
    Remove-Item "C:\ProgramData\Autodesk\Revit\Addins\2019\MKS" -Recurse -ErrorAction Ignore
    Remove-Item "$env:LOCALAPPDATA\Beam" -Recurse -ErrorAction Ignore
    Remove-Item "$env:APPDATA\Dynamo\Dynamo Revit\2.0\packages\MKS" -Recurse -ErrorAction Ignore
    Remove-Item "$env:APPDATA\Dynamo\Dynamo Core\2.0\packages\MKS" -Recurse -ErrorAction Ignore
    Remove-Item "$env:APPDATA\Dynamo\Dynamo Revit\2.3\packages\MKS" -Recurse -ErrorAction Ignore
    Remove-Item "$env:APPDATA\Dynamo\Dynamo Core\2.3\packages\MKS" -Recurse -ErrorAction Ignore
    Remove-Item "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Recurse -ErrorAction Ignore
    Remove-Item "$env:APPDATA\Grasshopper\Libraries\MKS" -Recurse -ErrorAction Ignore
    #BEAM
    New-Item "$env:LOCALAPPDATA\Beam" -ItemType directory | Out-Null
    New-Item "$env:LOCALAPPDATA\Beam\Temp" -ItemType directory | Out-Null
    Copy-Item "References\Newtonsoft.Json.dll" "$env:LOCALAPPDATA\Beam"
    Copy-Item "References\RestSharp.dll" "$env:LOCALAPPDATA\Beam"
    Copy-Item "beam.lic" "$env:LOCALAPPDATA\Beam"
    #REVIT
    New-Item -ItemType Directory -Force -Path "$env:APPDATA\Autodesk\Revit\Addins\2018" | Out-Null
    New-Item -ItemType Directory -Force -Path "$env:APPDATA\Autodesk\Revit\Addins\2019" | Out-Null
    New-Item -ItemType Directory -Force -Path "$env:APPDATA\Autodesk\Revit\Addins\2020" | Out-Null
    Copy-Item "Revit\REVITBEAM.dll" "$env:LOCALAPPDATA\Beam"
    Copy-Item "MKS.addin" "$env:LOCALAPPDATA\Beam\"
    Copy-Item "Revit\MKS.addin" "$env:APPDATA\Autodesk\Revit\Addins\2018\"
    Copy-Item "Revit\MKS.addin" "$env:APPDATA\Autodesk\Revit\Addins\2019\"
    Copy-Item "Revit\MKS.addin" "$env:APPDATA\Autodesk\Revit\Addins\2020\"
    #RHINO
    Copy-Item "Rhino\RHINOBEAM.rhp" "$env:LOCALAPPDATA\Beam\"
    New-Item "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -ItemType directory | Out-Null
    New-ItemProperty -Path "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Name "Name" -Value "MKS BEAM"  -PropertyType "String" | Out-Null
    New-ItemProperty -Path "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Name "FileName" -Value "$env:LOCALAPPDATA\Beam\RHINOBEAM.rhp"  -PropertyType "String" | Out-Null
    #DYNAMO
    New-Item "$env:LOCALAPPDATA\Beam\MKS" -ItemType directory | Out-Null
    New-Item "$env:LOCALAPPDATA\Beam\MKS\bin" -ItemType directory | Out-Null
    Copy-Item "Dynamo\pkg.json" "$env:LOCALAPPDATA\Beam\MKS\"
    Copy-Item "Dynamo\MKS.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\"
    Copy-Item "Dynamo\MKS.customization.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\"
    Copy-Item "Dynamo\MKS_DynamoCustomization.xml" "$env:LOCALAPPDATA\Beam\MKS\bin\"
    #GRASSHOPPER
    New-Item "$env:APPDATA\Grasshopper\Libraries\MKS" -ItemType directory | Out-Null
    Copy-Item "Grasshopper\GHBEAM.gha" "$env:LOCALAPPDATA\Beam\"
    Copy-Item "Grasshopper\GHBEAM.gha" "$env:APPDATA\Grasshopper\Libraries\MKS\"
}
catch
{
    [System.Windows.Forms.Messagebox]::Show("Error occured, close Revit and Rhino, wait 30 seconds and try again")
    $ErrorOccured=$true
}

if(!$ErrorOccured) 
{
    [System.Windows.Forms.Messagebox]::Show("Beam Installed Correctly")
}
