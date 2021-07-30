<#
.SYNOPSIS
  Check if input process is running
.DESCRIPTION
  Checks if  input process is running, a prompt window ask you if  you want to stop the process .Otherwise a prompt window informs you that the process is not running on your machine
.NOTES
  Version:        1.0
  Author:         Lunicco
  Creation Date:  30-07-2021
.EXAMPLE
  CheckProcessRunning.ps1 -Process_name SoundRec  
  
    -If Process is running, a prompt window ask you if  you want to stop the process
    -If Process is not running, a prompt window informs you that the process is not running on your machine
#>

#-------------------------------------------------------------[Init]--------------------------------------------------------------#
param 
  (
    [Parameter(Mandatory=$true)]
    [string] $Process_Name
  )
Add-Type -AssemblyName PresentationCore,PresentationFramework
$global:ProcessRunning=$false


#-----------------------------------------------------------[Functions]-----------------------------------------------------------#
function CheckProcessRunning
{  
  try 
  {
    if (get-process *$Process_Name*)  
    {
      $global:ProcessRunning="True"
      Write-Output $Process_Name" process is running"
    }
    else
    {
      $global:ProcessRunning="False"
      Write-Output $Process_Name" process is not running"
    }
   }
  catch 
  {
    Write-Host ("Error:" + $_.Exception.Message) 
  } 
} 

function InformProcess
{
  try
      {     
        [System.Windows.MessageBox]:: Show("$Process_Name process is not running in this moment","Process is not Running","Ok","Information")
      }

  catch
      {
          Write-Host ("Error:" + $_.Exception.Message)
      }
}

function StopProcess
{
  try
      {     
        $msgBoxInput = [System.Windows.MessageBox]:: Show("$Process_Name is running, Do you want to Stop it?","Process Running","YesNo","Warning")
        switch ($msgBoxInput) 
            {
                "Yes" 
                    {
                      Stop-Process -Name $Process_Name
                    }
                "No" 
                    {
                        Write-Host "Stop-Process canceled"
                    }
            }    

      }

  catch
      {
          Write-Host ("Error:" + $_.Exception.Message)
      }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------#

CheckProcessRunning
if ($ProcessRunning -eq $True)
    {
      StopProcess
    }
else 
    {
      InformProcess
    }