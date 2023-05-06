
-- Table: palateapp.dish

DROP TABLE IF EXISTS palateapp.dish cascade;

CREATE TABLE IF NOT EXISTS palateapp.dish
(
    id BIGSERIAL NOT NULL,
    dishname character varying COLLATE pg_catalog."default",
    cuisinetype character varying COLLATE pg_catalog."default",
    creationtime timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    userentry boolean NOT NULL DEFAULT 'false',
    dishtypes character varying[] COLLATE pg_catalog."default",	
    diet character varying COLLATE pg_catalog."default",	
    CONSTRAINT dish_pkey PRIMARY KEY (id),
    CONSTRAINT unique_dishname_cuisinetype_diet_combination UNIQUE (dishname, cuisinetype, diet)
);

-- Table: palateapp.dishrating

DROP TABLE IF EXISTS palateapp.dishrating;

CREATE TABLE IF NOT EXISTS palateapp.dishrating
(
    ratingid BIGSERIAL NOT NULL,
    ratingdescription character varying COLLATE pg_catalog."default",
    CONSTRAINT dishrating_pkey PRIMARY KEY (ratingid)
);
	
-- Table: palateapp.preferencekeys

DROP TABLE IF EXISTS palateapp.preferencekeys cascade;

CREATE TABLE IF NOT EXISTS palateapp.preferencekeys
(
    id BIGSERIAL NOT NULL,
    preferencekey character varying COLLATE pg_catalog."default",
    CONSTRAINT preferencekeys_pkey PRIMARY KEY (id),
    CONSTRAINT preferencekey_unique UNIQUE (preferencekey)
);
-- Table: palateapp.userdetail

DROP TABLE IF EXISTS palateapp.userdetail cascade;

CREATE TABLE IF NOT EXISTS palateapp.userdetail
(
    id BIGSERIAL NOT NULL,
    handle character varying COLLATE pg_catalog."default",
    firstname character varying COLLATE pg_catalog."default",
    lastname character varying COLLATE pg_catalog."default",
    gender character varying COLLATE pg_catalog."default",
    dob date,
    email character varying COLLATE pg_catalog."default",
    phonenumber bigint,
    profilephotoid character varying COLLATE pg_catalog."default",
    updatetime timestamp without time zone,
    creationtime timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	bio character varying COLLATE pg_catalog."default",
    CONSTRAINT userdetail_pkey PRIMARY KEY (id)
);

-- Table: palateapp.userselectedpreference

DROP TABLE IF EXISTS palateapp.userselectedpreference cascade;

CREATE TABLE IF NOT EXISTS palateapp.userselectedpreference
(
    id BIGSERIAL NOT NULL,
    userid integer,
	preferenceid integer,
    preferencevalue character varying COLLATE pg_catalog."default",
	creationtime timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT userselectedpreference_pkey PRIMARY KEY (id),
    CONSTRAINT fk_prefid FOREIGN KEY (preferenceid)
        REFERENCES palateapp.preferencekeys (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_userid FOREIGN KEY (userid)
        REFERENCES palateapp.userdetail (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
	CONSTRAINT unique_user_preference_combination UNIQUE (userid, preferenceid)
);
	
-- Table: palateapp.vendor

DROP TABLE IF EXISTS palateapp.vendor cascade;

CREATE TABLE IF NOT EXISTS palateapp.vendor
(
    id BIGSERIAL NOT NULL,
    location character varying,
    vendortype character varying,
    vendorname character varying,
    addressline1 character varying,
    addressline2 character varying,
    city character varying,
    state character varying,
    country character varying,
    postalcode character varying,
    phonenumber character varying,
	creationtime timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT vendor_pkey PRIMARY KEY (id)
);

-- Table: palateapp.dishreview

DROP TABLE IF EXISTS palateapp.dishreview cascade;

CREATE TABLE IF NOT EXISTS palateapp.dishreview
(
    id BIGSERIAL NOT NULL,
	userid integer,
	dishid integer,
	cuisinetype character varying COLLATE pg_catalog."default",
	rating integer,
	photoid character varying COLLATE pg_catalog."default",
	dishprice double precision,
	vendorid integer,
	creationtime timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
	dishname character varying COLLATE pg_catalog."default",
    diet character varying COLLATE pg_catalog."default",
    dishtypes character varying[] COLLATE pg_catalog."default",	
	validimage boolean NOT NULL DEFAULT 'true',
	location geography(Point,4326),
    dynamiclink character varying COLLATE pg_catalog."default",
    CONSTRAINT dishreview_pkey PRIMARY KEY (id),
    CONSTRAINT dishreview_ratingid_fkey FOREIGN KEY (rating)
        REFERENCES palateapp.dishrating (ratingid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,	
    CONSTRAINT dishreview_userid_fkey FOREIGN KEY (userid)
        REFERENCES palateapp.userdetail (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT dishreview_vendorid_fkey FOREIGN KEY (vendorid)
        REFERENCES palateapp.vendor (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION			
);


-- Table: palateapp.userbuddies

DROP TABLE IF EXISTS palateapp.userbuddies cascade;

CREATE TABLE IF NOT EXISTS palateapp.userbuddies
(
    id BIGSERIAL NOT NULL,
    userid integer,
    buddyid integer,
    CONSTRAINT userbuddies_pkey PRIMARY KEY (id),
    CONSTRAINT userbuddies_buddyid_fkey FOREIGN KEY (userid)
        REFERENCES palateapp.userdetail (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT userbuddies_userid_fkey FOREIGN KEY (userid)
        REFERENCES palateapp.userdetail (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: palateapp.usertoken

DROP TABLE IF EXISTS palateapp.usertoken;

CREATE TABLE IF NOT EXISTS palateapp.usertoken
(
    id BIGSERIAL NOT NULL,
    phonenumber bigint,
    tokenvalue character varying COLLATE pg_catalog."default",
    refreshtokenvalue character varying COLLATE pg_catalog."default",
    CONSTRAINT useusertoken_pkey PRIMARY KEY (id)
);

