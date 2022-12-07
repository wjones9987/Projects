### Collects the manager's user ID, previous store and new store as user input. Adds a leading zero to the store number if 3 digits are not entered ###

$UserID = Read-host "Enter manager's user ID"
$OldStore = Read-host "Enter origin store number"
$Store1 = $OldStore.PadLeft('3', '0')
$NewStore = Read-host "Enter destination store number"
$Store2 = $NewStore.PadLeft('3', '0')
$Origin = "\\S${Store1}BKO1\Users\Mgmt\${UserID}"
$Destination = "\\S${Store2}BKO1\Users\Mgmt\${UserID}"

### Checks the origin and destination stores for a folder.  If found at both stores, the files are transferred. ###
### If only a destination folder is found, no action is taken. If only an orign folder is found, the destination folder is created and files are transferred. ###
### If a folder is not found at either store, a destination folder is created. ###

if ((Test-Path $Origin) -and (Test-Path $Destination)) 
{robocopy $Origin $Destination /E /move}

elseif (!(Test-Path $Origin) -and !(Test-Path $Destination))
{Write-Host "No folder exists at either store. Creating a folder on the destination store server. No files will be transferred.";
Get-ChildItem \\S${Store2}bko1\Users\mgmt > \\ahqnas1\vol1\Groups\Access\Tools\NewStores_CreateTool\zdir.txt
$Fldr = "\\S${Store2}bko1\Users\MGMT\${UserID}"
mkdir $Fldr
icacls $Fldr /inheritance:d
icacls $Fldr /remove:g 'users' /t
icacls $Fldr /remove:g "reicorpnet\S${Store2}MAN" /t
icacls $Fldr /grant "${UserID}:(CI)(OI)M" /t}

elseif (!(Test-Path $Origin) -and (Test-Path $Destination))
{Write-Host "Destination folder already exists.  Origin folder not found. No files will be transferred."}
    
else 
{Write-Host "Creating new folder and transferring files.";
    Get-ChildItem \\S${Store2}bko1\Users\mgmt > \\ahqnas1\vol1\Groups\Access\Tools\NewStores_CreateTool\zdir.txt
    $Fldr = "\\S${Store2}bko1\Users\MGMT\${UserID}"
    mkdir $Fldr
    icacls $Fldr /inheritance:d
    icacls $Fldr /remove:g 'users' /t
    icacls $Fldr /remove:g "reicorpnet\S${Store2}MAN" /t
    icacls $Fldr /grant "${UserID}:(CI)(OI)M" /t

    robocopy $Origin $Destination /E /move
}