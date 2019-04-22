Import-Module activedirectory

Write-Host ""
Write-Host "-----------------------------------------------------"
Write-Host "-                                                   -"
Write-Host "-               RCM Client AD Creation              -"
Write-Host "-                  ver. 02/11/19                    -"
Write-Host "-                                                   -"
Write-Host "-----------------------------------------------------"
Write-Host ""

##################################################################
##                 	Function Create AD OU Structure 		    ##
##################################################################
Function Create-ADStructure($Mnemonic, $NpcID, $LongName, $Creds)
{
	$TargetDomain = "DC=NPC,DC=lan"
	$TargetServer = "npc.lan"
	$TargetPath = "OU=RCM,OU=Accounts,$($TargetDomain)"
	$password = Get-RandomCharacters -length 10 -characters 'abcdefghiklmnoprstuvwxyz'
	$password += Get-RandomCharacters -length 5 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
	$password += Get-RandomCharacters -length 3 -characters '1234567890'
	$password += Get-RandomCharacters -length 2 -characters '!"ยง$%&/()=?}][{@#*+'
	$password = Scramble-String $password
	
	
	#Create AD OUs
	Write-Host ""
	Write-Host "Creating Client OUs"
	New-ADOrganizationalUnit -Name "$($Mnemonic+"."+$NpcID)" -Path $TargetPath -Server $TargetServer -Credential $Creds
	New-ADOrganizationalUnit -Name "Security" -Path "OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer -Credential $Creds
	New-ADOrganizationalUnit -Name "Users" -Path "OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer -Credential $Creds
	Write-Host "Create Sub RCM OU's"
	Write-Host "Creating RCM OU under $user"
	New-ADOrganizationalUnit -Name "RCM" -Path "OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer  -Credential $Creds
	Write-Host "Creating Security OU under RCM $user"
	New-ADOrganizationalUnit -Name "Security" -Path "OU=RCM,OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer  -Credential $Creds
	Write-Host "Creating Services OU under RCM,$user"
	New-ADOrganizationalUnit -Name "Services" -Path "OU=RCM,OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer  -Credential $Creds
	Write-Host "Creating Security OU under RCM,$user"
	New-ADOrganizationalUnit -Name "Security" -Path "OU=Services,OU=RCM,OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer  -Credential $Creds
	Write-Host "Creating Users OU under RCM,$user"
	New-ADOrganizationalUnit -Name "Users" -Path "OU=Services,OU=RCM,OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer  -Credential $Creds	

	#Create RCM User
	Write-Host ""
	Write-Host "Create RCM User"
	Write-Host "Creating AD User: $($Mnemonic+".RCM.P.FTPSvc") Password is $password "
	$NewPassword = ConvertTo-SecureString -String $password -AsPlainText -Force
	New-ADUser -Name $newUser -GivenName $newUser -Surname $newUser -DisplayName $newUser -Description $newUser -AccountPassword $NewPassword  -Enabled $True -Type iNetOrgPerson -Path "OU=Users,OU=Services,OU=RCM,OU=$($SiteCode+"."+$SNCode),$($TargetPath)" -Server $TargetServer  -Credential $Creds 
	
	#Create AD Security Groups
	Write-Host ""
	Write-Host "Creating AD Groups"
	Write-Host "Creating AD Group: $($NpcID+".RCM.ADX.DL")"
	New-ADGroup -Name "$($NpcID+".RCM.ADX.DL")" -GroupScope DomainLocal -Description "$($LongName+" RCM Adaxes Client")" -Path "OU=Security,OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer -Credential $Creds
	Write-Host "Creating AD Group: $($NpcID+".RCM.FTP.DL")"
	New-ADGroup -Name "$($NpcID+".RCM.FTP.DL")" -GroupScope DomainLocal -Description "$($LongName+" RCM FTP")" -Path "OU=Security,OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer -Credential $Creds
	Write-Host "Creating AD Group: $($NpcID+".FTP.RCM.DL")"
	New-ADGroup -Name "$($NpcID+".FTP.RCM.DL")" -GroupScope DomainLocal -Description "$($Mnemonic+" RCM Client")" -Path "OU=Security,OU=RCM,OU=$($Mnemonic+"."+$NpcID),$($TargetPath)" -Server $TargetServer  -Credential $Creds
	Write-Host "Creating AD Group: $($NpcID+".RCMADM.FTP.DL")"
	New-ADGroup -Name "$($NpcID+".ADMRCM.FTP.DL")" -GroupScope DomainLocal -Description "$($Mnemonic+" RCM Administrator FTP")" -Path "OU=Security,OU=$($Mnemonic+"."+$SNCode),$($TargetPath)" -Server $TargetServer  -Credential $Creds

}

##################################################################
##     	Function Generate RandomCharacters String	    	    ##
##################################################################
function Get-RandomCharacters($length, $characters) {
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
    $private:ofs=""
    return [String]$characters[$random]
}

##################################################################
##        	Function Scramble Characters String        		    ##
##################################################################

function Scramble-String([string]$inputString){     
    $characterArray = $inputString.ToCharArray()   
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
    $outputString = -join $scrambledStringArray
    return $outputString 
}
##################################################################
##                 GET USER INPUTS FROM KEYBOARD                ##
##################################################################

$Loop = 1
While($Loop -eq 1) {
	Write-Host "Input NPC Mnemonic (format <CLIENT NAME>_<STATE>): " -ForegroundColor Yellow -NoNewLine
	$ClientMnemonic = Read-Host
	Write-Host "Input NPC Client ID (format <CLIENT ID>): " -ForegroundColor Yellow -NoNewLine
	$ClientNpcId = Read-Host
	Write-Host "Input Full Client Name: " -ForegroundColor Yellow -NoNewLine
	$ClientName = Read-Host
	
	Write-Host ""
	Write-Host "Client OU:  $($ClientMnemonic).$($ClientNpcId)"
	Write-Host "Is the Client OU correct (y/n): " -ForegroundColor Yellow -NoNewLine
	Switch(Read-Host){
		y {
			$AdminCredential = $Host.ui.PromptForCredential("Admin credentials required", "Please enter your Netsmartcore user name and password.", "", "NetBiosUserName")
			Write-Host "Creating AD OU Structure" -ForegroundColor Green
			Create-ADStructure $ClientMnemonic $ClientNpcId $ClientName $AdminCredential
			$Loop = 0
		}
		default {
			Write-Host ""
			Write-Host "Client OU invalid" -ForegroundColor Red
			Write-Host ""
		}
	}
}

Write-Host "Press any key to exit " -ForegroundColor Yellow -NoNewLine
$Exit = Read-Host