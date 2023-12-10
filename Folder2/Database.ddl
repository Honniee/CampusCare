-- Create database
CREATE DATABASE CampusCare;

-- Users table
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  user_type VARCHAR(20) CHECK(user_type IN ('Student', 'ClinicalStaff')) NOT NULL,
  registration_date TIMESTAMP NOT NULL,
  last_login_date TIMESTAMP NOT NULL,
  is_active BOOLEAN NOT NULL
);

-- Student_info table
CREATE TABLE Student_info (
  student_id INT PRIMARY KEY,
  user_id INT UNIQUE NOT NULL,
  user_type VARCHAR(20) CHECK(user_type = 'Student') NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR (50),
  program VARCHAR (50) NOT NULL,
  section VARCHAR (20) NOT NULL,
  date_of_birth DATE NOT NULL,
  address VARCHAR(50) NOT NULL,
  sex VARCHAR(10) NOT NULL,
  age INT NOT NULL,
  home_phone_no VARCHAR(20) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  email_address VARCHAR(255) NOT NULL,
  religion VARCHAR(50) NOT NULL,
  civil_status VARCHAR(50) NOT NULL,
  emergency_contact_name VARCHAR(100) NOT NULL,
  emergency_contact_no VARCHAR(20) NOT NULL,
  emergency_contact_address VARCHAR(50) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  CONSTRAINT student_type CHECK (user_type = 'Student')
);

-- Staff_basic_info table
CREATE TABLE Staff_basic_info (
  staff_id INT PRIMARY KEY,
  user_id INT UNIQUE NOT NULL,
  user_type VARCHAR(20) CHECK(user_type = 'ClinicalStaff') NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR (50),
  date_of_birth DATE NOT NULL,
  address VARCHAR(50) NOT NULL,
  sex VARCHAR(10) NOT NULL,
  age INT NOT NULL,
  home_phone_no VARCHAR(20) NOT NULL,
  mobile_no VARCHAR(20) NOT NULL,
  email_address VARCHAR(255) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  CONSTRAINT staff_type CHECK (user_type = 'ClinicalStaff')
);

-- Staff_professional_info table
CREATE TABLE Staff_professional_info (
  staff_id INT ,
   position_title VARCHAR(100) NOT NULL,
  license_number VARCHAR(50) UNIQUE NOT NULL,
  specialization VARCHAR(100) NOT NULL,
  department VARCHAR(100) NOT NULL,
  FOREIGN KEY (staff_id) REFERENCES Staff_basic_info(staff_id)
);

-- Medical_records table
CREATE TABLE Medical_records (
  medical_records_id INT PRIMARY KEY,
  student_id INT UNIQUE NOT NULL,
  medical_conditions TEXT NOT NULL,
  allergies TEXT NOT NULL,
  surgeries TEXT Not NULL,
  FOREIGN KEY (student_id) REFERENCES Student_info(student_id)
);

-- Immunization_records table
CREATE TABLE Immunization_records (
  immunization_id INT PRIMARY KEY,
  student_id INT UNIQUE NOT NULL,
  immunization_type VARCHAR (200) NOT NULL,
  date_administered DATE NOT NULL,
  administered_by VARCHAR (100) NOT NULL,
  due_date DATE NOT NULL,
  status VARCHAR(50) CHECK(status IN ('Up to Date', 'Incomplete')) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES Student_info(student_id)
);


-- Appointments table
CREATE TABLE Appointments (
  appointment_id INT PRIMARY KEY,
  student_id INT NOT NULL,
  staff_id INT NOT NULL,
  appointment_date DATE NOT NULL,
  status VARCHAR(50) CHECK(status IN ('Scheduled', 'Completed', 'Canceled')) NOT NULL,
  reason_for_visit TEXT NOT NULL,
  notes TEXT NOT NULL,
  FOREIGN KEY (student_id) REFERENCES Student_info(student_id),
  FOREIGN KEY (staff_id) REFERENCES Staff_basic_info(staff_id)
);

