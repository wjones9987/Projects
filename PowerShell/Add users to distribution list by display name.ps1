# Import Exchange Session
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://wlvaexc191/PowerShell
Import-PSSession $ExchangeSession -DisableNameChecking -AllowClobber

# Import AD
Import-Module ActiveDirectory

# Add a line for clarity
Write-Host "`n"

# Get CSV File Name
$FileName = Read-Host "What is the name of the CSV file?"

# Import the data from CSV file and assign it to a variable
$Users = Import-Csv "C:\Temp\$FileName.csv"

# Specify the target distribution list
$DL = Read-Host "What is the name of the distribution list?" 

Write-Host "`n"

# Get the DL membership before updating and add it to a variable
$DLbefore = get-distributiongroupmember -identity "$DL" | Select-Object displayname

# Add the users in the CSV file to the distro.  Output the specific error message if unable to add the user.
$Users | ForEach-Object {

    try {
        add-distributiongroupmember -identity $DL -member $_.name -ErrorAction stop
    }
    catch {
        Write-Host $_.Exception.Message -ForegroundColor Red
    }    

}

Write-Host "`n"

# Get the updated DL member list and add it to a variable
$DLafter = get-distributiongroupmember -identity "$DL" | Select-Object displayname

# Compare the before and after lists and save the members added to a variable
$MembersAdded = $DLafter.displayname | Where-Object {$DLbefore.displayname -notcontains $_} | Select-Object @{Name='Name';Expression={$_}}

Write-Host "New members added to $DL": -ForegroundColor Green

$MembersAdded | ft

