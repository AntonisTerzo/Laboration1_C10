/*
 För att accessa databasen vill vi ha två konton med rätt behörigheter.
 Den ena användaren ska vara ett utvecklarkonto och ha rättigheter att på bokdatabasen lägga till, ta
bort och uppdatera tabeller samt deras innehåll.
 Det andra kontot är tänkt för en web server att ansluta till databasen via och ska endast ha
rättigheter att utföra CRUD operationer och inte skapa eller ta bort databaser.
 Inget av kontona ska få lägga till nya användare eller skapa nya databaser
 */
DROP USER IF EXISTS 'developer'@'%';
DROP USER IF EXISTS 'web_server'@'%';

CREATE USER 'developer'@'%' IDENTIFIED BY 'developer_strong_password';
CREATE USER 'web_server'@'%' IDENTIFIED BY 'web_server_strong_password';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON bookstore.* TO 'developer'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'web_server'@'%';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'developer'@'%';
SHOW GRANTS FOR 'web_server'@'%';