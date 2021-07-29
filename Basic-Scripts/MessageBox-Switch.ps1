<#
.SYNOPSIS
    PS Message Prompt Template
.DESCRIPTION
    A template to use MessageBox funtionality using Switch logic. 
.NOTES
    Version:        1.0
    Author:         Lunicco
    Creation Date:  24-07-2021
#>

#-------------------------------------------------------------[Init]--------------------------------------------------------------#
Add-Type -AssemblyName PresentationCore,PresentationFramework

#-----------------------------------------------------------[Functions]-----------------------------------------------------------#
function MessageBox
{
    try
        {     
            $msgBoxInput = [System.Windows.MessageBox]:: Show("Do you want to reboot your computer now? (You have 5 minutes to save and close files before reboot starts)","System requires a reboot","YesNo","Warning")
            switch ($msgBoxInput) 
                {
                    "Yes" 
                        {
                            Write-Host "Reboot canceled"
                        }
                    "No" 
                        {
                            Write-Host "Reboot canceled"
                        }
                }
        }

    catch
        {
            Write-Host ("Error:" + $_.Exception.Message)
        }
  
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------#
MessageBox
