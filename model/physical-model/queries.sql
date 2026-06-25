-- ============================================================
--  AUTO REPAIR SHOP — 10 ЗАПРОСОВ
--  Database: PostgreSQL
-- ============================================================

SET search_path TO public;


-- ============================================================
--  ЗАПРОС 1: AND
--  Завершённые заявки с выставленным счётом суммой выше 3000 руб.
--  Показывает клиента, автомобиль, дату и итоговую сумму
-- ============================================================

SELECT
    r.id                                        AS request_id,
    p.last_name || ' ' || p.first_name          AS client,
    mc.name || ' ' || vm.name                  AS vehicle,
    r.request_date,
    i.total_amount                              AS invoice_amount
FROM request r
JOIN client c             ON c.id         = r.client_id
JOIN person p             ON p.id         = c.person_id
JOIN vehicle v            ON v.VIN        = r.VIN
JOIN vehicle_model vm     ON vm.id        = v.model_id
JOIN machinery_company mc ON mc.id        = vm.company_id
JOIN invoice i            ON i.request_id = r.id
WHERE r.status = 'completed'
  AND i.total_amount > 3000
ORDER BY i.total_amount DESC;


-- -- ============================================================
-- --  ЗАПРОС 2: OR
-- --  Все автомобили марки Toyota или Tesla с владельцами
-- --  Показывает у кого какой электромобиль или японская машина
-- -- ============================================================

-- SELECT
--     v.VIN,
--     v.year,
--     v.license_plate,
--     mc.name                                     AS manufacturer,
--     vm.name                                     AS model,
--     p.last_name || ' ' || p.first_name          AS owner
-- FROM vehicle v
-- JOIN vehicle_model vm     ON vm.id  = v.model_id
-- JOIN machinery_company mc ON mc.id  = vm.company_id
-- JOIN person p             ON p.id   = v.owner_id
-- WHERE mc.name = 'Toyota'
--    OR mc.name = 'Tesla'
-- ORDER BY mc.name, vm.name;


-- -- ============================================================
-- --  ЗАПРОС 3: BETWEEN
-- --  Сотрудники принятые на работу в период 2020–2022
-- --  Показывает стаж и зарплату каждого
-- -- ============================================================

-- SELECT
--     p.last_name || ' ' || p.first_name          AS employee,
--     e.date_of_employment,
--     e.salary,
--     (CURRENT_DATE - e.date_of_employment) / 365 AS years_of_service,
--     b.city || ', ' || b.street                  AS branch
-- FROM employee e
-- JOIN person p                  ON p.id  = e.person_id
-- JOIN auto_repair_shop_branch b ON b.id  = e.branch_id
-- WHERE e.date_of_employment BETWEEN '2020-01-01' AND '2022-12-31'
-- ORDER BY e.date_of_employment;


-- -- ============================================================
-- --  ЗАПРОС 4: LIKE
-- --  Клиенты с фамилией на 'К' и история их обращений
-- --  Показывает сколько раз приезжал и когда был последний раз
-- -- ============================================================

-- SELECT
--     p.last_name,
--     p.first_name,
--     p.middle_name,
--     COUNT(r.id)             AS total_requests,
--     MAX(r.request_date)     AS last_visit
-- FROM client c
-- JOIN person p       ON p.id       = c.person_id
-- LEFT JOIN request r ON r.client_id = c.id
-- WHERE p.last_name LIKE 'К%'
-- GROUP BY p.last_name, p.first_name, p.middle_name
-- ORDER BY p.last_name, p.first_name;


-- -- ============================================================
-- --  ЗАПРОС 5: IN
-- --  Услуги выполненные на автомобилях немецких производителей
-- --  Полезно для анализа: с какими марками больше работы
-- -- ============================================================

-- SELECT
--     mc.name                                     AS manufacturer,
--     vm.name                                     AS model,
--     v.year,
--     s.name                                      AS service,
--     s.price,
--     p.last_name || ' ' || p.first_name          AS mechanic
-- FROM service s
-- JOIN work_order wo        ON wo.id   = s.work_order_id
-- JOIN request r            ON r.id    = wo.request_id
-- JOIN vehicle v            ON v.VIN   = r.VIN
-- JOIN vehicle_model vm     ON vm.id   = v.model_id
-- JOIN machinery_company mc ON mc.id   = vm.company_id
-- JOIN execution e          ON e.service_id  = s.id
-- JOIN mechanic m           ON m.id          = e.mechanic_id
-- JOIN employee emp         ON emp.id        = m.id
-- JOIN person p             ON p.id          = emp.person_id
-- WHERE mc.name IN ('BMW', 'Mercedes-Benz')
-- ORDER BY mc.name, s.price DESC;


