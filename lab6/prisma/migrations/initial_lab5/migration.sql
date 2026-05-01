-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "lab5";
SET search_path TO "lab5";

-- CreateTable
CREATE TABLE "account_statuses" (
    "account_status_id" SERIAL NOT NULL,
    "status_name" VARCHAR(20) NOT NULL,

    CONSTRAINT "account_statuses_pkey" PRIMARY KEY ("account_status_id")
);

-- CreateTable
CREATE TABLE "account_types" (
    "account_type_id" SERIAL NOT NULL,
    "type_name" VARCHAR(20) NOT NULL,

    CONSTRAINT "account_types_pkey" PRIMARY KEY ("account_type_id")
);

-- CreateTable
CREATE TABLE "accounts" (
    "account_id" SERIAL NOT NULL,
    "client_id" INTEGER NOT NULL,
    "account_number" VARCHAR(30) NOT NULL,
    "account_type_id" INTEGER NOT NULL,
    "balance" DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    "currency_code" CHAR(3) NOT NULL,
    "account_status_id" INTEGER NOT NULL,
    "opened_date" DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("account_id")
);

-- CreateTable
CREATE TABLE "card_statuses" (
    "card_status_id" SERIAL NOT NULL,
    "status_name" VARCHAR(20) NOT NULL,

    CONSTRAINT "card_statuses_pkey" PRIMARY KEY ("card_status_id")
);

-- CreateTable
CREATE TABLE "card_types" (
    "card_type_id" SERIAL NOT NULL,
    "type_name" VARCHAR(20) NOT NULL,

    CONSTRAINT "card_types_pkey" PRIMARY KEY ("card_type_id")
);

-- CreateTable
CREATE TABLE "cards" (
    "card_id" SERIAL NOT NULL,
    "account_id" INTEGER NOT NULL,
    "card_number" VARCHAR(20) NOT NULL,
    "card_type_id" INTEGER NOT NULL,
    "expiry_date" DATE NOT NULL,
    "cvv" CHAR(3) NOT NULL,
    "card_status_id" INTEGER NOT NULL,

    CONSTRAINT "cards_pkey" PRIMARY KEY ("card_id")
);

-- CreateTable
CREATE TABLE "clients" (
    "client_id" SERIAL NOT NULL,
    "first_name" VARCHAR(50) NOT NULL,
    "last_name" VARCHAR(50) NOT NULL,
    "birth_date" DATE NOT NULL,
    "phone" VARCHAR(20) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "passport_number" VARCHAR(20) NOT NULL,
    "created_date" DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT "clients_pkey" PRIMARY KEY ("client_id")
);

-- CreateTable
CREATE TABLE "currencies" (
    "currency_code" CHAR(3) NOT NULL,
    "currency_name" VARCHAR(50) NOT NULL,

    CONSTRAINT "currencies_pkey" PRIMARY KEY ("currency_code")
);

-- CreateTable
CREATE TABLE "transaction_types" (
    "transaction_type_id" SERIAL NOT NULL,
    "type_name" VARCHAR(20) NOT NULL,

    CONSTRAINT "transaction_types_pkey" PRIMARY KEY ("transaction_type_id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "transaction_id" SERIAL NOT NULL,
    "account_id" INTEGER NOT NULL,
    "amount" DECIMAL(12,2) NOT NULL,
    "transaction_type_id" INTEGER NOT NULL,
    "transaction_date" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "description" TEXT,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("transaction_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "account_statuses_status_name_key" ON "account_statuses"("status_name");

-- CreateIndex
CREATE UNIQUE INDEX "account_types_type_name_key" ON "account_types"("type_name");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_account_number_key" ON "accounts"("account_number");

-- CreateIndex
CREATE UNIQUE INDEX "card_statuses_status_name_key" ON "card_statuses"("status_name");

-- CreateIndex
CREATE UNIQUE INDEX "card_types_type_name_key" ON "card_types"("type_name");

-- CreateIndex
CREATE UNIQUE INDEX "cards_card_number_key" ON "cards"("card_number");

-- CreateIndex
CREATE UNIQUE INDEX "clients_phone_key" ON "clients"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "clients_email_key" ON "clients"("email");

-- CreateIndex
CREATE UNIQUE INDEX "clients_passport_number_key" ON "clients"("passport_number");

-- CreateIndex
CREATE UNIQUE INDEX "currencies_currency_name_key" ON "currencies"("currency_name");

-- CreateIndex
CREATE UNIQUE INDEX "transaction_types_type_name_key" ON "transaction_types"("type_name");

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "fk_accounts_account_statuses" FOREIGN KEY ("account_status_id") REFERENCES "account_statuses"("account_status_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "fk_accounts_account_types" FOREIGN KEY ("account_type_id") REFERENCES "account_types"("account_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "fk_accounts_clients" FOREIGN KEY ("client_id") REFERENCES "clients"("client_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "fk_accounts_currencies" FOREIGN KEY ("currency_code") REFERENCES "currencies"("currency_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cards" ADD CONSTRAINT "fk_cards_accounts" FOREIGN KEY ("account_id") REFERENCES "accounts"("account_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cards" ADD CONSTRAINT "fk_cards_card_statuses" FOREIGN KEY ("card_status_id") REFERENCES "card_statuses"("card_status_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cards" ADD CONSTRAINT "fk_cards_card_types" FOREIGN KEY ("card_type_id") REFERENCES "card_types"("card_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "fk_transactions_accounts" FOREIGN KEY ("account_id") REFERENCES "accounts"("account_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "fk_transactions_transaction_types" FOREIGN KEY ("transaction_type_id") REFERENCES "transaction_types"("transaction_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

