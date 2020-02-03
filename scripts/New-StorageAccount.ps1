# $stagingResourceGroupName = 'visma-demo-app-stg'
# $stagingStorageAccountName = 'vismademoappstgjb'
$existingStorageAccount = Get-AzStorageAccount -ResourceGroupName $stagingResourceGroupName -Name $stagingStorageAccountName

if (!($existingStorageAccount)) {
    New-AzResourceGroup -Name $stagingResourceGroupName -Location 'West Europe'
    New-AzStorageAccount -ResourceGroupName $stagingResourceGroupName -Name $stagingStorageAccountName -SkuName Standard_LRS -Location 'West Europe' -Kind StorageV2
    New-AzRmStorageContainer -ResourceGroupName $stagingResourceGroupName -StorageAccountName $stagingStorageAccountName -Name 'staging'
}
