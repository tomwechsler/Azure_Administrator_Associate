Set-Location C:\
Clear-Host

#We need the module
Install-Module -Name Az -Force -AllowClobber -Verbose

#Log into Azure
Connect-AzAccount

#Select the correct subscription
Get-AzSubscription -SubscriptionName "MSDN Platforms" | Select-AzSubscription

$RGName = "resourcegroupname"

#To lock a resource, provide the name of the resource, its resource type, and its resource group name
New-AzResourceLock -LockLevel CanNotDelete -LockName LockSite -ResourceName examplesite -ResourceType Microsoft.Web/sites -ResourceGroupName $RGName

#To lock a resource group, provide the name of the resource group
New-AzResourceLock -LockName LockGroup -LockLevel CanNotDelete -ResourceGroupName $RGName

#To get information about a lock
Get-AzResourceLock

#To get all locks for a resource
Get-AzResourceLock -ResourceName examplesite -ResourceType Microsoft.Web/sites -ResourceGroupName $RGName

#To get all locks for a resource group
Get-AzResourceLock -ResourceGroupName $RGName

#To delete a lock for a resource
$lockId = (Get-AzResourceLock -ResourceGroupName $RGName -ResourceName examplesite -ResourceType Microsoft.Web/sites).LockId
Remove-AzResourceLock -LockId $lockId

#To delete a lock for a resource group
$lockId = (Get-AzResourceLock -ResourceGroupName $RGName).LockId
Remove-AzResourceLock -LockId $lockId
