/**
 * Scheduled snapshot cassandra datadisk service
 * CASES:
 *   1. Create an azure automation account (automation_account.tf)
 *   2. Create an azure automation runbook to snapshot cassandra datadisk (automation_snapshot.tf)
 *   3. Update azure automation module for automation runbook dependency (automation_snapshot.tf)
 *   4. Setup automation schedule (automaito_scheduled.tf)
 *
 * STEPS:
 *   1. Azure automation runbook settings (snapshot cassandra datadisk)
 *   2. Azure automation module settings
 */

locals {
    automation_datadisk_snapshot = {
        common_settings = {
            tags = "${
                merge(
                    local.common_standalone_tags,
                    map("role", "automation-robot")
                )
            }"
        }
        # STEP 1. Azure automation runbook settings (snapshot cassandra datadisk)
        automation_runbook_setting = {
            automation_account_name = "lafite-automation-robot-1"
            runbook_name = "cassandra-datadisk-backup"
            description   = "The runbook will create cassandra datadisk snapshots and delete old cassandra snapshots."
            runbook_type  = "PowerShell"
            uri       = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/c4935ffb69246a6058eb24f54640f53f69d3ac9f/101-automation-runbook-getvms/Runbooks/Get-AzureVMTutorial.ps1"
        }
        # STEP 2. Azure automation module settings
        /**
         *  Automation modules have dependencies, it needs to add step by step.
         *  The terraform modules doesn't have dependencies. We can apply the terraform.tf twice.
         */
        automation_module_setting = {
            automation_account_name = "lafite-automation-robot-1"
            module_name = ["AzureRM.Profile", "AzureRM.Automation","AzureRM.Compute","AzureRM.Resources","AzureRM.Sql"]
            uri         = [
                "https://devopsgallerystorage.blob.core.windows.net/packages/azurerm.profile.5.8.3.nupkg",
                "https://devopsgallerystorage.blob.core.windows.net/packages/azurerm.automation.6.1.1.nupkg",
                "https://devopsgallerystorage.blob.core.windows.net/packages/azurerm.compute.5.9.1.nupkg",
                "https://devopsgallerystorage.blob.core.windows.net/packages/azurerm.resources.6.7.3.nupkg",
                "https://devopsgallerystorage.blob.core.windows.net/packages/azurerm.sql.4.12.1.nupkg"
            ]
        }
    }
}
