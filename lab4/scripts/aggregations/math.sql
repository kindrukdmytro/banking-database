SET search_path TO lab2;

-- показує загальну статистику по балансах рахунків

SELECT
    COUNT(*) AS total_accounts,
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance,
    MIN(balance) AS minimum_balance,
    MAX(balance) AS maximum_balance
FROM accounts;