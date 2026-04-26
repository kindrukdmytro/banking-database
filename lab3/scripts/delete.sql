SET search_path TO lab2;

-- перевірка акаунту перед видаленням

SELECT 
    transaction_id,
    account_id,
    amount,
    transaction_type,
    transaction_date,
    description
FROM transactions
WHERE account_id = (
    SELECT account_id 
    FROM accounts 
    WHERE account_number = 'UA123456789000000006'
);


-- DELETE: видалення

DELETE FROM transactions
WHERE account_id = (
    SELECT account_id 
    FROM accounts 
    WHERE account_number = 'UA123456789000000006'
)
AND description = 'Initial account deposit';


-- перевірка акаунту після видалення

SELECT 
    COUNT(*) AS transactions_after_delete
FROM transactions
WHERE account_id = (
    SELECT account_id 
    FROM accounts 
    WHERE account_number = 'UA123456789000000006'
);