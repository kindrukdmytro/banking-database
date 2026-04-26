SET search_path TO lab2;

-- SELECT: Шукаємо активні акаунти

SELECT 
    c.client_id,
    c.first_name,
    c.last_name,
    a.account_number,
    a.account_type,
    a.balance,
    a.currency,
    a.status
FROM clients c
JOIN accounts a ON c.client_id = a.client_id
WHERE a.status = 'active';