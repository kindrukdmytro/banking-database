-- видаляє стару схему якщо та існує, а потім створює нову схему для нормалізованої бази

DROP SCHEMA IF EXISTS lab5 CASCADE;

CREATE SCHEMA lab5;

SET search_path TO lab5;