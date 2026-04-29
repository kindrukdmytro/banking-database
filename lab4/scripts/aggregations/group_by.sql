SET search_path TO lab2;

-- групує рахунки за типом

SELECT
    account_type,
    COUNT(*) AS accounts_count,
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type
ORDER BY account_type;