-- Estos ejemplos fueron tomados del siguiente artículo:
-- https://medium.com/@manutej/mastering-sql-window-functions-guide-e6dc17eb1995
CREATE TABLE Sales (
  SaleID INT,
  SalesPerson VARCHAR(50),
  SaleAmount INT,
  SaleDate DATE
);

INSERT INTO
  Sales (SaleId, SalesPerson, SaleAmount, SaleDate)
VALUES
  (1, 'Alice', 300, '2023-01-01'),
  (2, 'Bob', 150, '2023-01-02'),
  (3, 'Alice', 200, '2023-01-03'),
  (4, 'Charlie', 250, '2023-01-04'),
  (5, 'Bob', 300, '2023-01-05'),
  (6, 'Alice', 100, '2023-01-06'),
  (7, 'Charlie', 350, '2023-01-07'),
  (8, 'Alice', 450, '2023-01-08'),
  (9, 'Bob', 200, '2023-01-09'),
  (10, 'Charlie', 400, '2023-01-10'),
  (11, 'Alice', 150, '2023-01-11'),
  (12, 'Bob', 250, '2023-01-12'),
  (13, 'Charlie', 300, '2023-01-13'),
  (14, 'Alice', 350, '2023-01-14'),
  (15, 'Bob', 100, '2023-01-15');

-- 1. Running totals
SELECT
  SaleID,
  Salesperson,
  SaleAmount,
  SaleDate,
  SUM(SaleAmount) OVER (
    ORDER BY
      SaleDate
  ) AS RunningTotal
FROM
  Sales;

-- 2. Cumulative Totals (By SalesPerson)
SELECT
  SaleID,
  Salesperson,
  SaleAmount,
  SaleDate,
  SUM(SaleAmount) OVER (
    PARTITION BY Salesperson
    ORDER BY
      SaleDate
  ) AS CumulativeSalePerPerson
FROM
  Sales;

-- 3. Ranking Sales by SalesAmount
SELECT
  SaleID,
  Salesperson,
  SaleAmount,
  SaleDate,
  RANK() OVER (
    ORDER BY
      SaleAmount DESC
  ) AS SaleRank
FROM
  Sales;

-- 4. Moving Average (3-Day) of SalesAmount
SELECT
  SaleID,
  SaleDate,
  Salesperson,
  SaleAmount,
  AVG(SaleAmount) OVER (
    ORDER BY
      SaleDate ROWS BETWEEN 1 PRECEDING
      AND 1 FOLLOWING
  ) AS MovingAverage
FROM
  Sales;

-- RANK() Example
SELECT
  SaleID,
  Salesperson,
  SaleAmount,
  RANK() OVER (
    ORDER BY
      SaleAmount DESC
  ) AS RankByAmount
FROM
  Sales;

-- DENSE_RANK() Example
SELECT
  SaleID,
  Salesperson,
  SaleAmount,
  DENSE_RANK() OVER (
    ORDER BY
      SaleAmount DESC
  ) AS DenseRankByAmount
FROM
  Sales;

-- ROW_NUMBER() Example
SELECT
  SaleID,
  Salesperson,
  SaleAmount,
  ROW_NUMBER() OVER (
    ORDER BY
      SaleAmount DESC
  ) AS RowNumByAmount
FROM
  Sales;

-- NTILE() Example
SELECT
  SaleID,
  Salesperson,
  SaleAmount,
  NTILE(4) OVER (
    ORDER BY
      SaleAmount DESC
  ) AS Quartile
FROM
  Sales;