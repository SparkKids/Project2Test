-- Table: public.courses

-- DROP TABLE IF EXISTS public.courses;

CREATE TABLE IF NOT EXISTS public.courses
(
    courses_id integer NOT NULL,
    title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    departments_id integer NOT NULL,
    CONSTRAINT courses_pkey PRIMARY KEY (courses_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.courses
    OWNER to postgres;

COMMENT ON TABLE public.courses
    IS 'Master table for courses offered at the institution.';

COMMENT ON COLUMN public.courses.title
    IS 'The title for the course. Example: Calculus 101';

COMMENT ON COLUMN public.courses.departments_id
    IS 'Foreign Key to the departments table.';