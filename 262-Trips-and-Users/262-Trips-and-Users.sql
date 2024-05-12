WITH unbanned_client AS (
  SELECT users_id
  FROM Users
  WHERE role = 'client' AND banned = 'No'
),
unbanned_driver AS (
  SELECT users_id
  FROM Users
  WHERE role = 'driver' AND banned = 'No'
),
canceled_trips AS (
  SELECT
    t.id,
    t.client_id,
    t.driver_id,
    t.request_at
  FROM
    Trips t
  JOIN
    unbanned_client uc ON t.client_id = uc.users_id
  JOIN
    unbanned_driver ud ON t.driver_id = ud.users_id
  WHERE
    t.status IN ('cancelled_by_driver', 'cancelled_by_client') AND
    t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
),
total_requests AS (
  SELECT
    request_at,
    COUNT(*) AS total_requests
  FROM Trips t
  JOIN unbanned_client uc ON t.client_id = uc.users_id
  JOIN unbanned_driver ud ON t.driver_id = ud.users_id
  WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
  GROUP BY request_at
)

SELECT
  tr.request_at,
  ROUND((COUNT(ct.id) * 100.0) / tr.total_requests, 2) AS cancellation_rate
FROM
  total_requests tr
LEFT JOIN
  canceled_trips ct ON tr.request_at = ct.request_at
GROUP BY
  tr.request_at, tr.total_requests
ORDER BY
  tr.request_at;