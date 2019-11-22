Param(
    [string]$ServiceName
)

$Service = Get-WmiObject -Class Win32_Service -Filter "Name = '$ServiceName'"

if ($Service -ne $null)
{
    $Service | stop-service -Force
    Start-Sleep -s 10
    $Service.Delete()
}

