SET search_path TO lab2;

-- показує тільки ті типи рахунків де сума > 10000

SELECT
    account_type,
    COUNT(*) AS accounts_count,
    SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type
HAVING SUM(balance) > 10000
ORDER BY total_balance DESC;