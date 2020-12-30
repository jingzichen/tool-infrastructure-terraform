/**
 * Scheduled snapshot cassandra datadisk service
 * CASES:
 *   1. Create an azure automation account (automation_account.tf)
 *   2. Create an azure automation runbook to snapshot cassandra datadisk (automation_snapshot.tf)
 *   3. Update azure automation module for automation runbook dependency (automation_snapshot.tf)
 *   4. Setup automation schedule (automaito_scheduled.tf)
 */

# CASE 1: Create an azure automation account
locals {
    automation_account = {
        common_settings = {
            tags = "${
                merge(
                    local.common_standalone_tags,
                    map("role", "automation-robot")
                )
            }"
        }

        automation_account_setting = {
            automation_account_count = "1"
            automation_account_name = "automation-robot"
        }
    }
}
