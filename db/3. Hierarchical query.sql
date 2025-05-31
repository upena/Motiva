DECLARE @employee_id INT = 10;

--Utlizando una Common Table Expression recursiva para referenciarse a si misma y ejecutar la consulta hasta que se cumpla una condicion
WITH hierarchy_up AS (
    SELECT 
        employee_id,
        first_name,
        manager_id,
        0 AS level
    FROM employees
    WHERE employee_id = @employee_id 

    UNION ALL

    SELECT 
        e.employee_id,
        e.first_name,
        e.manager_id,
        h.level + 1
    FROM employees e
    INNER JOIN hierarchy_up h ON e.employee_id = h.manager_id
)

SELECT 
    employee_id,
    first_name,
    manager_id
FROM hierarchy_up
ORDER BY level;