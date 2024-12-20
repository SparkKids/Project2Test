-- Table: public.courses
-- Drop the course_offerings first. it depends on courses
DROP TABLE IF EXISTS public.course_offerings;

DROP TABLE IF EXISTS public.courses;

--Create the table
CREATE TABLE IF NOT EXISTS public.courses
(
    course_id integer NOT NULL,
    title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    department_id integer NOT NULL,
    CONSTRAINT courses_pkey PRIMARY KEY (course_id),
	CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES public.departments(department_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.courses
    OWNER to postgres;

COMMENT ON TABLE public.courses
    IS 'Master table for courses offered at the institution.';

COMMENT ON COLUMN public.courses.title
    IS 'The title for the course. Example: Calculus 101';

COMMENT ON COLUMN public.courses.department_id
    IS 'Foreign Key to the departments table.';

-- Table: public.schools
-- Drop the table if it exists
DROP TABLE IF EXISTS public.schools;

-- Create the schools table with a schools_id column
CREATE TABLE IF NOT EXISTS public.schools
(
    school_id integer NOT NULL ,
    school_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT schools_pkey PRIMARY KEY (school_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.schools
    OWNER to postgres;

COMMENT ON TABLE public.schools
    IS 'Physical entity that houses instructors and course offerings.';


	
-- Table: public.departments
-- Drop the course_offerings first. it depends on courses
DROP TABLE IF EXISTS public.course_offerings;
-- The courses table depends on the departments table, so drop courses first
-- Drop the courses table if it exists
DROP TABLE IF EXISTS public.courses;

-- Drop the table if it exists
DROP TABLE IF EXISTS public.departments;
DROP SEQUENCE IF EXISTS public.departments_id_seq;

CREATE TABLE IF NOT EXISTS public.departments
(
    department_id integer NOT NULL,
    department_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT departments_pkey PRIMARY KEY (department_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.departments
    OWNER to postgres;

COMMENT ON TABLE public.departments
    IS 'The department in a school responsible for a course.';
-- Table: public.courses

--Create the table
CREATE TABLE IF NOT EXISTS public.courses
(
    course_id integer NOT NULL,
    title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    department_id integer NOT NULL,
    CONSTRAINT courses_pkey PRIMARY KEY (course_id),
	CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES public.departments(department_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.courses
    OWNER to postgres;

COMMENT ON TABLE public.courses
    IS 'Master table for courses offered at the institution.';

COMMENT ON COLUMN public.courses.title
    IS 'The title for the course. Example: Calculus 101';

COMMENT ON COLUMN public.courses.department_id
    IS 'Foreign Key to the departments table.';


-- Table: public.course_offerings

--Create the table
CREATE TABLE IF NOT EXISTS public.course_offerings
(
    course_offering_id integer NOT NULL,
    course_id integer NOT NULL,
    location character varying(40) COLLATE pg_catalog."default" NOT NULL,
    days character varying(40) COLLATE pg_catalog."default" NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    CONSTRAINT course_offerings_pkey PRIMARY KEY (course_offering_id),
	CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.courses(course_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.course_offerings
    OWNER to postgres; 

-- Drop the the students table first. It depends on persons.
DROP TABLE IF EXISTS public.students;
-- Drop the guardians table first. It depends on persons.
DROP TABLE IF EXISTS public.guardians;

-- Drop the persons table first. It depends on genders 
DROP TABLE IF EXISTS public.persons;

-- Table: public.genders
-- Drop the genders table if it exists 
DROP TABLE IF EXISTS public.genders;

--Create the table
CREATE TABLE IF NOT EXISTS public.genders
(
    gender_id integer NOT NULL,
    gender_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genders_pkey PRIMARY KEY (gender_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.genders
    OWNER to postgres;

	

-- Table: public.persons

--Create the table
CREATE TABLE IF NOT EXISTS public.persons
(
    person_id integer NOT NULL,
    last_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    middle_name character varying(40) COLLATE pg_catalog."default",
    personal_title character varying(10) COLLATE pg_catalog."default",
    suffix character varying(10) COLLATE pg_catalog."default",
    nickname character varying(30) COLLATE pg_catalog."default",
    gender_id integer,
    birth_date date,
    comment_text text COLLATE pg_catalog."default",
    CONSTRAINT persons_pkey PRIMARY KEY (person_id),
	CONSTRAINT fk_gender FOREIGN KEY (gender_id) REFERENCES public.genders(gender_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.persons
    OWNER to postgres;

COMMENT ON TABLE public.persons
    IS 'Represents the base information for a person. A person can serve different roles. For example, parent, teacher, student, ....';

COMMENT ON COLUMN public.persons.person_id
    IS 'Primary key for the persons table.';

COMMENT ON COLUMN public.persons.personal_title
    IS 'This is titles such as Jr., Sr. etc';

COMMENT ON COLUMN public.persons.suffix
    IS 'Dr., Mr., Ms., etc.';


-- Table: public.guardians
DROP SEQUENCE IF EXISTS public.guardians_id_seq;

--Create the table
CREATE TABLE IF NOT EXISTS public.guardians
(
    guardian_id integer NOT NULL,
    person_id integer NOT NULL,
    authorized_indicator character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    emergency_indicator character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    CONSTRAINT guardians_pkey PRIMARY KEY (guardian_id),
	CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES public.persons(person_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.guardians
    OWNER to postgres;

COMMENT ON TABLE public.guardians
    IS 'This is a subtype of the person table.';


-- Table: public.students

--Create the table
CREATE TABLE IF NOT EXISTS public.students
(
    student_id integer NOT NULL,
    person_id integer,
    grade_name character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT students_pkey PRIMARY KEY (student_id),
	CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES public.persons(person_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.students
    OWNER to postgres;

-- Table: public.addresses
-- Drop the the table then the sequence if they exist
DROP TABLE IF EXISTS public.addresses;
DROP SEQUENCE IF EXISTS public.addresses_id_seq;

--Create the table
CREATE TABLE IF NOT EXISTS public.addresses
(
    address_id integer NOT NULL,
    address1 character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address2 character varying(255) COLLATE pg_catalog."default",
    city_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    state_code character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT 'CO'::character varying,
    zip_code character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT addresses_pkey PRIMARY KEY (address_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.addresses
    OWNER to postgres;

COMMENT ON TABLE public.addresses
    IS 'Master table for holding addresses.';

-- Table: public.telecommunications_numbers
-- Drop the the table then the sequence if they exist
DROP TABLE IF EXISTS public.telecommunications_numbers;
DROP SEQUENCE IF EXISTS public.telecommunications_numbers_id_seq;

--Create the table
CREATE TABLE IF NOT EXISTS public.telecommunications_numbers
(
    telecommunications_number_id integer NOT NULL,
    area_code smallint NOT NULL,
    contact_number character varying(40) COLLATE pg_catalog."default" NOT NULL,
    country_code smallint,
    CONSTRAINT telecommunications_numbers_pkey PRIMARY KEY (telecommunications_number_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.telecommunications_numbers
    OWNER to postgres;

COMMENT ON TABLE public.telecommunications_numbers
    IS 'Method of contacting by phone, etc. Examples: home phone, work phone, fax, mobile phone.';

-- Table: public.role_types
-- Drop users first. It depends on role_types
DROP TABLE IF EXISTS public.users;
-- Drop the the table if it exists
DROP TABLE IF EXISTS public.role_types;

--Create the table
CREATE TABLE IF NOT EXISTS public.role_types
(
    role_type_id integer NOT NULL,
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT role_types_pkey PRIMARY KEY (role_type_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.role_types
    OWNER to postgres;


-- Table: public.users


CREATE TABLE IF NOT EXISTS public.users
(
    user_id integer NOT NULL,
    person_id integer NOT NULL,
    password_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    role_type_id integer NOT NULL,
    electronic_address_string character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
	CONSTRAINT fk_role_type FOREIGN KEY (role_type_id) REFERENCES public.role_types(role_type_id)

)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;

COMMENT ON TABLE public.users
    IS 'This is the table used to log into the application.';

COMMENT ON COLUMN public.users.person_id
    IS 'Foreign key to the persons table.';
	
COMMENT ON COLUMN public.users.password_name
    IS 'This is the password used to log into the application.';

COMMENT ON COLUMN public.users.role_type_id
    IS 'Foreign key to the role_types table.';

COMMENT ON COLUMN public.users.electronic_address_string
    IS 'The users email address. Example: johnsmith@school.com';

/*

-- Insert data into the Person table.
USE School
GO
SET IDENTITY_INSERT dbo.Person ON
GO
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (1, 'Abercrombie', 'Kim', '1995-03-11', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (2, 'Barzdukas', 'Gytis', null, '2005-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (3, 'Justice', 'Peggy', null, '2001-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (4, 'Fakhouri', 'Fadi', '2002-08-06', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (5, 'Harui', 'Roger', '1998-07-01', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (6, 'Li', 'Yan', null, '2002-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (7, 'Norman', 'Laura', null, '2003-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (8, 'Olivotto', 'Nino', null, '2005-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (9, 'Tang', 'Wayne', null, '2005-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (10, 'Alonso', 'Meredith', null, '2002-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (11, 'Lopez', 'Sophia', null, '2004-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (12, 'Browning', 'Meredith', null, '2000-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (13, 'Anand', 'Arturo', null, '2003-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (14, 'Walker', 'Alexandra', null, '2000-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (15, 'Powell', 'Carson', null, '2004-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (16, 'Jai', 'Damien', null, '2001-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (17, 'Carlson', 'Robyn', null, '2005-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (18, 'Zheng', 'Roger', '2004-02-12', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (19, 'Bryant', 'Carson', null, '2001-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (20, 'Suarez', 'Robyn', null, '2004-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (21, 'Holt', 'Roger', null, '2004-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (22, 'Alexander', 'Carson', null, '2005-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (23, 'Morgan', 'Isaiah', null, '2001-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (24, 'Martin', 'Randall', null, '2005-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (25, 'Kapoor', 'Candace', '2001-01-15', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (26, 'Rogers', 'Cody', null, '2002-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (27, 'Serrano', 'Stacy', '1999-06-01', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (28, 'White', 'Anthony', null, '2001-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (29, 'Griffin', 'Rachel', null, '2004-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (30, 'Shan', 'Alicia', null, '2003-09-01', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (31, 'Stewart', 'Jasmine', '1997-10-12', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (32, 'Xu', 'Kristen', '2001-7-23', null, 'Instructor');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (33, 'Gao', 'Erica', null, '2003-01-30', 'Student');
INSERT INTO dbo.Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (34, 'Van Houten', 'Roger', '2000-12-07', null, 'Instructor');
GO
SET IDENTITY_INSERT dbo.Person OFF
GO

-- Insert data into the Department table.
INSERT INTO dbo.Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (1, 'Engineering', 350000.00, '2007-09-01', 2);
INSERT INTO dbo.Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (2, 'English', 120000.00, '2007-09-01', 6);
INSERT INTO dbo.Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (4, 'Economics', 200000.00, '2007-09-01', 4);
INSERT INTO dbo.Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (7, 'Mathematics', 250000.00, '2007-09-01', 3);
GO



-- Insert data into the Course table.
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (1050, 'Chemistry', 4, 1);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (1061, 'Physics', 4, 1);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (1045, 'Calculus', 4, 7);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (2030, 'Poetry', 2, 2);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (2021, 'Composition', 3, 2);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (2042, 'Literature', 4, 2);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (4022, 'Microeconomics', 3, 4);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (4041, 'Macroeconomics', 3, 4);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (4061, 'Quantitative', 2, 4);
INSERT INTO dbo.Course (CourseID, Title, Credits, DepartmentID)
VALUES (3141, 'Trigonometry', 4, 7);
GO

-- Insert data into the OnlineCourse table.
INSERT INTO dbo.OnlineCourse (CourseID, URL)
VALUES (2030, 'http://www.fineartschool.net/Poetry');
INSERT INTO dbo.OnlineCourse (CourseID, URL)
VALUES (2021, 'http://www.fineartschool.net/Composition');
INSERT INTO dbo.OnlineCourse (CourseID, URL)
VALUES (4041, 'http://www.fineartschool.net/Macroeconomics');
INSERT INTO dbo.OnlineCourse (CourseID, URL)
VALUES (3141, 'http://www.fineartschool.net/Trigonometry');

--Insert data into OnsiteCourse table.
INSERT INTO dbo.OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (1050, '123 Smith', 'MTWH', '11:30');
INSERT INTO dbo.OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (1061, '234 Smith', 'TWHF', '13:15');
INSERT INTO dbo.OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (1045, '121 Smith','MWHF', '15:30');
INSERT INTO dbo.OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (4061, '22 Williams', 'TH', '11:15');
INSERT INTO dbo.OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (2042, '225 Adams', 'MTWH', '11:00');
INSERT INTO dbo.OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (4022, '23 Williams', 'MWF', '9:00');

-- Insert data into the CourseInstructor table.
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (1050, 1);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (1061, 31);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (1045, 5);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (2030, 4);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (2021, 27);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (2042, 25);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (4022, 18);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (4041, 32);
INSERT INTO dbo.CourseInstructor(CourseID, PersonID)
VALUES (4061, 34);
GO

--Insert data into the OfficeAssignment table.
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (1, '17 Smith');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (4, '29 Adams');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (5, '37 Williams');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (18, '143 Smith');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (25, '57 Adams');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (27, '271 Williams');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (31, '131 Smith');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (32, '203 Williams');
INSERT INTO dbo.OfficeAssignment(InstructorID, Location)
VALUES (34, '213 Smith');

-- Insert data into the StudentGrade table.
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2021, 2, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2030, 2, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2021, 3, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2030, 3, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2021, 6, 2.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2042, 6, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2021, 7, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2042, 7, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2021, 8, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (2042, 8, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4041, 9, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4041, 10, null);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4041, 11, 2.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4041, 12, null);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4061, 12, null);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 14, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 13, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4061, 13, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4041, 14, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 15, 2.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 16, 2);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 17, null);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 19, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4061, 20, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4061, 21, 2);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 22, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4041, 22, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4061, 22, 2.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (4022, 23, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1045, 23, 1.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1061, 24, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1061, 25, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1050, 26, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1061, 26, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1061, 27, 3);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1045, 28, 2.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1050, 28, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1061, 29, 4);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1050, 30, 3.5);
INSERT INTO dbo.StudentGrade (CourseID, StudentID, Grade)
VALUES (1061, 30, 4);
GO*/