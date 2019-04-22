#create_snapshot.ps1
Connect-VIServer 10.128.1.74

$vms = get-vm -name pvcmh1vcntl01.netsmartcore.lan, pvcmh1pscl01.netsmartcore.lan
$name = "Adaxes_1094259"
foreach($vm in $vms) {
    $snap = get-Snapshot -vm $vm -name $name
    write-host "removing snapshot $snap.name for $vm.name"
    remove-snapshot -snapshot $snap -confirm:$false -runasync:$true
}