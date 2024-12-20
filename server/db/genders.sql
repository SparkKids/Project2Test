-- Table: public.genders

DROP TABLE IF EXISTS public.genders;

CREATE TABLE IF NOT EXISTS public.genders
(
    gender_id integer NOT NULL,
    gender_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genders_pkey PRIMARY KEY (gender_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.genders
    OWNER to postgres;