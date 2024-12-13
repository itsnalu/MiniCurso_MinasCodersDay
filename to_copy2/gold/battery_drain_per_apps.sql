SELECT 
    number_of_apps,
    AVG(battery_drain) AS mean_battery_drain
FROM {{ ref("mst_mobile_device_usage") }}
GROUP BY 1
ORDER BY 2 DESC