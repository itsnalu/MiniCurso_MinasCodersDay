SELECT 
    `User ID` AS user_id,
	UPPER(TRIM(`Device Model`)) AS device_model,
	UPPER(TRIM(`Operating System`)) AS operating_system,
	`App Usage Time (min/day)` AS app_usage_minutes_per_day,
	`Screen On Time (hours/day)` AS screen_time_hours_per_day,
	`Battery Drain (mAh/day)` AS battery_drain,
	`Number of Apps Installed` AS number_of_apps,
	`Data Usage (MB/day)` AS data_usage_mb_per_day,
	`Age` AS age,
	LOWER(TRIM(`Gender`)) AS gender,
    CASE 
        WHEN `Age` BETWEEN 0 AND 17 THEN "under-age"
        WHEN `Age` BETWEEN 18 AND 35 THEN "early-adult"
        WHEN `Age` BETWEEN 36 AND 50 THEN "mid-adult"
        WHEN `Age` BETWEEN 51 AND 60 THEN "late-adult"
        WHEN `Age` BETWEEN 61 AND 120 THEN "aged"
        ELSE NULL
    END AS age_group,
    CASE 
        WHEN `User Behavior Class` = 5 THEN "higher-usage"
        WHEN `User Behavior Class` = 4 THEN "high-usage"
        WHEN `User Behavior Class` = 3 THEN "middle-usage"
        WHEN `User Behavior Class` = 2 THEN "low-usage"
        WHEN `User Behavior Class` = 1 THEN "lower-usage"
	 END AS user_classification
FROM {{ ref("mobile_device_usage") }}