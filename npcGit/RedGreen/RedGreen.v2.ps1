<#
.SYNOPSIS
  Name: RedGreen.ps1
  The purpose of this script is to blah blah... What?
  
.DESCRIPTION
  A slightly longer description of example.ps1 Why and How?

.PARAMETER InitialDirectory
  The initial directory which this example script will use.
  
.PARAMETER Add
  A switch parameter that will cause the example function to ADD content.

Add or remove PARAMETERs as required.

.NOTES
    Updated: 2019-04-15        Updated Output of Failed systems.
    Release Date: 2019-03-17
   
  Author: James Karocki

.EXAMPLE
  Run the Get-Example script to create the c:\example folder:
  Get-Example -Directory c:\example

.EXAMPLE 
  Run the Get-Example script to create the folder c:\example and
  overwrite any existing folder in that location:
  Get-Example -Directory c:\example -force

See Help about_Comment_Based_Help for more .Keywords

# Comment-based Help tags were introduced in PS 2.0
#requires -version 2
https://www.petri.com/change-powershell-console-font-and-background-colors
#>
Write-Host ""
Write-Host "-----------------------------------------------------"
Write-Host "-                                                   -"
Write-Host "-        Client Red Light Green Light Check         -"
Write-Host "-                  ver. 04/18/19                    -"
Write-Host "-                                                   -"
Write-Host "-----------------------------------------------------"
Write-Host ""

##################################################################
##                     Static Variables                         ##
##################################################################
$Inputfile=".\RedGreen-Hostname.txt"
$OutputLog=".\RedGreen.log"
$Downhosts = @()
$s=Get-Date

##################################################################
##                     Log Function                             ##
##################################################################
 function Write-Log
{
          [CmdletBinding()]
          Param
          (
                   [Parameter(Mandatory = $true,
                                        ValueFromPipelineByPropertyName = $true)]
                   [ValidateNotNullOrEmpty()]
                   [Alias("LogContent")]
                   [string]$Message,
                   [Parameter(Mandatory = $false)]
                   [Alias('LogPath')]
                   [string]$Path,
                   [Parameter(Mandatory = $false)]
                   [ValidateSet("Error", "Warn", "Info")]
                   [string]$Level = "Info",
                   [Parameter(Mandatory = $false)]
                   [switch]$NoClobber
          )
          
          Begin
          {
                   # Set VerbosePreference to Continue so that verbose messages are displayed.
                   #$VerbosePreference = 'Continue'
				   $VerbosePreference = 'Nope'
          }
          Process
          {
                   
                   # If the file already exists and NoClobber was specified, do not write to the log.
                   if ((Test-Path $Path) -AND $NoClobber)
                   {
                             Write-Error "Log file $Path already exists, and you specified NoClobber. Either delete the file or specify a different name."
                             Return
                   }
                   
                   # If attempting to write to a log file in a folder/path that doesn't exist create the file including the path.
                   elseif (!(Test-Path $Path))
                   {
                             Write-Verbose "Creating $Path."
                             $NewLogFile = New-Item $Path -Force -ItemType File
                   }
                   
                   else
                   {
                             # Nothing to see here yet.
                   }
                   
                   # Format Date for our Log File
                   $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                   
                   # Write message to error, warning, or verbose pipeline and specify $LevelText
                   switch ($Level)
                   {
                             'Error' {
                                      Write-Error $Message
                                      $LevelText = 'ERROR:'
                             }
                             'Warn' {
                                      Write-Warning $Message
                                      $LevelText = 'WARNING:'
                             }
                             'Info' {
                                      Write-Verbose $Message
                                      $LevelText = 'INFO:'
                             }
                   }
                   
                   # Write log entry to $Path
                   "$FormattedDate $LevelText $Message" | Out-File -FilePath $Path -Append
          }
          End
          {
          }
}


GC $Inputfile | %{
	If (Test-Connection $_ -Quiet -Count 2){
	Write-Log -Message "$_ is UP"  -Path $OutputLog
	Write-Host "$_ is UP" -b Green
	}
	Else{
	Write-Log -Message "$_ is Down"  -Path $OutputLog
	Write-Host "$_ is Down" -b Red
	$Downhosts += $_
	}
}
##################################################################
##                     Endtime Variable                         ##
##################################################################
$e=Get-Date

##################################################################
##                     TotalTime  Variable                      ##
##################################################################
$TotalTime=($e - $s).TotalSeconds
Write-Host ""
Write-Host ""
Write-Host "-----------------------------------------------------"
Write-Host "-  Total Time for Run was $TotalTime seconds        -"
Write-Log -Message "Total Time for Run was $TotalTime seconds"  -Path $OutputLog
Write-Host "-----------------------------------------------------"
Write-Host ""
Write-Host "-----------------------------------------------------"
Write-Host "-  Systems to check back up as still not responding -"
Write-Log -Message "Systems to check back up as still not responding"  -Path $OutputLog
Write-Host "-----------------------------------------------------"
Write-Host ""
Write-Log -Message " "  -Path $OutputLog
Write-Log -Message "-----------------------------------------------------"  -Path $OutputLog
Write-Host "-----------------------------------------------------"
foreach ($Downhost in $Downhosts){
Write-Host "      $Downhost is Down                   " -b Red       
Write-Log -Message "$Downhost is Down "  -Path $OutputLog  
}
Write-Log -Message "-----------------------------------------------------"  -Path $OutputLog
Write-Host "-----------------------------------------------------"
Write-Host ""
Write-Host ""