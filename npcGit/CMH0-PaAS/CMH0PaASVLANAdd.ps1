#############################
#Standard Variables
#############################
$vmhosts="cmhpesxil053.netsmartcore.lan","cmhpesxil055.netsmartcore.lan","cmhpesxil118.netsmartcore.lan","cmhpesxil156.netsmartcore.lan","cmhpesxil162.netsmartcore.lan","cmhpesxil167.netsmartcore.lan","cmhpesxil172.netsmartcore.lan","cmhpesxil176.netsmartcore.lan"
#######################
## CMH1
#######################
$cVC = "10.128.1.86"
$cNTP = 10.128.1.30
#$cdcCredintials = Get-Credential -Message "Please Enter your Destination vCenter Credentials to be Saved"
$myVirtualSwitch="vSwitch1"
$VMotionVLan = "6"
#Connect-VIServer -Server $cVC -Credential $cdcCredintials

Foreach ($vmhost in $vmhosts){
New-VirtualPortGroup -Name "PaAS Client 61" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 561 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 62" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 562 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 63" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 563 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 64" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 564 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 65" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 565 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 66" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 566 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 67" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 567 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 68" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 568 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 69" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 569 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 70" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 570 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 71" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 571 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 72" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 572 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 73" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 573 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 74" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 574 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 75" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 575 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 76" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 576 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 77" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 577 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 78" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 578 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 79" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 579 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 80" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 580 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 81" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 581 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 82" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 582 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 83" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 583 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 84" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 584 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 85" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 585 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 86" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 586 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 87" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 587 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 88" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 588 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 89" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 589 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 90" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 590 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 91" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 591 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 92" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 592 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 93" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 593 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 94" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 594 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 95" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 595 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 96" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 596 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 97" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 597 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 98" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 598 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 99" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch1" -VMHost $vmhost) -VLanId 599 -Confirm:$false
New-VirtualPortGroup -Name "PaAS Client 100" -VirtualSwitch (Get-VirtualSwitch -Standard -Name "vSwitch2" -VMHost $vmhost) -VLanId 600 -Confirm:$false
}