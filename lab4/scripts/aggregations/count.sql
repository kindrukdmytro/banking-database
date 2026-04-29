SET search_path TO lab2;

-- рахує кількість записів у кожній основній таблиці

SELECT 'clients' AS table_name, COUNT(*) AS total_rows FROM clients
UNION ALL
SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL
SELECT 'cards', COUNT(*) FROM cards
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions;