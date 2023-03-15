DROP TABLE IF EXISTS etiquetas_articulos CASCADE;
DROP TABLE IF EXISTS articulos_facturas CASCADE;
DROP TABLE IF EXISTS facturas CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS articulos CASCADE;
DROP TABLE IF EXISTS etiquetas CASCADE;

CREATE TABLE etiquetas (
    id          bigserial     PRIMARY KEY,
    nombre      varchar(255)  UNIQUE NOT NULL
);

CREATE TABLE articulos (
    id              bigserial     PRIMARY KEY,
    codigo          varchar(13)   NOT NULL UNIQUE,
    descripcion     varchar(255)  NOT NULL,
    precio          numeric(7, 2) NOT NULL,
    stock           int           NOT NULL
);

CREATE TABLE usuarios (
    id       bigserial    PRIMARY KEY,
    usuario  varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    validado bool         NOT NULL
);

CREATE TABLE facturas (
    id         bigserial  PRIMARY KEY,
    created_at timestamp  NOT NULL DEFAULT localtimestamp(0),
    usuario_id bigint NOT NULL REFERENCES usuarios (id)
);

-- Crear tabla después de haber creado las tablas de las que depende
CREATE TABLE etiquetas_articulos (
    id_etiqueta bigint NOT NULL REFERENCES etiquetas(id),
    id_articulo bigint NOT NULL REFERENCES articulos(id),
    PRIMARY KEY (id_etiqueta, id_articulo)
);

CREATE TABLE articulos_facturas (
    articulo_id bigint NOT NULL REFERENCES articulos (id),
    factura_id  bigint NOT NULL REFERENCES facturas (id),
    cantidad    int    NOT NULL,
    PRIMARY KEY (articulo_id, factura_id)
);

-- Carga inicial de datos de prueba:

INSERT INTO etiquetas (nombre)
    VALUES('alimentación'),
            ('juguetes'),
            ('ferreteria');

INSERT INTO articulos (codigo, descripcion, precio, stock)
    VALUES ('18273892389', 'Yogur piña', 200.50, 4),
           ('83745828273', 'Tigretón', 50.10, 2),
           ('51736128495', 'Disco duro SSD 500 GB', 150.30, 0),
           ('83746828273', 'Tigretón', 50.10, 3),
           ('51786128435', 'Disco duro SSD 500 GB', 150.30, 5),
           ('83745228673', 'Tigretón', 50.10, 8),
           ('51786198495', 'Disco duro SSD 500 GB', 150.30, 1);

INSERT INTO etiquetas_articulos(id_articulo, id_etiqueta)    
        VALUES(1, 1), (1, 2), (3, 1), (2, 1), (4, 2), (5, 1), (6, 1), (7, 3);

INSERT INTO usuarios (usuario, password, validado)
    VALUES ('admin', crypt('admin', gen_salt('bf', 10)), true),
           ('pepe', crypt('pepe', gen_salt('bf', 10)), false);
