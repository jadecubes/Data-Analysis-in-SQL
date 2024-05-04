
-- BY GROUP BY
WITH CTE AS (
    SELECT
        player_id,
        MIN(event_date) AS min_event_date,
        device_id
    FROM Activity
    GROUP BY player_id, device_id
)
SELECT CTE.player_id, CTE.device_id
FROM CTE;
