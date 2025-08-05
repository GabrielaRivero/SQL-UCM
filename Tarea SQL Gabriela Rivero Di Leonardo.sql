## Ejercicio 2
#Pregunta 1
SELECT `country` AS 'País',`status` AS Estado, COUNT(`order_id`) AS Total_operaciones, ROUND(AVG(`amount`),2) AS Importe_promedio
FROM `orders`
WHERE `created_at` > 01-07-2015
	AND `country` IN ('Francia', 'Portugal','España')
	AND `amount` > 100
	AND `amount` < 1500
GROUP BY `country`,`status`
ORDER BY Importe_promedio DESC;

#Pregunta 2
SELECT `country` AS 'País', COUNT(`order_id`) AS Total_operaciones, MAX(`amount`) AS Valor_max, MIN(`amount`) AS Valor_min
FROM `orders`
WHERE NOT `status` IN ("Delinquent","Cancelled")
	  AND `amount` > 100
GROUP BY `country`
ORDER BY Total_operaciones DESC
LIMIT 3;

## Ejercicio 3
# Pregunta 1
SELECT 
m.`merchant_id` AS ID, 
`name` AS Nombre,
`country` AS 'País',
 COUNT(o.`order_id`) AS Total_operaciones, 
 ROUND(AVG(o.`amount`),2) AS Importe_promedio, 
 COUNT(`refunded_at`) AS Total_devoluciones,
CASE
	WHEN  COUNT(`refunded_at`) > 0 THEN "SÍ"
    ELSE "NO"
END AS Acepta_devoluciones
FROM 
	`merchants` AS m 
	INNER JOIN `orders` AS o ON m.merchant_id = o.merchant_id
	LEFT JOIN `refunds` AS r ON o.order_id = r.order_id
WHERE `country` IN ('Marruecos','Italia','España', 'Portugal')
GROUP BY country, m.`merchant_id`, `name`
HAVING Total_operaciones>10
ORDER BY Total_operaciones ASC;

#Pregunta 2
CREATE VIEW orders_view AS
SELECT m.`merchant_id` AS Comercio_ID, `name` AS Comercio,
		o.`order_id`, `created_at`, `status`, o.`amount`, `country`,
		COUNT(r.`order_id`) AS Numero_devoluciones,SUM(r.`amount`) AS Suma_devoluciones
FROM 
	`merchants` AS m 
	INNER JOIN `orders` AS o ON m.merchant_id = o.merchant_id
	LEFT JOIN `refunds` AS r ON o.order_id = r.order_id
GROUP BY m.merchant_id, o.order_id, name, created_at, status, amount, country;

## Ejercicio 4
SELECT
    `country`,
    SUM(CASE WHEN `status` = 'Delinquent' OR `status` = 'Cancelled' THEN 1 ELSE 0 
             END) AS Total_Delinquent_Cancelled,
    COUNT(*) AS Total_Operaciones,
    (SUM(CASE WHEN `status` = 'Delinquent' OR `status` = 'Cancelled' THEN 1 ELSE 0 
			 END) / COUNT(*)) AS 'Proporción'
FROM `orders`
GROUP BY `country`
ORDER BY (SUM(CASE WHEN `status` = 'Delinquent' OR `status` = 'Cancelled' THEN 1 ELSE 0 
			 END) / COUNT(*)) DESC
LIMIT 3;


SELECT
    `country`, name,
    SUM(CASE WHEN `status` = 'Delinquent' OR `status` = 'Cancelled' THEN 1 ELSE 0 
             END) AS Total_Delinquent_Cancelled,
    COUNT(*) AS Total_Operaciones,
    (SUM(CASE WHEN `status` = 'Delinquent' OR `status` = 'Cancelled' THEN 1 ELSE 0 
			 END) / COUNT(*)) AS 'Proporción',
	(CASE 
		WHEN (SUM(CASE WHEN `status` = 'Delinquent' OR `status` = 'Cancelled' THEN 1 ELSE 0 
			 END) / COUNT(*)) >= 0.20 THEN "ALTO" 
        ELSE "BAJO"
        END) AS "Protocolo_seguridad"
FROM `orders` AS o INNER JOIN `merchants` AS m ON m.`merchant_id`=o.`merchant_id`
WHERE `country` IN ('Marruecos','Francia','España')
GROUP BY `country`, name
HAVING Total_Delinquent_Cancelled >= 3
ORDER BY (SUM(CASE WHEN `status` = 'Delinquent' OR `status` = 'Cancelled' THEN 1 ELSE 0 
			 END) / COUNT(*)) DESC;