SELECT 
    age_group,
    AVG(app_usage_minutes_per_day) AS mean_usage,
    AVG(screen_time_hours_per_day) AS mean_screen_time,
    SUM(app_usage_minutes_per_day) AS sum_usage,
    SUM(screen_time_hours_per_day) AS sum_screen_time,
    COUNT(*) AS number_of_users
FROM {{ ref("mst_mobile_device_usage") }}
GROUP BY age_group