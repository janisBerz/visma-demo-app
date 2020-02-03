# $stagingResourceGroupName = 'visma-demo-app-stg'
# $stagingStorageAccountName = 'vismademoappstgjb'

if (!(Get-AzStorageAccount -ResourceGroupName $stagingResourceGroupName -Name $stagingStorageAccountName)) {
    New-AzResourceGroup -Name $stagingResourceGroupName -Location 'West Europe'
    New-AzStorageAccount -ResourceGroupName $stagingResourceGroupName -Name $stagingStorageAccountName -SkuName Standard_LRS -Location 'West Europe' -Kind StorageV2
    New-AzRmStorageContainer -ResourceGroupName $stagingResourceGroupName -StorageAccountName $stagingStorageAccountName -Name 'staging'
}



