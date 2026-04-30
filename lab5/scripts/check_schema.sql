SET search_path TO lab5;

-- перевірка нормалізованої схеми

SELECT
    c.client_id,
    c.first_name,
    c.last_name,
    a.account_number,
    at.type_name AS account_type,
    a.balance,
    cur.currency_code,
    cur.currency_name,
    ast.status_name AS account_status
FROM clients c
JOIN accounts a ON c.client_id = a.client_id
JOIN account_types at ON a.account_type_id = at.account_type_id
JOIN currencies cur ON a.currency_code = cur.currency_code
JOIN account_statuses ast ON a.account_status_id = ast.account_status_id
ORDER BY c.client_id;

-- перевірка карток

SELECT
    ca.card_id,
    ca.card_number,
    ct.type_name AS card_type,
    ca.expiry_date,
    cs.status_name AS card_status,
    a.account_number
FROM cards ca
JOIN card_types ct ON ca.card_type_id = ct.card_type_id
JOIN card_statuses cs ON ca.card_status_id = cs.card_status_id
JOIN accounts a ON ca.account_id = a.account_id
ORDER BY ca.card_id;

-- перевірка транзакцій і типів транзакцій

SELECT
    t.transaction_id,
    a.account_number,
    tt.type_name AS transaction_type,
    t.amount,
    t.transaction_date,
    t.description
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN transaction_types tt ON t.transaction_type_id = tt.transaction_type_id
ORDER BY t.transaction_id;