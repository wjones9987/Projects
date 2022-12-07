# Import AD Module
Import-Module ActiveDirectory

# Get CSV File Name
$FileName = Read-Host "What is the name of the CSV file?"

# Import the data from CSV file and assign it to variable
$Users = Import-Csv "C:\Temp\$FileName.csv"

# Specify the target group
$Group = Read-Host "What is the name of the AD group?" 

$Users | ForEach-Object {
    
    # Retrieve the user and assign to a variable
    $ADUser = Get-ADUser -Filter "samaccountname -eq '$($_.username)'"

    # Get a list of the group members and assign to a variable
        $GroupMember = Get-ADGroupMember -Identity "$Group" | Select-Object samaccountname    
        
        # Check the group membership to see if the user already is a member
        if ($GroupMember | Where-Object -Property samaccountname -EQ $ADUser.samaccountname) {

            Write-Host "$($_.username) already is a member of $Group" -ForegroundColor Yellow
        }
        # Check to see if the user exists in AD
        elseif ($null -eq $ADUser.samaccountname) {

            Write-Host "$($_.username) was not found" -ForegroundColor Red            
        }
        # If the user exists in AD and is not already a member, add the user to the group        
        else {          
           
            Add-ADGroupMember -Identity $Group -Members $ADUser.SamAccountName -Confirm:$false

            Write-Host "$($_.username) has been added to $Group" -ForegroundColor Green

            }            
    }
  
