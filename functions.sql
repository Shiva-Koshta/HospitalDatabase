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
    p_id INT,
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
        INSERT INTO patient (p_id, p_gender, p_name, p_address, p_age)
		VALUES (p_id, p_gender, p_name, p_address, p_age);
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


