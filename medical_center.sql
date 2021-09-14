DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center;

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    doctor_name TEXT NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    patient_name TEXT NOT NULL
);

CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    doctor_id INTEGER REFERENCES doctors NOT NULL,
    patient_id INTEGER REFERENCES patients NOT NULL
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    disease_name TEXT
);

CREATE TABLE diagnoses (
    id SERIAL PRIMARY KEY,
    visit_id INTEGER REFERENCES visits NOT NULL,
    disease_id INTEGER REFERENCES diseases
);

INSERT INTO doctors (doctor_name)
VALUES
('Ken Smith'),
('Samantha Brown'),
('Gary White'),
('Melvin Apple'),
('Tina Morris'),
('Jane Shep'),
('Jimmy Butler'),
('Gordon Hay'),
('Alice Price');

INSERT INTO patients (patient_name)
VALUES
('Susan Powers'),
('Tyler Robison'),
('Daniele Grey'),
('Doug Flute'),
('Bobby scmidt'),
('Larry Pole'),
('Jane Brown'),
('Jane Brown'),
('Elizabeth Hamil');


INSERT INTO visits (doctor_id, patient_id)
VALUES
(4, 7),
(3, 4), 
(6, 3),
(1, 1), 
(2, 4), 
(9, 7), 
(7, 6), 
(5, 2), 
(8, 1), 
(4, 8); 

INSERT INTO diseases (disease_name)
VALUES
('flu'), 
('common cold'),
('strain'), 
('broken bone'), 
('muscle tear'), 
('diabetes'),
('unknown disease'),
('insomnia'),
('fever');

INSERT INTO diagnoses (visit_id, disease_id)
VALUES
(1, 1),
(1, 2),
(1, 4),
(2, 3),
(5, 6), 
(7, 8),
(4, 5), 
(6, 6), 
(8, 1), 
(7, 2);

INSERT INTO diagnoses (visit_id)
VALUES
(4),
(6),
(8),
(3),
(5),
(1);








-- -- Querys
-- cond contains 'broken'
-- SELECT patients.name AS patient_name, doctors.name AS doctor_name, conditions
-- FROM visits
-- JOIN doctors ON visits.doctor_id = doctors.id
-- JOIN patients ON visits.patient_id = patients.id
-- WHERE conditions[1] ILIKE '%broken%';

-- SELECT patients.name AS patient_name, doctors.name AS doctor_name, conditions
-- FROM visits
-- JOIN doctors ON visits.doctor_id = doctors.id
-- JOIN patients ON visits.patient_id = patients.id
-- WHERE  ILIKE '%broken%' = ANY (conditions);

-- --LIKE/ILIKE for searching in array?
-- SELECT patients.name AS patient_name, doctors.name AS doctor_name, conditions
-- FROM visits
-- JOIN doctors ON visits.doctor_id = doctors.id
-- JOIN patients ON visits.patient_id = patients.id
-- WHERE  conditions @> '{"Flu"}';
-- --LIKE/ILIKE with @>  ?

-- --condition of patients with 2+ conds
-- SELECT patients.name AS patient_name, doctors.name AS doctor_name, conditions
-- FROM visits
-- JOIN doctors ON visits.doctor_id = doctors.id
-- JOIN patients ON visits.patient_id = patients.id
-- WHERE array_length(conditions, 1) > 1;

-- -- --Any condition contains 'sore' or 'sprained'
-- SELECT patients.name AS patient_name, doctors.name AS doctor_name, conditions
-- FROM visits
-- JOIN doctors ON visits.doctor_id = doctors.id
-- JOIN patients ON visits.patient_id = patients.id
-- WHERE conditions @> ILIKE '%sore%' OR conditions @> ILIKE '%sprained%'
-- ORDER BY patients.name;



-- --How many patients each doctor has seen, subquery for zero
-- SELECT doctors.name, COUNT(*) AS num_patients_seen
-- FROM visits
-- JOIN doctors ON visits.doctor_id = doctors.id
-- GROUP BY doctors.name
-- ORDER BY num_patients_seen DESC;


-- --Which doctors have seen less than 2 patients, inc 0
-- SELECT doctors.name, COUNT(*)
-- FROM visits
-- JOIN doctors ON visits.doctor_id = doctors.id
-- GROUP BY doctors.name
-- HAVING COUNT(*) < 2;


