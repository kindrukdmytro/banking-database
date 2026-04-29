SET search_path TO lab2;

-- для кожного клієнта рахує суму всіх його рахунків

SELECT
    c.client_id,
    c.first_name,
    c.last_name,
    (
        SELECT SUM(a.balance)
        FROM accounts a
        WHERE a.client_id = c.client_id
    ) AS total_balance
FROM clients c
ORDER BY c.client_id;