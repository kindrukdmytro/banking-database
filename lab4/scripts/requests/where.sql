SET search_path TO lab2;

-- шукає рахунки де баланс вищий за середній

SELECT
    account_id,
    client_id,
    account_number,
    account_type,
    balance,
    currency,
    status
FROM accounts
WHERE balance > (
    SELECT AVG(balance)
    FROM accounts
)
ORDER BY balance DESC;