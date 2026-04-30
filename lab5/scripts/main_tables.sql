SET search_path TO lab5;

-- створення основних таблиць банківської системи(повторювані текстові значення замінені зовнішніми ключами)

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
    account_type_id INTEGER NOT NULL,
    balance NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    currency_code CHAR(3) NOT NULL,
    account_status_id INTEGER NOT NULL,
    opened_date DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT fk_accounts_clients
        FOREIGN KEY (client_id)
        REFERENCES clients(client_id),

    CONSTRAINT fk_accounts_account_types
        FOREIGN KEY (account_type_id)
        REFERENCES account_types(account_type_id),

    CONSTRAINT fk_accounts_currencies
        FOREIGN KEY (currency_code)
        REFERENCES currencies(currency_code),

    CONSTRAINT fk_accounts_account_statuses
        FOREIGN KEY (account_status_id)
        REFERENCES account_statuses(account_status_id),

    CONSTRAINT chk_account_balance
        CHECK (balance >= 0)
);

CREATE TABLE cards (
    card_id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL,
    card_number VARCHAR(20) NOT NULL UNIQUE,
    card_type_id INTEGER NOT NULL,
    expiry_date DATE NOT NULL,
    cvv CHAR(3) NOT NULL,
    card_status_id INTEGER NOT NULL,

    CONSTRAINT fk_cards_accounts
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id),

    CONSTRAINT fk_cards_card_types
        FOREIGN KEY (card_type_id)
        REFERENCES card_types(card_type_id),

    CONSTRAINT fk_cards_card_statuses
        FOREIGN KEY (card_status_id)
        REFERENCES card_statuses(card_status_id),

    CONSTRAINT chk_cvv
        CHECK (cvv ~ '^[0-9]{3}$')
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    transaction_type_id INTEGER NOT NULL,
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description TEXT,

    CONSTRAINT fk_transactions_accounts
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id),

    CONSTRAINT fk_transactions_transaction_types
        FOREIGN KEY (transaction_type_id)
        REFERENCES transaction_types(transaction_type_id),

    CONSTRAINT chk_transaction_amount
        CHECK (amount > 0)
);