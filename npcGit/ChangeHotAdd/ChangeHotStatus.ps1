############################# CHANGELOG #######################################
# December 2016		First version
# March 2017   
#
#
################################ CONSTANTS ######################################
# ChangeHotAddState
#
#
# This script will allow take in a set of 


############################# CHANGELOG #######################################
# February 2013		First version
# April 2013		Bugfixes, Added Per Cluster report
# July 2013			Bugfixes, Added Cluster Resilience & Provisionning Potential reports, other minor code adjustements
# January 2014		Added Consolidation ratio, ESXi Hardware & Software Information table, vCenter version, Print Computer name and script version


################################ CONSTANTS ######################################


#-------------------------CHANGE THESE VALUES--------------------------------
$SMTPServer ="10.192.254.2"
$vCenterSrv = "192.168.151.77"
$InFile = "C:\scripts\HotCPUMEMAdd.txt"
$DebugFile = "C:\VMsDebug_2.txt"
$OutFile = "C:\VMsOut_2.txt"
$ToAddress = "jkarocki@ntst.com"
#$ToAddress = "destinationadress1@company.com", "destinationadress2@company.com", "destinationadress3@company.com"

#-----------------------------------------------------------------------------


############################ GLOBAL VARIABLES ###################################


################################ FUNCTIONS ######################################
Function Disable-vCpuHotAdd($vm){
    $vmview = Get-vm $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec

    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="vcpu.hotadd"
    $extra.Value="false"
    $vmConfigSpec.extraconfig += $extra

    $vmview.ReconfigVM($vmConfigSpec)
}

Function Enable-vCpuHotAdd($vm){
echo $vm
    $vmview = Get-vm $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec

    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="vcpu.hotadd"
    $extra.Value="true"
    $vmConfigSpec.extraconfig += $extra

    $vmview.ReconfigVM($vmConfigSpec)
}

Function Enable-MemHotAdd($vm){
echo $vm
    $vmview = Get-vm $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec

    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="mem.hotadd"
    $extra.Value="true"
    $vmConfigSpec.extraconfig += $extra

    $vmview.ReconfigVM($vmConfigSpec)
}

Function Disable-MemHotAdd($vm){
    $vmview = Get-VM $vm | Get-View 
    $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec

    $extra = New-Object VMware.Vim.optionvalue
    $extra.Key="mem.hotadd"
    $extra.Value="false"
    $vmConfigSpec.extraconfig += $extra

    $vmview.ReconfigVM($vmConfigSpec)
}

############################ vCenter Hot Add Changes ############################
Connect-VIServer $vCenterSrv


ForEach ($vmname in Get-Content $InFile)
{
echo $vmname    # Call function to enable HotAdd
	Enable-MemHotAdd $vmname
	#Enable-vCpuHotAdd $vmname
}
Disconnect-VIServer -Server $vCenterSrv -Force