SET search_path TO lab2;

-- показує типи транзакцій у яких сума більша за середню

SELECT
    transaction_type,
    COUNT(*) AS transactions_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY transaction_type
HAVING SUM(amount) > (
    SELECT AVG(amount)
    FROM transactions
)
ORDER BY total_amount DESC;