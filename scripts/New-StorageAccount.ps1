
[CmdletBinding()]
Param (
    [string]$stagingResourceGroupName,
    [string]$stagingStorageAccountName
    )
$existingStorageAccount = Get-AzStorageAccount -ResourceGroupName $stagingResourceGroupName -Name $stagingStorageAccountName -verbose -ErrorAction SilentlyContinue
Write-Host "Storage account name $existingStorageAccount"

if ($null -eq $existingStorageAccount) {
    New-AzResourceGroup -Name $stagingResourceGroupName -Location 'West Europe' -verbose
    New-AzStorageAccount -ResourceGroupName $stagingResourceGroupName -Name $stagingStorageAccountName -SkuName Standard_LRS -Location 'West Europe' -Kind StorageV2 -verbose
    New-AzRmStorageContainer -ResourceGroupName $stagingResourceGroupName -StorageAccountName $stagingStorageAccountName -Name 'staging' -verbose
}
