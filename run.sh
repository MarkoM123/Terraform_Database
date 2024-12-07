#!/bin/bash
### Instalacija Apache Web Servera
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd


### Instalacija PostgreSQL klijenta

sudo amazon-linux-extras install postgresql14

# Definiši putanju SQL fajla
SQL_FILE="/home/ec2-user/db-tabela.sql"

# Kreiraj SQL fajl i dodaj sadržaj
cat << EOF > $SQL_FILE
-- Kreiranje tabele
CREATE TABLE korisnici (
    id SERIAL PRIMARY KEY,
    Ime VARCHAR(25),
    Prezime VARCHAR(25),
    Godine INT
);

-- Ubacivanje podataka u tabelu
INSERT INTO korisnici (Ime, Prezime, Godine) VALUES
('Marko', 'Markovic', 28),
('Petar', 'Petrovic', 30),
('Nikola', 'Tesla', 56);

-- Provera podataka u tabeli
SELECT * FROM korisnici;
EOF
