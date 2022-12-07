# Import AD
Import-Module ActiveDirectory

# Import Exchange Session
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://wlvaexc191/PowerShell
Import-PSSession $ExchangeSession -DisableNameChecking

# Input contact information and DL name
$ContactName = Read-Host "What is the contact name?"
$EmailAddress = Read-Host "What is the contact email?"
$distro = Read-Host "What is the name of the distribution list?"

# Create the new contact
New-MailContact -Name "$ContactName" -ExternalEmailAddress "$EmailAddress" -OrganizationalUnit "reicorpnet.com/REI/Accounts/Contacts"

Start-Sleep -Seconds 2

# Add the new contact to the distribution list
Add-DistributionGroupMember -Identity "$distro" -Member "$ContactName"

Start-Sleep -Seconds 2

# Check to verify that the contact has been added to the DL
$DistroMembers = Get-DistributionGroupMember -Identity "$distro"

    if ($DistroMembers | Where-Object {$_.name -eq $ContactName}) {
        Write-Host "`n`n$ContactName has been added to $distro" -ForegroundColor Green
    }
    else {
        Write-Host "`n`n$ContactName was not found in $distro" -ForegroundColor Red
    }


