-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    users_id integer NOT NULL,
    persons_id integer NOT NULL,
    password_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    role_types_id integer NOT NULL,
    electronic_address_string character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (users_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;

COMMENT ON TABLE public.users
    IS 'This is the table used to log into the application.';

COMMENT ON COLUMN public.users.persons_id
    IS 'Foreign key to the persons table.';
	
COMMENT ON COLUMN public.users.password_name
    IS 'This is the password used to log into the application.';

COMMENT ON COLUMN public.users.role_types_id
    IS 'Foreign key to the role_types table.';

COMMENT ON COLUMN public.users.electronic_address_string
    IS 'The users email address. Example: johnsmith@school.com';

