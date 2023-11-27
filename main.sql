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
