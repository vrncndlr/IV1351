
CREATE TABLE classroom (
 classroom_id SERIAL NOT NULL,
 classroom VARCHAR(100)
);

ALTER TABLE classroom ADD CONSTRAINT PK_classroom PRIMARY KEY (classroom_id);


CREATE TABLE instructor (
 employment_id SERIAL NOT NULL,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 street VARCHAR(100) NOT NULL,
 zipcode VARCHAR(5) NOT NULL,
 city VARCHAR(100) NOT NULL,
 email VARCHAR (100) UNIQUE,
 can_teach_ensemble BOOLEAN NOT NULL,
 phone_private VARCHAR(100) UNIQUE,
 phone_other VARCHAR(100) UNIQUE
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (employment_id);


CREATE TABLE siblings (
 student_id SERIAL NOT NULL
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (student_id);


CREATE TABLE student (
 student_id SERIAL NOT NULL,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 street VARCHAR(100) NOT NULL,
 zipcode VARCHAR(5) NOT NULL,
 city VARCHAR(100) NOT NULL,
 email VARCHAR(100) UNIQUE,
 contact_email VARCHAR(100) UNIQUE,
 contactperson_firstname VARCHAR(100) NOT NULL,
 contactperson_lastname VARCHAR(100) NOT NULL,
 contact_phone VARCHAR(100) UNIQUE,
 contact_phone2 VARCHAR(100) UNIQUE
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_siblings (
 student_id SERIAL NOT NULL,
 student_id_0 SERIAL NOT NULL
);

ALTER TABLE student_siblings ADD CONSTRAINT PK_student_siblings PRIMARY KEY (student_id,student_id_0);


CREATE TABLE application (
 student_id SERIAL NOT NULL,
 skill_level VARCHAR(100) NOT NULL
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (student_id);


CREATE TABLE instrument (
 instument_id SERIAL NOT NULL,
 type VARCHAR(100) NOT NULL,
 skill_level VARCHAR(100) NOT NULL,
 student_id SERIAL NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instument_id);


CREATE TABLE instrument_rental (
 rental_id SERIAL NOT NULL,
 type VARCHAR(100),
 in_stock BOOLEAN NOT NULL,
 price INT NOT NULL,
 student_id SERIAL
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (rental_id);


CREATE TABLE lesson_bookings (
 lesson_id SERIAL NOT NULL,
 time_slots VARCHAR(1000),
 classroom_id SERIAL NOT NULL,
 employment_id SERIAL,
 student_id SERIAL
);

ALTER TABLE lesson_bookings ADD CONSTRAINT PK_lesson_bookings PRIMARY KEY (lesson_id);


CREATE TABLE lessons_sold (
 lesson_id SERIAL NOT NULL,
 employment_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL
);

ALTER TABLE lessons_sold ADD CONSTRAINT PK_lessons_sold PRIMARY KEY (lesson_id,employment_id,student_id);


CREATE TABLE price_list (
 lesson_id SERIAL NOT NULL,
 type VARCHAR(100),
 skill_level VARCHAR(100),
 price INT
);

ALTER TABLE price_list ADD CONSTRAINT PK_price_list PRIMARY KEY (lesson_id);


CREATE TABLE   individual_lesson (
 lesson_id SERIAL NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 skill_level VARCHAR(100) NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE ensemble (
 lesson_id SERIAL NOT NULL,
 genre VARCHAR(100) NOT NULL,
 min_students INT NOT NULL,
 max_students INT NOT NULL,
 registered_students INT
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id SERIAL NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 skill_level VARCHAR(100) NOT NULL,
 min_students INT NOT NULL,
 max_students INT NOT NULL,
 registered_students INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


ALTER TABLE student_siblings ADD CONSTRAINT FK_student_siblings_0 FOREIGN KEY (student_id) REFERENCES siblings (student_id);
ALTER TABLE student_siblings ADD CONSTRAINT FK_student_siblings_1 FOREIGN KEY (student_id_0) REFERENCES student (student_id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE lesson_bookings ADD CONSTRAINT FK_lesson_bookings_0 FOREIGN KEY (classroom_id) REFERENCES classroom (classroom_id) ON DELETE CASCADE ON UPDATE CASCASE;
ALTER TABLE lesson_bookings ADD CONSTRAINT FK_lesson_bookings_1 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);
ALTER TABLE lesson_bookings ADD CONSTRAINT FK_lesson_bookings_2 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE lessons_sold ADD CONSTRAINT FK_lessons_sold_0 FOREIGN KEY (lesson_id) REFERENCES lesson_bookings (lesson_id);


ALTER TABLE price_list ADD CONSTRAINT FK_price_list_0 FOREIGN KEY (lesson_id) REFERENCES lesson_bookings (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson_bookings (lesson_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES lesson_bookings (lesson_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson_bookings (lesson_id);


