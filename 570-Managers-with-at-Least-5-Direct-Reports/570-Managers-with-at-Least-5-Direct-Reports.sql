WITH Managers AS (
    SELECT
        managerId
    FROM
        Employee
    WHERE
        managerId IS NOT NULL
    GROUP BY
        managerId
    HAVING
        COUNT(*) >= 5
)

SELECT
    E.name
FROM
    Employee AS E
JOIN
    Managers ON E.id = Managers.managerId;
