WITH FirstLogins AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),
SecondDayLogins AS (
    SELECT
        f.player_id
    FROM FirstLogins f
    JOIN Activity a ON f.player_id = a.player_id
        AND  a.event_date = DATE_ADD(f.first_login)
    GROUP BY f.player_id
)
SELECT
    ROUND(COUNT(DISTINCT s.player_id) / CAST(COUNT(DISTINCT f.player_id) AS FLOAT), 2) AS fraction
FROM FirstLogins f
LEFT JOIN SecondDayLogins s ON f.player_id = s.player_id;
