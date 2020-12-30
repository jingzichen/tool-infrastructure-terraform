output "snapshot_ids" {
    description = "The id of Snapshot resources created"
    value       = ["${azurerm_snapshot.snapshots.*.id}"]
}