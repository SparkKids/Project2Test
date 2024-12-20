-- Table: public.role_types

-- DROP TABLE IF EXISTS public.role_types;

CREATE TABLE IF NOT EXISTS public.role_types
(
    role_types_id integer NOT NULL,
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT role_types_pkey PRIMARY KEY (role_types_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.role_types
    OWNER to postgres;