import-module activedirectory

function Get-RandomCharacters($length, $characters) {
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
    $private:ofs=""
    return [String]$characters[$random]
}
 
function Scramble-String([string]$inputString){     
    $characterArray = $inputString.ToCharArray()   
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
    $outputString = -join $scrambledStringArray
    return $outputString 
}
$users = Get-Content "C:\RCM-AD\RCMUser.txt"
$TargetDomain = "DC=NPC,DC=lan"
$TargetServer = "npc.lan"
$TargetPath = "OU=RCM,OU=Accounts,$($TargetDomain)"

Foreach($user in $users) {
	$SiteCode,$SNCode = $user.Split(".")
	$newUser=$SNCode+".RCM.P.FTPSvc"
	echo $newUser
	echo $SNCode
	echo $SiteCode
	$password = Get-RandomCharacters -length 10 -characters 'abcdefghiklmnoprstuvwxyz'
	$password += Get-RandomCharacters -length 5 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
	$password += Get-RandomCharacters -length 3 -characters '1234567890'
	$password += Get-RandomCharacters -length 2 -characters '!"ยง$%&/()=?}][{@#*+'
	$password = Scramble-String $password

	#Create AD OUs
	Write-Host ""
	Write-Host "Create Sub RCM OU's"
	Write-Host "Creating Users OU under $user"
	New-ADOrganizationalUnit -Name "Users" -Path "OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer	
	Write-Host "Creating Security OU under $user"
	New-ADOrganizationalUnit -Name "Security" -Path "OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer	
	Write-Host "Creating RCM OU under $user"
	New-ADOrganizationalUnit -Name "RCM" -Path "OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer 
	Write-Host "Creating Security OU under RCM $user"
	New-ADOrganizationalUnit -Name "Security" -Path "OU=RCM,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer 
	Write-Host "Creating Services OU under RCM,$user"
	New-ADOrganizationalUnit -Name "Services" -Path "OU=RCM,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer 
	Write-Host "Creating Security OU under RCM,$user"
	New-ADOrganizationalUnit -Name "Security" -Path "OU=Services,OU=RCM,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer 
	Write-Host "Creating Users OU under RCM,$user"
	New-ADOrganizationalUnit -Name "Users" -Path "OU=Services,OU=RCM,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer 

	#Create RCM User
	Write-Host ""
	Write-Host "Create RCM User"
	Write-Host "Creating AD User: $($SNCode+".RCM.P.FTPSvc") Password is $password "
	$NewPassword = ConvertTo-SecureString -String $password -AsPlainText -Force
	New-ADUser -Name $newUser -GivenName $newUser -Surname $newUser -DisplayName $newUser -Description $newUser -AccountPassword $NewPassword  -Enabled $True -Type iNetOrgPerson -Path "OU=Users,OU=Services,OU=RCM,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer 

	#Create RCM Groups
	Write-Host ""
	Write-Host "Create RCM Groups"
	Write-Host "Creating AD Group: $($SNCode+".RCM.FTP.DL")"
	New-ADGroup -Name "$($SNCode+".RCM.FTP.DL")" -GroupScope DomainLocal -Description "$($SiteCode+" RCM FTP Users")" -Path "OU=Security,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer
	Write-Host "Creating AD Group: $($SNCode+".RCM.ADX.DL")"
	New-ADGroup -Name "$($SNCode+".RCM.ADX.DL")" -GroupScope DomainLocal -Description "$($SiteCode+" RCM Adaxes Administrators")" -Path "OU=Security,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer
	Write-Host "Creating AD Group: $($SNCode+".FTP.RCM.DL")"
	New-ADGroup -Name "$($SNCode+".FTP.RCM.DL")" -GroupScope DomainLocal -Description "$($SiteCode+" RCM Client")" -Path "OU=Security,OU=RCM,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer 
	Write-Host "Creating AD Group: $($SNCode+".RCMADM.FTP.DL")"
	New-ADGroup -Name "$($SNCode+".ADMRCM.FTP.DL")" -GroupScope DomainLocal -Description "$($SiteCode+" RCM Administrator FTP")" -Path "OU=Security,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer
}