CREATE (account:aws_account {id: "123", name: "Account A"})
CREATE (ec2:aws_ec2_instance {id: "i-456", name: "Instance A"})
CREATE (s3:aws_s3_bucket {id: "bucket-789", name: "Bucket A"})
CREATE (account)-[:HAS]->(ec2)
CREATE (account)-[:OWNS]->(s3)
CREATE (ec2)-[:CONNECTS_TO]->(s3);

// Consulta en Cypher Query Languate para traer todas las relaciones aws_account -> HAS -> aws_ec2_instance 
MATCH (account:aws_account)-[:HAS]->(ec2:aws_ec2_instance)
RETURN account, ec2;