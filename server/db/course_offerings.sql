-- Table: public.course_offerings

-- DROP TABLE IF EXISTS public.course_offerings;

CREATE TABLE IF NOT EXISTS public.course_offerings
(
    course_offering_id integer NOT NULL,
    course_id integer NOT NULL,
    location character varying(40) COLLATE pg_catalog."default" NOT NULL,
    days character varying(40) COLLATE pg_catalog."default" NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    CONSTRAINT course_offerings_pkey PRIMARY KEY (course_offering_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.course_offerings
    OWNER to postgres;