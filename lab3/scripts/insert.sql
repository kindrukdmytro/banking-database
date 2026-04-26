SET search_path TO lab2;

DELETE FROM transactions
WHERE account_id IN (
    SELECT account_id 
    FROM accounts 
    WHERE account_number = 'UA123456789000000006'
);

DELETE FROM cards
WHERE account_id IN (
    SELECT account_id 
    FROM accounts 
    WHERE account_number = 'UA123456789000000006'
);

DELETE FROM accounts
WHERE account_number = 'UA123456789000000006';

DELETE FROM clients
WHERE email = 'ivan.vyhovskyi@example.com';


-- INSERT: Додаємо нового клієнта

INSERT INTO clients (
    first_name,
    last_name,
    birth_date,
    phone,
    email,
    passport_number,
    created_date
)
VALUES (
    'Іван',
    'Виговський',
    '1987-03-20',
    '+380501010101',
    'ivan.vyhovskyi@example.com',
    'FF678901',
    CURRENT_DATE
);


-- INSERT: Додаємо новий акаунт

INSERT INTO accounts (
    client_id,
    account_number,
    account_type,
    balance,
    currency,
    status,
    opened_date
)
VALUES (
    (SELECT client_id FROM clients WHERE email = 'ivan.vyhovskyi@example.com'),
    'UA123456789000000006',
    'debit',
    10000.00,
    'UAH',
    'active',
    CURRENT_DATE
);


-- INSERT: Додаємо нову картку 

INSERT INTO cards (
    account_id,
    card_number,
    card_type,
    expiry_date,
    cvv,
    status
)
VALUES (
    (SELECT account_id FROM accounts WHERE account_number = 'UA123456789000000006'),
    '5555666677778888',
    'MasterCard',
    '2029-12-31',
    '678',
    'active'
);


-- INSERT: додаємо транзакцію

INSERT INTO transactions (
    account_id,
    amount,
    transaction_type,
    transaction_date,
    description
)
VALUES (
    (SELECT account_id FROM accounts WHERE account_number = 'UA123456789000000006'),
    10000.00,
    'credit',
    CURRENT_TIMESTAMP,
    'Initial account deposit'
);


-- перевірка даних

SELECT 
    c.client_id,
    c.first_name,
    c.last_name,
    a.account_id,
    a.account_number,
    a.balance,
    ca.card_number,
    t.amount,
    t.transaction_type,
    t.description
FROM clients c
JOIN accounts a ON c.client_id = a.client_id
JOIN cards ca ON a.account_id = ca.account_id
JOIN transactions t ON a.account_id = t.account_id
WHERE c.email = 'ivan.vyhovskyi@example.com';