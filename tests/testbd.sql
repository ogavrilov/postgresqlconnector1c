CREATE DATABASE test_bd;

\c test_bd

CREATE TABLE public.test_types (
	"id" bigint PRIMARY KEY,
	"varchar_field" varchar(32),
	"text_field" text,
	"char_field" char,
	"binary_field" bytea,
	"boolean_field" bool,
	"int2_field" int2,
	"int4_field" int4,
	"int8_field" int8,
	"money_field" money,
	"float4_field" float4,
	"float8_field" float8,
	"numeric_field" numeric,
	"date_field" date,
	"timestamp_field" timestamp without time zone,
	"timestampz_field" timestamp with time zone,
	"time_field" time without time zone,
	"timez_field" time with time zone,
	"uuid_field" uuid,
	"xml_field" xml,
	"json_field" json,
	"jsonb_field" jsonb
	);
