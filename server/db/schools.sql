-- Table: public.schools

-- DROP TABLE IF EXISTS public.schools;

CREATE TABLE IF NOT EXISTS public.schools
(
    schools_id integer NOT NULL,
    school_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT schools_pkey PRIMARY KEY (schools_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.schools
    OWNER to postgres;

COMMENT ON TABLE public.schools
    IS 'Physical entity that houses instructors and course offerings.';