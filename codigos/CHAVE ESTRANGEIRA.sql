-- Tabela de Estudantes
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- Tabela de cursos
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100)
);

-- Tabela de matricula
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);

INSERT INTO students (name, age)
VALUES
    ('Zé da Manga', 22),
    ('Zé da Coves', 25);

SELECT * FROM students;

INSERT INTO courses (course_name)
VALUES
	('Banco de Dados Relacional'),
    ('Banco de Dados NoSQL');

SELECT * FROM courses;

INSERT INTO enrollments (student_id, course_id)
VALUES
	(1,1),
	(1,2),
	(2,1),
	(2,2);

DELETE FROM students WHERE student_id = 1;


SELECT * FROM enrollments;

DROP TABLE enrollments, students, courses;

SELECT enrollments.student_id, students.name, enrollments.student_id, 
courses.course_name FROM enrollments
LEFT JOIN students ON enrollments.student_id = students.student_id
LEFT JOIN courses ON enrollments.course_id = courses.course_id;
