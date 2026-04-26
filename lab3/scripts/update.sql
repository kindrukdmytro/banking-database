SET search_path TO lab2;

-- перевірка акаунту перед операцією

SELECT 
    account_id,
    client_id,
    account_number,
    balance,
    currency,
    status
FROM accounts
WHERE account_number = 'UA123456789000000006';


-- UPDATE: малюємо гроші

UPDATE accounts
SET balance = 8500.00
WHERE account_number = 'UA123456789000000006';


-- перевірка акаунту після операції

SELECT 
    account_id,
    client_id,
    account_number,
    balance,
    currency,
    status
FROM accounts
WHERE account_number = 'UA123456789000000006';