<#
 * Snapshot cassandra datadisk
 * STEPS:
 *   1. Get the connection "AzureRunAsConnection"
 *   2. List current disk snapshot name
 *   3. Create new cassandra datadisk snpahots
 *   4. Check new cassandra datadisk snpahots status is successeded 
 *   5. Delete old cassandra datadisk snapshot
#>

# STEP 1: Get the connection "AzureRunAsConnection"
$connectionName = "AzureRunAsConnection"
try
{
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         

    "Logging in to Azure..."
    Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

# STEP 2: List current disk snapshot name
$DeletesnapshotNames=Get-AzureRmSnapshot | Select Name,ResourceGroupName,Tags
Write-Output "This is old snapshots list." + $DeletesnapshotNames

# STEP 3: Create new cassandra datadisk snpahots
$disks=Get-AzureRmDisk | Select Name,Tags,Id,Location,ResourceGroupName ; 
$snapshot_tag="cassandra-datadisk"
foreach($disk in $disks) 
{ 
    foreach($tag in $disk.Tags) 
    { 
        $disk_tag="cassandra-data-backup"
        if($tag.$disk_tag -eq 'true') {
            $snapshotconfig = New-AzureRmSnapshotConfig -SourceUri $disk.Id -CreateOption Copy -Location $disk.Location -Tag @{environment="production";role="lafite-automation-robot";type="standalone";$snapshot_tag="snapshot"};
            $SnapshotName=$disk.Name+"-snapshot-"+((Get-Date).AddHours(8).ToString("yyyy-MM-dd-HH-mm"));
            New-AzureRmSnapshot -Snapshot $snapshotconfig -SnapshotName $SnapshotName -ResourceGroupName $disk.ResourceGroupName 
            # STEP 4: Check new cassandra datadisk snpahots status is successeded          
            $Checksnapshotstatus=Get-AzureRmSnapshot | Select Name, ProvisioningState| Out-String -stream |  Select-String -Pattern $SnapshotName | Select-String -Pattern "Succeeded"
            Write-Output  $Checksnapshotstatus
            if($Checksnapshotstatus -eq $null) {
                Write-Output "Error! $SnapshotName not found."
                exit
            }
        }
    }
}

# STEP 5: Delete old cassandra datadisk snapshot
foreach($DeletesnapshotName in $DeletesnapshotNames) {
    foreach($deletetag in $DeletesnapshotName.Tags) {
        if($deletetag.$snapshot_tag -eq 'snapshot') {
            Write-Output ($DeletesnapshotName.Name + " will be removed." ) 
            Remove-AzureRmSnapshot -ResourceGroupName $DeletesnapshotName.ResourceGroupName -SnapshotName $DeletesnapshotName.Name -Force;
        }
    }
}