<#
.SYNOPSIS
    This script moves computers in Active Directory to a specified Organizational Unit (OU).

.AUTHOR
    SpeedySpikes

.CREATED
    05/15/2025
#>

Import-Module ActiveDirectory

# Specify the target Organizational Unit (OU)
# Define a list of Organizational Units (OUs)
$ouList = @(
    "OU=WorkstationGroup1,OU=Department1,OU=Location1,OU=Computers,DC=example,DC=com",
    "OU=WorkstationGroup2,OU=Department2,OU=Location2,OU=Computers,DC=example,DC=com",
    "OU=WorkstationGroup3,OU=Department3,OU=Location3,OU=Computers,DC=example,DC=com",
    "OU=WorkstationGroup4,OU=Department4,OU=Location4,OU=Computers,DC=example,DC=com",
    "OU=NewComputers,OU=Department5,OU=Location5,OU=Computers,DC=example,DC=com"
)

# Display the list of OUs for selection
Write-Host "Select the target Organizational Unit (OU):"
for ($i = 0; $i -lt $ouList.Count; $i++) {
    Write-Host "$($i + 1): $($ouList[$i])"
}
Write-Host "0: Enter a custom OU"

# Prompt the user to select an OU
$selection = Read-Host "Enter the number corresponding to your choice"
if ($selection -eq "0") {
    $targetOU = Read-Host "Enter the custom OU's full path"
} elseif ($selection -as [int] -and $selection -gt 0 -and $selection -le $ouList.Count) {
    $targetOU = $ouList[$selection - 1]
} else {
    Write-Host "Invalid selection. Exiting." -ForegroundColor Red
    exit
}

Write-Host "Target OU: $targetOU"

while ($true) {
    # Prompt the user for the computer name
    $computerName = Read-Host "Enter the computer name to move"
    if ($computerName -eq "") {
        Write-Host "No computer name entered. Exiting." -ForegroundColor Red
        break
    }
    # Validate the computer name format
    if ($computerName[0] -eq "M") {
        # don't change the name
    } elseif ($computerName[1] -eq "-") {
        $computerName = "M" + $computerName.Substring(2)
    } else {
        $computerName = "M" + $computerName
    }
    
    # Check if the computer exists in Active Directory
    $computer = Get-ADComputer -Filter {Name -eq $computerName} -ErrorAction SilentlyContinue

    if ($computer) {
        # Move the computer to the target OU
        try {
            Move-ADObject -Identity $computer.DistinguishedName -TargetPath $targetOU
            Write-Host "Successfully moved $computerName to $targetOU" -ForegroundColor Green
        } catch {
            Write-Host "Failed to move $computerName. Error: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "Computer $computerName not found in Active Directory." -ForegroundColor Yellow
        $isLaptop = Read-Host "Is this a laptop? (y/n)"
        if ($isLaptop -eq "y") {
            $computerName += "L"
            $computer = Get-ADComputer -Filter {Name -eq $computerName} -ErrorAction SilentlyContinue
            if ($computer) {
                # Move the laptop to the target OU
                try {
                    Move-ADObject -Identity $computer.DistinguishedName -TargetPath $targetOU
                    Write-Host "Successfully moved $computerName to $targetOU" -ForegroundColor Green
                } catch {
                    Write-Host "Failed to move $computerName. Error: $_" -ForegroundColor Red
                }
            } else {
                Write-Host "Laptop $computerName not found in Active Directory." -ForegroundColor Yellow
            }
        }
    }
}