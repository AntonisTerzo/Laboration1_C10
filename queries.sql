USE laboration1;
# Moon Mission
#1
CREATE TABLE successful_mission AS
SELECT *
FROM moon_mission
WHERE outcome='Successful';
#2
ALTER TABLE successful_mission
ADD primary key(mission_id);
#3
UPDATE successful_mission
SET successful_mission.operator=REPLACE(TRIM(successful_mission.operator), ' ', '')
WHERE operator IS NOT NULL;

UPDATE moon_mission
SET moon_mission.operator=REPLACE(TRIM(moon_mission.operator), ' ', '')
WHERE operator IS NOT NULL;
#4
