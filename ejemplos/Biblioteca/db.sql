-- Crear la tabla authors
CREATE TABLE authors (
  author_id INT PRIMARY KEY,
  name VARCHAR(100),
  country VARCHAR(50)
);

-- Insertar datos en authors (incluye un valor nulo)
INSERT INTO
  authors (author_id, name, country)
VALUES
  (1, 'Gabriel García Márquez', 'Colombia'),
  (2, 'J.K. Rowling', 'UK'),
  (3, 'Haruki Murakami', NULL);

-- País desconocido para ilustrar un valor nulo
-- Crear la tabla books
CREATE TABLE books (
  book_id INT PRIMARY KEY,
  title VARCHAR(200),
  publication_year INT,
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Insertar datos en books
INSERT INTO
  books (book_id, title, publication_year, author_id)
VALUES
  (1, 'Cien Años de Soledad', 1967, 1),
  (
    2,
    'Harry Potter and the Philosopher''s Stone',
    1997,
    2
  ),
  (3, 'Kafka on the Shore', 2002, 3);

-- Crear la tabla loans
CREATE TABLE loans (
  loan_id INT PRIMARY KEY,
  book_id INT,
  user_id INT,
  loan_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Insertar datos en loans
INSERT INTO
  loans (loan_id, book_id, user_id, loan_date)
VALUES
  (1, 1, 101, '2024-11-01'),
  (2, 3, 102, '2024-11-05'),
  (3, 2, 103, '2024-11-10');