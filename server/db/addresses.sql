-- Table: public.addresses

-- DROP TABLE IF EXISTS public.addresses;

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