-- Notifications table
CREATE TABLE Notifications (
  notification_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  message TEXT NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  is_read BOOLEAN NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- User (Students)
INSERT INTO Users (user_id, username, password_hash, user_type, registration_date, last_login_date, is_active)
VALUES 
(1, 'student1', 'pass1', 'Student', '2023-01-01', '2023-11-25', TRUE),
(2, 'student2', 'pass2', 'Student', '2023-02-15', '2023-11-24', TRUE),
(3, 'student3', 'pass3', 'Student', '2023-03-10', '2023-11-23', TRUE),
(4, 'student4', 'pass4', 'Student', '2023-04-05', '2023-11-22', TRUE),
(5, 'student5', 'pass5', 'Student', '2023-05-20', '2023-11-21', TRUE),
(6, 'student6', 'pass6', 'Student', '2023-06-12', '2023-11-20', TRUE),
(7, 'student7', 'pass7', 'Student', '2023-07-08', '2023-11-19', TRUE),
(8, 'student8', 'pass8', 'Student', '2023-08-03', '2023-11-18', TRUE),
(9, 'student9', 'pass9', 'Student', '2023-09-25', '2023-11-17', TRUE),
(10, 'student10', 'pass10', 'Student', '2023-10-15', '2023-11-16', TRUE);

-- User (Clinical Staff)
INSERT INTO Users (user_id, username, password_hash, user_type, registration_date, last_login_date, is_active)
VALUES 
(11, 'staff1', 'pass1', 'ClinicalStaff', '2023-01-01', '2023-11-25', TRUE),
(12, 'staff2', 'pass2', 'ClinicalStaff', '2023-02-15', '2023-11-24', TRUE),
(13, 'staff3', 'pass3', 'ClinicalStaff', '2023-03-10', '2023-11-23', TRUE),
(14, 'staff4', 'pass4', 'ClinicalStaff', '2023-04-05', '2023-11-22', TRUE),
(15, 'staff5', 'pass5', 'ClinicalStaff', '2023-05-20', '2023-11-21', TRUE),
(16, 'staff6', 'pass6', 'ClinicalStaff', '2023-06-12', '2023-11-20', TRUE),
(17, 'staff7', 'pass7', 'ClinicalStaff', '2023-07-08', '2023-11-19', TRUE),
(18, 'staff8', 'pass8', 'ClinicalStaff', '2023-08-03', '2023-11-18', TRUE),
(19, 'staff9', 'pass9', 'ClinicalStaff', '2023-09-25', '2023-11-17', TRUE),
(20, 'staff10', 'pass10', 'ClinicalStaff', '2023-10-15', '2023-11-16', TRUE);


-- Student_info table
INSERT INTO Student_info (student_id, user_id, user_type, last_name, first_name, middle_name, program, section, date_of_birth, address, sex, age, home_phone_no, mobile_no, email_address, religion, civil_status, emergency_contact_name, emergency_contact_no, emergency_contact_address)
VALUES
(111, 1, 'Student', 'Mercado', 'Mae', 'Anne', 'Bachelor of Science in Information Technology', 'BSIT-2101', '2004-07-29', 'San Jose', 'F', 19, '888-671', '63-123', 'Mae_Mercado@gmail.com', 'Catholic', 'Single', 'Lea Mercado', '63-103', 'San Jose'),
(112, 2, 'Student', 'Vergara', 'Christine', 'Rose', 'Electrical Engineering', 'EE-2102', '2004-02-11', 'Lipa', 'F', 19, '888-672', '63-223', 'Christine_Vergara@gmail.com', 'Catholic', 'Single', 'Rochelle Vergara', '63-203', 'Lipa'),
(113, 3, 'Student', 'Carandang', 'Amanda', 'Marie', 'Mechanical Engineering', 'ME-2103', '2004-09-23', 'Lipa', 'F', 19, '888-673', '63-323', 'Amanda_Carandang@gmail.com', 'Catholic', 'Single', 'Sarah Carandang', '63-303', 'Lipa'),
(114, 4, 'Student', 'Carandang', 'Justine', 'Michael', 'Information Technology', 'BSIT-2104', '2004-01-04', 'San Vicente', 'M', 19, '888-674', '63-423', 'Justine_Carandang@gmail.com', 'Catholic', 'Single', 'Anthony Carandang', '63-403', 'San Vicente'),
(115, 5, 'Student', 'Aguila', 'Jonah', 'Jane', 'Nursing', 'NURS-2105', '2002-01-27', 'San Jose', 'F', 21, '888-675', '63-523', 'Jonah_Aguila@gmail.com', 'Catholic', 'Single', 'Rea Aguila', '63-503', 'San Jose'),
(116, 6, 'Student', 'Ambal', 'Miguel', 'Angel', 'Civil Engineering', 'CE-2106', '2003-07-04', 'Lipa', 'M', 20, '888-676', '63-623', 'Miguel_Ambal@gmail.com', 'Catholic', 'Single', 'Joy Ambal', '63-603', 'Lipa'),
(117, 7, 'Student', 'Chavez', 'Joshua', 'James', 'Chemical Engineering', 'CHE-2107', '2002-04-21', 'Lipa', 'M', 21, '888-677', '63-723', 'Joshua_Chavez@gmail.com', 'Catholic', 'Single', 'Juan Chavez', '63-703', 'Lipa'),
(118, 8, 'Student', 'Gonzales', 'Carlo', 'Christopher', 'Psychology', 'PSYCH-2108', '2005-07-15', 'Abra', 'M', 18, '888-678', '63-823', 'Carlo_Gonzales@gmail.com', 'Catholic', 'Single', 'Reny Gonzales', '63-803', 'Abra'),
(119, 9, 'Student', 'Apostol', 'Maria', 'Melissa', 'Business Administration', 'BADM-2109', '2002-11-25', 'San Jose', 'M', 21, '888-679', '63-923', 'Maria_Apostol@gmail.com', 'Catholic', 'Single', 'Aiza Apostol', '63-903', 'San Jose'),
(120, 10, 'Student', 'Harake', 'Ashley', 'Alex', 'Computer Engineering', 'COE-2110', '2003-07-04', 'Batangas', 'F', 20, '888-670', '63-023', 'Ashley_Harake@gmail.com', 'Catholic', 'Single', 'Leny Harake', '63-003', 'Batangas');

INSERT INTO Staff_basic_info (staff_id, user_id, user_type, last_name, first_name, middle_name, date_of_birth, address, sex, age, home_phone_no, mobile_no, email_address)
VALUES
(201, 11, 'ClinicalStaff', 'Smith', 'John', 'Alexander', '1980-05-15', 'Lipa', 'Male', 41, '888-123', '63-146', 'john.smith@gmail.com'),
(202, 12, 'ClinicalStaff', 'Johnson', 'Alice', 'Marie', '1990-10-20', 'San Jose', 'Female', 32, '888-223', '63-246', 'alice.johnson@gmail.com'),
(203, 13, 'ClinicalStaff', 'Williams', 'Michael', 'David', '1985-12-03', 'Calamba', 'Male', 37, '888-323', '63-346', 'michael.williams@gmail.com'),
(204, 14, 'ClinicalStaff', 'Brown', 'Emily', 'Nicole', '1978-07-28', 'Lipa', 'Female', 45, '888-423', '63-446', 'emily.brown@gmail.com'),
(205, 15, 'ClinicalStaff', 'Davis', 'Robert', 'Edward', '1992-02-10', 'Batangas', 'Male', 29, '888-523', '63-546', 'robert.davis@gmail.com'),
(206, 16, 'ClinicalStaff', 'Martinez', 'Sophia', 'Grace', '1987-09-05', 'San Pablo', 'Female', 34, '63-646', '4321098765', 'sophia.martinez@gmail.com'),
(207, 17, 'ClinicalStaff', 'Garcia', 'Daniel', 'Joseph', '1975-04-18', 'Calamba', 'Male', 48, '888-723', '63-746', 'daniel.garcia@gmail.com'),
(208, 18, 'ClinicalStaff', 'Miller', 'Olivia', 'Emma', '1995-11-22', 'Lipa', 'Female', 26, '888-823', '63-846', 'olivia.miller@gmail.com'),
(209, 19, 'ClinicalStaff', 'Lee', 'David', 'Christopher', '1989-06-30', 'San Jose', 'Male', 32, '888-923', '63-946', 'david.lee@gmail.com'),
(210, 20, 'ClinicalStaff', 'Taylor', 'Emma', 'Grace', '1983-03-14', 'Batangas', 'Female', 38, '888-023', '63-046', 'emma.taylor@gmail.com');

-- Staff_professional_info table
INSERT INTO Staff_professional_info (staff_id, position_title, license_number, specialization, department)
VALUES
(201, 'Senior Physician', 'MD12345', 'General Medicine', 'General Medicine Department'),
(202, 'Nurse Practitioner', 'RN98765', 'Primary Care', 'Primary Care Department'),
(203, 'Physician Assistant', 'PA54321', 'Health Promotion', 'Health Promotion Department'),
(204, 'Clinical Psychologist', 'CP67890', 'Mental Health Counseling', 'Mental Health Department'),
(205, 'Senior Nurse', 'RN23456', 'Student Health Services', 'Student Health Services Department'),
(206, 'Medical Technologist', 'MT87654', 'Laboratory Services', 'Laboratory Department'),
(207, 'Emergency Medical Technician', 'EMT11223', 'Emergency Response', 'Emergency Response Department'),
(208, 'Senior Nurse', 'RN33445', 'Women''s Health', 'Women''s Health Department'),
(209, 'Clinical Social Worker', 'CSW55667', 'Student Counseling', 'Counseling Department'),
(210, 'Senior Physician', 'MD11223', 'Sports Medicine', 'Sports Medicine Department');

-- Medical_records table
INSERT INTO Medical_records (medical_records_id, student_id, medical_conditions, allergies, surgeries)
VALUES
(1001, 111, 'No significant medical conditions', 'None', 'None'),
(1002, 112, 'Asthma', 'Pollen', 'Appendectomy'),
(1003, 113, 'Allergies to penicillin', 'Peanuts', 'None'),
(1004, 114, 'Migraines', 'Shellfish', 'Tonsillectomy'),
(1005, 115, 'Seasonal allergies', 'Cat dander', 'None'),
(1006, 116, 'No significant medical conditions', 'None', 'None'),
(1007, 117, 'Type 1 Diabetes', 'None', 'None'),
(1008, 118, 'No significant medical conditions', 'None', 'None'),
(1009, 119, 'No significant medical conditions', 'None', 'None'),
(1010, 120, 'No significant medical conditions', 'None', 'None');


-- Immunization_records table
INSERT INTO Immunization_records (immunization_id, student_id, immunization_type, date_administered, administered_by, due_date, status)
VALUES
(2001, 111, 'Measles, Mumps, Rubella (MMR)', '2023-01-15', 'Dr. Olivia Simmons', '2023-01-15', 'Up to Date'),
(2002, 112, 'Influenza (Flu)', '2023-02-20', 'Dr. Benjamin Harris', '2023-02-20', 'Up to Date'),
(2003, 113, 'Tetanus, Diphtheria, Pertussis (Tdap)', '2023-03-25', 'Dr. Sophia Miller', '2024-03-25', 'Incomplete'),
(2004, 114, 'Hepatitis B', '2023-04-10', 'Dr. Daniel Garcia', '2024-04-10', 'Incomplete'),
(2005, 115, 'Varicella (Chickenpox)', '2023-05-15', 'Dr. Michael Williams', '2023-05-15', 'Up to Date'),
(2006, 116, 'Meningococcal', '2023-06-20', 'Dr. Emily Brown', '2024-06-20', 'Incomplete'),
(2007, 117, 'Human Papillomavirus (HPV)', '2023-07-25', 'Dr. John Smith', '2024-07-25', 'Incomplete'),
(2008, 118, 'Influenza (Flu)', '2023-08-30', 'Dr. Alice Johnson', '2023-08-30', 'Up to Date'),
(2009, 119, 'Tetanus, Diphtheria, Pertussis (Tdap)', '2023-09-15', 'Dr. David Lee', '2024-09-15', 'Incomplete'),
(2010, 120, 'Measles, Mumps, Rubella (MMR)', '2023-10-20', 'Dr. Emma Taylor', '2023-10-20', 'Up to Date');

-- Appointments table (25 data values)
INSERT INTO Appointments (appointment_id, student_id, staff_id, appointment_date, status, reason_for_visit, notes)
VALUES
(1001, 115, 201, '2023-11-01', 'Scheduled', 'Routine Health Checkup', 'Student maintaining regular health checkups'),
(1002, 113, 201, '2023-11-01', 'Completed', 'Dental Cleaning and Checkup', 'Student attending routine dental appointment'),
(1003, 111, 203, '2023-11-01', 'Scheduled', 'Vision Screening for Eye Health', 'Student experiencing mild vision issues'),
(1004, 112, 202, '2023-11-01', 'Canceled', 'Allergy Consultation', 'Student rescheduled due to personal reasons'),
(1005, 118, 205, '2023-11-02', 'Scheduled', 'Vaccination for School Health Program', 'Participation in university-wide health initiative'),
(1006, 119, 206, '2023-11-02', 'Completed', 'Nutritional Consultation for Dietary Guidance', 'Student seeking advice for maintaining a healthy diet'),
(1007, 114, 207, '2023-11-07', 'Scheduled', 'Speech Therapy Session for Communication Improvement', 'Supporting student\''s academic and social development'),
(1008, 117, 208, '2023-11-08', 'Canceled', 'Flu Shot for Seasonal Health', 'Student rescheduled due to a conflicting academic event'),
(1009, 116, 209, '2023-11-09', 'Scheduled', 'Physical Examination for Internship Requirement', 'Mandatory health checkup for internship placement'),
(1010, 120, 210, '2023-11-10', 'Completed', 'Counseling Session for Coping with Academic Stress', 'Student seeking emotional support during exams'),
(1011, 113, 201, '2023-11-11', 'Scheduled', 'Chiropractic Adjustment for Posture Improvement', 'Student addressing posture concerns affecting studies'),
(1012, 111, 202, '2023-11-12', 'Completed', 'Optometry Checkup for Vision Correction', 'Student proactively managing visual health for academic success'),
(1013, 117, 203, '2023-11-13', 'Scheduled', 'Psychiatric Consultation for Mental Health Support', 'Student seeking assistance for mental health concerns'),
(1014, 119, 204, '2023-11-14', 'Completed', 'Sports Medicine Appointment for Injury Recovery', 'Athlete requiring ongoing medical support for a sustained injury'),
(1015, 114, 205, '2023-11-15', 'Scheduled', 'Nutritional Consultation for Dietary Guidance', 'Student exploring healthier dietary options'),
(1016, 112, 206, '2023-11-18', 'Scheduled', 'Physical Therapy Session for Injury Rehabilitation', 'Student recovering from a sports-related injury'),
(1017, 120, 207, '2023-11-17', 'Scheduled', 'Routine Health Checkup', 'Regular health monitoring for overall well-being'),
(1018, 118, 208, '2023-11-19', 'Completed', 'Dental Cleaning and Checkup', 'Student attending routine dental appointment'),
(1019, 119, 209, '2023-11-19', 'Scheduled', 'Vision Screening for Eye Health', 'Student experiencing mild vision issues'),
(1020, 115, 210, '2023-11-20', 'Completed', 'Allergy Consultation', 'Student addressing allergy concerns for improved comfort'),
(1021, 111, 210, '2023-11-21', 'Scheduled', 'Vaccination for School Health Program', 'Participation in university-wide health initiative'),
(1022, 112, 202, '2023-11-21', 'Completed', 'Nutritional Consultation for Dietary Guidance', 'Student seeking advice for maintaining a healthy diet'),
(1023, 117, 203, '2023-11-23', 'Scheduled', 'Speech Therapy Session for Communication Improvement', 'Supporting student\''s academic and social development'),
(1024, 113, 204, '2023-11-24', 'Canceled', 'Flu Shot for Seasonal Health', 'Student rescheduled due to a conflicting academic event'),
(1025, 114, 205, '2023-11-25', 'Scheduled', 'Physical Examination for Internship Requirement', 'Mandatory health checkup for internship placement');


-- Notifications for Student Users related to Appointments
INSERT INTO Notifications (notification_id, user_id, message, timestamp, is_read)
VALUES
(2001, 5, 'Reminder: Your routine health checkup is scheduled for November 1, 2023', '2023-10-30 09:00:00', false),
(2002, 3, 'Completed: Your dental cleaning and checkup on November 1, 2023, was successful', '2023-11-01 16:00:00', true),
(2003, 1, 'Canceled: Your allergy consultation has been rescheduled', '2023-11-02 09:30:00', true),
(2004, 2, 'Upcoming: Get ready for your flu shot on November 8, 2023', '2023-11-07 14:45:00', false),
(2005, 8, 'Completed: Your nutritional consultation on November 2, 2023, provided valuable guidance', '2023-11-02 16:20:00', true),
(2006, 9, 'Reminder: Speech therapy session scheduled for November 13, 2023', '2023-11-09 13:00:00', false),
(2007, 4, 'Upcoming: Sports medicine appointment on November 14, 2023', '2023-11-12 11:45:00', false),
(2008, 7, 'Canceled: Your flu shot has been rescheduled', '2023-11-08 11:30:00', true),
(2009, 6, 'Completed: Your mandatory physical examination for internship on November 9, 2023', '2023-11-09 17:00:00', true),
(2010, 10, 'Reminder: Counseling session on November 10, 2023, for coping with academic stress', '2023-11-10 15:00:00', false),
(2011, 3, 'Upcoming: Chiropractic adjustment on November 11, 2023, for posture improvement', '2023-11-10 14:30:00', false),
(2012, 1, 'Completed: Optometry checkup on November 12, 2023, for vision correction', '2023-11-12 16:45:00', true),
(2013, 7, 'Reminder: Psychiatric consultation scheduled for November 13, 2023', '2023-11-10 13:30:00', false),
(2014, 9, 'Canceled: Your sports medicine appointment has been rescheduled', '2023-11-25 11:00:00', true),
(2015, 4, 'Upcoming: Nutritional consultation on November 15, 2023', '2023-11-14 15:30:00', false);

-- Notifications for Clinical Staff Users related to Appointments
INSERT INTO Notifications (notification_id, user_id, message, timestamp, is_read)
VALUES
(3001, 11, 'Reminder: Prepare for vision screening appointments on November 1, 2023', '2023-10-30 08:30:00', false),
(3002, 11, 'Completed: Review health checkup results for November 1, 2023 appointments', '2023-11-01 16:30:00', true),
(3003, 13, 'Canceled: Allergy consultation (Rescheduled)', '2023-11-02 09:30:00', true),
(3004, 12, 'Upcoming: Prepare for flu shot appointments on November 8, 2023', '2023-11-07 14:00:00', false),
(3005, 15, 'Completed: Nutritional consultations on November 2, 2023, were successfully conducted', '2023-11-02 16:30:00', true),
(3006, 16, 'Reminder: Speech therapy sessions scheduled for November 13, 2023', '2023-11-09 13:15:00', false),
(3007, 17, 'Canceled: Sports medicine appointments have been rescheduled', '2023-11-25 11:30:00', true),
(3008, 18, 'Upcoming: Dental cleaning and checkup appointments on November 19, 2023', '2023-11-18 15:30:00', false),
(3009, 19, 'Completed: Physical examination appointments on November 9, 2023', '2023-11-09 18:00:00', true),
(3010, 20, 'Reminder: Counseling sessions on November 10, 2023', '2023-11-10 15:45:00', false),
(3011, 11, 'Upcoming: Chiropractic adjustment appointments on November 11, 2023', '2023-11-10 15:00:00', false),
(3012, 12, 'Completed: Optometry checkup appointments on November 12, 2023', '2023-11-12 17:00:00', true),
(3013, 13, 'Reminder: Psychiatric consultations scheduled for November 13, 2023', '2023-11-10 14:00:00', false),
(3014, 14, 'Canceled: Flu shot appointments have been rescheduled', '2023-11-24 11:30:00', true),
(3015, 15, 'Upcoming: Nutritional consultations on November 15, 2023', '2023-11-14 16:00:00', false);
