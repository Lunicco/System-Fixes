<#
.Synopsis
  Check system reboot
.DESCRIPTION
  Check system reboot
.EXAMPLE
   Author: Lunicco
#>
$global:OutputVarible=" "
$global:RequiresReboot = $false
$global:UptimeDays=15

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
                    $global:OutputVarible=$OutputVarible+ "`nSystem requires a reboot"
                    Write-Output $OutputVarible
                }
            else
                {
                    $global:OutputVarible=$OutputVarible+ "`nSystem does not require a reboot"
                    Write-Output $OutputVarible
                }
        }

    catch
        {
            $RequiresReboot = $false
            Write-Host ("Error:" + $_.Exception.Message)
        }
  
}

CheckRestart
if ($RequiresReboot)
    {
        $title   = " "
        $msg     = "Do you want to reboot your computer now? (You have 5 minutes to save and close files before reboot starts)"
        $options = "&Yes", "&No"
        $default = 1  

        do 
            {
                $PromptMessage = (Get-Host).UI.PromptForChoice($title, $msg, $options, $default)
                if ($PromptMessage -eq 0) 
                    {
                        shutdown /r /f /t 300
                        $PromptMessage=1
                    }
            } 
        until ($PromptMessage -eq 1)
    }