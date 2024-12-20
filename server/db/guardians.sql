-- Table: public.guardians

-- DROP TABLE IF EXISTS public.guardians;

CREATE TABLE IF NOT EXISTS public.guardians
(
    guardians_id integer NOT NULL,
    persons_id integer NOT NULL,
    authorized_indicator character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    emergency_indicator character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    CONSTRAINT guardians_pkey PRIMARY KEY (guardians_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.guardians
    OWNER to postgres;

COMMENT ON TABLE public.guardians
    IS 'This is a subtype of the person table.';