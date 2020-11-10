az login

az account show

az account list --all --output table

az account set --subscription "MSDN Platforms"

#Create a resource group
az group create --name myResourceGroup --location westeurope

#Create virtual networks
az network vnet create --name myVirtualNetwork1 --resource-group myResourceGroup --address-prefixes 10.0.0.0/16 --subnet-name Subnet1 --subnet-prefix 10.0.0.0/24

az network vnet create --name myVirtualNetwork2 --resource-group myResourceGroup --address-prefixes 10.1.0.0/16 --subnet-name Subnet1 --subnet-prefix 10.1.0.0/24

#Peer virtual networks
# Get the id for myVirtualNetwork1. Use with the Cloud Shell
vNet1Id=$(az network vnet show --resource-group myResourceGroup --name myVirtualNetwork1 --query id --out tsv)
# If you use the Azure CLI local the use
$vNet1Id=(az network vnet show --resource-group myResourceGroup --name myVirtualNetwork1 --query id --out tsv)

# Get the id for myVirtualNetwork2. Use with the Cloud Shell
vNet2Id=$(az network vnet show --resource-group myResourceGroup --name myVirtualNetwork2 --query id --out tsv)
# If you use the Azure CLI local the use
$vNet2Id=(az network vnet show --resource-group myResourceGroup --name myVirtualNetwork2 --query id --out tsv)

#Create a peering from myVirtualNetwork1 to myVirtualNetwork2
az network vnet peering create --name myVirtualNetwork1-myVirtualNetwork2 --resource-group myResourceGroup --vnet-name myVirtualNetwork1 --remote-vnet $vNet2Id --allow-vnet-access

#Create a peering from myVirtualNetwork2 to myVirtualNetwork1
az network vnet peering create --name myVirtualNetwork2-myVirtualNetwork1 --resource-group myResourceGroup --vnet-name myVirtualNetwork2 --remote-vnet $vNet1Id --allow-vnet-access

#Confirm that the peering state
az network vnet peering show --name myVirtualNetwork1-myVirtualNetwork2 --resource-group myResourceGroup --vnet-name myVirtualNetwork1 --query peeringState

#Clean Up
az group delete --name myResourceGroup --yes