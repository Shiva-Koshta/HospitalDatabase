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


CREATE TRIGGER insert_appointmentTrigger AFTER INSERT ON Patient
FOR EACH ROW EXECUTE PROCEDURE insert_appointment();



