-- task 3
-- TRUNCATE TABLE registration CASCADE;
-- TRUNCATE TABLE student CASCADE;
-- TRUNCATE TABLE teacher CASCADE;
-- TRUNCATE TABLE webinar CASCADE;

-- \copy teacher FROM 'teacher.csv' WITH (FORMAT csv)
-- \copy webinar FROM 'webinar.csv' WITH (FORMAT csv)
-- \copy student FROM 'student.csv' WITH (FORMAT csv)
-- \copy registration FROM 'registration.csv' WITH (FORMAT csv)

-- task 4

-- TRUNCATE TABLE registration CASCADE;
-- TRUNCATE TABLE student CASCADE;
-- TRUNCATE TABLE teacher CASCADE;
-- TRUNCATE TABLE webinar CASCADE;


-- ALTER TABLE registration DROP CONSTRAINT registration_student_id_fkey;
-- ALTER TABLE registration DROP CONSTRAINT registration_webinar_id_fkey;
-- ALTER TABLE student DROP CONSTRAINT student_mentor_id_fkey; 
-- ALTER TABLE webinar DROP CONSTRAINT webinar_teacher_id_fkey; 


-- \copy teacher FROM 'teacher.csv' WITH (FORMAT csv)
-- \copy webinar FROM 'webinar.csv' WITH (FORMAT csv)
-- \copy student FROM 'student.csv' WITH (FORMAT csv)
-- \copy registration FROM 'registration.csv' WITH (FORMAT csv)


-- ALTER TABLE registration ADD CONSTRAINT registration_student_id_fkey FOREIGN KEY (student_id) REFERENCES student(id);
-- ALTER TABLE registration ADD CONSTRAINT registration_webinar_id_fkey FOREIGN KEY (webinar_id) REFERENCES webinar(id);
-- ALTER TABLE student ADD CONSTRAINT student_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES teacher(id);
-- ALTER TABLE webinar ADD CONSTRAINT webinar_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES teacher(id);

-- task 5

-- SELECT * FROM student, teacher
-- WHERE student.mentor_id = teacher.id
-- AND (student.city = 'Berlin' OR teacher.city = 'Berlin');


