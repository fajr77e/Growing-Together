DROP DATABASE IF EXISTS greenpath_db;
CREATE DATABASE greenpath_db;
USE greenpath_db;

-- 1. Users table
CREATE TABLE users (
    userID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role ENUM('Admin', 'Volunteer') NOT NULL
);
 ALTER TABLE users ADD COLUMN firstName VARCHAR(50) AFTER userID;
ALTER TABLE users ADD COLUMN lastName VARCHAR(50) AFTER firstName;

UPDATE users SET firstName = SUBSTRING_INDEX(name, ' ', 1), lastName = SUBSTRING_INDEX(name, ' ', -1);
ALTER TABLE users DROP COLUMN name;

INSERT INTO users (userID, firstName, lastName, email, password, phone, role) VALUES
(1000, 'Fajr', 'Al-Assaf', 'fajr.alassaf@greenpath.com', 'admin123', '0501001000', 'Admin'),
(1001, 'Layal', 'Al-Tamimi', 'layal.altamimi@greenpath.com', 'admin123', '0501001001', 'Admin'),
(1002, 'Shaden', 'Al-Gamdie', 'shaden.algamdie@greenpath.com', 'admin123', '0501001002', 'Admin'),
(1003, 'Razan', 'Sahli', 'razan.sahli@greenpath.com', 'vol123', '0501001003', 'Volunteer'),
(1004, 'Fatima', 'Al-Taher', 'fatima.altaher@greenpath.com', 'vol123', '0501001004', 'Volunteer'),
(1005, 'Nora', 'Al-Dosari', 'nora.dosari@greenpath.com', 'vol123', '0501001005', 'Volunteer'),
(1006, 'Khalid', 'Al-Harbi', 'khalid.harbi@greenpath.com', 'vol123', '0501001006', 'Volunteer'),
(1007, 'Sarah', 'Al-Anazi', 'sarah.anazi@greenpath.com', 'vol123', '0501001007', 'Volunteer'),
(1008, 'Omar', 'Al-Shammari', 'omar.shammari@greenpath.com', 'vol123', '0501001008', 'Volunteer'),
(1009, 'Laila', 'Al-Balawi', 'laila.balawi@greenpath.com', 'vol123', '0501001009', 'Volunteer');


 CREATE TABLE locations (
    locationID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

INSERT INTO locations (locationID, name, city) VALUES
(2000, 'King Abdullah Park', 'Riyadh'),
(2001, 'Al-Mamzar Beach Park', 'Jeddah'),
(2002, 'Al-Shallal Theme Park', 'Jeddah'),
(2003, 'King Fahd Park', 'Dammam'),
(2004, 'Al-Salam Park', 'Abha'),
(2005, 'Al-Faisaliah Garden', 'Taif'),
(2006, 'Corniche Park', 'Yanbu'),
(2007, 'Al-Ula Heritage Site', 'Al-Ula'),
(2008, 'Palm Beach Resort', 'Al-Khobar'),
(2009, 'Desert Rose Garden', 'Hail');
CREATE TABLE campaigns (
    campaignID INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    date DATE NOT NULL,
    target INT NOT NULL,
    status ENUM('Active', 'Completed', 'Cancelled') DEFAULT 'Active',
    supervisorID INT NOT NULL,
    locationID INT NOT NULL,
    FOREIGN KEY (supervisorID) REFERENCES users(userID) ON DELETE CASCADE,
    FOREIGN KEY (locationID) REFERENCES locations(locationID) ON DELETE CASCADE
);

INSERT INTO campaigns (campaignID, title, date, target, status, supervisorID, locationID) VALUES
(3000, 'Riyadh Greening Initiative', '2025-01-15', 500, 'Completed', 1000, 2000),
(3001, 'Jeddah Coastal Cleanup', '2025-02-20', 1000, 'Completed', 1001, 2001),
(3002, 'Dammam Forest Project', '2025-03-10', 750, 'Completed', 1002, 2003),
(3003, 'Abha Mountain Planting', '2025-04-05', 800, 'Active', 1000, 2004),
(3004, 'Taif Rose Revival', '2025-05-12', 600, 'Active', 1001, 2005),
(3005, 'Yanbu Waterfront Trees', '2025-06-18', 900, 'Active', 1002, 2006),
(3006, 'Al-Ula Heritage Forest', '2025-07-22', 400, 'Active', 1000, 2007),
(3007, 'Khobar Palm Project', '2025-08-30', 700, 'Active', 1001, 2008),
(3008, 'Hail Desert Bloom', '2025-09-14', 300, 'Active', 1002, 2009),
(3009, 'Year End Mega Campaign', '2025-12-01', 2000, 'Completed', 1000, 2000);

CREATE TABLE trees (
    treeID INT PRIMARY KEY,
    treeType VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    plantedBy INT NOT NULL,
    campaignID INT NOT NULL,
    locationID INT NOT NULL,
    FOREIGN KEY (plantedBy) REFERENCES users(userID) ON DELETE CASCADE,
    FOREIGN KEY (campaignID) REFERENCES campaigns(campaignID) ON DELETE CASCADE,
    FOREIGN KEY (locationID) REFERENCES locations(locationID) ON DELETE CASCADE
);

INSERT INTO trees (treeID, treeType, quantity, plantedBy, campaignID, locationID) VALUES
(4000, 'Neem Tree', 120, 1003, 3000, 2000),
(4001, 'Sidr Tree', 85, 1004, 3000, 2001),
(4002, 'Olive Tree', 200, 1005, 3001, 2002),
(4003, 'Palm Tree', 150, 1006, 3001, 2003),
(4004, 'Acacia Tree', 95, 1007, 3002, 2004),
(4005, 'Ghaf Tree', 110, 1008, 3002, 2005),
(4006, 'Jacaranda', 65, 1009, 3003, 2006),
(4007, 'Bougainvillea', 180, 1003, 3003, 2007),
(4008, 'Frangipani', 75, 1004, 3004, 2008),
(4009, 'Moringa Tree', 130, 1005, 3004, 2009);

CREATE TABLE volunteer_registrations (
    registrationID INT PRIMARY KEY,
    campaignID INT NOT NULL,
    volunteerID INT NOT NULL,
    registeredAt DATE NOT NULL,
    FOREIGN KEY (campaignID) REFERENCES campaigns(campaignID) ON DELETE CASCADE,
    FOREIGN KEY (volunteerID) REFERENCES users(userID) ON DELETE CASCADE,
    UNIQUE KEY unique_registration (campaignID, volunteerID)
);

INSERT INTO volunteer_registrations (registrationID, campaignID, volunteerID, registeredAt) VALUES
(5000, 3000, 1003, '2025-01-01'),
(5001, 3000, 1004, '2025-01-02'),
(5002, 3001, 1005, '2025-02-10'),
(5003, 3001, 1006, '2025-02-12'),
(5004, 3002, 1007, '2025-03-01'),
(5005, 3002, 1008, '2025-03-03'),
(5006, 3003, 1009, '2025-03-25'),
(5007, 3003, 1003, '2025-03-28'),
(5008, 3004, 1004, '2025-05-01'),
(5009, 3004, 1005, '2025-05-02');

CREATE TABLE tree_status (
    logID INT PRIMARY KEY,
    treeID INT NOT NULL,
    reportedBy INT NOT NULL,
    reportedDate DATE NOT NULL,
    healthStatus ENUM('Healthy', 'Not Watered', 'Dead') NOT NULL,
    FOREIGN KEY (treeID) REFERENCES trees(treeID) ON DELETE CASCADE,
    FOREIGN KEY (reportedBy) REFERENCES users(userID) ON DELETE CASCADE
);

INSERT INTO tree_status (logID, treeID, reportedBy, reportedDate, healthStatus) VALUES
(6000, 4000, 1003, '2025-02-01', 'Healthy'),
(6001, 4001, 1004, '2025-02-15', 'Healthy'),
(6002, 4002, 1005, '2025-03-10', 'Healthy'),
(6003, 4003, 1006, '2025-03-20', 'Not Watered'),
(6004, 4004, 1007, '2025-04-05', 'Healthy'),
(6005, 4005, 1008, '2025-04-18', 'Not Watered'),
(6006, 4006, 1009, '2025-05-01', 'Healthy'),
(6007, 4007, 1003, '2025-05-10', 'Dead'),
(6008, 4008, 1004, '2025-05-20', 'Healthy'),
(6009, 4009, 1005, '2025-06-01', 'Healthy');

-- View with computed column (total trees per campaign)
CREATE VIEW CampaignPerformance AS
SELECT 
    c.campaignID,
    c.title,
    c.target,
    IFNULL(SUM(t.quantity), 0) AS trees_planted,  -- computed column
    (IFNULL(SUM(t.quantity), 0) / c.target) * 100 AS completion_percentage  -- computed column
FROM campaigns c
LEFT JOIN trees t ON c.campaignID = t.campaignID
GROUP BY c.campaignID, c.title, c.target;

ALTER TABLE users DROP COLUMN name;
ALTER TABLE users ADD COLUMN firstName VARCHAR(50) NOT NULL AFTER userID;
ALTER TABLE users ADD COLUMN lastName VARCHAR(50) NOT NULL AFTER firstName;


UPDATE users SET firstName = 'Fajr', lastName = 'Al-Assaf' WHERE userID = 1000;
UPDATE users SET firstName = 'Layal', lastName = 'Al-tamimi' WHERE userID = 1001;
UPDATE users SET firstName = 'Shaden', lastName = 'Al-ghamdi' WHERE userID = 1002;
UPDATE users SET firstName = 'Razan', lastName = 'Sahli' WHERE userID = 1003;
UPDATE users SET firstName = 'Fatima', lastName = 'Al-Taher' WHERE userID = 1004;
UPDATE users SET firstName = 'Nora', lastName = 'Al-Dosari' WHERE userID = 1005;
UPDATE users SET firstName = 'Khalid', lastName = 'Al-Harbi' WHERE userID = 1006;
UPDATE users SET firstName = 'Sarah', lastName = 'Al-Anazi' WHERE userID = 1007;
UPDATE users SET firstName = 'Omar', lastName = 'Al-Shammari' WHERE userID = 1008;
UPDATE users SET firstName = 'Laila', lastName = 'Al-Balawi' WHERE userID = 1009;


CREATE TABLE user_profiles (
    profileID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT UNIQUE NOT NULL,
    bio TEXT,
    profilePicture VARCHAR(255),
    joinDate DATE NOT NULL,
    points INT DEFAULT 0,
    FOREIGN KEY (userID) REFERENCES users(userID) ON DELETE CASCADE
);

INSERT INTO user_profiles (userID, bio, joinDate, points) VALUES
(1000, 'Lead Administrator - Fajr Al-Assaf', '2024-01-15', 500),
(1001, 'Co-Administrator - Layal Al-Tamimi', '2024-02-20', 450),
(1002, 'Senior Administrator - Shaden Al-Gamdie', '2024-03-10', 480),
(1003, 'Active volunteer - Razan Sahli', '2024-04-05', 300),
(1004, 'Tree planting expert - Fatima Al-Taher', '2024-05-12', 280),
(1005, 'Environmental activist - Nora Al-Dosari', '2024-06-18', 350),
(1006, 'Dedicated volunteer - Khalid Al-Harbi', '2024-07-22', 150),
(1007, 'Regular reporter - Sarah Al-Anazi', '2024-08-30', 200),
(1008, 'Team leader - Omar Al-Shammari', '2024-09-14', 250),
(1009, 'Active member - Laila Al-Balawi', '2024-10-01', 180);

CREATE TABLE volunteer_skills (
    skillID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    skill VARCHAR(50) NOT NULL,
    FOREIGN KEY (userID) REFERENCES users(userID) ON DELETE CASCADE
);

INSERT INTO volunteer_skills (userID, skill) VALUES
(1003, 'Planting'),
(1003, 'Irrigation'),
(1003, 'Tree Maintenance'),
(1004, 'Pruning'),
(1004, 'Monitoring'),
(1004, 'Reporting'),
(1005, 'Planting'),
(1005, 'Seeding'),
(1005, 'Irrigation'),
(1006, 'Pruning'),
(1006, 'Tree Identification'),
(1007, 'Planting'),
(1007, 'Reporting'),
(1007, 'Data Entry'),
(1008, 'Team Leading'),
(1008, 'Planting'),
(1008, 'Training'),
(1009, 'Irrigation'),
(1009, 'Monitoring'),
(1009, 'Field Work');

CREATE TABLE tree_log (
    logID INT NOT NULL,
    treeID INT NOT NULL,
    changeDate DATE NOT NULL,
    oldStatus VARCHAR(20),
    newStatus VARCHAR(20) NOT NULL,
    changedBy INT NOT NULL,
    PRIMARY KEY (logID, treeID),
    FOREIGN KEY (treeID) REFERENCES trees(treeID) ON DELETE CASCADE,
    FOREIGN KEY (changedBy) REFERENCES users(userID)
);


INSERT INTO tree_log (logID, treeID, changeDate, oldStatus, newStatus, changedBy) VALUES
(1, 4000, '2025-02-01', NULL, 'Healthy', 1003),
(1, 4001, '2025-02-15', NULL, 'Healthy', 1004),
(1, 4002, '2025-03-10', NULL, 'Healthy', 1005),
(1, 4003, '2025-03-20', NULL, 'Not Watered', 1006),
(1, 4004, '2025-04-05', NULL, 'Healthy', 1007),
(1, 4005, '2025-04-18', NULL, 'Not Watered', 1008),
(1, 4006, '2025-05-01', NULL, 'Healthy', 1009),
(1, 4007, '2025-05-10', NULL, 'Dead', 1003),
(1, 4008, '2025-05-20', NULL, 'Healthy', 1004),
(1, 4009, '2025-06-01', NULL, 'Healthy', 1005);


DELIMITER //
CREATE TRIGGER after_tree_status_update
AFTER UPDATE ON tree_status
FOR EACH ROW
BEGIN
    DECLARE last_logID INT;
    
    SELECT IFNULL(MAX(logID), 0) + 1 INTO last_logID 
    FROM tree_log WHERE treeID = NEW.treeID;
INSERT INTO tree_log (logID, treeID, changeDate, oldStatus, newStatus, changedBy)
    VALUES (last_logID, NEW.treeID, CURDATE(), OLD.healthStatus, NEW.healthStatus, NEW.reportedBy);
END //
DELIMITER ;




CREATE VIEW campaign_performance AS
SELECT 
    c.campaignID,
    c.title,
    CONCAT(u.firstName, ' ', u.lastName) AS supervisor_name,
    c.target,
    IFNULL(SUM(t.quantity), 0) AS trees_planted,
    ROUND((IFNULL(SUM(t.quantity), 0) / c.target) * 100, 2) AS completion_percentage,
    COUNT(DISTINCT vr.volunteerID) AS volunteer_count
FROM campaigns c
LEFT JOIN users u ON c.supervisorID = u.userID
LEFT JOIN trees t ON c.campaignID = t.campaignID
LEFT JOIN volunteer_registrations vr ON c.campaignID = vr.campaignID
GROUP BY c.campaignID, c.title, c.target;


SELECT * FROM user_profiles;

SELECT u.firstName, u.lastName, vs.skill
FROM users u
JOIN volunteer_skills vs ON u.userID = vs.userID
ORDER BY u.userID;

SELECT * FROM tree_log;

SELECT * FROM campaign_performance;

SELECT * FROM users;
SELECT * FROM trees;
SELECT * FROM tree_status;
SELECT * FROM volunteer_registrations;
SELECT * FROM campaigns;
SELECT * FROM locations;

-- Insert
INSERT INTO users (userID, name, email, password, phone, role) 
VALUES (1010, 'Nouf Al-Harbi', 'nouf.harbi@greenpath.com', 'admin123', '0501010101', 'Admin');

INSERT INTO campaigns (campaignID, title, date, target, status, supervisorID, locationID) 
VALUES (3010, 'Eastern Province Greening', '2025-10-15', 1500, 'Active', 1000, 2008);

-- Delete
DELETE FROM trees WHERE treeID = 4010;
DELETE FROM users WHERE userID = 1010;


-- Update 
UPDATE tree_status SET healthStatus = 'Not Watered' WHERE treeID = 4000;
UPDATE users SET phone = '0509999999' WHERE userID = 1003;

-- Select
SELECT * FROM users WHERE role = 'Volunteer';
SELECT * FROM trees WHERE plantedBy = 1000;

-- Find
SELECT * FROM users WHERE name LIKE 'F%';
SELECT * FROM locations WHERE city LIKE '%h';

--  between
SELECT * FROM users
WHERE userID BETWEEN 1000 AND 1005;
SELECT * FROM campaigns 
WHERE target BETWEEN 500 AND 1000;


-- Find  IN specific --
SELECT * FROM users 
WHERE userID IN (1003, 1004, 1005, 1006);
SELECT * FROM trees 
WHERE campaignID IN (3000, 3001, 3002);

-- Find trees with no status reports
SELECT t.* FROM trees t
LEFT JOIN tree_status ts ON t.treeID = ts.treeID
WHERE ts.logID IS NULL;

-- Find campaigns with no trees planted
SELECT c.* FROM campaigns c
LEFT JOIN trees t ON c.campaignID = t.campaignID
WHERE t.treeID IS NULL;

-- Order by
SELECT * FROM campaigns ORDER BY date DESC;
SELECT * FROM campaigns ORDER BY target DESC;

-- Get unique tree types
SELECT DISTINCT treeType FROM trees;
SELECT DISTINCT city FROM locations;

-- Union of campaign titles and location names
SELECT title AS name, 'Campaign' AS type FROM campaigns
UNION
SELECT name, 'Location' AS type FROM locations;


-- Average target per status
SELECT 
    status,
    AVG(target) AS average_target,
    COUNT(*) AS campaign_count
FROM campaigns
GROUP BY status;

-- Maximum and minimum trees planted per campaign
SELECT 
    campaignID,
    MAX(quantity) AS max_trees_type,
    MIN(quantity) AS min_trees_type,
    SUM(quantity) AS total_trees
FROM trees
GROUP BY campaignID
HAVING SUM(quantity) > 100;

-- Natural join between trees and tree_status
SELECT * FROM trees NATURAL JOIN tree_status;
-- Natural join between users and volunteer_registrations
SELECT * FROM users NATURAL JOIN volunteer_registrations;

-- Find volunteers who planted trees in Riyadh
SELECT DISTINCT u.name, u.email
FROM users u
WHERE u.userID IN (
    SELECT t.plantedBy
    FROM trees t
    WHERE t.locationID IN (
        SELECT l.locationID
        FROM locations l
        WHERE l.city = 'Riyadh'
    )
);

-- Find campaigns with no volunteers registered
SELECT c.title, c.date
FROM campaigns c
WHERE c.campaignID NOT IN (
    SELECT DISTINCT vr.campaignID
    FROM volunteer_registrations vr
);

-- Get campaigns by status
DELIMITER //
CREATE PROCEDURE GetCampaignsByStatus(IN campaignStatus VARCHAR(20))
BEGIN
    SELECT * FROM campaigns WHERE status = campaignStatus;
END //
DELIMITER ;

CALL GetCampaignsByStatus('Active');

 --Calculate total trees in a campaign
DELIMITER //
CREATE FUNCTION GetCampaignTotalTrees(campaignID INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT IFNULL(SUM(quantity), 0) INTO total
    FROM trees
    WHERE trees.campaignID = campaignID;
    RETURN total;
END //
DELIMITER ;
SELECT GetCampaignTotalTrees(3000);

-- View Volunteer Activity Report
CREATE VIEW VolunteerActivity AS
SELECT 
    u.userID,
    u.name,
    u.email,
    u.phone,
    COUNT(DISTINCT vr.campaignID) AS campaigns_joined,
    IFNULL(SUM(t.quantity), 0) AS trees_planted,
    COUNT(DISTINCT ts.logID) AS status_reports
FROM users u
LEFT JOIN volunteer_registrations vr ON u.userID = vr.volunteerID
LEFT JOIN trees t ON u.userID = t.plantedBy
LEFT JOIN tree_status ts ON u.userID = ts.reportedBy
WHERE u.role = 'Volunteer'
GROUP BY u.userID, u.name, u.email, u.phone;

-- Trigger Prevent deleting admin if only one left
DELIMITER //
CREATE TRIGGER PreventLastAdminDelete
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    DECLARE admin_count INT;
    
    IF OLD.role = 'Admin' THEN
        SELECT COUNT(*) INTO admin_count FROM users WHERE role = 'Admin' AND userID != OLD.userID;
        IF admin_count = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete the last admin';
        END IF;
    END IF;
END //
DELIMITER ;

-- View with computed column (total trees per campaign)
CREATE VIEW CampaignPerformance AS
SELECT 
    c.campaignID,
    c.title,
    c.target,
    IFNULL(SUM(t.quantity), 0) AS trees_planted,  -- computed column
    (IFNULL(SUM(t.quantity), 0) / c.target) * 100 AS completion_percentage  -- computed column
FROM campaigns c
LEFT JOIN trees t ON c.campaignID = t.campaignID
GROUP BY c.campaignID, c.title, c.target;