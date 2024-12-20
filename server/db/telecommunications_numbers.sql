-- Table: public.telecommunications_number

-- DROP TABLE IF EXISTS public.telecommunications_number;

CREATE TABLE IF NOT EXISTS public.telecommunications_number
(
    telecommunications_number_id integer NOT NULL DEFAULT nextval('telecommunications_number_id_seq'::regclass),
    area_code smallint NOT NULL,
    contact_number character varying(40) COLLATE pg_catalog."default" NOT NULL,
    country_code integer,
    CONSTRAINT telecommunications_number_pkey PRIMARY KEY (telecommunications_number_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.telecommunications_number
    OWNER to postgres;

COMMENT ON TABLE public.telecommunications_number
    IS 'Method of contacting by phone, etc. Examples: home phone, work phone, fax, mobile phone.';