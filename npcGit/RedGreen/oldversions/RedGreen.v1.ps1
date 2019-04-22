$s=Get-Date
GC .\RedGreen-Hostname.txt | %{
	If (Test-Connection $_ -Quiet -Count 2){
	Write-Host "$_ is UP" -b Green
	}
	Else{
	Write-Host "$_ is Down" -b Red
	}
}
$e=Get-Date
($e - $s).TotalSeconds