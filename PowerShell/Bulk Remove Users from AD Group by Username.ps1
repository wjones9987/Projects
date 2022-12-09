# Import AD Module
Import-Module ActiveDirectory

# Get CSV File Name
$FileName = Read-Host "What is the name of the CSV file?"

# Import the data from CSV file and assign it to variable
$Users = Import-Csv "C:\Temp\$FileName.csv"

# Specify the target group
$Group = Read-Host "What is the name of the AD group?" 

$Users | ForEach-Object {
    
        # Get a list of the group members and assign to a variable
        $GroupMember = Get-ADGroupMember -Identity "$Group" | Select-Object samaccountname
        
        # Retrieve the user and assign to a variable
        $ADUser = Get-ADUser -Filter "samaccountname -eq '$($_.username)'"
        
        # Check the group membership to see if the user is a member.  If found, remove the user.
        if ($GroupMember | Where-Object -Property samaccountname -EQ $_.username) {

            Remove-ADGroupMember -Identity $Group -Members $ADUser.SamAccountName -Confirm:$false

            Write-Host "$($_.username) has been removed from $Group" -ForegroundColor Green          
           
        }
        
        # If the user was not found in the group, print the name        
        else {          
           
            Write-Host "$($_.username) was not found in $Group" -ForegroundColor Red

            }            
    }
  
