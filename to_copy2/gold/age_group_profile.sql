SELECT 
    age_group,
    user_classification,
    AVG(number_of_apps) AS mean_number_of_apps,
    AVG(app_usage_minutes_per_day) AS mean_usage,
    AVG(screen_time_hours_per_day) AS mean_screen_time,
    COUNT(*) AS user_count
FROM {{ ref("mst_mobile_device_usage") }}
GROUP BY age_group, user_classification
ORDER BY 3 DESC