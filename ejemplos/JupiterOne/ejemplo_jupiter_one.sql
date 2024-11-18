-- Crear tablas entities y relationships
CREATE TABLE entities (
  id VARCHAR PRIMARY KEY,
  type VARCHAR,
  name VARCHAR
);

CREATE TABLE relationships (
  id SERIAL PRIMARY KEY,
  source_id VARCHAR,
  target_id VARCHAR,
  type VARCHAR,
  FOREIGN KEY (source_id) REFERENCES entities(id),
  FOREIGN KEY (target_id) REFERENCES entities(id)
);

-- Llenar las tablas con algunos datos de prueba
INSERT INTO
  entities (id, type, name)
VALUES
  ('123', 'aws_account', 'Account A'),
  ('i-456', 'aws_ec2_instance', 'Instance A'),
  ('bucket-789', 'aws_s3_bucket', 'Bucket A');

INSERT INTO
  relationships (source_id, target_id, type)
VALUES
  ('123', 'i-456', 'HAS'),
  ('123', 'bucket-789', 'OWNS'),
  ('i-456', 'bucket-789', 'CONNECTS_TO');

-- Consulta SQL para traer todas las relaciones aws_account -> HAS -> aws_ec2_instance
SELECT
  e1.name AS account,
  e2.name AS instance
FROM
  entities e1
  JOIN relationships r ON e1.id = r.source_id
  JOIN entities e2 ON r.target_id = e2.id
WHERE
  e1.type = 'aws_account'
  AND r.type = 'HAS'
  AND e2.type = 'aws_ec2_instance';