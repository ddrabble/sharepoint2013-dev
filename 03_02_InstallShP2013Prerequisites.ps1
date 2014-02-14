# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Installs the Sharepoint 2013 pre-requisites
#
# History
# 1.0 	2014-01-03 	Initial version 
# 1.1	2014-02-14	Externalized config 
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

# basic path and ISO info
$developerFolderPath = $h.developerFolderPath
$softwareSetupPath = $h.softwareSetupPath
$sharepointSetupPath = [STRING]::Concat($softwareSetupPath, $h.spPrereqSetupPath)

Write-Host "(VM) $(Get-Date): Start to install ShP2013 prerequisites."

# Configure SQL Server using Local System account 

if (-Not(Test-Path $sharepointSetupPath))
{
    Write-Host "(VM) $(Get-Date): $sharepointSetupPath does not exist"
    exit 1
}
$psExecPath = Join-Path -Path $developerFolderPath "tools\PsExec.exe"
$psExecLogPath = Join-Path -Path $developerFolderPath "tools\PsExecLog.txt"

$arguments = $sharepointSetupPath


$process = Start-Process -NoNewWindow -FilePath $psExecPath -ArgumentList $arguments -Wait -PassThru



return 0
