CREATE TABLE Patient (
  p_id INT PRIMARY KEY,
  p_gender VARCHAR(10) ,
  p_name VARCHAR(255) not null,
  p_address VARCHAR(255),
  p_age INT not null
);

CREATE TABLE Medical_History (
  h_id INT ,
  p_id INT ,
  date DATE,
  p_condition VARCHAR(255),
  p_surgery VARCHAR(255),
  p_link VARCHAR(255),
  PRIMARY KEY (h_id,p_id),
  FOREIGN KEY (p_id) REFERENCES Patient(p_id)
);



CREATE TABLE Schedule (
  s_id INT PRIMARY KEY,
  Start_Time TIME not null,
  End_Time TIME not null
);

CREATE TABLE Doctors (
  d_reg_id INT PRIMARY KEY,
  d_name VARCHAR(255) not null,
  d_cabin_no INT not null
);


CREATE TABLE Appointments (
  p_id INT,
  s_id INT,
  reg_id INT,
  PRIMARY KEY (p_id,s_id,reg_id),
  FOREIGN KEY (p_id) REFERENCES Patient(p_id),
  FOREIGN KEY (s_id) REFERENCES Schedule(s_id),
  FOREIGN KEY (reg_id) REFERENCES Doctors(d_reg_id)
);

CREATE TABLE Follow (
  s_id INT,
  reg_id INT,
  PRIMARY KEY (reg_id,s_id),
  FOREIGN KEY (s_id) REFERENCES Schedule(s_id),
  FOREIGN KEY (reg_id) REFERENCES Doctors(d_reg_id)
);

INSERT INTO Patient (p_id, p_gender, p_name, p_address, p_age)
VALUES
  (1, 'Male', 'John Doe', '123 Main St, Cityville', 30),
  (2, 'Female', 'Jane Smith', '456 Oak St, Townsville', 25),
  (3, 'Male', 'Bob Johnson', '789 Pine St, Villagetown', 40),
  (4, 'Female', 'Alice Brown', '101 Maple St, Hamletville', 35),
  (5, 'Male', 'Charlie Wilson', '202 Cedar St, Countryside', 28),
  (6, 'Female', 'Eva Davis', '303 Elm St, Suburbia', 45),
  (7, 'Male', 'Sam Turner', '404 Birch St, Outskirts', 55),
  (8, 'Female', 'Olivia White', '505 Spruce St, Ruralville', 22),
  (9, 'Male', 'Michael Lee', '606 Fir St, Farmland', 33),
  (10, 'Female', 'Grace Martinez', '707 Redwood St, Meadowland', 29);

INSERT INTO Medical_History (h_id, p_id, date, p_condition, p_surgery, p_link)
VALUES
  (1, 1, '2023-01-10', 'Hypertension', 'None', 'https://link1.com'),
  (2, 2, '2023-02-15', 'Diabetes', 'Appendectomy', 'https://link2.com'),
  (3, 3, '2023-03-20', 'Allergies', 'None', 'https://link3.com'),
  (4, 4, '2023-04-25', 'Asthma', 'Knee Replacement', 'https://link4.com'),
  (5, 5, '2023-05-30', 'Migraine', 'None', 'https://link5.com'),
  (6, 6, '2023-06-05', 'Arthritis', 'None', 'https://link6.com'),
  (7, 7, '2023-07-15', 'Heart Disease', 'Bypass Surgery', 'https://link7.com'),
  (8, 8, '2023-08-20', 'Thyroid Disorder', 'None', 'https://link8.com'),
  (9, 9, '2023-09-25', 'Depression', 'None', 'https://link9.com'),
  (10, 10, '2023-10-30', 'Chronic Pain', 'None', 'https://link10.com');

INSERT INTO Schedule (s_id, Start_Time, End_Time)
VALUES
  (1, '00:00:00', '01:00:00'),
  (2, '01:00:00', '02:00:00'),
  (3, '02:00:00', '03:00:00'),
  (4, '03:00:00', '04:00:00'),
  (5, '04:00:00', '05:00:00'),
  (6, '05:00:00', '06:00:00'),
  (7, '06:00:00', '07:00:00'),
  (8, '07:00:00', '08:00:00'),
  (9, '08:00:00', '09:00:00'),
  (10, '09:00:00', '10:00:00'),
  (11, '10:00:00', '11:00:00'),
  (12, '11:00:00', '12:00:00'),
  (13, '12:00:00', '13:00:00'),
  (14, '13:00:00', '14:00:00'),
  (15, '14:00:00', '15:00:00'),
  (16, '15:00:00', '16:00:00'),
  (17, '16:00:00', '17:00:00'),
  (18, '17:00:00', '18:00:00'),
  (19, '18:00:00', '19:00:00'),
  (20, '19:00:00', '20:00:00'),
  (21, '20:00:00', '21:00:00'),
  (22, '21:00:00', '22:00:00'),
  (23, '22:00:00', '23:00:00'),
  (24, '23:00:00', '00:00:00');

INSERT INTO Doctors (d_reg_id, d_name, d_cabin_no)
VALUES
  (101, 'Dr. Smith', 1),
  (102, 'Dr. Johnson', 2),
  (103, 'Dr. Brown', 3),
  (104, 'Dr. White', 4),
  (105, 'Dr. Davis', 5),
  (106, 'Dr. Turner', 6),
  (107, 'Dr. Martinez', 7),
  (108, 'Dr. Lee', 8),
  (109, 'Dr. Wilson', 9),
  (110, 'Dr. Turner', 10);

INSERT INTO Appointments (p_id, s_id, reg_id)
VALUES
  (1, 1, 101),
  (2, 2, 102),
  (3, 3, 103),
  (4, 4, 104),
  (5, 5, 105),
  (6, 6, 106),
  (7, 7, 107),
  (8, 8, 108),
  (9, 9, 109),
  (10, 10, 110);

INSERT INTO Follow (s_id, reg_id)
VALUES
  (1, 101),
  (2, 101),
  (3, 101),
  (4, 101),
  (2, 102),
  (3, 102),
  (4, 102),
  (5, 102),
  (6, 102),
  (4, 103),
  (5, 103),
  (6, 103),
  (7, 103),
  (8, 101),
  (9, 101),
  (10, 101),
  (11, 102),
  (12, 102),
  (13, 102),
  (10, 104),
  (11, 104),
  (12, 104),
  (13, 104),
  (14, 104),
  (15, 105),
  (16, 105),
  (13, 106),
  (14, 106),
  (15, 106),
  (16, 106),
  (12, 107),
  (13, 108),
  (14, 109),
  (15, 109),
  (15, 110),
  (16, 110),
  (17, 110),
  (17, 105),
  (18, 105),
  (16, 107),
  (17, 107),
  (18, 107),
  (19, 107),
  (20, 107),
  (21, 108),
  (22, 108),
  (23, 108),
  (24, 108)
  ;