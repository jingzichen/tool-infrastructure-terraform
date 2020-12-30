output "schedule_id" {
    value   = "${azurerm_automation_schedule.schedule.*.id}"
}

output "job_schedule_id" {
    value   = "${azurerm_automation_job_schedule.job_schedule.*.id}"
}