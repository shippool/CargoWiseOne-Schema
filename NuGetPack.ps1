$root = Join-Path (split-path -parent $MyInvocation.MyCommand.Definition) '\..'
$version = [System.Reflection.Assembly]::LoadFile("$root\cargowiseone-schema\lib\CargoWiseSchema.dll").GetName().Version
$versionStr = "{0}.{1}.{2}" -f ($version.Major, $version.Minor, $version.Build)

Write-Host "Setting .nuspec version tag to $versionStr" -ForegroundColor Green
$content = Get-Content $root\cargowiseone-schema\CargoWiseOne-Schema.nuspec
$content = $content -replace '\$version\$',$versionStr
$content | Out-File $root\cargowiseone-schema\CargoWise_Schema.compiled.nuspec -Force

& NuGet.exe pack $root\cargowiseone-schema\CargoWise_Schema.compiled.nuspec