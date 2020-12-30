locals {
    # For main cluster
    common_tags = "${map(
        "type", "ashely",
        "environment", "production"
    )}"

    # For other standalone infrastructure
    common_standalone_tags = "${map(
        "type", "ashely",
        "environment", "production"
    )}"
}
