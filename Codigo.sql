SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Marca` (
  `ID Marca` INT NOT NULL AUTO_INCREMENT,
  `Rut` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Fecha Creación` DATE NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID Marca`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `Nombre Usuario` VARCHAR(45) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre Usuario`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `ID Cliente` INT NOT NULL AUTO_INCREMENT,
  `Usuario_Nombre Usuario` VARCHAR(45) NOT NULL,
  `Banco` VARCHAR(45) NOT NULL,
  `Numero Cuenta` INT NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID Cliente`),
  CONSTRAINT `fk_Cliente_Usuario`
    FOREIGN KEY (`Usuario_Nombre Usuario`)
    REFERENCES `mydb`.`Usuario` (`Nombre Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cliente_Usuario_idx` ON `mydb`.`Cliente` (`Usuario_Nombre Usuario` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Empresa` (
  `Rut` INT NOT NULL,
  `Cliente_ID` INT NOT NULL,
  `Rubro` VARCHAR(45) NOT NULL,
  `Nombre Fantasía` VARCHAR(45) NOT NULL,
  `Teléfono` INT NOT NULL,
  `Rut RL` INT NOT NULL,
  `Nombre RL` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Rut`),
  CONSTRAINT `fk_Empresa_Cliente1`
    FOREIGN KEY (`Cliente_ID`)
    REFERENCES `mydb`.`Cliente` (`ID Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Empresa_Cliente1_idx` ON `mydb`.`Empresa` (`Cliente_ID` ASC) VISIBLE;
CREATE UNIQUE INDEX `Rut_UNIQUE` ON `mydb`.`Empresa` (`Rut` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Natural` (
  `Rut` INT NOT NULL,
  `Cliente_ID` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `ApPaterno` VARCHAR(45) NOT NULL,
  `ApMaterno` VARCHAR(45) NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL,
  `Región` VARCHAR(45) NOT NULL,
  `Fecha Nacimiento` DATE NOT NULL,
  `Sexo` VARCHAR(45) NULL DEFAULT '##Sexo no especificado##',
  `Celular` INT NOT NULL,
  `Fecha Registro` DATE NOT NULL,
  PRIMARY KEY (`Rut`),
  CONSTRAINT `fk_Natural_Cliente1`
    FOREIGN KEY (`Cliente_ID`)
    REFERENCES `mydb`.`Cliente` (`ID Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Natural_Cliente1_idx` ON `mydb`.`Natural` (`Cliente_ID` ASC) VISIBLE;
CREATE UNIQUE INDEX `Rut_UNIQUE` ON `mydb`.`Natural` (`Rut` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Trabajador` (
  `Rut` INT NOT NULL,
  `Usuario_Nombre Usuario` VARCHAR(45) NOT NULL,
  `Marca_ID Marca` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `ApPaterno` VARCHAR(45) NOT NULL,
  `ApMaterno` VARCHAR(45) NOT NULL,
  `Fecha Registro` DATE NOT NULL,
  PRIMARY KEY (`Rut`),
  CONSTRAINT `fk_Trabajador_Usuario1`
    FOREIGN KEY (`Usuario_Nombre Usuario`)
    REFERENCES `mydb`.`Usuario` (`Nombre Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajador_Marca1`
    FOREIGN KEY (`Marca_ID Marca`)
    REFERENCES `mydb`.`Marca` (`ID Marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Trabajador_Usuario1_idx` ON `mydb`.`Trabajador` (`Usuario_Nombre Usuario` ASC) VISIBLE;
CREATE INDEX `fk_Trabajador_Marca1_idx` ON `mydb`.`Trabajador` (`Marca_ID Marca` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Zapato` (
  `ID Zapato` INT NOT NULL AUTO_INCREMENT,
  `Marca_ID Marca` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Descripción` VARCHAR(100) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `Talla` INT NOT NULL,
  `Temporada` VARCHAR(45) NOT NULL,
  `Material` VARCHAR(45) NOT NULL,
  `Foto1` VARCHAR(45) NOT NULL,
  `Foto2` VARCHAR(45) NOT NULL,
  `Foto3` VARCHAR(45) NOT NULL,
  `Precio` INT NOT NULL,
  `Stock` INT NOT NULL,
  `Seguridad o no` TINYINT NOT NULL,
  PRIMARY KEY (`ID Zapato`),
  CONSTRAINT `fk_Zapato_Marca1`
    FOREIGN KEY (`Marca_ID Marca`)
    REFERENCES `mydb`.`Marca` (`ID Marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Zapato_Marca1_idx` ON `mydb`.`Zapato` (`Marca_ID Marca` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Oferta` (
  `ID Oferta` INT NOT NULL auto_increment,
  `Marca_ID Marca` INT NOT NULL,
  `Fecha Inicio` DATE NOT NULL,
  `Fecha Término` DATE NOT NULL,
  `Porcentaje` INT NOT NULL,
  PRIMARY KEY (`ID Oferta`),
  CONSTRAINT `fk_Oferta_Marca1`
    FOREIGN KEY (`Marca_ID Marca`)
    REFERENCES `mydb`.`Marca` (`ID Marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Oferta_Marca1_idx` ON `mydb`.`Oferta` (`Marca_ID Marca` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Zapato_has_Oferta` (
  `Zapato_ID Zapato` INT NOT NULL,
  `Oferta_ID Oferta` INT NOT NULL,
  PRIMARY KEY (`Zapato_ID Zapato`, `Oferta_ID Oferta`),
  CONSTRAINT `fk_Zapato_has_Oferta_Zapato1`
    FOREIGN KEY (`Zapato_ID Zapato`)
    REFERENCES `mydb`.`Zapato` (`ID Zapato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zapato_has_Oferta_Oferta1`
    FOREIGN KEY (`Oferta_ID Oferta`)
    REFERENCES `mydb`.`Oferta` (`ID Oferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Zapato_has_Oferta_Oferta1_idx` ON `mydb`.`Zapato_has_Oferta` (`Oferta_ID Oferta` ASC) VISIBLE;
CREATE INDEX `fk_Zapato_has_Oferta_Zapato1_idx` ON `mydb`.`Zapato_has_Oferta` (`Zapato_ID Zapato` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Compra` (
  `ID Compra` INT NOT NULL AUTO_INCREMENT,
  `Cliente_ID Cliente` INT NOT NULL,
  `Dirección Despacho` VARCHAR(45) NOT NULL,
  `Coste Despacho` INT NOT NULL,
  `Medio de Pago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID Compra`),
  CONSTRAINT `fk_Compra_Cliente1`
    FOREIGN KEY (`Cliente_ID Cliente`)
    REFERENCES `mydb`.`Cliente` (`ID Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Compra_Cliente1_idx` ON `mydb`.`Compra` (`Cliente_ID Cliente` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Descuento` (
  `ID Descuento` INT NOT NULL AUTO_INCREMENT,
  `Cliente_ID Cliente` INT NOT NULL,
  `Compra_ID Compra` INT NULL,
  `Motivo` VARCHAR(45) NOT NULL,
  `Gastado o Vencido` TINYINT NOT NULL,
  `Monto` INT NOT NULL,
  PRIMARY KEY (`ID Descuento`),
  CONSTRAINT `fk_Descuento_Cliente1`
    FOREIGN KEY (`Cliente_ID Cliente`)
    REFERENCES `mydb`.`Cliente` (`ID Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Descuento_Compra1`
    FOREIGN KEY (`Compra_ID Compra`)
    REFERENCES `mydb`.`Compra` (`ID Compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Descuento_Cliente1_idx` ON `mydb`.`Descuento` (`Cliente_ID Cliente` ASC) VISIBLE;
CREATE INDEX `fk_Descuento_Compra1_idx` ON `mydb`.`Descuento` (`Compra_ID Compra` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Devolución` (
  `Código Devolución` INT NOT NULL AUTO_INCREMENT,
  `Cliente_ID Cliente` INT NOT NULL,
  `Descuento_ID Descuento` INT NOT NULL,
  `Razón` VARCHAR(45) NULL DEFAULT '##Razón no entregada##',
  PRIMARY KEY (`Código Devolución`),
  CONSTRAINT `fk_Devolución_Descuento1`
    FOREIGN KEY (`Descuento_ID Descuento`)
    REFERENCES `mydb`.`Descuento` (`ID Descuento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Devolución_Cliente1`
    FOREIGN KEY (`Cliente_ID Cliente`)
    REFERENCES `mydb`.`Cliente` (`ID Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Devolución_Descuento1_idx` ON `mydb`.`Devolución` (`Descuento_ID Descuento` ASC) VISIBLE;
CREATE INDEX `fk_Devolución_Cliente1_idx` ON `mydb`.`Devolución` (`Cliente_ID Cliente` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Zapato_has_Compra` (
  `Zapato_ID Zapato` INT NOT NULL,
  `Compra_ID Compra` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`Zapato_ID Zapato`, `Compra_ID Compra`),
  CONSTRAINT `fk_Zapato_has_Compra_Zapato1`
    FOREIGN KEY (`Zapato_ID Zapato`)
    REFERENCES `mydb`.`Zapato` (`ID Zapato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zapato_has_Compra_Compra1`
    FOREIGN KEY (`Compra_ID Compra`)
    REFERENCES `mydb`.`Compra` (`ID Compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Zapato_has_Compra_Compra1_idx` ON `mydb`.`Zapato_has_Compra` (`Compra_ID Compra` ASC) VISIBLE;
CREATE INDEX `fk_Zapato_has_Compra_Zapato1_idx` ON `mydb`.`Zapato_has_Compra` (`Zapato_ID Zapato` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `mydb`.`Devolución_has_Zapato` (
  `Zapato_ID Zapato` INT NOT NULL,
  `Devolución_Código Devolución` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`Zapato_ID Zapato`, `Devolución_Código Devolución`),
  CONSTRAINT `fk_Devolución_has_Zapato_Devolución1`
    FOREIGN KEY (`Devolución_Código Devolución`)
    REFERENCES `mydb`.`Devolución` (`Código Devolución`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Devolución_has_Zapato_Zapato1`
    FOREIGN KEY (`Zapato_ID Zapato`)
    REFERENCES `mydb`.`Zapato` (`ID Zapato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Devolución_has_Zapato_Zapato1_idx` ON `mydb`.`Devolución_has_Zapato` (`Zapato_ID Zapato` ASC) VISIBLE;
CREATE INDEX `fk_Devolución_has_Zapato_Devolución1_idx` ON `mydb`.`Devolución_has_Zapato` (`Devolución_Código Devolución` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into marca (`Rut`, `Nombre`, `Fecha Creación`, `Dirección`, `Correo`) values
(5834,'Adidas', '1949-08-18', 'Espoz 3150, Vitacura', 'atencion@adidas.cl'),
(7564,'Nike', '1964-01-25', 'Isidora Goyenechea 3365, Las Condes', 'atencion_cl@nike.com'),
(3452,'Bubblegummers', '1977-05-12', 'Camino a Melipilla 9460, Maipú', 'atencion@bubblegummers.cl'),
(8765,'Converse', '1908-02-15', 'Huerfanos 830, Santiago', 'atencion_cl@converse.com'),
(4574,'Vans', '1966-03-16', 'Av. Américo Vespucio 399, Maipú', 'atencion_cl@vans.com');
select * from marca;

insert into Usuario values 
('Paris', 'rep_legal@paris.cl', 'hkjljd5784g'),
('Falabella', 'rep_legal@falabella.cl', 'nbhftn74nhjk'),
('Johnsons', 'rep_legal@johnsons.cl', '5h43bfkdsbv'),
('H&M', 'rep_legal@acheyeme.cl', 'b4n74nhjksxdftg'),
('Shein', 'rep_legal@shein.cl', 'h46dsbvuiggfb'),
('Juancito11', 'juancito11@gmail.com', 'aguantebulla'),
('pedrordep', 'ordepedro@yahoo.com', 'anitalavalatina'),
('Juancito12', 'juancito12@gmail.com', 'aguantebullb'),
('Juancito13', 'juancito13@gmail.com', 'aguantebullc'),
('meemoo', 'esto_es_epico@yahoo.com', 'thor_pesa'),
('JoseFlores', 'jose_flores@gmail.com', 'brasilcampeao#1'),
('RobertoPlaza', 'roberto_plasa_en_la_casa@gmail.com', 'plasaconzeta'),
('JaimeContreras', 'jotunhaime@gmail.com', 'gow5goty'),
('NataliaGaldames', 'illuminaty@gmail.com', 'eyou3214'),
('AlexGaldames', 'hermanaxD@gmail.com', 'easports');
select * from Usuario;

insert into Cliente (`Usuario_Nombre Usuario`, `Banco`, `Numero Cuenta`, `Dirección`) values 
('Paris', 'Estado', 4121234, 'Calle Alelí 1234, Chillota'),
('Falabella', 'Estado', 12341234, 'Av. Camioneta -12344442, Pudaipú'),
('Johnsons', 'Estado', 23321423, 'Calle Walaby 42, Sydney'),
('H&M', 'Estado', 63424, 'Psj. A 1, Kendrick Navia'),
('Shein', 'Estado', 65433212, 'Vivo en 1, Puente Florido'),
('Juancito11', 'Estado', 123141234, 'Robos Blvd. 4, Provialto'),
('pedrordep', 'Estado', 2323453, 'Calle Avenida sqrt(3), Perulandia'),
('Juancito12', 'santander', 45745, 'Avenida Calle 777, Encaramessi'),
('Juancito13', 'Estado', 0987654, 'Ole Oleoleole 789, Cazzelindes Colindantes'),
('meemoo', 'Estado', 23456789, 'Pi Calle 3.141592653589793, Melipi Ya');
select* from Cliente;

insert into Empresa values 
(56455, 1, 'Ropa', 'Paris', 3607326, 12974, 'Hugo Pato'),
(98798, 2, 'Ropa', 'Falabella', 3746583, 46795, 'Paco Pato'),
(20558, 3, 'Ropa', 'Johnsons', 8475628, 69792, 'Luis Pato'),
(27030, 4, 'Ropa', 'H&M', 0987652, 1158, 'Joel McHale'),
(1411 , 5, 'Ropa', 'Shein', 6583920, 55333, 'Danny Pudi');
select* from Empresa;

insert into `Natural` values 
(12343, 6, 'Juan', 'Cito', 'Sheesh', 'Santiago', 'Metropolitana', '1987-12-12', 'Hombre', '1234543', '2012-01-01'),
(65345, 7, 'Pedro', 'McDuck', 'Sheeran', 'Santiago', 'Metropolitana', '1984-02-18', 'Hombre', '5432543', '2016-01-01'),
(23432, 8, 'Juan', 'Zote', 'Tazo', 'Santiago', 'Metropolitana', '1987-12-12', 'Hombre', '1234543', '2012-01-01'),
(09876, 9, 'Juan', 'Zárate', 'Barrasium', 'Santiago', 'Metropolitana', '1987-12-12', 'Hombre', '1234543', '2012-01-01'),
(56778, 10, 'Domingo', 'Ocholoco', 'Zysygy', 'Santiago', 'Metropolitana', '1987-12-12', 'Hombre', '1234543', '2012-01-01');
select* from `Natural`;

insert into Trabajador values 
(28478, 'JoseFlores', 1, 'Jose', 'Flores', 'Gonzalez', '2016-01-01'),
(23434, 'RobertoPlaza', 2, 'Roberto', 'Plaza', 'Barriga', '2015-01-01'),
(87654, 'JaimeContreras', 3, 'Jaime', 'Contreras', 'Meza', '2014-01-01'),
(54378, 'NataliaGaldames', 4, 'Natalia', 'Galdames', 'Segoviano', '2013-01-01'),
(12654, 'AlexGaldames', 5, 'Alex', 'Galdames', 'Gomez', '2022-01-01');
select * from Trabajador;

insert into Zapato (`Marca_ID Marca`,`Tipo`,`Descripción`,`Color`,`Talla`,`Temporada`,`Material`,`Foto1`,`Foto2`,`Foto3`,`Precio`,`Stock`,`Seguridad o no`) values
(1, 'Zapatilla Outdoor', 'Entresuela moldeada que brinda una óptima amortiguación', 'Negro', 40, 'Verano', 'Primegreen', 'foto1adidas.jpg', 'foto2adidas.jpg', 'foto3adidas.jpg', 50400, 67, 0),
(2, 'Zapatilla Deportiva', 'Soft Foam: Sistema que otorga amortiguación y comodidad, proporcionando suavidad al andar', 'Negro', 40, 'Verano', 'Poliester y goma', 'foto1nike.jpg', 'foto2nike.jpg', 'foto3nike.jpg', 24490, 45, 0),
(4, 'Zapatilla Urbana', 'Tipo de Punta: Redonda, Empeine: Moldeado, Tipo Ajuste: Cordón, Forma de Taco: Plataforma', 'Negro', 27, 'Otoño', 'Textil y gaucho', 'foto1converse.jpg', 'foto2converse.jpg', 'foto3converse.jpg', 52990, 119, 0),
(3, 'Zapatilla Deportiva', 'Cloudfoam: Suela suave con textura cómoda que proporciona una amortiguación y una tracción más firme', 'Celeste', 40, 'Verano', 'nylon y goma', 'foto1bg.jpg', 'foto2bg.jpg', 'foto3bg.jpg', 41990, 13, 0),
(5, 'Zapatilla Urbana', 'cordones vulcanizados, punta redonda, cuello acolchado para mayor comodidad', 'Celeste', 35, 'Verano', '51% Cuero, 41% Textil, 8% Caucho', 'foto1vans.jpg', 'foto2vans.jpg', 'foto3vans.jpg', 59990, 5, 0);
select * from Zapato;

insert into Oferta (`Marca_ID Marca`, `Fecha Inicio`, `Fecha Término`, `Porcentaje`) values
(4, '2022-11-28', '2022-12-05', 20),
(5, '2022-10-12', '2022-11-12', 35),
(3, '2022-12-12', '2022-12-13', 70),
(1, '2022-12-24', '2023-01-24', 10),
(2, '2022-10-10', '2022-12-12', 15);
select * from Oferta;

insert into Zapato_has_Oferta values (1,5), (2,4), (3,3), (4,2), (5,2), (5,1), (1,2), (1,3), (3,5);
select * from Zapato_has_oferta;

insert into Compra (`Cliente_ID Cliente`, `Dirección Despacho`, `Coste Despacho`, `Medio de Pago`) values
(1, 'Calle Alelí 1234, Chillota', 50000, 'factura'),
(6, 'Estados Unidos 231, Cerro Navia', 2500, 'debito'),
(5, 'Vivo En 1, Puente Florido', 2500, 'cheque'),
(10, 'Alcaldía de Lo Prado, Pudahuel', 10000, 'efectivo'),
(3, 'Calle Walaby 42, Sydney', 250000, 'monedas de oro');
select * from Compra;

insert into Zapato_has_Compra values
(1, 1, 400),
(2, 2, 2),
(3, 3, 30),
(4, 5, 200),
(5, 5, 200);
select * from Zapato_has_Compra;

insert into Descuento (`Cliente_ID Cliente`, `Compra_ID Compra`, `Motivo`, `Gastado o Vencido`, `Monto`) values
(1, NULL, 'Compra mayor a 550.000', 0, 104500),
(8, NULL, 'Devolucion', 0, 20000),
(7, NULL, 'Primera Compra', 0, 5000),
(5, NULL, 'Compra mayor a 550.000', 0, 760000),
(3, NULL, 'Devolucion', 0, 550000),
(1, NULL, 'Devolucion', 0, 20000),
(10, NULL, 'Devolucion', 0, 9990),
(9,NULL, 'Devolucion', 0, 64990);
select * from Descuento;

insert into Devolución (`Cliente_ID Cliente`, `Descuento_ID Descuento`, `Razón`) values
(8, 2, null),
(3, 5, 'Compra por error'),
(1, 6, 'Compra por error'),
(9, 8, 'no m gustaron'),
(10, 7, 'mi mama no me deja usarlos');
select * from devolución;

insert into Devolución_has_Zapato values
(3, 1, 2),
(5, 2, 15),
(2, 3, 200),
(4, 4, 1),
(1, 5, 1);
select * from devolución_has_zapato;

-- Ordenar el Precio de cada compra de menor a mayor valor
select `Compra_ID Compra` as `ID Compra`, sum(`Cantidad`*`Precio`) as `Precio Total` from 
Zapato_has_Compra join Zapato on Zapato_has_Compra.`Zapato_ID Zapato` = Zapato.`ID Zapato` group by `Compra_ID Compra` order by sum(`Cantidad`*`Precio`);

-- Encontrar Zapatos con 2 o más ofertas
select Zapato.`ID Zapato` as `ID Zapato`, COUNT(Zapato_has_oferta.`Oferta_ID Oferta`) as `N° Ofertas a las que pertenece el Zapato` from Zapato_has_oferta join 
Zapato on Zapato_has_oferta.`Zapato_ID Zapato` = Zapato.`ID Zapato` group by Zapato.`ID Zapato` having COUNT(Zapato_has_oferta.`Oferta_ID Oferta`) >= 2 order by COUNT(Zapato_has_oferta.`Oferta_ID Oferta`) DESC;

-- Encontrar las Marcas cuyas ofertas duran más de un mes
select `Nombre de Marca`, `Días que dura la Oferta` from (
	select Marca.`Nombre` as `Nombre de Marca`, DATEDIFF(Oferta.`Fecha Término`, Oferta.`Fecha Inicio`) as `Días que dura la Oferta` from 
    Marca join Oferta on Oferta.`Marca_ID Marca` = Marca.`ID Marca` order by DATEDIFF(Oferta.`Fecha Término`, Oferta.`Fecha Inicio`) DESC
) as `P` where `Días que dura la Oferta` > 30;

-- Clientes con menos de 100.000 pesos de descuento acumulado
select `Nombre de Usuario`, `Descuento Total` from (
select Cliente.`Usuario_Nombre Usuario` as `Nombre de Usuario`, sum(`Monto`) as `Descuento Total` from 
Descuento join Cliente on Cliente.`ID Cliente` = Descuento.`Cliente_ID Cliente` group by Cliente.`ID Cliente` order by sum(`Monto`) DESC
) as `S` where `Descuento Total` < 100000;

-- Nombre Completo del Trabajador que con más tiempo trabajando
select `Nombre Completo`, `Días Trabajados` as `Cantidad De Días Trabajados` from (
	select Concat(Nombre, ' ', ApPaterno, ' ', ApMaterno) as `Nombre Completo`, datediff(SYSDATE(), `Fecha Registro`) as `Días Trabajados` from Trabajador order by datediff(SYSDATE(), `Fecha Registro`) DESC
) as `TT` where `Días Trabajados` = (
	select max(datediff(SYSDATE(), `Fecha Registro`)) from Trabajador
);

-- Marca para la que trabaja el empleado con el nombre completo más largo
select Nom as `Nombre Trabajador`, Len as `N° de Caracteres en el nombre`, Mar as `Marca` from (
select concat(Trabajador.Nombre, ' ', Trabajador.ApPaterno, ' ', Trabajador.ApMaterno) as Nom, Marca.Nombre as Mar, length(concat(Trabajador.Nombre, Trabajador.ApPaterno, Trabajador.ApMaterno)) as Len from 
Trabajador join Marca on Marca.`ID Marca` = Trabajador.`Marca_ID Marca` order by length(Trabajador.`Usuario_Nombre Usuario`) DESC
) as `N` where Len = (select max(length(concat(Nombre, ApPaterno, ApMaterno))) from Trabajador);