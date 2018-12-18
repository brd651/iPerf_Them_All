$iparray = @("10.1.1.111", "172.16.1.11")
$portarray = @("4443", "5201", "30000", "64000", "65535" ,"20", "21", "22", "23", "25", "80", "81", "110", "137", "139", "143", "443", "445", "465", "993", "995") 
$threadarray = @("1", "5", "15", "25", "50")
$stopwatch = New-Object -TypeName System.Diagnostics.Stopwatch

$stopwatch.Start()
cd C:\Users\User\Desktop\iperf

Start-Transcript -Path C:\Users\User\Desktop\output.txt -Append

foreach ($ip in $iparray){
	foreach ($thread in $threadarray){
		foreach ($port in $portarray){
			Write-Host "Upload test: ""IP="$ip  "Port="$port "threads="$thread
			.\iperf3.exe -c $ip -p $port -P $thread -t 15
			Start-Sleep -s 3
			Write-Host "Download test: ""IP="$ip  "Port="$port "threads="$thread
			.\iperf3.exe -c $ip -p $port -P $thread -t 15 -R
			Start-Sleep -s 3
			Write-Host $stopwatch.Elapsed.Seconds
		}
	}
}
$stopwatch.Stop()
Write-Host $stopwatch.Elapsed
Stop-Transcript
