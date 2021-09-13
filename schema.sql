CREATE DATABASE typoteka
  WITH
  OWNER = dmitry
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;

DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS articles_categories;

CREATE TABLE categories (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE users (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  avatar VARCHAR(50),
  name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash varchar(255) NOT NULL
);

CREATE TABLE articles (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  created_at TIMESTAMP DEFAULT current_timestamp,
  title VARCHAR(255) NOT NULL,
  announce TEXT NOT NULL,
  photo VARCHAR(50),
  full_text TEXT,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE SET NULL
    ON DELETE SET NULL
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  text TEXT NOT NULL,
  article_id INTEGER NOT NULL,
  user_id INTEGER,
  FOREIGN KEY (article_id) REFERENCES articles(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE SET NULL
    ON DELETE SET NULL
);

CREATE TABLE articles_categories (
  article_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  PRIMARY KEY (article_id, category_id),
  FOREIGN KEY (article_id) REFERENCES articles(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES comments(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX ON articles(title);
