CREATE TABLE Patient (
  p_id SERIAL PRIMARY KEY,
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


--funtion for inserting data into the "appointment" table
CREATE OR REPLACE FUNCTION insert_appointment()
RETURNS trigger AS
$$

    -- Insert data into the "Appointments" table
    declare p_patient_id int;
    declare p_schedule_id int;
    declare p_doctor_reg_id int;

    -- select p_id into p_patient_id from Patient where p_id = NEW.p_id;
    BEGIN
    p_patient_id := NEW.p_id;
	
	SELECT s_id, reg_id into p_schedule_id,p_doctor_reg_id
  	FROM Follow
  	WHERE (s_id, reg_id) NOT IN (SELECT s_id, reg_id FROM Appointments)
  	LIMIT 1;


    -- INSERT INTO Appointments (p_id, s_id, reg_id)
    -- VALUES (p_patient_id, p_schedule_id, p_doctor_reg_id);
     IF p_doctor_reg_id IS NOT NULL AND p_schedule_id IS NOT NULL THEN
        -- Insert the appointment for the new patient
        INSERT INTO Appointments (p_id, s_id, reg_id)
        VALUES (p_patient_id, p_schedule_id, p_doctor_reg_id);
        RAISE NOTICE 'Appointment scheduled successfully for patient %.', p_patient_id;
    ELSE
        RAISE NOTICE 'No available schedule found.';
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insert_appointmentTrigger AFTER INSERT ON Patient
FOR EACH ROW EXECUTE PROCEDURE insert_appointment();

--funtion for inserting data into the "patient" table
CREATE FUNCTION InsertPatient (
    p_gender VARCHAR(10),
    p_name VARCHAR(255),
    p_address VARCHAR(255),
    p_age INT
)
RETURNS INT
AS $$
DECLARE
    num_patients INT;
BEGIN

        -- Insert into the patient table
        INSERT INTO patient ( p_gender, p_name, p_address, p_age)
		VALUES ( p_gender, p_name, p_address, p_age);
   		select count(*) into num_patients from patient;
    RETURN num_patients;
END;
$$ LANGUAGE plpgsql;


--function for inserting data into the "medical_history" table
CREATE FUNCTION InsertHistory (
  h_id INT ,
  p_id INT ,
  date DATE,
  p_condition VARCHAR(255),
  p_surgery VARCHAR(255),
  p_link VARCHAR(255)
)
RETURNS INT
AS $$
DECLARE
    num_his INT;
BEGIN

        -- Insert into the history table
        INSERT INTO  Medical_History(h_id, p_id,date, p_condition, p_surgery, p_link)
		VALUES (h_id, p_id,date, p_condition, p_surgery, p_link);
		   		select count(*) into num_his  from medical_history;
    RETURN num_his ;
END;
$$ LANGUAGE plpgsql;


--funtion for inserting data into the "doctors" table
CREATE FUNCTION InsertDoctor (
  d_reg_id INT ,
  d_name VARCHAR(255) ,
  d_cabin_no INT 
)
RETURNS INT
AS $$
DECLARE
    num_doctors INT;
BEGIN

        -- Insert into the doctor table
        INSERT INTO doctors(d_reg_id,d_name,d_cabin_no)
		VALUES (d_reg_id,d_name,d_cabin_no);
   		select count(*) into num_doctors from doctors;
    RETURN num_doctors;
END;
$$ LANGUAGE plpgsql;
--funtion for inserting data into the "follow" table
CREATE FUNCTION FillFollow (
  s_id INT,
  reg_id INT
)
RETURNS INT
AS $$
DECLARE
    num_follow INT;
BEGIN

        -- Insert into the doctor table
        INSERT INTO follow(s_id,reg_id)
		VALUES (s_id,reg_id);
   		select count(*) into num_follow from follow;
    RETURN num_follow;
END;
$$ LANGUAGE plpgsql;

--funtion for inserting data into the "schedule" table
CREATE OR REPLACE FUNCTION InsertSchedule ()
RETURNS INT
AS $$
DECLARE
    num_schedules INT;
BEGIN

        -- Insert into the schedules table
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
   		select count(*) into num_schedules from schedule;
    RETURN  num_schedules;
END;
$$ LANGUAGE plpgsql;



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