-- -- ============================================================
-- --  ЗАПРОС 6: GROUP BY + COUNT + агрегатные функции
-- --  Рейтинг механиков по количеству выполненных услуг
-- --  Показывает загрузку каждого механика
-- -- ============================================================

-- SELECT
--     p.last_name || ' ' || p.first_name          AS mechanic,
--     m.specialty,
--     m.rank,
--     COUNT(e.service_id)                         AS services_count,
--     MIN(e.date_start)                           AS first_job,
--     MAX(e.date_start)                           AS last_job
-- FROM mechanic m
-- JOIN employee emp  ON emp.id        = m.id
-- JOIN person p      ON p.id          = emp.person_id
-- JOIN execution e   ON e.mechanic_id = m.id
-- GROUP BY p.last_name, p.first_name, m.specialty, m.rank
-- ORDER BY services_count DESC;


-- -- ============================================================
-- --  ЗАПРОС 7: GROUP BY + SUM + несколько таблиц
-- --  Выручка и количество завершённых заявок по каждому филиалу
-- --  Показывает насколько прибыльный каждый филиал
-- -- ============================================================

-- SELECT
--     ars.name                                    AS shop,
--     b.city,
--     b.street || ' ' || b.building              AS address,
--     COUNT(DISTINCT r.id)                        AS completed_requests,
--     COALESCE(SUM(i.total_amount), 0)            AS total_revenue,
--     bb.balance                                  AS current_budget
-- FROM auto_repair_shop_branch b
-- JOIN auto_repair_shop ars   ON ars.id      = b.shop_id
-- LEFT JOIN request r         ON r.branch_id = b.id AND r.status = 'completed'
-- LEFT JOIN invoice i         ON i.request_id = r.id
-- LEFT JOIN branch_budget bb  ON bb.branch_id = b.id
-- GROUP BY ars.name, b.city, b.street, b.building, bb.balance
-- ORDER BY total_revenue DESC NULLS LAST;


-- -- ============================================================
-- --  ЗАПРОС 8: GROUP BY + AVG + HAVING
-- --  Виды услуг со средней стоимостью выше 2000 руб.
-- --  Показывает какие работы дороже всего обходятся клиентам
-- -- ============================================================

-- SELECT
--     s.name                                      AS service_type,
--     COUNT(*)                                    AS times_performed,
--     ROUND(AVG(s.price), 2)                      AS avg_price,
--     MIN(s.price)                                AS min_price,
--     MAX(s.price)                                AS max_price
-- FROM service s
-- GROUP BY s.name
-- HAVING AVG(s.price) > 2000
-- ORDER BY avg_price DESC;


-- -- ============================================================
-- --  ЗАПРОС 9: Подзапрос (NOT IN)
-- --  Детали которые есть на складе но ни разу не использовались
-- --  Показывает неликвид — детали которые зря занимают место
-- -- ============================================================

-- SELECT
--     d.part_number,
--     d.name                                      AS detail_name,
--     d.description,
--     SUM(i.quantity)                             AS total_in_stock
-- FROM detail d
-- JOIN inventory i ON i.detail_id = d.id
-- WHERE d.id NOT IN (
--     SELECT DISTINCT inv.detail_id
--     FROM detail_usage du
--     JOIN inventory inv ON inv.id = du.inventory_id
-- )
-- GROUP BY d.part_number, d.name, d.description
-- ORDER BY total_in_stock DESC;


-- ============================================================
--  ЗАПРОС 10: Вложенный подзапрос
--  Клиенты чья общая сумма счетов выше средней по всем клиентам
--  Показывает самых ценных клиентов мастерской
-- ============================================================

-- SELECT
--     p.last_name || ' ' || p.first_name          AS client,
--     COUNT(i.id)                                 AS invoices_count,
--     SUM(i.total_amount)                         AS total_spent
-- FROM client c
-- JOIN person p   ON p.id         = c.person_id
-- JOIN request r  ON r.client_id  = c.id
-- JOIN invoice i  ON i.request_id = r.id
-- GROUP BY p.last_name, p.first_name
-- HAVING SUM(i.total_amount) > (
--     SELECT AVG(client_total)
--     FROM (
--         SELECT SUM(i2.total_amount) AS client_total
--         FROM client c2
--         JOIN request r2 ON r2.client_id  = c2.id
--         JOIN invoice i2 ON i2.request_id = r2.id
--         GROUP BY c2.id
--     ) sub
-- )
-- ORDER BY total_spent DESC;