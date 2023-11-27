--funtion for inserting data into the "appointment" table
CREATE OR REPLACE FUNCTION insert_appointment()
RETURNS trigger AS
$$
BEGIN
    -- Insert data into the "Appointments" table
    declare p_patient_id int;
    declare p_schedule_id int;
    declare p_doctor_reg_id int;

    select p_id into p_patient_id from Patient where p_id = NEW.p_id;
	
	SELECT s_id, reg_id into p_schedule_id,p_doctor_reg_id
  	FROM Follow
  	WHERE (s_id, reg_id) NOT IN (SELECT s_id, reg_id FROM Appointments)
  	LIMIT 1;


    -- INSERT INTO Appointments (p_id, s_id, reg_id)
    -- VALUES (p_patient_id, p_schedule_id, p_doctor_reg_id);
     IF doctor_reg_id IS NOT NULL AND schedule_id IS NOT NULL THEN
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
CREATE FUNCTION InsertSchedule (
  s_id INT ,
  Start_Time TIME ,
  End_Time TIME 
)
RETURNS INT
AS $$
DECLARE
    num_schedules INT;
BEGIN

        -- Insert into the schedules table
        INSERT INTO schedule(s_id,start_time,end_time)
		VALUES (s_id,start_time,end_time);
   		select count(*) into num_schedules from schedule;
    RETURN  num_schedules;
END;
$$ LANGUAGE plpgsql;


