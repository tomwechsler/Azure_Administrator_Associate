Set-Location C:\Scripte
Clear-Host

Install-Module -Name Az -Force -AllowClobber -Verbose

#Log into Azure
Connect-AzAccount

#Select the correct subscription
Get-AzSubscription -SubscriptionName "Visual Studio Enterprise-Abonnement" | Select-AzSubscription

#Providers
Get-AzProviderOperation "Microsoft.Support/*" | Format-Table Operation, Description -AutoSize

Get-AzRoleDefinition -Name "Reader" | ConvertTo-Json | Out-File C:\Scripte\ReaderSupportRole.json

#Open the ReaderSupportRole.json in VSCode

code . ReaderSupportRole.json

Get-AzSubscription

#In AssignableScopes, add your subscription ID
#Change the Name and Description properties to "Reader Support Tickets" and "View everything in the subscription and also open support tickets."

New-AzRoleDefinition -InputFile "C:\Scripte\ReaderSupportRole.json"

#To list all your custom roles
Get-AzRoleDefinition | Where-Object {$_.IsCustom -eq $true} | Format-Table Name, IsCustom

#You can also see the custom role in the Azure portal

#Delete a custom role
Get-AzRoleDefinition "Reader Support Tickets"

Remove-AzRoleDefinition -Id "4840cc3c-6292-478c-b88b-44b258c69a09" #Replace the ID with the result from line 32
