/**
 * Scheduled snapshot cassandra datadisk service
 * CASES:
 *   1. Create an azure automation account (automation_account.tf)
 *   2. Create an azure automation runbook to snapshot cassandra datadisk (automation_snapshot.tf)
 *   3. Update azure automation module for automation runbook dependency (automation_snapshot.tf)
 *   4. Setup automation schedule (automaito_scheduled.tf)
 */

# CASE 4: Setup automation schedule frequency, times, description etc.
/**
 * Schedule start_time needs at least 5 mins. Anyone want to deploy infrastructure needs to revise the value.
 */
locals {
    automation_datadisk_snapshot_schedule = {
        automation_schedule_setting = {
            automation_account_name = "lafite-automation-robot-1"
            schedule_name = "cassandar-datadisk-backup-schedule"
            frequency     = "Hour"
            interval      = "4"
            timezone      = "Taipei Standard Time"
            description   = "The runbooks is cassandra datadisk backup. This job runs every 4 hours."
            runbook_name  = "cassandra-datadisk-backup"
        }
    }
}
