CREATE SCHEMA VehicleBreakdown;
-- PART 1
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20),
    Member_Location VARCHAR(20),
    Member_Age INT
);
CREATE TABLE Vehicle (
    Vehicle_Registration VARCHAR(10) PRIMARY KEY,
    Vehicle_Make VARCHAR(10),
    Vehicle_Model VARCHAR(10),
    Member_ID INT,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID)
);
CREATE TABLE Engineer (
    Engineer_ID INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20)
);
CREATE TABLE Breakdown (
    Breakdown_ID INT PRIMARY KEY,
    Vehicle_Registration VARCHAR(10),
    Engineer_ID INT,
    Breakdown_Date DATE,
    Breakdown_Time TIME,
    Breakdown_Location VARCHAR(20),
    FOREIGN KEY (Vehicle_Registration) REFERENCES Vehicle(Vehicle_Registration),
    FOREIGN KEY (Engineer_ID) REFERENCES Engineer(Engineer_ID)
);
-- PART 2
ALTER TABLE VehicleBreakdown.Vehicle
ADD CONSTRAINT FK_Vehicle_Member
FOREIGN KEY (Member_ID)
REFERENCES VehicleBreakdown.Member(Member_ID);
ALTER TABLE VehicleBreakdown.Breakdown
ADD CONSTRAINT FK_Breakdown_Vehicle
FOREIGN KEY (Vehicle_Registration)
REFERENCES VehicleBreakdown.Vehicle(Vehicle_Registration);

ALTER TABLE VehicleBreakdown.Breakdown
ADD CONSTRAINT FK_Breakdown_Engineer
FOREIGN KEY (Engineer_ID)
REFERENCES VehicleBreakdown.Engineer(Engineer_ID);


INSERT INTO VehicleBreakdown.Member (Member_ID, First_Name, Last_Name, Member_Location, Member_Age)
VALUES
(1, 'John', 'Doe', 'New York', 30),
(2, 'Yonis', 'Abdulahi', 'London', 23),
(3, 'Bob', 'Jones', 'Manchester', 79),
(4, 'Naruto', 'Brown', 'Tokyo', 40),
(5, 'David', 'Davis', 'Paris', 28);
INSERT INTO vehiclebreakdown.vehicle (Member_id,Vehicle_Registration,Vehicle_Make, Vehicle_Model)
VALUES
(1,'ABC123', 'Toyota', 'visa'),
(2,'XYZ789', 'Honda', 'Civic'),
(3,'LMN456', 'Ford', 'Focus'),
(4,'DEF234', 'Lambo', 'Gold'),
(5,'GHI567', 'Nissan', 'Altima'),
(1,'JKL890', 'Hyundai', 'Elantra'),
(3,'MNO345', 'BMX', 'ACLASS'),
(4,'PQR678', 'Subaru', 'Impreza');
INSERT INTO vehiclebreakdown.engineer (Engineer_id,first_name,last_name)
VALUES
(1,'Kaladin','robb'),
(2,'shallan','patrick'),
(3,'Dalinar','joe');
INSERT INTO VehicleBreakdown.Breakdown (Breakdown_ID, Vehicle_Registration, Engineer_ID, Breakdown_Date, Breakdown_Location)
VALUES
-- Two breakdowns on the same day
(1, 'ABC123', 1, '2024-08-15', 'New York'),
(2, 'JKL890', 2, '2024-08-15', 'New York'),
-- Three breakdowns in the same month (August)
(3, 'XYZ789', 3, '2024-08-05', 'London'),
(4, 'PQR678', 1, '2024-08-25', 'Tokyo'),
(5, 'MNO345', 2, '2024-08-12', 'Manchester'),
-- Vehicles breaking down more than once
(6, 'LMN456', 2, '2024-05-10', 'Manchester'),
(7, 'DEF234', 3, '2024-07-20', 'Tokyo'),
(8, 'GHI567', 1, '2024-06-12', 'Paris'),
(9, 'ABC123', 3, '2024-06-25', 'New York'),
(10, 'GHI567', 1, '2024-08-02', 'Paris'),
(11, 'MNO345', 2, '2024-06-15', 'Manchester'),
(12, 'GHI567', 3, '2024-06-30', 'Paris' );

