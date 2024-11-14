USE laboration1;
/* Moon Mission
Uppgift 1: Använd ”CREATE TABLE..AS SELECT” för att ta ut alla kolumner för alla lyckade uppdrag
(Successful outcome) i “moonmission” och sätt in i en ny tabell med namn ”successful_mission”. */
CREATE TABLE successful_mission AS
SELECT *
FROM moon_mission
WHERE outcome = 'Successful';
/* Uppgift 2: Skriv en query som ändrar tabellen “successful_mission” så att kolumnen “mission_id” blir en
primärnyckel och auto inkrementerar. Ta inte bort tabellen och skapa den på nytt, enbart egenskaperna för mission_id ska ändras. */
ALTER TABLE successful_mission
    ADD primary key (mission_id);
/* Uppgift 3: I kolumnen ‘operator’ har det smugit sig in ett eller flera mellanslag i operatörens namn. Skriv
queries som uppdaterar och tar bort mellanslagen kring operatören för både “successful_mission” och “moon_missions”. */
UPDATE successful_mission
SET successful_mission.operator=REPLACE(TRIM(successful_mission.operator), ' ', '')
WHERE operator IS NOT NULL;

UPDATE moon_mission
SET moon_mission.operator=REPLACE(TRIM(moon_mission.operator), ' ', '')
WHERE operator IS NOT NULL;
-- Uppgift 4: Skriv en query som tar bort alla uppdrag utförda 2010 eller senare från “successful_mission”.
DELETE
FROM successful_mission
WHERE successful_mission.launch_date >= '2010-01-01';
/* Uppgift 5: Gör en SELECT för att ta ut samtliga rader och kolumner från tabellen “account”, men slå ihop
 ‘first_name’ och ‘last_name’ till en ny kolumn ‘name’, samt lägg till en extra kolumn ‘gender’ som
 du ger värdet ‘female’ för alla användare vars näst sista siffra i personnumret är jämn, och värdet ‘male’ för de användare där siffran är udda.
-- Added a gender column so i can check uppgift 6
ALTER TABLE account
ADD gender VARCHAR(10);

UPDATE account
SET account.gender = CASE
    WHEN CONVERT(SUBSTR(ssn, LENGTH(ssn) - 1, 1), UNSIGNED )% 2 = 0 THEN 'female'
    ELSE 'male'
END;
*/
SELECT *,
       CONCAT(account.first_name, ' ', account.last_name)               AS name,
       IF(SUBSTRING(ssn, LENGTH(ssn) - 1, 1) % 2 = 0, 'female', 'male') AS gender
FROM account;
/* Uppgift 6: Skriv en query som tar bort alla kvinnor födda före 1970.
DELETE FROM account
WHERE gender = 'female'
AND CONVERT(SUBSTR(ssn, 1, 2), UNSIGNED ) < 70;
*/
DELETE
FROM account
WHERE SUBSTRING(REPLACE(ssn, '-', ''), LENGTH(REPLACE(ssn, '-', '')) - 1, 1) % 2 = 0
  AND REPLACE(ssn, '-', '') < '700101';
/* Uppgift 7: Skriv en query som returnerar två kolumner ‘gender’ och ‘average_age’, och två rader där ena
visar medelåldern för män, och den andra medelåldern för kvinnor för alla användare i tabellen ‘account’. */
SELECT IF(SUBSTRING(REPLACE(ssn, '-', ''), LENGTH(REPLACE(ssn, '-', '')) - 1, 1) % 2 = 1, 'female', 'male') as gender,
    AVG(
        YEAR(CURRENT_DATE()) - YEAR(STR_TO_DATE(
             IF(SUBSTRING(ssn, 1, 2) > '24', CONCAT('19', SUBSTRING(ssn, 1, 6)),
             CONCAT('20', SUBSTRING(ssn, 1, 6))), '%Y%m%d' ))
       ) as average_age
FROM account
GROUP BY gender;