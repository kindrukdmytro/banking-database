SET search_path TO lab5;

-- заповнення довідникових таблиць

INSERT INTO account_types (account_type_id, type_name) VALUES
(1, 'debit'),
(2, 'credit'),
(3, 'savings');

INSERT INTO account_statuses (account_status_id, status_name) VALUES
(1, 'active'),
(2, 'blocked'),
(3, 'closed');

INSERT INTO currencies (currency_code, currency_name) VALUES
('UAH', 'Ukrainian hryvnia'),
('USD', 'US dollar'),
('EUR', 'Euro');

INSERT INTO card_types (card_type_id, type_name) VALUES
(1, 'Visa'),
(2, 'MasterCard');

INSERT INTO card_statuses (card_status_id, status_name) VALUES
(1, 'active'),
(2, 'expired'),
(3, 'blocked');

INSERT INTO transaction_types (transaction_type_id, type_name) VALUES
(1, 'debit'),
(2, 'credit');

-- заповнення основних таблиць

INSERT INTO clients (
    client_id,
    first_name,
    last_name,
    birth_date,
    phone,
    email,
    passport_number,
    created_date
) VALUES
(1, 'Дмитро', 'Кіндрук', '1111-11-11', '+380501112233', 'dmytro.kindruk@example.com', 'AA123456', '2026-04-01'),
(2, 'Богдан', 'Хмельницький', '1998-09-25', '+380671234567', 'bohdan.khmelnytskyi@example.com', 'BB234567', '2026-04-02'),
(3, 'Іван', 'Мазепа', '1995-02-14', '+380931112244', 'ivan.mazepa@example.com', 'CC345678', '2026-04-03'),
(4, 'Пилип', 'Орлик', '2001-11-08', '+380991234321', 'pylyp.orlyk@example.com', 'DD456789', '2026-04-04'),
(5, 'Петро', 'Дорошенко', '1990-06-30', '+380631234987', 'petro.doroshenko@example.com', 'EE567890', '2026-04-05');

INSERT INTO accounts (
    account_id,
    client_id,
    account_number,
    account_type_id,
    balance,
    currency_code,
    account_status_id,
    opened_date
) VALUES
(1, 1, 'UA123456789000000001', 1, 125000.50, 'UAH', 1, '2026-04-01'),
(2, 2, 'UA123456789000000002', 3, 45000.00, 'UAH', 1, '2026-04-02'),
(3, 3, 'UA123456789000000003', 2, 3000.00, 'UAH', 1, '2026-04-03'),
(4, 4, 'UA123456789000000004', 1, 8200.75, 'USD', 1, '2026-04-04'),
(5, 5, 'UA123456789000000005', 3, 15000.00, 'EUR', 2, '2026-04-05');

INSERT INTO cards (
    card_id,
    account_id,
    card_number,
    card_type_id,
    expiry_date,
    cvv,
    card_status_id
) VALUES
(1, 1, '4444111122223333', 1, '2077-05-31', '123', 1),
(2, 2, '5555222233334444', 2, '2029-07-31', '234', 1),
(3, 3, '4444333322221111', 1, '2027-12-31', '345', 1),
(4, 4, '5555444433332222', 2, '2028-10-31', '456', 1),
(5, 5, '4444555566667777', 1, '2026-11-30', '567', 3);

INSERT INTO transactions (
    transaction_id,
    account_id,
    amount,
    transaction_type_id,
    transaction_date,
    description
) VALUES
(1, 1, 1500.00, 2, '2026-04-10 10:10:10', 'Salary payment'),
(2, 1, 250.50, 1, '2026-04-11 11:11:11', 'Card payment in shop'),
(3, 2, 5000.00, 2, '2026-04-12 12:12:12', 'Deposit replenishment'),
(4, 3, 800.00, 1, '2026-04-13 18:00:00', 'Online purchase'),
(5, 4, 120.75, 1, '2026-04-14 12:00:00', 'ATM withdrawal');

-- оновлення послідовностей після ручного вставлення ID

SELECT setval('clients_client_id_seq', (SELECT MAX(client_id) FROM clients));
SELECT setval('accounts_account_id_seq', (SELECT MAX(account_id) FROM accounts));
SELECT setval('cards_card_id_seq', (SELECT MAX(card_id) FROM cards));
SELECT setval('transactions_transaction_id_seq', (SELECT MAX(transaction_id) FROM transactions));

SELECT setval('account_types_account_type_id_seq', (SELECT MAX(account_type_id) FROM account_types));
SELECT setval('account_statuses_account_status_id_seq', (SELECT MAX(account_status_id) FROM account_statuses));
SELECT setval('card_types_card_type_id_seq', (SELECT MAX(card_type_id) FROM card_types));
SELECT setval('card_statuses_card_status_id_seq', (SELECT MAX(card_status_id) FROM card_statuses));
SELECT setval('transaction_types_transaction_type_id_seq', (SELECT MAX(transaction_type_id) FROM transaction_types));