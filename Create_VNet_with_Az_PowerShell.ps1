az login

az account show

az account list --all --output table

az account set --subscription "Visual Studio Enterprise-Abonnement"

#Create a resource group
az group create --name myResourceGroup --location westeurope

#Create virtual networks
az network vnet create --name myVirtualNetwork1 --resource-group myResourceGroup --address-prefixes 10.0.0.0/16 --subnet-name Subnet1 --subnet-prefix 10.0.0.0/24


#The PowerShell way
Set-Location c:\
Clear-Host

Install-Module -Name Az -Force -AllowClobber -Verbose

#Log into Azure
Connect-AzAccount

#Select the correct subscription
Get-AzSubscription -SubscriptionName "MSDN Platforms" | Select-AzSubscription
Get-AzContext

#Create a resource group
New-AzResourceGroup -ResourceGroupName myResourceGroup2020 -Location WestEurope

#Create a virtual network 
$virtualNetwork1 = New-AzVirtualNetwork `
  -ResourceGroupName myResourceGroup2020 `
  -Location WestEurope `
  -Name myVirtualNetwork1 `
  -AddressPrefix 10.1.0.0/16

#Create a subnet configuration
$subnetConfig = Add-AzVirtualNetworkSubnetConfig `
  -Name Subnet1 `
  -AddressPrefix 10.1.0.0/24 `
  -VirtualNetwork $virtualNetwork1

#Write the subnet configuration to the virtual network
$virtualNetwork1 | Set-AzVirtualNetwork