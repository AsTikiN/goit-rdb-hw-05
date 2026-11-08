-- ДЗ5. Підзапити, CTE temp і функція ділення.
-- База теми 3. Запити не змінюють order_details.

USE goit_rdb_hw_03;

-- 1. order_details і customer_id із orders. Підзапит у SELECT.
SELECT
  order_details.*,
  (
    SELECT orders.customer_id
    FROM orders
    WHERE orders.id = order_details.order_id
  ) AS customer_id
FROM order_details;

-- 2. Ті самі позиції, але лише якщо в замовлення shipper_id = 3.
-- Підзапит у WHERE.
SELECT *
FROM order_details
WHERE order_id IN (
  SELECT id
  FROM orders
  WHERE shipper_id = 3
);

-- 3. Підзапит у FROM: quantity > 10, середнє quantity за order_id.
SELECT
  filtered.order_id,
  AVG(filtered.quantity) AS avg_quantity
FROM (
  SELECT order_id, quantity
  FROM order_details
  WHERE quantity > 10
) AS filtered
GROUP BY filtered.order_id;

-- 4. Те саме через WITH. Ім'я тимчасового набору — temp, як у умові.
WITH temp AS (
  SELECT order_id, quantity
  FROM order_details
  WHERE quantity > 10
)
SELECT
  temp.order_id,
  AVG(temp.quantity) AS avg_quantity
FROM temp
GROUP BY temp.order_id;

-- 5. Ділення двох FLOAT. Нуль і NULL не кидають помилку, повертають NULL.
DROP FUNCTION IF EXISTS divide_float;

DELIMITER //

CREATE FUNCTION divide_float(dividend FLOAT, divisor FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
  IF dividend IS NULL OR divisor IS NULL OR divisor = 0 THEN
    RETURN NULL;
  END IF;
  RETURN dividend / divisor;
END //

DELIMITER ;

-- Застосування до quantity. Другий аргумент — довільний дільник 2.
-- Дані таблиці не оновлюються.
SELECT
  id,
  order_id,
  product_id,
  quantity,
  divide_float(quantity, 2) AS quantity_divided
FROM order_details;
