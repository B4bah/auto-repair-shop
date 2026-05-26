-- ---------- QUERIES ----------
SELECT r.id, c.id AS client_id, r.status, r.request_date
FROM request r
JOIN client c ON r.client_id = c.id
WHERE (r.status = 'pending' OR r.status = 'in_progress')
  AND r.request_date >= CURRENT_DATE - INTERVAL '30 days';


SELECT VIN, license_plate
FROM vehicle
WHERE VIN LIKE 'WBA%' OR VIN LIKE 'WAU%';


SELECT id, request_date, status
FROM request
WHERE request_date BETWEEN '2024-01-01' AND '2024-12-31';


SELECT id, branch_id, salary
FROM employee
WHERE branch_id IN (1, 2, 3);


SELECT r.branch_id, SUM(i.total_amount) AS total_revenue
FROM request r
JOIN invoice i ON r.id = i.request_id
GROUP BY r.branch_id
ORDER BY total_revenue DESC;


SELECT work_order_id, AVG(price) AS avg_service_price
FROM service
GROUP BY work_order_id;


SELECT e.mechanic_id, COUNT(*) AS total_jobs
FROM execution e
GROUP BY e.mechanic_id
ORDER BY total_jobs DESC;


SELECT c.id
FROM client c
JOIN request r ON c.id = r.client_id
JOIN invoice i ON r.id = i.request_id
GROUP BY c.id
HAVING SUM(i.total_amount) >
       (SELECT AVG(total_amount) FROM invoice);


SELECT s.id, s.name
FROM service s
WHERE s.id IN (
    SELECT du.service_id
    FROM detail_usage du
    JOIN detail_supplier ds ON du.inventory_id = ds.detail_id
    WHERE ds.unit_price > 500);


SELECT branch_id, SUM(quantity) AS total_stock
FROM inventory
GROUP BY branch_id
HAVING SUM(quantity) < 50;