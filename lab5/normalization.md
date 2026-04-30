## Початкова схема бази даних:

## Таблиця `clients`

Таблиця зберігала інформацію про клієнтів банку.

```text
clients
-------------------------
PK client\_id
first\_name
last\_name
birth\_date
phone UNIQUE
email UNIQUE
passport\_number UNIQUE
created\_date
```

У цій таблиці кожен клієнт має унікальний ідентифікатор `client\_id`. Також унікальними є номер телефону, email та номер паспорта.

## Таблиця `accounts`

Таблиця зберігала інформацію про рахунки клієнтів.

У цій таблиці були повторювані значення в полях: `account\_type`, `currency` та `status`.

```text
accounts
-------------------------
PK account\_id
FK client\_id
account\_number UNIQUE
account\_type
balance
currency
status
opened\_date
```

Проблема цієї таблиці полягає в тому, що тип рахунку, валюта та статус зберігалися як текстові значення безпосередньо в таблиці `accounts`. Наприклад, значення: `debit`, `credit`, `savings`, `UAH`, `USD`, `EUR`, `active`, `blocked`  - повторювалися у багатьох рядках.

## Таблиця `cards`

Таблиця зберігала інформацію про банківські картки.

У цій таблиці були повторювані значення в полях: `card\_type` та `status`.

```text
cards
-------------------------
PK card\_id
FK account\_id
card\_number UNIQUE
card\_type
expiry\_date
cvv
status
```

Проблема цієї таблиці полягає в тому, що тип картки та статус картки зберігалися як текстові значення. Наприклад: `Visa`, `MasterCard`, `active`, `expired`, `blocked` могли повторюватися в багатьох рядках.

## Таблиця `transactions`

Таблиця зберігала інформацію про фінансові операції.

У цій таблиці було повторюване значення в полі `transaction\_type`.

```text
transactions
-------------------------
PK transaction\_id
FK account\_id
amount
transaction\_type
transaction\_date
description
```

Проблема таблиці полягає в тому, що тип транзакції `debit` або `credit` зберігався безпосередньо у кожному рядку таблиці.

## Виявлені проблеми:

У початковій схемі частина значень зберігалася повторно, що могло створити плутанину у достовіності даних.

Повторювані значення:

```text
accounts.account\_type
accounts.currency
accounts.status
cards.card\_type
cards.status
transactions.transaction\_type
```

Можливі проблеми:

* якщо потрібно змінити назву статусу рахунку, її доведеться змінювати у багатьох рядках;
* можна випадково записати однакове значення по-різному, наприклад `active` і `Active`;
* неможливо зручно зберігати перелік допустимих типів або статусів окремо від основних таблиць;
* порушується принцип, за яким кожен факт повинен зберігатися лише один раз.

Функціональні залежності початкової схеми:

---

## Таблиця `clients`

Функціональні залежності:

```text
client\_id -> first\_name, last\_name, birth\_date, phone, email, passport\_number, created\_date
phone -> client\_id
email -> client\_id
passport\_number -> client\_id
```

Первинний ключ: `client\_id`.
Альтернативні унікальні ключі: `phone`, `email`, `passport\_number`.

## Таблиця `accounts`

Функціональні залежності:

```text
account\_id -> client\_id, account\_number, account\_type, balance, currency, status, opened\_date
account\_number -> account\_id, client\_id, account\_type, balance, currency, status, opened\_date
account\_type -> allowed account type value
currency -> currency meaning
status -> account status meaning
```

Первинний ключ: `account\_id`.
Альтернативний унікальний ключ: `account\_number`.
Проблемні атрибути: `account\_type`, `currency`, `status`.

## Таблиця `cards`

Функціональні залежності:

```text
card\_id -> account\_id, card\_number, card\_type, expiry\_date, cvv, status
card\_number -> card\_id, account\_id, card\_type, expiry\_date, cvv, status
card\_type -> allowed card type value
status -> card status meaning
```

Первинний ключ: `card\_id`.
Альтернативний унікальний ключ: `card\_number`.
Проблемні атрибути: `card\_type`, `status`.

## Таблиця `transactions`

Функціональні залежності:

```text
transaction\_id -> account\_id, amount, transaction\_type, transaction\_date, description
transaction\_type -> allowed transaction type value
```

Первинний ключ: `transaction\_id`.
Проблемний атрибут: `transaction\_type`.

Аналіз нормальних форм:

---

## 1НФ

Початкова схема відповідає 1НФ, оскільки всі атрибути є атомарними. У таблицях немає полів, які містять списки значень або повторювані групи в одному стовпці.

Наприклад, `phone`, `email`, `account\\\_number`, `account\\\_type`, `currency`, `status` зберігаються як окремі значення.

## 2НФ

Початкова схема відповідає 2НФ, оскільки всі основні таблиці мають прості первинні ключі, а не складені. Через це немає часткових залежностей від частини складеного ключа.

Наприклад, у таблиці `accounts` первинним ключем є один атрибут `account\\\_id`, тому всі інші атрибути залежать від усього ключа.