-- TASK 3 QUESTIONS 
-- Retrieve the first 3 members from the Member table.
SELECT * FROM MEMBER LIMIT 3;
-- Retrieve 3 members, skipping the first 2.
SELECT * FROM MEMBER 
WHERE member_ID BETWEEN 2 AND 5;
-- Retrieve all vehicles whose Vehicle_Make starts with 'T'.
SELECT * FROM vehicle WHERE Vehicle_Make LIKE 'T%';
-- Retrieve all breakdowns that occurred between '2023-01-01' and '2023-06-30'.
SELECT * FROM breakdown 
WHERE Breakdown_date BETWEEN '2023-01-01' and '2023-06-30';
-- Retrieve details of  vehicles with three Vehicle_Registration of you own choice in the list –  for example vehicles with registration 'ABC123', 'XYZ789', 'ANZ789'.
SELECT * FROM vehicle
WHERE Vehicle_Registration IN ('GHI567','ABC123','MNO345');
-- Retrieve the number of breakdowns each vehicle has had.
SELECT Vehicle_Registration, COUNT(*) AS Number_of_Breakdowns FROM Breakdown GROUP BY Vehicle_Registration;
-- Retrieve all members sorted by Member_Age in descending order
SELECT * FROM member ORDER BY Member_Age;
-- Retrieve all vehicles that are either 'Toyota' make or 'Honda' make, and the model starts with 'C’
SELECT *FROM vehicle WHERE (Vehicle_Make = 'Toyota' OR Vehicle_Make = 'Honda')
AND Vehicle_Model LIKE 'C%';
-- Retrieve all engineers who do not have any breakdowns assigned (use LEFT JOIN and IS NULL)
SELECT vehiclebreakdown.engineer.*
FROM vehiclebreakdown.engineer
LEFT JOIN VehicleBreakdown.Breakdown 
ON vehiclebreakdown.engineer.Engineer_id = VehicleBreakdown.Breakdown.Engineer_ID
WHERE VehicleBreakdown.Breakdown.Engineer_ID IS NULL;
-- Retrieve all members aged between 25 and 40
SELECT * FROM MEMBER 
WHERE member_age BETWEEN 25 AND 40;
-- Retrieve all members whose First_Name starts with 'J' and Last_Name contains 'son'
SELECT * FROM vehiclebreakdown.member WHERE First_Name LIKE 'J%'AND Last_Name LIKE '%son%'; ;
-- Retrieve the top 5 oldest members.
SELECT* FROM MEMBER ORDER BY member_age DESC LIMIT 5;
-- Retrieve all vehicle registrations in uppercase.
SELECT UPPER(vehicle_registration) AS vehicle_registration_IN_ALLCAPS FROM vehicle;
-- Retrieve the details of all members along with the vehicles they own.
SELECT 
    m.Member_ID,
    m.First_Name,
    m.Last_Name,
    m.Member_Location,
    m.Member_Age,
    v.Vehicle_Registration,
    v.Vehicle_Make,
    v.Vehicle_Model
FROM Member m LEFT JOIN  Vehicle v ON m.Member_ID = v.Member_ID ;
-- Retrieve all members and any associated vehicles, including members who do not own any vehicles.
SELECT 
    m.Member_ID,
    m.First_Name,
    m.Last_Name,
    m.Member_Location,
    m.Member_Age,
    v.Vehicle_Registration,
    v.Vehicle_Make,
    v.Vehicle_Model
FROM Member m LEFT JOIN  Vehicle v ON m.Member_ID = v.Member_ID ;
-- Retrieve all vehicles and the associated members, including vehicles that are not owned by any members
SELECT 
    m.Member_ID,
    m.First_Name,
    m.Last_Name,
    m.Member_Location,
    m.Member_Age,
    v.Vehicle_Registration,
    v.Vehicle_Make,
    v.Vehicle_Model
FROM Member m LEFT JOIN  Vehicle v ON m.Member_ID = v.Member_ID ;
-- Retrieve the number of breakdowns each member has had
SELECT 
    m.Member_ID,
    m.First_Name,
    m.Last_Name,
    COUNT(b.Breakdown_ID) AS NumberOfBreakdowns
FROM 
    Member m
LEFT JOIN 
    Vehicle v ON m.Member_ID = v.Member_ID
LEFT JOIN 
    Breakdown b ON v.Vehicle_Registration = b.Vehicle_Registration
GROUP BY 
    m.Member_ID, 
    m.First_Name, 
    m.Last_Name;
-- Retrieve all breakdowns along with member first name and last name that occurred for vehicles owned by members aged over 50
SELECT 
    b.Breakdown_ID,
    b.Vehicle_Registration,
    b.Engineer_ID,
    b.Breakdown_Date,
    b.Breakdown_Location,
    m.First_Name,
    m.Last_Name
FROM 
    Breakdown b
JOIN 
    Vehicle v ON b.Vehicle_Registration = v.Vehicle_Registration
JOIN 
    Member m ON v.Member_ID = m.Member_ID
WHERE 
    m.Member_Age > 50;
-- TASK 5 EXPLAIN AVG,MIN,MAX AND SUM and examples 
-- The MIN() function gives us  the smallest value of a column.
SELECT  MIN(Member_Age) FROM MEMBER;
-- The MAX() function gives us the largest value of a column.
SELECT MAX(Member_Age) FROM MEMBER;
-- SUM RETURNS THE SUM OF VALUES FROM A COLUMN
SELECT SUM(BREAKDOWN_ID) FROM BREAKDOWN;
-- AVG RETURNS THE AVERAGE OF A VALUE FROM A COLUMN
SELECT AVG(MEMBER_ID) FROM vehicle;
-- TASK 6 
-- Update 3 records of your own choice from the Engineer table.
UPDATE engineer
SET Last_name="changes";
SELECT* FROM engineer;
-- Delete 2 records or your own choice from the breakdown table.
DELETE  FROM breakdown;
SELECT* FROM breakdown;
-- ZakirullahP@justit.co.uk SEND THIS FILE TO ZAC
