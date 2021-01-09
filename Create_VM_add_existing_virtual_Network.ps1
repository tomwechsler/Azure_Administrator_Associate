Set-Location c:\
Clear-Host

Install-Module -Name Az -Force -AllowClobber -Verbose

#Log into Azure
Connect-AzAccount

#Select the correct subscription
Get-AzSubscription -SubscriptionName "MSDN Platforms" | Select-AzSubscription
Get-AzContext

#Search for the resource groups
Get-AzResourceGroup | Format-Table

#Whats in a specific resource group
Get-AzResource -ResourceGroupName tw-azuredemo-rg | Format-Table

#Some variables
$RGName = "tw-azuredemo-rg"
$VnetName = "tw-vnet-workload"
$Location = "westeurope"
$VMName = "twsrv2021"
$credential = Get-Credential

#We need all infos about the virtual network
$VirtualNetwork = (Get-AzVirtualNetwork -Name $VnetName -ResourceGroupName $RGName)

#Let's have a look at the variable
$VirtualNetwork

#Create a network interface
$nic = New-AzNetworkInterface `
    -ResourceGroupName $RGName `
    -Name "twsrv2021-nic" `
    -Location $Location `
    -SubnetId $VirtualNetwork.Subnets[0].Id

#Define your VM
$vmConfig = New-AzVMConfig -VMName $VMName -VMSize "Standard_D2s_v4"

#Create the rest of your VM configuration
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig `
    -Windows `
    -ComputerName $VMName `
    -Credential $credential `
    -ProvisionVMAgent `
    -EnableAutoUpdate
$vmConfig = Set-AzVMSourceImage -VM $vmConfig `
    -PublisherName "MicrosoftWindowsServer" `
    -Offer "WindowsServer" `
    -Skus "2016-Datacenter" `
    -Version "latest"

#Attach the network interface that you previously created
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

#Create your VM
New-AzVM -VM $vmConfig -ResourceGroupName $RGName -Location $Location
