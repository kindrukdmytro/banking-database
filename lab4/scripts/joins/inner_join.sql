SET search_path TO lab2;

-- виводить клієнтів з їх банківськими рахунками

SELECT
    c.client_id,
    c.first_name,
    c.last_name,
    a.account_id,
    a.account_number,
    a.account_type,
    a.balance,
    a.currency,
    a.status
FROM clients c
INNER JOIN accounts a ON c.client_id = a.client_id
ORDER BY c.client_id;