## 3НФ

Початкова схема не повністю відповідає 3НФ, оскільки в таблицях є повторювані довідникові значення. Такі значення краще винести в окремі таблиці, щоб уникнути дублювання та аномалій оновлення.

Для приведення схеми до 3НФ я створив довідникові таблиці, а в основних таблицях замість текстових значень використані зовнішні ключі.

## Нормалізація таблиць:

## 

## `accounts`

Початковий дизайн:

```text
accounts(account\\\_id, client\\\_id, account\\\_number, account\\\_type, balance, currency, status, opened\\\_date)
```

Проблема:

```text
account\\\_type, currency, status
```

Ці атрибути містили повторювані значення.

Запропоновані нові таблиці:

```text
account\\\_types(account\\\_type\\\_id, type\\\_name)
account\\\_statuses(account\\\_status\\\_id, status\\\_name)
currencies(currency\\\_code, currency\\\_name)
```

Нова таблиця `accounts`:

```text
accounts(account\\\_id, client\\\_id, account\\\_number, account\\\_type\\\_id, balance, currency\\\_code, account\\\_status\\\_id, opened\\\_date)
```

Логічні команди зміни структури:

```sql
ALTER TABLE accounts
    ADD COLUMN account\\\_type\\\_id INTEGER;

ALTER TABLE accounts
    ADD COLUMN account\\\_status\\\_id INTEGER;

ALTER TABLE accounts
    ADD COLUMN currency\\\_code CHAR(3);

ALTER TABLE accounts
    DROP COLUMN account\\\_type;

ALTER TABLE accounts
    DROP COLUMN status;

ALTER TABLE accounts
    DROP COLUMN currency;
```

Зміна усуває аномалію, тому що типи рахунків, статуси та валюти тепер зберігаються один раз у довідникових таблицях, а таблиця `accounts` лише посилається на них через зовнішні ключі.

## `cards`

Початковий дизайн:

```text
cards(card\\\_id, account\\\_id, card\\\_number, card\\\_type, expiry\\\_date, cvv, status)
```

Проблема:

```text
card\\\_type, status
```

Ці атрибути містили повторювані значення.

Запропоновані нові таблиці:

```text
card\\\_types(card\\\_type\\\_id, type\\\_name)
card\\\_statuses(card\\\_status\\\_id, status\\\_name)
```

Нова таблиця `cards`:

```text
cards(card\\\_id, account\\\_id, card\\\_number, card\\\_type\\\_id, expiry\\\_date, cvv, card\\\_status\\\_id)
```

Логічні команди зміни структури:

```sql
ALTER TABLE cards
    ADD COLUMN card\\\_type\\\_id INTEGER;

ALTER TABLE cards
    ADD COLUMN card\\\_status\\\_id INTEGER;

ALTER TABLE cards
    DROP COLUMN card\\\_type;

ALTER TABLE cards
    DROP COLUMN status;
```

Зміна усуває дублювання, тому що типи та статуси карток зберігаються в окремих таблицях.

## `transactions`

Початковий дизайн:

```text
transactions(transaction\\\_id, account\\\_id, amount, transaction\\\_type, transaction\\\_date, description)
```

Проблема:

```text
transaction\\\_type
```

Цей атрибут містив повторювані значення.

Запропонована нова таблиця:

```text
transaction\\\_types(transaction\\\_type\\\_id, type\\\_name)
```

Нова таблиця `transactions`:

```text
transactions(transaction\\\_id, account\\\_id, amount, transaction\\\_type\\\_id, transaction\\\_date, description)
```

Логічні команди зміни структури:

```sql
ALTER TABLE transactions
    ADD COLUMN transaction\\\_type\\\_id INTEGER;

ALTER TABLE transactions
    DROP COLUMN transaction\\\_type;
```

Зміна усуває дублювання, тому що тип транзакції тепер зберігається в окремій таблиці `transaction\\\_types`.

## Перероблена схема бази даних

Після нормалізації схема містить основні таблиці та довідникові таблиці.

Основні таблиці:

```text
clients
accounts
cards
transactions
```

Довідникові таблиці:

```text
account\\\_types
account\\\_statuses
currencies
card\\\_types
card\\\_statuses
transaction\\\_types
```

SQL-реалізація нормалізованої схеми:

---

Перероблена схема реалізована за допомогою окремих SQL-файлів у папці `scripts`.

```text
scripts/create\\\_schema.sql
scripts/lookup\\\_tables.sql
scripts/main\\\_tables.sql
scripts/insert\\\_data.sql
scripts/check\\\_schema.sql
```

Файл `create\\\_schema.sql` створює схему `lab5`.

Файл `lookup\\\_tables.sql` містить SQL-інструкції `CREATE TABLE` для довідникових таблиць:

```text
account\\\_types(account\\\_type\\\_id, type\\\_name)
account\\\_statuses(account\\\_status\\\_id, status\\\_name)
currencies(currency\\\_code, currency\\\_name)
card\\\_types(card\\\_type\\\_id, type\\\_name)
card\\\_statuses(card\\\_status\\\_id, status\\\_name)
transaction\\\_types(transaction\\\_type\\\_id, type\\\_name)
```

Файл `main\\\_tables.sql` містить SQL-інструкції `CREATE TABLE` для основних таблиць:

```text
clients(client\\\_id, first\\\_name, last\\\_name, birth\\\_date, phone, email, passport\\\_number, created\\\_date)
accounts(account\\\_id, client\\\_id, account\\\_number, account\\\_type\\\_id, balance, currency\\\_code, account\\\_status\\\_id, opened\\\_date)
cards(card\\\_id, account\\\_id, card\\\_number, card\\\_type\\\_id, expiry\\\_date, cvv, card\\\_status\\\_id)
transactions(transaction\\\_id, account\\\_id, amount, transaction\\\_type\\\_id, transaction\\\_date, description)
```

Файл `insert\\\_data.sql` заповнює довідникові та основні таблиці тестовими даними.

Файл `check\\\_schema.sql` перевіряє роботу нормалізованої схеми через `SELECT`-запити з `JOIN`.

Повний SQL-код з командами `CREATE TABLE`, первинними ключами, зовнішніми ключами та обмеженнями знаходиться в окремих файлах папки `scripts`. 

Структура таблиць у 3НФ:

---

## `clients`

```text
PK client\\\_id
first\\\_name
last\\\_name
birth\\\_date
phone UNIQUE
email UNIQUE
passport\\\_number UNIQUE
created\\\_date
```

## `accounts`

```text
PK account\\\_id
FK client\\\_id
account\\\_number UNIQUE
FK account\\\_type\\\_id
balance
FK currency\\\_code
FK account\\\_status\\\_id
opened\\\_date
```

## `cards`

```text
PK card\\\_id
FK account\\\_id
card\\\_number UNIQUE
FK card\\\_type\\\_id
expiry\\\_date
cvv
FK card\\\_status\\\_id
```

## `transactions`

```text
PK transaction\\\_id
FK account\\\_id
amount
FK transaction\\\_type\\\_id
transaction\\\_date
description
```

## `account\\\_types`

```text
PK account\\\_type\\\_id
type\\\_name UNIQUE
```

## `account\\\_statuses`

```text
PK account\\\_status\\\_id
status\\\_name UNIQUE
```

## `currencies`

```text
PK currency\\\_code
currency\\\_name UNIQUE
```

## `card\\\_types`

```text
PK card\\\_type\\\_id
type\\\_name UNIQUE
```

## `card\\\_statuses`

```text
PK card\\\_status\\\_id
status\\\_name UNIQUE
```

## `transaction\\\_types`

```text
PK transaction\\\_type\\\_id
type\\\_name UNIQUE
```

## ER-діаграма

```text
visual/ERdiagram.jpg
```

!\[Normalized ERD](visual/ERdiagram.jpg)

На діаграмі показано всі основні та довідникові таблиці, а також зв’язки між ними:

## 

1. `clients.client\\\_id` → `accounts.client\\\_id`

   * один клієнт може мати багато рахунків;
2. `accounts.account\\\_id` → `cards.account\\\_id`

   * один рахунок може мати багато карток;
3. `accounts.account\\\_id` → `transactions.account\\\_id`

   * один рахунок може мати багато транзакцій;
4. `account\\\_types.account\\\_type\\\_id` → `accounts.account\\\_type\\\_id`

   * один тип рахунку може використовуватися в багатьох рахунках;
5. `account\\\_statuses.account\\\_status\\\_id` → `accounts.account\\\_status\\\_id`

   * один статус рахунку може використовуватися в багатьох рахунках;
6. `currencies.currency\\\_code` → `accounts.currency\\\_code`

   * одна валюта може використовуватися в багатьох рахунках;
7. `card\\\_types.card\\\_type\\\_id` → `cards.card\\\_type\\\_id`

   * один тип картки може використовуватися в багатьох картках;
8. `card\\\_statuses.card\\\_status\\\_id` → `cards.card\\\_status\\\_id`

   * один статус картки може використовуватися в багатьох картках;
9. `transaction\\\_types.transaction\\\_type\\\_id` → `transactions.transaction\\\_type\\\_id`

   * один тип транзакції може використовуватися в багатьох транзакціях.

## Висновок:

Під час виконання лабораторної роботи ми проаналізував початкову схему банківської бази даних та виявили повторювані текстові значення в таблицях, а для усунення надлишковості були створені окремі довідникові таблиці. Після нормалізації основні таблиці більше не зберігають повторювані текстові значення, а використовують зовнішні ключі на довідникові таблиці. Це зменшує дублювання, покращує цілісність даних і знижує ризик аномалій оновлення.
Фінальна схема відповідає третій нормальній формі, оскільки всі неключові атрибути залежать від ключів своїх таблиць, а довідникові значення винесені в окремі таблиці.



