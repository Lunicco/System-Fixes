<#
.SYNOPSIS
    Check system reboot
.DESCRIPTION
    Checks if system uptime is greater than UptimeDays variable (15 days by default), in Positive case, asks about system reboot using the MessgeBox funtionallity.
.NOTES
    Version:        1.0
    Author:         Lunicco
    Creation Date:  27-07-2021
#>

#-------------------------------------------------------------[Init]--------------------------------------------------------------#
Add-Type -AssemblyName PresentationCore,PresentationFramework
$global:OutputVarible=" "
$global:RequiresReboot = $false
$global:UptimeDays=15

#-----------------------------------------------------------[Functions]-----------------------------------------------------------#
function CheckRestart
{
    try
        {     
            $today=Get-Date 
            $LastBootUptime=(gcim Win32_OperatingSystem).LastBootUpTime
            $PCUptime = ($today - $LastBootUptime).Days
            $global:OutputVarible="Current date: "+$today+"`nLast Reboot: " +$LastBootUptime+"`nDays since last Reboot: "+$PCUptime

            if($PCUptime -gt $UptimeDays) 
                {
                    $global:RequiresReboot = $true
                    $global:OutputVarible=$OutputVarible+ "`n`nSystem requires a reboot"
                    [System.Windows.MessageBox]:: Show($OutputVarible,"System Uptime Information","Ok","Information")
                }
            else
                {
                    $global:OutputVarible=$OutputVarible+ "`n`nSystem does not require a reboot"
                    [System.Windows.MessageBox]:: Show($OutputVarible,"System Uptime Information","Ok","Information")
                }
        }

    catch
        {
            $RequiresReboot = $false
            Write-Host ("Error:" + $_.Exception.Message)
        }
  
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------#
CheckRestart
if ($RequiresReboot)
    {
        $msgBoxInput = [System.Windows.MessageBox]:: Show("Do you want to reboot your computer now? (You have 5 minutes to save and close files before reboot starts)","System requires a reboot","YesNo","Warning")
        switch ($msgBoxInput) 
            {
                "Yes" 
                    {
                        shutdown /r /f /t 300
                    }
                "No" 
                    {
                        Write-Host "Reboot canceled"
                    }
            }
    }