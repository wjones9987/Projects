# Start transcript
Start-Transcript -Path "C:\Temp\MailAccountStatus.log" -Append

# Import AD Module
Import-Module ActiveDirectory

# Import the data from CSV file and assign it to variable
$Mailboxes = Import-Csv "C:\Temp\GenericMailboxes.csv"

# Iterates through the list, identifies accounts that are enabled, then disables them
$Mailboxes.ForEach({

     $Status = Get-ADUser -Identity $_.name | Select-Object enabled 
    
     if ($Status -match "True") {
          Write-Host "Mailbox $($_.name) is enabled" -ForegroundColor Red
          Write-Host "Disabling the mailbox. One moment..."
          
          do {$Status = Get-ADUser -Identity $_.name | Select-Object enabled
              Get-ADUser -Identity $_.name | Set-ADUser -Enabled $false
              Start-Sleep -Seconds 5
              $Status = Get-ADUser -Identity $_.name | Select-Object enabled}
          while ($Status -match "True")
                   
          Write-Host "Mailbox $($_.name) $($_."display name") is now disabled" -ForegroundColor Green
          
     }
     elseif ($Status -match "False") {
          Write-Host "Mailbox $($_.name) is disabled" -ForegroundColor Green
     }
     else {
          Write-Host "Mailbox not found" 
     }
}) 

Stop-Transcript






    
    

