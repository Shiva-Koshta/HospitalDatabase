SELECT InsertPatient(
    16, -- p_id
    'Male', -- p_gender
    'John Doe', -- p_name
    '123 Example St', -- p_address
    30 -- p_age
);


SELECT InsertHistory(
    3, -- h_id
    16, -- p_id
    '2023-11-27', -- date
    'Fine', -- p_condition
    'Brain Surgery', -- p_surgery
    'www.google.com' -- p_link
);


SELECT InsertDoctor(
	3333,'asad',22);
    
SELECT InsertSchedule(
);

SELECT FillFollow(
	3333,22);