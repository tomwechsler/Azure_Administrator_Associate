Get-Command *az*user*

Get-Help New-AzADUser -detail

$SecureStringPassword = ConvertTo-SecureString -String 'Pa$$w0rdABC123' -AsPlainText -Force

New-AzADUser -DisplayName "Max Bishop" -UserPrincipalName "max.bishop@cloudgrid.site"  -Password $SecureStringPassword -MailNickname "MBishop"

Get-AzADUser
Get-azaduser | select displayname
Get-azaduser -DisplayName "Max Bishop"

$upn = "max.bishop@cloudgrid.site"
$city = "Zurich"
Update-AzADUser -UPNOrObjectId $upn -City $city 
(Show the city attribute in the portal GUI)

New-AzADGroup -DisplayName ProjectB_Members -MailNickname ProjectB_Members

Get-azadgroup | select displayname, id
(Copy the ID for ProjectB_Members)

$members = @()
$members += (Get-AzADUser -DisplayName "Jane Dodge").Id
$members += (Get-AzADUser -DisplayName "Janice Carter").Id

Add-AzADGroupMember -TargetGroupObjectID <Ihre Gruppen ID>  -MemberObjectID $members
