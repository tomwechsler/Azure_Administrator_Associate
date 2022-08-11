#Create a password object
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

#Assign the password
$PasswordProfile.Password = "P@ssw0rd98765!!!"

#Create the new user
New-AzureADUser -AccountEnabled $True -DisplayName "Abby Brown" -PasswordProfile $PasswordProfile -MailNickName "AbbyBrown" -UserPrincipalName "Abby.Brown@cloudgrid.site"
