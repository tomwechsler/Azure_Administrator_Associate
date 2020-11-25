Set-Location c:\
Clear-Host

Install-Module -Name Az -Force -AllowClobber -Verbose

#Some variables
$location = "westeurope"

#Log into Azure
Connect-AzAccount

#Select the correct subscription
Get-AzSubscription -SubscriptionName "Visual Studio Enterprise-Abonnement" | Select-AzSubscription
Get-AzContext

#List existing network security groups
Get-AzNetworkSecurityGroup
(Get-AzNetworkSecurityGroup).Name

#Search for ResourceGroups
(Get-AzResourceGroup).ResourceGroupName

#Create a detailed network security group
$rule1 = New-AzNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 300 -SourceAddressPrefix `
    Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

$rule2 = New-AzNetworkSecurityRuleConfig -Name web-rule -Description "Allow HTTP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 400 -SourceAddressPrefix `
    Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80, 443

$nsg = New-AzNetworkSecurityGroup -ResourceGroupName tw-azuredemo-rg -Location $location -Name `
    "NSG-FrontEnd" -SecurityRules $rule1,$rule2

#List all Vnets in the Subscription
(Get-AzVirtualNetwork).Name

#Let's create a variable
$VNet = Get-AzVirtualNetwork -Name 'tw-vnet-workload'

#We need the name of the subnet
Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNet | Select-Object Name,AddressPrefix

#We save the information in a variable
$VNetSubnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNet -Name workload

#We associate the nsg to the subnet
Set-AzVirtualNetworkSubnetConfig -Name $VNetSubnet.Name -VirtualNetwork $VNet -AddressPrefix $VNetSubnet.AddressPrefix -NetworkSecurityGroup $nsg

#Updates our virtual network 
$VNet | Set-AzVirtualNetwork

#Let's check the configuration
(Get-AzVirtualNetwork -Name 'tw-vnet-workload').Subnets
