function Send-GelfLog {
    param(
        [string]$graylogServer,
        [int]$port,
        [string]$message,
        [string]$hostName
    )
    $gelfMessage = @{
        "version" = "1.1"
        "host" = $hostName
        "short_message" = $message
        "timestamp" = [int][double]::Parse((Get-Date -UFormat "%s"))
        "level" = 6
    }
    $json = $gelfMessage | ConvertTo-Json -Compress
    $bytes = [Text.Encoding]::ASCII.GetBytes($json)
    $client = New-Object System.Net.Sockets.UdpClient $graylogServer, $port
    $client.Send($bytes, $bytes.Length)
    $client.Close()
}

# Использование функции
$logPath = "C:\Logs\UserLogin.log"
$ipAddress = (Get-NetIPAddress -AddressFamily IPv4).IPAddress
$macAddress = (Get-NetAdapter | where { $_.Status -eq "up" }).MacAddress
$loginTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$userInfo = "$env:USERNAME, $ipAddress, $macAddress, $loginTime"

# Запись в локальный файл и отправка в Graylog
Add-Content -Path $logPath -Value $userInfo
Send-GelfLog -graylogServer "graylog_server_ip" -port graylog_input_port -message $userInfo -hostName $env:COMPUTERNAME
