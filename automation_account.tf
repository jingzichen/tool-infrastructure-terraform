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

# CASE 1: Create an azure automation account
module "automation_account" {
    source                   = "./modules/automation_account"

    automation_account_count = "${local.automation_account.automation_account_setting.automation_account_count}"
    automation_account_name  = "${local.automation_account.automation_account_setting.automation_account_name}"
    location                 = "${module.resource_group.location}"
    resource_group_name      = "${module.resource_group.name}"
    tags                     = "${local.automation_account.common_settings.tags}"
}
