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
$Downhosts = @()

##################################################################
##                     Start time Variable                      ##
##################################################################
$s=Get-Date

GC $Inputfile | %{
	If (Test-Connection $_ -Quiet -Count 2){
	Write-Host "$_ is UP" -b LightGreen
	}
	Else{
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
Write-Host "-----------------------------------------------------"
Write-Host ""
Write-Host "-----------------------------------------------------"
Write-Host "-  Systems to check back up as still not responding -"
Write-Host "-----------------------------------------------------"
foreach ($Downhost in $Downhosts){
Write-Host "      $Downhost is Down                   " -b Red         
}
Write-Host "-----------------------------------------------------"
Write-Host ""
Write-Host ""