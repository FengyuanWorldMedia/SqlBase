-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.p_privilege
(
    privilege_id character(3) NOT NULL,
    privilege_desc character varying(300),
    del_flg character(1),
    create_user character varying(8),
    create_time timestamp without time zone,
    update_user character varying(8),
    update_time timestamp without time zone,
    PRIMARY KEY (privilege_id)
);

CREATE TABLE IF NOT EXISTS public.p_group_privilege
(
    privilege_group_id integer,
    privilege_group_desc character varying(300),
    del_flg character varying(1),
    create_user character varying(8),
    create_time timestamp without time zone,
    update_user character varying(8),
    update_time timestamp without time zone,
    PRIMARY KEY (privilege_group_id)
);

CREATE TABLE IF NOT EXISTS public.p_group_privilege_relation
(
    privilege_group_id integer,
    privilege_id character(3),
    del_flg character(1),
    create_user character varying(8),
    create_time timestamp without time zone,
    update_user character varying(8),
    update_time timestamp without time zone,
    PRIMARY KEY (privilege_group_id, privilege_id)
);

CREATE TABLE IF NOT EXISTS public.p_user_privilege
(
    privilege_id character(3) NOT NULL,
    del_flg character(1),
    create_user character varying(8),
    create_time timestamp without time zone,
    update_user character varying(8),
    update_time timestamp without time zone,
    user_id character varying(8),
    start_ymd character varying(8),
    end_ymd character varying(8),
    PRIMARY KEY (privilege_id, user_id)
);

CREATE TABLE IF NOT EXISTS public.p_user_group
(
    privilege_group_id integer,
    user_id character varying(8),
    del_flg character varying(1),
    create_user character varying(8),
    create_time timestamp without time zone,
    update_user character varying(8),
    update_time timestamp without time zone,
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS public.p_object_privilege_relation
(
    privilege_id character(3) NOT NULL,
    object_id character varying(10) NOT NULL,
    del_flg character(1),
    create_user character varying(8),
    create_time timestamp without time zone,
    update_user character varying(8),
    update_time timestamp without time zone,
    PRIMARY KEY (privilege_id, object_id)
);

CREATE TABLE IF NOT EXISTS public.webapi_request
(
    request_id character varying(10),
    request_path character varying(100),
    request_desc character varying(200),
    "create" character varying(8),
    PRIMARY KEY (request_id)
);

CREATE TABLE IF NOT EXISTS public.u_user
(
    user_id character varying(8),
    nick_name character varying(50),
    PRIMARY KEY (user_id)
);

ALTER TABLE IF EXISTS public.p_group_privilege_relation
    ADD CONSTRAINT p_goup_privilege_relation_fk1 FOREIGN KEY (privilege_id)
    REFERENCES public.p_privilege (privilege_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.p_group_privilege_relation
    ADD CONSTRAINT p_goup_privilege_relation_fk2 FOREIGN KEY (privilege_group_id)
    REFERENCES public.p_group_privilege (privilege_group_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.p_user_privilege
    ADD CONSTRAINT p_user_privilege_fk1 FOREIGN KEY (privilege_id)
    REFERENCES public.p_privilege (privilege_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.p_user_privilege
    ADD FOREIGN KEY (user_id)
    REFERENCES public.u_user (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.p_user_group
    ADD CONSTRAINT p_user_group_fk1 FOREIGN KEY (privilege_group_id)
    REFERENCES public.p_group_privilege (privilege_group_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.p_user_group
    ADD CONSTRAINT p_user_group_fk2 FOREIGN KEY (user_id)
    REFERENCES public.u_user (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.p_object_privilege_relation
    ADD CONSTRAINT p_object_privilege_relation_fk1 FOREIGN KEY (object_id)
    REFERENCES public.webapi_request (request_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.p_object_privilege_relation
    ADD CONSTRAINT p_object_privilege_relation_fk2 FOREIGN KEY (privilege_id)
    REFERENCES public.p_privilege (privilege_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;