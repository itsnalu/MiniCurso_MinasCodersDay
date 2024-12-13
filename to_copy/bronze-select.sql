SELECT 
	$1 AS "User ID",
	$2 AS "Device Model",
	$3 AS "Operating System",
	$4 AS "App Usage Time (min/day)",
	$5 AS "Screen On Time (hours/day)",
	$6 AS "Battery Drain (mAh/day)",
	$7 AS "Number of Apps Installed",
	$8 AS "Data Usage (MB/day)",
	$9 AS "Age",
	$10 AS "Gender",
	$11 AS "User Behavior Class"
FROM FILES
(
    "aws.s3.endpoint" = "http://minio-nginx-1:9000",
    "path" = "s3://bronze/mobile_device_usage/user_behavior_dataset.csv",
    "aws.s3.enable_ssl" = "false",
    "aws.s3.access_key" = "bQdKTzRmSipjRwsStM6l",
    "aws.s3.secret_key" = "OpBXpmKcmpscsqBEJa4CtewaiVsA077pIgwCpael",
    "format" = "csv",
    "csv.column_separator"=",",
    "csv.skip_header"="1",
    "aws.s3.use_aws_sdk_default_behavior" = "false",
    "aws.s3.use_instance_profile" = "false",
    "aws.s3.enable_path_style_access" = "true"
)