#################################################################
#list all teams where a specific user is owner or member
#Martin Löffler 
#24.08.2023
#################################################################

# connect to teams with teams admin role 
Connect-MicrosoftTeams 

# mail of user to be checked
$userToCheck = "<---enter mail address of user here--->"

# get all teams of user
$teams = Get-Team -User $userToCheck

# all teams with role of user 
$result = New-Object System.Data.Datatable
[void]$result.Columns.Add("TeamName")
[void]$result.Columns.Add("UserRoleInTeam")
[void]$result.Columns.Add("TeamVisibility")
[void]$result.Columns.Add("TeamArchived")
[void]$result.Columns.Add("TeamDescription")

foreach ($team in $teams){
 $teamMember = Get-TeamUser -GroupId $team.GroupId | where User -eq $userToCheck
 [void]$result.Rows.Add($team.DisplayName,$teamMember.Role,$team.Visibility,$team.Archived,$team.Description)
}

# print resulting table
$result | Format-Table -AutoSize -Force -Wrap

# export as csv (change path if you like)
$result | Export-Csv C:\temp\UserInTeams.csv -NoType