#create_snapshot.ps1
Connect-VIServer 10.128.1.74
Get-vm | get-snapshot | format-list vm,name,SizeGB,created