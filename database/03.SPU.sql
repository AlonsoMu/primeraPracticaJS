USE appstore1;

DELIMITER $$
CREATE PROCEDURE spu_productos_listar()
BEGIN 
	SELECT pro.idproducto, 
	cat.categoria, 
	pro.descripcion, 
	pro.precio, 
	pro.garantia, 
	pro.fotografia
	FROM productos pro
	INNER JOIN categorias cat ON cat.idcategoria = pro.idcategoria
	WHERE pro.inactive_at IS NULL;
END $$

DELIMITER $$
CREATE PROCEDURE spu_productos_buscar(IN _idproducto INT)
BEGIN 
	SELECT pro.idproducto, 
	cat.categoria, 
	pro.descripcion, 
	pro.precio, 
	pro.garantia, 
	pro.fotografia
	FROM productos pro
	INNER JOIN categorias cat ON pro.idcategoria = cat.idcategoria
	WHERE pro.idproducto = _idproducto;
END $$


DELIMITER $$
CREATE PROCEDURE spu_productos_registrar
(
	IN _idcategoria	INT,
	IN _descripcion 	VARCHAR(150),
	IN _precio			FLOAT(7,2),
	IN _garantia		TINYINT,
	IN _fotografia		VARCHAR(200)
)
BEGIN
	INSERT INTO productos
		(idcategoria, descripcion, precio, garantia, fotografia)
		VALUES
		(_idcategoria, _descripcion, _precio, _garantia, NULLIF(_fotografia, ''));
	
    -- Nos devuelve el ultimo valor agregado
    SELECT @@last_insert_id 'idproducto';
END $$

-- En cualquier proceso de consulta/listado/búsqueda, debemos recuperar PK
DROP PROCEDURE spu_categorias_listar
DELIMITER $$
CREATE PROCEDURE spu_categorias_listar()
BEGIN
	SELECT idcategoria, categoria FROM categorias
	WHERE inactive_at IS NULL;
END $$

DELIMITER $$
CREATE PROCEDURE spu_categorias_registrar(
	IN _categoria 	VARCHAR(30)
)
BEGIN
	INSERT INTO categorias (categoria) VALUES (_categoria);
END $$

DELIMITER $$
CREATE PROCEDURE spu_productos_eliminar(IN _idproducto INT)
BEGIN
	UPDATE productos
    SET inactive_at = NOW()
    WHERE idproducto = _idproducto;
END $$

DELIMITER $$
CREATE PROCEDURE spu_roles_listar()
BEGIN
	SELECT idrol, rol FROM roles
    WHERE inactive_at IS NULL;
END $$

DELIMITER $$
CREATE PROCEDURE spu_nacionalidades_listar()
BEGIN
	SELECT idnacionalidad, nombrepais, nombrecorto FROM nacionalidades;
END $$

DELIMITER $$
CREATE PROCEDURE spu_usuarios_listar()
BEGIN
	SELECT
		USU.idusuario,
		ROL.rol,
		NAC.nombrepais,
        USU.avatar,
		USU.apellidos,
		USU.nombres
		FROM usuarios USU
		INNER JOIN roles ROL ON ROL.idrol = USU.idrol
		INNER JOIN nacionalidades NAC ON NAC.idnacionalidad = USU.idnacionalidad
		WHERE USU.inactive_at IS NULL;
END $$

DELIMITER $$
CREATE PROCEDURE spu_usuarios_registrar(
	IN _idrol 		INT,
	IN _idnacionalidad	INT,
	IN _avatar		VARCHAR(200),
	IN _apellidos		VARCHAR(30),
	IN _nombres 		VARCHAR(30),
	IN _email 		VARCHAR(50),
	IN _claveacceso		VARCHAR(100)
)
BEGIN
	INSERT INTO usuarios
		(idrol, idnacionalidad, avatar, apellidos, nombres, email, claveacceso)
	VALUES
	(_idrol, _idnacionalidad, NULLIF(_avatar, ''), _apellidos, _nombres, _email, _claveacceso);

	SELECT @@last_insert_id 'idusuario';

END $$

DELIMITER $$
CREATE PROCEDURE spu_usuarios_eliminar(IN _idusuario INT)
BEGIN
	UPDATE usuarios
    SET inactive_at = NOW()
    WHERE idusuario = _idusuario;
END $$

SELECT * FROM nacionalidades;
SELECT * FROM roles;
SELECT * FROM productos;
SELECT * FROM usuarios;
CALL spu_usuarios_listar();
CALL spu_roles_listar();
CALL spu_nacionalidades_listar();
CALL spu_usuarios_registrar(1, 1, '', 'Hernandez Yerén', 'Yorghet', 'yorghet@gmail.com', '123456');
CALL spu_usuarios_registrar(1, 50, '', 'Muñoz Quispe', 'Alonso', 'alonso@gmail.com', '123456');
CALL spu_productos_registrar(1,'ProductoA', 4500, 12, '');
CALL spu_productos_registrar(2,'ProductoB', 500, 24, '');
CALL spu_categorias_registrar("Laptop");
CALL spu_categorias_listar();
CALL spu_productos_listar();
CALL spu_productos_buscar(1);
DELETE FROM productos;
ALTER TABLE productos AUTO_INCREMENT 1;

DELETE FROM usuarios;
ALTER TABLE usuarios AUTO_INCREMENT 1;