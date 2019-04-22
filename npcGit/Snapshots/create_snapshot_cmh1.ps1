#create_snapshot.ps1
Connect-VIServer 10.128.1.74

$vms = get-vm -name pvnpcohmdbw01.npc.lan,pvnpcohsftpw01.npc.lan
$name = "WSFTP8.01"
$Desc = "WSFTP801 upgrade to 86"
foreach($vm in $vms) {
    write-host "creating snapshot $name for $vm.name"
    $snap = New-Snapshot -vm $vm -name $name -Description $Desc -confirm:$false -runasync:$true
}