SET search_path TO lab2;

-- виводить усі рахунки та інформацію про картки

SELECT
    a.account_id,
    a.account_number,
    a.account_type,
    a.balance,
    c.card_id,
    c.card_number,
    c.card_type,
    c.status AS card_status
FROM cards c
RIGHT JOIN accounts a ON c.account_id = a.account_id
ORDER BY a.account_id;