SET search_path TO lab5;

-- Створення довідникових таблиць для нормалізації повторюваних значень

CREATE TABLE account_types (
    account_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE account_statuses (
    account_status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE currencies (
    currency_code CHAR(3) PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE card_types (
    card_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE card_statuses (
    card_status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE transaction_types (
    transaction_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(20) NOT NULL UNIQUE
);