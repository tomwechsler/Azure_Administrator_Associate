Set-Location C:\Temp
Clear-Host

Install-Module -Name Az -Force -AllowClobber -Verbose

#Log into Azure
Connect-AzAccount

#Select the correct subscription
Get-AzSubscription -SubscriptionName "Visual Studio Enterprise-Abonnement" | Select-AzSubscription

#Providers
Get-AzProviderOperation "Microsoft.Support/*" | FT Operation, Description -AutoSize

Get-AzRoleDefinition -Name "Reader" | ConvertTo-Json | Out-File C:\Temp\ReaderSupportRole.json

#Open the ReaderSupportRole.json in VSCode

Get-AzSubscription

#In AssignableScopes, add your subscription ID
#Change the Name and Description properties to "Reader Support Tickets" and "View everything in the subscription and also open support tickets."

New-AzRoleDefinition -InputFile "C:\Temp\ReaderSupportRole.json"

#To list all your custom roles
Get-AzRoleDefinition | ? {$_.IsCustom -eq $true} | FT Name, IsCustom

#You can also see the custom role in the Azure portal

#Delete a custom role
Get-AzRoleDefinition "Reader Support Tickets"

Remove-AzRoleDefinition -Id "c499320b-0d83-46e4-8a3e-c790286f1f09"