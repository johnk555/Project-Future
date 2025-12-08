CREATE TABLE House (
	houseId INT,
	name NVARCHAR(20),
	PRIMARY KEY (houseId)
);
 
CREATE TABLE Professor (
	profId INT,
	fname NVARCHAR(15),
	lname NVARCHAR(20),
	houseId INT,
	PRIMARY KEY (profId),
	FOREIGN KEY (houseId) REFERENCES House (houseId)
);
 
CREATE TABLE Course (
	crscode NVARCHAR(3),
	title NVARCHAR(30),
	PRIMARY KEY (crscode)
);
 
CREATE TABLE Student (
	studId INT,
	fname NVARCHAR(15),
	lname NVARCHAR(20),
	gender NVARCHAR(2),
	houseId INT,
	age INT,
	magic INT
	PRIMARY KEY (studId),
	FOREIGN KEY (houseId) REFERENCES House (houseId)
);
 
CREATE TABLE Teaching (
	teachId INT,
	profId INT,
	crscode NVARCHAR(3),
	trimester NVARCHAR(10),
	PRIMARY KEY (teachId),
	FOREIGN KEY (profId) REFERENCES Professor (profId),
	FOREIGN KEY (crscode) REFERENCES Course (crscode)
);

INSERT INTO House VALUES 
	 (1, 'Mullinder')
	,(2, 'Dervonhouse')
	,(3, 'Collingshore')
	,(4, 'Leviticus')
	;
 
	INSERT INTO Professor VALUES (10, 'Titus', 'Rackmore', 1)	
	,(11, 'Ominus', 'Stills', 4)
	,(12, 'Mattheus', 'Rogon', 1)
	,(13, 'Fitzroy', 'Lumber', 1)
	,(14, 'Noxius', 'Matin', 1)
	,(15, 'Antina', 'Verotious', 1)
	,(16, 'Finnister', 'Doogle', 2)
	,(17, 'Nastix', 'Remundus', 3)
	,(18, 'Homer', 'Horronic', 4)
	,(19, 'Sherpi', 'Mardeth', 3)
	,(20, 'Crisis', 'Attak', 2)
	,(21, 'Enemius', 'Jupiter', 3)
	,(22, 'Ivy', 'Badder', 2)
	,(23, 'Litmus', 'Nephertus', 1)
	;

 
INSERT INTO Course VALUES ('MBA', 'Magic Basics')
	,('SUP', 'Supreme Beings')
	,('TRA', 'Transformations')
	,('DIV', 'Divine Communication')
	,('SOR', 'Sorcery')
	,('TIM', 'Time Reversal')
	,('WIZ', 'Wizardy Theory')
	,('ANI', 'Animating Objects')
	,('WHI', 'White Spells')
	,('BAT', 'Battle Tactics')
	,('ELE', 'Elements Manipulation')
	,('PRO', 'Protecting the Innocent')
	,('PRA', 'Praying to the Beyond')
	,('COR', 'Core Protection')
	,('REG', 'Regeneration')
	,('MEN', 'Mental Manipulation')
	,('HEA', 'Healing')
	;
 
INSERT INTO Student VALUES (1001, 'Maret', 'Tepin', 'M', 1, 12, 3)
	,(1002, 'Permittus', 'Vosel', 'M', 1, 13, 3)
	,(1003, 'Elinda', 'Firret', 'F', 1, 14, 3)
	,(1004, 'Canyon', 'Dermot', 'M', 1, 14, 3)
	,(1005, 'Zidler', 'Mostor', 'M', 2, 13, 3)
	,(1006, 'Litna', 'Kry', 'F', 2, 10, 3)
	,(1007, 'Lucas', 'Dinner', 'M', 2, 12, 3)
	,(1008, 'Anthea', 'Stiles', 'F', 2, 13, 3)
	,(1009, 'Lucinda', 'Maddlebath', 'F', 2, 12, 3)
	,(1010, 'Elisabeth', 'Wise', 'F', 2, 12, 3)
	,(1011, 'Boris', 'Lineage', 'M', 3, 12, 3)
	,(1012, 'Sommer', 'Quon', 'M', 3, 14, 3)
	,(1013, 'Dana', 'Derry', 'F', 4, 13, 3)
	,(1014, 'Nomo', 'Bernon', 'M', 4, 14, 3)
	,(1015, 'Elke', 'James', 'F', 4, 13, 3)
	,(1016, 'Kimi', 'Ragat', 'M', 4, 15, 3)
	,(1017, 'Zonder', 'Spark', 'M', 4, 14, 3)
	;
 
INSERT INTO Teaching VALUES (810, 21, 'SOR', 'Autumn')
    ,(811, 21, 'ANI', 'Autumn')
    ,(812, 21, 'DIV', 'Autumn')
    ,(813, 11, 'WHI', 'Autumn')
    ,(814, 17, 'WHI', 'Autumn')
    ,(815, 22, 'TIM', 'Autumn')
    ,(816, 15, 'TRA', 'Autumn')
    ,(817, 23, 'WHI', 'Autumn')
    ,(818, 18, 'ELE', 'Winter')
    ,(819, 18, 'SOR', 'Winter')
    ,(820, 18, 'ANI', 'Winter')
    ,(821, 14, 'WHI', 'Winter')
    ,(822, 12, 'TIM', 'Winter')
    ,(823, 11, 'WHI', 'Spring')
    ,(824, 15, 'TRA', 'Spring')
    ,(825, 16, 'WHI', 'Spring')
    ,(826, 22, 'COR', 'Summer')
    ,(827, 12, 'MEN', 'Summer')
    ,(828, 22, 'ANI', 'Summer')
    ,(829, 23, 'REG', 'Summer')
    ,(830, 13, 'HEA', 'Summer')
    ,(831, 23, 'COR', 'Summer')
    ;

	SELECT * FROM Course
