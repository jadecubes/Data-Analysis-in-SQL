-- By PARTITION
WITH CTE AS (
    SELECT
        player_id,
        device_id,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
    FROM Activity
)
SELECT player_id, device_id
FROM CTE
WHERE rn = 1;

