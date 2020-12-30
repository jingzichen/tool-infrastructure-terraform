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

# CASE 4: Setup automation schedule
module "automation_job_schedule" {
    source                  = "./modules/automation_schedule"

    automation_account_name = "${local.automation_datadisk_snapshot_schedule.automation_schedule_setting.automation_account_name}"
    automation_account_rg   = "${module.resource_group.name}"
    schedule_name           = "${local.automation_datadisk_snapshot_schedule.automation_schedule_setting.schedule_name}"
    frequency               = "${local.automation_datadisk_snapshot_schedule.automation_schedule_setting.frequency}"
    interval                = "${local.automation_datadisk_snapshot_schedule.automation_schedule_setting.interval}"
    timezone                = "${local.automation_datadisk_snapshot_schedule.automation_schedule_setting.timezone}"
    description             = "${local.automation_datadisk_snapshot_schedule.automation_schedule_setting.description}"
    runbook_name            = "${local.automation_datadisk_snapshot_schedule.automation_schedule_setting.runbook_name}"
}
