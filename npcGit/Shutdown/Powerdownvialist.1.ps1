#Connect-VIServer -Server 10.128.1.86
$InFile = ".\CMH0WindowsProd.1.txt"
$vms = Get-Content $InFile
foreach ($vm in $vms){
Get-VM $vm| shutdown-vmguest -confirm:$false
}