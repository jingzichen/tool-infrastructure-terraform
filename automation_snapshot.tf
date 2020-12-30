/**
 * Scheduled snapshot cassandra datadisk service
 * CASES:
 *   1. Create an azure automation account (automation_account.tf)
 *   2. Create an azure automation runbook to snapshot cassandra datadisk (automation_snapshot.tf)
 *   3. Update azure automation module for automation runbook dependency (automation_snapshot.tf)
        - [Note] If you change the runbook content, you need to remove the schedule and recreate it again
                 Ref.: https://github.com/terraform-providers/terraform-provider-azurerm/issues/6466
 *   4. Setup automation schedule (automaito_scheduled.tf)
 */

# CASE 2: Create an azure automation runbook to snapshot cassandra datadisk
module "automation_runbook" {
    source                  = "./modules/automation_runbook"

    automation_account_name = "${local.automation_datadisk_snapshot.automation_runbook_setting.automation_account_name}"
    automation_account_rg   = "${module.resource_group.name}"
    runbook_name            = "${local.automation_datadisk_snapshot.automation_runbook_setting.runbook_name}"
    location                = "${module.resource_group.location}"
    resource_group_name     = "${module.resource_group.name}"
    description             = "${local.automation_datadisk_snapshot.automation_runbook_setting.description}"
    runbook_type            = "${local.automation_datadisk_snapshot.automation_runbook_setting.runbook_type}"
    uri                     = "${local.automation_datadisk_snapshot.automation_runbook_setting.uri}"
    content                 = file("${path.module}/runbooks/cassandra-datadisk-backup.ps1")
    tags                    = "${local.automation_datadisk_snapshot.common_settings.tags}"
}

# CASE 3: Update azure automation module for automation runbook dependency
module "automation_module" {
    source                  = "./modules/automation_module"

    module_names            = "${local.automation_datadisk_snapshot.automation_module_setting.module_name}"
    automation_account_name = "${local.automation_datadisk_snapshot.automation_runbook_setting.automation_account_name}"
    automation_account_rg   = "${module.resource_group.name}"
    uri                     = "${local.automation_datadisk_snapshot.automation_module_setting.uri}"
}
