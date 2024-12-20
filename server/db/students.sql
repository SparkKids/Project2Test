-- Table: public.students

-- DROP TABLE IF EXISTS public.students;

CREATE TABLE IF NOT EXISTS public.students
(
    students_id integer NOT NULL,
    persons_id integer,
    grade_name character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT students_pkey PRIMARY KEY (students_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.students
    OWNER to postgres;