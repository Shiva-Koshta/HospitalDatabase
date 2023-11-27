--funtion for inserting data into the "appointment" table
CREATE OR REPLACE FUNCTION insert_appointment(
    p_patient_id INT,
    p_schedule_id INT,
    p_doctor_reg_id INT
)
RETURNS VOID AS
$$
BEGIN
    -- Insert data into the "Appointments" table
    INSERT INTO Appointments (p_id, s_id, reg_id)
    VALUES (p_patient_id, p_schedule_id, p_doctor_reg_id);
END;
$$
LANGUAGE plpgsql;
