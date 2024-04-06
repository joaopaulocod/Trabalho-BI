
CREATE TABLE public.dim_data (
                sk_data INTEGER NOT NULL,
                nk_data DATE NOT NULL,
                desc_data_completa VARCHAR(60) NOT NULL,
                nr_ano INTEGER NOT NULL,
                nm_trimestre VARCHAR(20) NOT NULL,
                nr_ano_trimestre VARCHAR(20) NOT NULL,
                nr_mes INTEGER NOT NULL,
                nm_mes VARCHAR(20) NOT NULL,
                ano_mes VARCHAR(20) NOT NULL,
                nr_semana INTEGER NOT NULL,
                ano_semana VARCHAR(20) NOT NULL,
                nr_dia INTEGER NOT NULL,
                nr_dia_ano INTEGER NOT NULL,
                nm_dia_semana VARCHAR(20) NOT NULL,
                flag_final_semana CHAR(3) NOT NULL,
                flag_feriado CHAR(3) NOT NULL,
                nm_feriado VARCHAR(60) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT sk_data_pk PRIMARY KEY (sk_data)
);


CREATE SEQUENCE public.dim_entrega_sk_entrega_seq;

CREATE TABLE public.dim_entrega (
                sk_entrega INTEGER NOT NULL DEFAULT nextval('public.dim_entrega_sk_entrega_seq'),
                nk_entrega INTEGER NOT NULL,
                nm_estado VARCHAR(30) NOT NULL,
                sg_estado VARCHAR(2) NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_entrega PRIMARY KEY (sk_entrega)
);


ALTER SEQUENCE public.dim_entrega_sk_entrega_seq OWNED BY public.dim_entrega.sk_entrega;

CREATE SEQUENCE public.dim_modelo_sk_modelo_seq;

CREATE TABLE public.dim_modelo (
                sk_modelo INTEGER NOT NULL DEFAULT nextval('public.dim_modelo_sk_modelo_seq'),
                nk_modelo INTEGER NOT NULL,
                preco NUMERIC(10,2) NOT NULL,
                nm_marca VARCHAR(30) NOT NULL,
                nm_modelo VARCHAR(30) NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_modelo PRIMARY KEY (sk_modelo)
);


ALTER SEQUENCE public.dim_modelo_sk_modelo_seq OWNED BY public.dim_modelo.sk_modelo;

CREATE SEQUENCE public.dim_vendedor_sk_vendedor_seq;

CREATE TABLE public.dim_vendedor (
                sk_vendedor INTEGER NOT NULL DEFAULT nextval('public.dim_vendedor_sk_vendedor_seq'),
                nk_vendedor INTEGER NOT NULL,
                nm_vendedor VARCHAR(100) NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_vendedor PRIMARY KEY (sk_vendedor)
);


ALTER SEQUENCE public.dim_vendedor_sk_vendedor_seq OWNED BY public.dim_vendedor.sk_vendedor;

CREATE TABLE public.ft_vendas (
                sk_vendedor INTEGER NOT NULL,
                sk_modelo INTEGER NOT NULL,
                sk_entrega INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                md_quantidade INTEGER NOT NULL
);


ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_data_ft_vendas_fk
FOREIGN KEY (sk_data)
REFERENCES public.dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_entrega_ft_vendas_fk
FOREIGN KEY (sk_entrega)
REFERENCES public.dim_entrega (sk_entrega)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_modelo_ft_vendas_fk
FOREIGN KEY (sk_modelo)
REFERENCES public.dim_modelo (sk_modelo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_vendedor_ft_vendas_fk
FOREIGN KEY (sk_vendedor)
REFERENCES public.dim_vendedor (sk_vendedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
