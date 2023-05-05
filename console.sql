BEGIN;


DROP TABLE IF EXISTS public."BENEFICIOS";

CREATE TABLE IF NOT EXISTS public."BENEFICIOS"
(
    id bigint NOT NULL,
    nombre_beneficio varchar(150) COLLATE pg_catalog."default",
    is_covered varchar(15) COLLATE pg_catalog."default",
    quant_limit_on_svc varchar(15) COLLATE pg_catalog."default",
    explicacion varchar(1750) COLLATE pg_catalog."default",
    is_excel_from_inn_moop varchar(15) COLLATE pg_catalog."default",
    is_excel_from_onn_moop varchar(15) COLLATE pg_catalog."default",
    plan_id varchar(50) COLLATE pg_catalog."default",
    CONSTRAINT "BENEFICIOS_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."CANTIDADES";

CREATE TABLE IF NOT EXISTS public."CANTIDADES"
(
    id bigint NOT NULL,
    limite bigint,
    unidad_limite varchar(50) COLLATE pg_catalog."default",
    beneficio_id bigint,
    CONSTRAINT "CANTIDADES_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."COSTOS";

CREATE TABLE IF NOT EXISTS public."COSTOS"
(
    id bigint NOT NULL,
    beneficio_id bigint,
    copay_inn_tier1 varchar(50) COLLATE pg_catalog."default",
    copay_inn_tier2 varchar(50) COLLATE pg_catalog."default",
    copay_out_of_net varchar(50) COLLATE pg_catalog."default",
    coins_inn_tier1 varchar(50) COLLATE pg_catalog."default",
    coins_inn_tier2 varchar(50) COLLATE pg_catalog."default",
    cost_out_of_net varchar(50) COLLATE pg_catalog."default",
    CONSTRAINT "COSTOS_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."EDADES";

CREATE TABLE IF NOT EXISTS public."EDADES"
(
    id varchar(15) COLLATE pg_catalog."default" NOT NULL,
    estado_id bigint,
    edad varchar(50) COLLATE pg_catalog."default",
    cantidad_edades bigint,
    CONSTRAINT "EDADES_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."EDADES_SEGUROS";

CREATE TABLE IF NOT EXISTS public."EDADES_SEGUROS"
(
    id bigint NOT NULL,
    plan_id varchar(50) COLLATE pg_catalog."default",
    edad varchar(15) COLLATE pg_catalog."default",
    CONSTRAINT "EDADES_SEGUROS_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."EDUCACION";

CREATE TABLE IF NOT EXISTS public."EDUCACION"
(
    id bigint NOT NULL,
    edad_id varchar(15) COLLATE pg_catalog."default",
    grado varchar(50) COLLATE pg_catalog."default",
    cantidad_educacion bigint,
    CONSTRAINT "EDUCACION_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."ESTADOS";

CREATE TABLE IF NOT EXISTS public."ESTADOS"
(
    id bigint NOT NULL,
    nombre varchar(50) COLLATE pg_catalog."default",
    CONSTRAINT "ESTADOS_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."ESTADOS_CIVILES";

CREATE TABLE IF NOT EXISTS public."ESTADOS_CIVILES"
(
    id bigint NOT NULL,
    edad_id varchar(15) COLLATE pg_catalog."default",
    estado_civil varchar(50) COLLATE pg_catalog."default",
    cantidad_civil bigint,
    CONSTRAINT "ESTADOS_CIVILES_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."ETNIAS";

CREATE TABLE IF NOT EXISTS public."ETNIAS"
(
    id bigint NOT NULL,
    edad_id varchar(15) COLLATE pg_catalog."default",
    etnia varchar(50) COLLATE pg_catalog."default",
    cantidad_etnias bigint,
    CONSTRAINT "ETNIAS_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."FECHAS_TASAS";

CREATE TABLE IF NOT EXISTS public."FECHAS_TASAS"
(
    id bigint NOT NULL,
    edad_seguro_id bigint,
    fecha_efectiva varchar(15) COLLATE pg_catalog."default",
    fecha_expiracion varchar(15) COLLATE pg_catalog."default",
    CONSTRAINT "FECHAS_TASAS_pkey" PRIMARY KEY (id)
);


DROP TABLE IF EXISTS public."HOGARES";

CREATE TABLE IF NOT EXISTS public."HOGARES"
(
    id bigint NOT NULL,
    edad_id varchar(15) COLLATE pg_catalog."default",
    personas varchar(50) COLLATE pg_catalog."default",
    cantidad_hogares bigint,
    CONSTRAINT "HOGARES_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."INGRESOS";

CREATE TABLE IF NOT EXISTS public."INGRESOS"
(
    id bigint NOT NULL,
    edad_id varchar(15) COLLATE pg_catalog."default",
    ingresos varchar(50) COLLATE pg_catalog."default",
    cantidad_ingresos bigint,
    CONSTRAINT "INGRESOS_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."PLANES";

CREATE TABLE IF NOT EXISTS public."PLANES"
(
    id varchar(25) COLLATE pg_catalog."default" NOT NULL,
    estado_id bigint,
    nombre_plan varchar(200) COLLATE pg_catalog."default",
    tipo varchar(10) COLLATE pg_catalog."default",
    nivel_metal varchar(15) COLLATE pg_catalog."default",
    nombre_proveedor varchar(100) COLLATE pg_catalog."default",
    CONSTRAINT "PLANES_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."TARIFAS_GRUPALES";

CREATE TABLE IF NOT EXISTS public."TARIFAS_GRUPALES"
(
    id bigint NOT NULL,
    fechas_id bigint,
    tarifa_parejas double precision,
    beneficiario_un_dependiente double precision,
    beneficiario_dos_dependientes double precision,
    beneficiario_tres_mas_dependientes double precision,
    pareja_un_dependientes double precision,
    pareja_dos_dependientes double precision,
    pareja_tres_mas_dependientes double precision,
    CONSTRAINT "TARIFAS_GRUPALES_pkey" PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public."TASAS_INDIVIDUALES";

CREATE TABLE IF NOT EXISTS public."TASAS_INDIVIDUALES"
(
    id bigint NOT NULL,
    fechas_id bigint,
    tarifa double precision,
    CONSTRAINT "TASAS_INDIVIDUALES_pkey" PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public."BENEFICIOS"
    ADD CONSTRAINT fk_beneficios_cod_planes FOREIGN KEY (plan_id)
    REFERENCES public."PLANES" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."CANTIDADES"
    ADD CONSTRAINT fk_cantidades_cod_beneficios FOREIGN KEY (beneficio_id)
    REFERENCES public."BENEFICIOS" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."COSTOS"
    ADD CONSTRAINT fk_costos_cod_beneficios FOREIGN KEY (beneficio_id)
    REFERENCES public."BENEFICIOS" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."EDADES"
    ADD CONSTRAINT fk_edades_cod_estados FOREIGN KEY (estado_id)
    REFERENCES public."ESTADOS" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."EDADES_SEGUROS"
    ADD CONSTRAINT fk_edads_cod_planes FOREIGN KEY (plan_id)
    REFERENCES public."PLANES" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."EDUCACION"
    ADD CONSTRAINT fk_educacion_cod_edades FOREIGN KEY (edad_id)
    REFERENCES public."EDADES" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ESTADOS_CIVILES"
    ADD CONSTRAINT fk_civiles_cod_edades FOREIGN KEY (edad_id)
    REFERENCES public."EDADES" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ETNIAS"
    ADD CONSTRAINT fk_etnias_cod_edades FOREIGN KEY (edad_id)
    REFERENCES public."EDADES" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."FECHAS_TASAS"
    ADD CONSTRAINT fk_fechas_cod_edads FOREIGN KEY (edad_seguro_id)
    REFERENCES public."EDADES_SEGUROS" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."HOGARES"
    ADD CONSTRAINT fk_hogares_cod_edades FOREIGN KEY (edad_id)
    REFERENCES public."EDADES" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."INGRESOS"
    ADD CONSTRAINT fk_ingresos_cod_edades FOREIGN KEY (edad_id)
    REFERENCES public."EDADES" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PLANES"
    ADD CONSTRAINT fk_planes_cod_estados FOREIGN KEY (estado_id)
    REFERENCES public."ESTADOS" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."TARIFAS_GRUPALES"
    ADD CONSTRAINT fk_tarifasg_cod_fechas FOREIGN KEY (fechas_id)
    REFERENCES public."FECHAS_TASAS" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."TASAS_INDIVIDUALES"
    ADD CONSTRAINT fk_tarifasi_cod_fechas FOREIGN KEY (fechas_id)
    REFERENCES public."FECHAS_TASAS" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;