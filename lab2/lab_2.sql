DROP SCHEMA IF EXISTS lab2 CASCADE;

CREATE SCHEMA lab2;

SET search_path TO lab2;

CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    passport_number VARCHAR(20) NOT NULL UNIQUE,
    created_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL,
    account_number VARCHAR(30) NOT NULL UNIQUE,
    account_type VARCHAR(20) NOT NULL,
    balance NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    currency CHAR(3) NOT NULL DEFAULT 'UAH',
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    opened_date DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT fk_accounts_clients
        FOREIGN KEY (client_id)
        REFERENCES clients(client_id),

    CONSTRAINT chk_account_type
        CHECK (account_type IN ('debit', 'credit', 'savings')),

    CONSTRAINT chk_account_status
        CHECK (status IN ('active', 'blocked', 'closed')),

    CONSTRAINT chk_account_balance
        CHECK (balance >= 0)
);

CREATE TABLE cards (
    card_id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL,
    card_number VARCHAR(20) NOT NULL UNIQUE,
    card_type VARCHAR(20) NOT NULL,
    expiry_date DATE NOT NULL,
    cvv CHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',

    CONSTRAINT fk_cards_accounts
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id),

    CONSTRAINT chk_card_type
        CHECK (card_type IN ('Visa', 'MasterCard')),

    CONSTRAINT chk_card_status
        CHECK (status IN ('active', 'expired', 'blocked')),

    CONSTRAINT chk_cvv
        CHECK (cvv ~ '^[0-9]{3}$')
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description TEXT,

    CONSTRAINT fk_transactions_accounts
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id),

    CONSTRAINT chk_transaction_type
        CHECK (transaction_type IN ('debit', 'credit')),

    CONSTRAINT chk_transaction_amount
        CHECK (amount > 0)
);

INSERT INTO clients (first_name, last_name, birth_date, phone, email, passport_number, created_date) VALUES
('Дмитро', 'Кіндрук', '2005-04-12', '+380501112233', 'dmytro.kindruk@example.com', 'AA123456', '2026-04-01'),
('Богдан', 'Хмельницький', '1998-09-25', '+380671234567', 'bohdan.khmelnytskyi@example.com', 'BB234567', '2026-04-02'),
('Іван', 'Мазепа', '1995-02-14', '+380931112244', 'ivan.mazepa@example.com', 'CC345678', '2026-04-03'),
('Пилип', 'Орлик', '2001-11-08', '+380991234321', 'pylyp.orlyk@example.com', 'DD456789', '2026-04-04'),
('Петро', 'Дорошенко', '1990-06-30', '+380631234987', 'petro.doroshenko@example.com', 'EE567890', '2026-04-05');

INSERT INTO accounts (client_id, account_number, account_type, balance, currency, status, opened_date) VALUES
(1, 'UA123456789000000001', 'debit', 12500.50, 'UAH', 'active', '2026-04-01'),
(2, 'UA123456789000000002', 'savings', 45000.00, 'UAH', 'active', '2026-04-02'),
(3, 'UA123456789000000003', 'credit', 3000.00, 'UAH', 'active', '2026-04-03'),
(4, 'UA123456789000000004', 'debit', 8200.75, 'USD', 'active', '2026-04-04'),
(5, 'UA123456789000000005', 'savings', 15000.00, 'EUR', 'blocked', '2026-04-05');

INSERT INTO cards (account_id, card_number, card_type, expiry_date, cvv, status) VALUES
(1, '4444111122223333', 'Visa', '2028-05-31', '123', 'active'),
(2, '5555222233334444', 'MasterCard', '2029-07-31', '234', 'active'),
(3, '4444333322221111', 'Visa', '2027-12-31', '345', 'active'),
(4, '5555444433332222', 'MasterCard', '2028-10-31', '456', 'active'),
(5, '4444555566667777', 'Visa', '2026-11-30', '567', 'blocked');

INSERT INTO transactions (account_id, amount, transaction_type, transaction_date, description) VALUES
(1, 1500.00, 'credit', '2026-04-10 10:15:00', 'Salary payment'),
(1, 250.50, 'debit', '2026-04-11 14:30:00', 'Card payment in shop'),
(2, 5000.00, 'credit', '2026-04-12 09:00:00', 'Deposit replenishment'),
(3, 800.00, 'debit', '2026-04-13 18:45:00', 'Online purchase'),
(4, 120.75, 'debit', '2026-04-14 12:20:00', 'ATM withdrawal');

SELECT 'clients' AS table_name, COUNT(*) AS rows_count FROM clients
UNION ALL
SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL
SELECT 'cards', COUNT(*) FROM cards
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions;