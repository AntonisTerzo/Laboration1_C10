USE laboration1;
# Moon Mission
# Uppgift 1
CREATE TABLE successful_mission AS
SELECT *
FROM moon_mission
WHERE outcome = 'Successful';
# Uppgift 2
ALTER TABLE successful_mission
    ADD primary key (mission_id);
# Uppgift 3
UPDATE successful_mission
SET successful_mission.operator=REPLACE(TRIM(successful_mission.operator), ' ', '')
WHERE operator IS NOT NULL;

UPDATE moon_mission
SET moon_mission.operator=REPLACE(TRIM(moon_mission.operator), ' ', '')
WHERE operator IS NOT NULL;
# Uppgift 4
DELETE
FROM successful_mission
WHERE successful_mission.launch_date >= '2010-01-01';
# Uppgift 5
/* #Added a gender column so i can check uppgift 6
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
# Uppgift 6
/*
DELETE FROM account
WHERE gender = 'female'
AND CONVERT(SUBSTR(ssn, 1, 2), UNSIGNED ) < 70;
*/
DELETE
FROM account
WHERE SUBSTRING(REPLACE(ssn, '-', ''), LENGTH(REPLACE(ssn, '-', '')) - 1, 1) % 2 = 0
  AND REPLACE(ssn, '-', '') < '700101';
# Uppgift 7
SELECT IF(SUBSTRING(REPLACE(ssn, '-', ''), LENGTH(REPLACE(ssn, '-', '')) - 1, 1) % 2 = 1, 'Male', 'Female') as gender,
    AVG(
        YEAR(CURRENT_DATE()) - YEAR(STR_TO_DATE(
             IF(SUBSTRING(ssn, 1, 2) > '24', CONCAT('19', SUBSTRING(ssn, 1, 6)),
             CONCAT('20', SUBSTRING(ssn, 1, 6))), '%Y%m%d' ))
       ) as average_age
FROM account
GROUP BY gender;