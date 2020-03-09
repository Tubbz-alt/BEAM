Get-ChildItem -Recurse | Unblock-File

New-Item "$env:LOCALAPPDATA\Beam" -ItemType directory -Force | Out-Null
New-Item "$env:LOCALAPPDATA\Beam\Temp" -ItemType directory -Force | Out-Null
New-Item "$env:LOCALAPPDATA\Beam\MKS" -ItemType directory -Force | Out-Null
New-Item "$env:LOCALAPPDATA\Beam\MKS\bin" -ItemType directory -Force | Out-Null

Remove-Item "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Recurse -ErrorAction Ignore

New-Item "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -ItemType directory | Out-Null
New-ItemProperty -Path "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Name "Name" -Value "MKS BEAM"  -PropertyType "String" | Out-Null
New-ItemProperty -Path "HKCU:\Software\McNeel\Rhinoceros\6.0\Plug-ins\2ed06c48-9229-4f20-984e-ae31fe55e316" -Name "FileName" -Value "$env:LOCALAPPDATA\Beam\RHINOBEAM.rhp"  -PropertyType "String" | Out-Null

Copy-Item "RHINOBEAM.rhp" "$env:LOCALAPPDATA\Beam\"
Copy-Item "REVITBEAM.dll" "$env:LOCALAPPDATA\Beam"
Copy-Item "MKS.addin" "$env:LOCALAPPDATA\Beam"
Copy-Item "GHBEAM.gha" "$env:LOCALAPPDATA\Beam\"
Copy-Item "Newtonsoft.Json.dll" "$env:LOCALAPPDATA\Beam"
Copy-Item "RestSharp.dll" "$env:LOCALAPPDATA\Beam"
Copy-Item "Newtonsoft.Json.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\"
Copy-Item "MKS\pkg.json" "$env:LOCALAPPDATA\Beam\MKS\"
Copy-Item "MKS\bin\MKS.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\"
Copy-Item "MKS\bin\MKS.customization.dll" "$env:LOCALAPPDATA\Beam\MKS\bin\"
