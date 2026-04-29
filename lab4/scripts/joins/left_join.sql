SET search_path TO lab2;

-- виводить усіх клієнтів і рахує їхню кількість рахунків 

SELECT
    c.client_id,
    c.first_name,
    c.last_name,
    COUNT(a.account_id) AS accounts_count
FROM clients c
LEFT JOIN accounts a ON c.client_id = a.client_id
GROUP BY c.client_id, c.first_name, c.last_name
ORDER BY c.client_id;