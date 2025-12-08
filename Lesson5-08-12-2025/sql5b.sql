-- Display the last name and first name of all Utmus professors
-- Ordered in ascending by last name

SELECT fname, lname
FROM Professor
ORDER BY lname ASC 

-- Display the last name of students who are older than 13 years old

SELECT s.lname, s.age
FROM Student s
WHERE s.age >= 13;

-- Display the all information about the courses which contain
-- the word 'the' in their title ('the' must be a full word).
SELECT * 
FROM Course as c
WHERE c.title LIKE '% the %' OR c.title LIKE 'the %'

-- Display the all information about the courses which contain
-- words starting with 'T' in their title.
SELECT *
FROM Course 
WHERE title LIKE 'T%' OR title LIKE '% T%'

-- Display the first and last name of the students of the 'Mullinder' house.
SELECT s.fname AS 'First Name', s.lname AS 'Last Name', h.name as House
FROM student as s
INNER JOIN HOUSE h
ON s.houseId = h.houseId
WHERE h.name = 'Mullinder';

-- Using JOIN, find the first and last name of the professors of the 
-- 'Mullinder' house that teach courses in the 'Autumn' trimester
SELECT p.fname AS 'First Name', p.lname AS 'Last Name', h.name as House, t.trimester
FROM Professor as p
INNER JOIN HOUSE h ON p.houseId = h.houseId
INNER JOIN Teaching t ON p.profId = t.profID
WHERE h.name = 'Mullinder' AND t.trimester = 'Autumn';

-- Create a second query which does the same without using JOINs
SELECT p.fname AS 'First Name', p.lname AS 'Last Name', h.name as House, t.trimester
FROM Professor as p, House as h, Teaching as t
WHERE h.name = 'Mullinder' AND t.trimester = 'Autumn' AND p.profId = t.profID AND p.houseId = h.houseId;

-- How many professors are teaching the course with the title 'Sorcery'?
SELECT COUNT(DISTINCT t.profId)
FROM Teaching t
INNER JOIN Course c ON c.crscode = t.crscode
WHERE c.title = 'Sorcery'

SELECT COUNT(DISTINCT p.profid)
FROM Professor as p
INNER JOIN Teaching as t
ON p.profId = t.profId 
INNER JOIN Course as c
ON c.crscode = t.crscode
WHERE c.title = 'Sorcery';

-- Show the courses that are not taught this year at all.

SELECT c.title, t.trimester
FROM Course as c
LEFT JOIN Teaching as t
ON c.crscode = t.crscode
WHERE t.trimester IS NULL;

-- Find the student-to-teacher ratio for each of the four houses
 
-- subquery
 
SELECT querya.HouseName, (CAST(queryb.Students AS float) / CAST(querya.Teachers AS float)) as Ratio
    FROM
    (SELECT
          house.name AS HouseName,
          COUNT(Professor.profid) AS Teachers
     FROM Professor,
          House
     WHERE
	      Professor.houseid = House.houseid
     GROUP BY
	      house.name) as querya,
     (SELECT
          house.name AS HouseName,
          COUNT(Student.studid) AS Students
     FROM House,
          Student
     WHERE
	      Student.houseid = House.houseid
     GROUP BY
	      house.name) as queryb
WHERE querya.HouseName = queryb.HouseName;
