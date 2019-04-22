#Connect-VIServer -Server 10.128.1.86
$InFile = "C:\Users\jkarocki\Desktop\Migrations\March2019MW\WindowsProd\CMH0WindowsProd.1.txt"
$vms = Get-Content $InFile
foreach ($vm in $vms){
Get-VM $vm| start-vm -confirm:$false
}