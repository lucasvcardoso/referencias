Param(
    [string]$ServiceName,
    [string]$exePath
)

function Get-FrameworkDirectory()
{
    $([System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory())
}

$Service = Get-WmiObject -Class Win32_Service -Filter "Name = '$ServiceName'"

if ($Service -ne $null)
{
    $Service | stop-service -Force
    Start-Sleep -s 10
    $Service.Delete()
}

$FrameworkDir = Get-FrameworkDirectory

$exeDir = "D:\ETPS2 Workspace\ETPS2\Development-2017-02-Feb\Main Application\Services Projects\ServicesMonitor\ETPS2.ServicesMonitor\bin\Debug\ETPS2.ServicesMonitor.exe"

Set-Alias install_util (Join-Path $FrameworkDir "InstallUtil.exe")

install_util "$exePath"

#Get-Service -Name $ServiceName -ComputerName . | Set-Service -Status Running


#---------------------------------------------------------------------------------------------------
$Service | start-service 
