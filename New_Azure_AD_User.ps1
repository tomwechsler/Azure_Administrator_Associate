Set-Location c:\
Clear-Host

Install-Module -Name AzureAD -AllowClobber -Force -Verbose

Import-Module AzureAD

#Username and PW for Login
$Credential = Get-Credential

Connect-AzureAD -Credential $Credential

#Are we connected?
Get-AzureADUser

#Create a password profile
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "P@ssw0rd444!"

New-AzureADUser -DisplayName "Tim Jones" -PasswordProfile $PasswordProfile -UserPrincipalName "Tim.Jones@tomwechsler.xyz" -AccountEnabled $true -MailNickName "TimJones"

Get-AzureADUser -Filter "Displayname eq 'Tim Jones'"

New-AzureADGroup -DisplayName "Store" -MailEnabled $false -SecurityEnabled $true -MailNickName "Store"

Get-AzureADGroup -Filter "DisplayName eq 'Store'"

Get-AzureADUser -Filter "Displayname eq 'Tim Jones'"

Add-AzureADGroupMember -ObjectId "e0179643-72bd-476e-a0a5-c78d09cb231f" -RefObjectId "0e23bdf9-a3cb-48e8-8b4a-cfd64e9f207c" #RefObjectID = User; ObjectId = Gruppe

Get-AzureADGroup -Filter "DisplayName eq 'Store'"

Get-AzureADUserMembership  -ObjectId "0e23bdf9-a3cb-48e8-8b4a-cfd64e9f207c" #RefObjectID = User;

Get-AzureADGroupMember -ObjectId "e0179643-72bd-476e-a0a5-c78d09cb231f" #ObjectId = Gruppe

#Another way
$domain = "tomwechsler.xyz"

#Find an existing user
Get-AzureADUser -SearchString "FR"

Get-AzureADUser -Filter "State eq 'SO'"

Get-AzureADUser -Filter "Displayname eq 'Fred Prefect'" | Select-Object Displayname, State, Department

#Creating a new user
$user = @{
    City = "Oberbuchsiten"
    Country = "Switzerland"
    Department = "Information Technology"
    DisplayName = "Fred Jonas"
    GivenName = "Fred"
    JobTitle = "Azure Administrator"
    UserPrincipalName = "fred.jonas@$domain"
    PasswordProfile = $PasswordProfile
    PostalCode = "4625"
    State = "SO"
    StreetAddress = "Hiltonstrasse"
    Surname = "Jonas"
    TelephoneNumber = "455-233-22"
    MailNickname = "FredJonas"
    AccountEnabled = $true
    UsageLocation = "CH"
}

$newUser = New-AzureADUser @user

$newUser | Format-List

Get-AzureADUser -Filter "Displayname eq 'Fred Jonas'" | Select-Object Displayname, State, Department