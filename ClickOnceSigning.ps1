param([string] $solutionDir, [string] $publishDir, [string] $assemblyName)

$publishVersionDir = Get-ChildItem -Path $publishDir'\Application Files\' | ?{$_.PSIsContainer } | Sort-Object BaseName -Descending | Select-Object -First 1
$publishVersionDir = $publishDir + 'Application Files\' + $publishVersionDir


$cmd = $solutionDir + '3rdParty\Signtool\signtool.exe'

$sha1 = Get-ChildItem -Path Cert:\CurrentUser\My -Recurse |  where {$_.Subject -like '*Accuratech*'} | Select-Object -First 1
$sha1 = $sha1."Thumbprint"

#Sign version executable
$cmd = $solutionDir + '3rdParty\Signtool\signtool.exe sign /t http://timestamp.digicert.com /sha1 ' + $sha1 + ' /v ''' + $publishVersionDir + '\' + $assemblyName + '.exe'''
$cmd
Invoke-Expression $cmd
$cmd = $solutionDir + '3rdParty\Signtool\signtool.exe sign /tr http://timestamp.digicert.com /td sha256 /fd sha256 /sha1 ' + $sha1 + ' /v ''' + $publishVersionDir + '\' + $assemblyName + '.exe'''
$cmd
Invoke-Expression $cmd

#Sign version executable
$cmd = $solutionDir + '3rdParty\Signtool\signtool.exe sign /t http://timestamp.digicert.com /sha1 ' + $sha1 + ' /v ''' + $publishDir + $assemblyName + '.exe'''
$cmd
Invoke-Expression $cmd
$cmd = $solutionDir + '3rdParty\Signtool\signtool.exe sign /tr http://timestamp.digicert.com /td sha256 /fd sha256 /sha1 ' + $sha1 + ' /v ''' + $publishDir + $assemblyName + '.exe'''
$cmd
Invoke-Expression $cmd

#Sign executable manifest file
$cmd = $solutionDir + '3rdParty\Signtool\mage.exe -u ''' + $publishVersionDir + '\' + $assemblyName + '.exe.manifest''  -ch ' + $sha1 + '  -fd ''' + $publishVersionDir + ''' -ti http://timestamp.digicert.com -pub ''Accuratech APS'' -um ''True'''
$cmd
Invoke-Expression $cmd

#Sign application manifest file with
$cmd = $solutionDir + '3rdParty\Signtool\mage.exe -u ''' + $publishDir + $assemblyName + '.application'' -appm ''' + $publishVersionDir + '\' + $assemblyName + '.exe.manifest'' -ch ' + $sha1 + '  -ti http://timestamp.digicert.com -pub ''Accuratech APS'' -um ''True'''
$cmd
Invoke-Expression $cmd

#Sign setup.exe
$cmd = $solutionDir + '3rdParty\Signtool\signtool.exe sign /t http://timestamp.digicert.com /sha1 ' + $sha1 + ' /v ''' + $publishDir + 'setup.exe'''
$cmd
Invoke-Expression $cmd
$cmd = $solutionDir + '3rdParty\Signtool\signtool.exe sign /tr http://timestamp.digicert.com /td sha256 /fd sha256 /sha1 ' + $sha1 + ' /v ''' + $publishDir + 'setup.exe'''
$cmd
Invoke-Expression $cmd
