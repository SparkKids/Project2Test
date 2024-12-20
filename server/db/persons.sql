-- Table: public.persons

-- DROP TABLE IF EXISTS public.persons;

CREATE TABLE IF NOT EXISTS public.persons
(
    persons_id integer NOT NULL,
    last_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    middle_name character varying(40) COLLATE pg_catalog."default",
    personal_title character varying(10) COLLATE pg_catalog."default",
    suffix character varying(10) COLLATE pg_catalog."default",
    nickname character varying(30) COLLATE pg_catalog."default",
    genders_id integer,
    birth_date date,
    comment text COLLATE pg_catalog."default",
    CONSTRAINT persons_pkey PRIMARY KEY (persons_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.persons
    OWNER to postgres;

COMMENT ON TABLE public.persons
    IS 'Represents the base information for a person. A person can serve different roles. For example, parent, teacher, student, ....';

COMMENT ON COLUMN public.persons.persons_id
    IS 'Primary key for the persons table.';

COMMENT ON COLUMN public.persons.personal_title
    IS 'This is titles such as Jr., Sr. etc';

COMMENT ON COLUMN public.persons.suffix
    IS 'Dr., Mr., Ms., etc.';