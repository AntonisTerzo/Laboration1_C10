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
