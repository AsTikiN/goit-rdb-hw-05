# goit-rdb-hw-05

П'ять запитів у `queries.sql`. База — та сама, що в темі 3 (`goit_rdb_hw_03`).

Функцію створюють у клієнті, який розуміє `DELIMITER` (mysql CLI або Workbench). Застосування — `SELECT divide_float(quantity, 2)`, без `UPDATE`: інакше кількості в таблиці будуть перезаписані.

Пункт 2 навмисно без `JOIN`. Умова просить вкладений запит в `WHERE`.
