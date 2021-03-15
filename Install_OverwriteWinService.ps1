Param(
    [string]$ServiceName,
    [string]$exePath
)

function Get-FrameworkDirectory()
{
    $([System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory())
}

$Service = Get-WmiObject -Class Win32_Service -Filter "Name = '$ServiceName'"

if ($null -ne $Service)
{
    $Service | stop-service -Force
    Start-Sleep -s 10
    $Service.Delete()
}

$FrameworkDir = Get-FrameworkDirectory

#$exeDir = "C:\SonarQube\sonarqube-8.5.1.38104\bin\windows-x86-64\wrapper.exe"

Set-Alias install_util (Join-Path $FrameworkDir "InstallUtil.exe")

install_util "$exePath"

#Get-Service -Name $ServiceName -ComputerName . | Set-Service -Status Running


#---------------------------------------------------------------------------------------------------
$Service | start-service 
