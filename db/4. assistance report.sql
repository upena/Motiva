


--Primer PIVOT: contar ausencias por tipo
WITH CountPivot AS (
    SELECT *
    FROM (
        SELECT employee_id, absence_type_id
        FROM assistance
    ) AS SourceTable
    PIVOT (
        COUNT(absence_type_id)
        FOR absence_type_id IN ([2], [3], [8])
    ) AS PivotTable
), 

-- Segundo PIVOT: sumar horas por tipo
SumPivot AS (
    SELECT *
    FROM (
        SELECT employee_id, absence_type_id, num_of_hours
        FROM assistance
    ) AS SourceTable
    PIVOT (
        SUM(num_of_hours)
        FOR absence_type_id IN ([2], [3], [8])
    ) AS PivotTable
)

-- Unir ambos pivots
SELECT 
    c.employee_id,
    c.[2] AS num_of_absence_type_2,
    s.[2] AS num_of_hours_type_2,
    c.[3] AS num_of_absence_type_3,
    s.[3] AS num_of_hours_type_3,
    c.[8] AS num_of_absence_type_8,
    s.[8] AS num_of_hours_type_8
FROM CountPivot c
JOIN SumPivot s ON c.employee_id = s.employee_id
ORDER BY c.employee_id;