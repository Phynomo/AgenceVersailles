CREATE DATABASE dbAgenceVersailles
GO
use dbAgenceVersailles
GO
--Creacion de Esquemas
CREATE SCHEMA gral
GO
CREATE SCHEMA acce
GO
CREATE SCHEMA [agen]

GO 
--Creacion de la tabla de usuarios
CREATE TABLE acce.tbUsuarios(
	usua_Id 				INT IDENTITY(1,1),
	usua_NombreUsuario		NVARCHAR(100) NOT NULL,
	usua_Correo				NVARCHAR(200) NOT NULL,
	usua_Contrasena			NVARCHAR(MAX) NOT NULL,
	pers_Id					INT NOT NULL,
	usua_EsAdmin			BIT NOT NULL,    
	usua_UsuCreacion		INT NOT NULL,
	usua_FechaCreacion		DATETIME NOT NULL CONSTRAINT DF_usua_FechaCreacion DEFAULT(GETDATE()),
	usua_UsuModificacion	INT,
	usua_FechaModificacion	DATETIME,
	usua_Estado				BIT NOT NULL CONSTRAINT DF_usua_Estado DEFAULT(1)
	CONSTRAINT PK_acce_tbUsuarios_usua_Id  PRIMARY KEY(usua_Id)
);

--********* PROCEDIMIENTO INSERTAR USUARIOS ADMIN**************--
GO
CREATE OR ALTER PROCEDURE acce.UDP_InsertUsuario
	@usua_NombreUsuario		NVARCHAR(100),
	@usua_Correo			NVARCHAR(200),	
	@usua_Contrasena		NVARCHAR(200),
	@pers_Id				INT,
	@usua_EsAdmin			BIT							
AS
BEGIN
	DECLARE @password NVARCHAR(MAX)=(SELECT HASHBYTES('Sha2_512', @usua_Contrasena));
	INSERT acce.tbUsuarios(usua_NombreUsuario, usua_Correo, usua_Contrasena, pers_Id, usua_EsAdmin, usua_UsuCreacion)
	VALUES(@usua_NombreUsuario, @usua_Correo, @password, @pers_Id, @usua_EsAdmin, 1);
END;
GO

GO
EXEC acce.UDP_InsertUsuario 'admin', 'defaultperson@aless.com', '123', 1, 1;

--********* ALTERAR TABLA USUARIOS **************--
--********* AGREGAR AUDITORIA**************--
GO
ALTER TABLE [acce].[tbUsuarios]
ADD CONSTRAINT FK_acce_tbUsuarios_acce_tbUsuarios_user_UsuCreacion_usua_Id  FOREIGN KEY(usua_UsuCreacion) REFERENCES acce.tbUsuarios([usua_Id]),
	CONSTRAINT FK_acce_tbUsuarios_acce_tbUsuarios_user_UsuModificacion_usua_Id  FOREIGN KEY(usua_UsuModificacion) REFERENCES acce.tbUsuarios([usua_Id])

GO 
--Creacion de la tabla de continentes
CREATE TABLE gral.tbContinentes(
	cont_Id 				INT IDENTITY(1,1),
	cont_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_gral_tbContinentes_cont_Id  PRIMARY KEY(cont_Id)
);
GO 
--Creacion de la tabla se Paises
CREATE TABLE gral.tbPaises(
	pais_Id 				INT IDENTITY(1,1),
	pais_Nombre				NVARCHAR(100) NOT NULL,
	cont_Id 				INT NOT NULL
	CONSTRAINT PK_gral_tbPaises_pais_Id  PRIMARY KEY(pais_Id),
	CONSTRAINT FK_gral_tbPaises_gral_tbContientes_cont_Id FOREIGN KEY(cont_Id) REFERENCES gral.tbContinentes(cont_Id)
);
GO 
--Creacion de la tabla de Departamentos 
CREATE TABLE gral.tbDepartamentos(
	depa_Id 				INT IDENTITY(1,1),
	depa_Nombre				NVARCHAR(100) NOT NULL,
	pais_Id 				INT NOT NULL
	CONSTRAINT PK_gral_tbDepartamentos_depa_Id  PRIMARY KEY(depa_Id),
	CONSTRAINT FK_gral_tbDepartamentos_gral_tbPaises_pais_Id FOREIGN KEY(pais_Id) REFERENCES gral.tbPaises(pais_Id)
);
GO
--Creacion de la tabla de Cuidades
CREATE TABLE gral.tbCiudades(
	ciud_Id 				INT IDENTITY(1,1),
	ciud_Nombre				NVARCHAR(100) NOT NULL,
	depa_Id 				INT  NOT NULL
	CONSTRAINT PK_gral_tbCuidades_ciud_Id  PRIMARY KEY(ciud_Id),
	CONSTRAINT FK_gral_tbCiudades_gral_tbDepartamentos_depa_Id FOREIGN KEY(depa_Id) REFERENCES gral.tbDepartamentos(depa_Id)
);
GO
--Creacion de la tabla de Aeropuertos
CREATE TABLE agen.tbAeropuertos(
	aero_Id 				INT IDENTITY(1,1),
	aero_Nombre				NVARCHAR(100) NOT NULL,
	ciud_Id 				INT NOT NULL,
	aero_DireccionExacta	Nvarchar(500) NOT NULL
	CONSTRAINT PK_agen_tbAeropurtos_aero_Id  PRIMARY KEY(aero_Id),
	CONSTRAINT FK_agen_tbAeropuertos_gral_tbCiudades_ciud_Id FOREIGN KEY(ciud_Id) REFERENCES gral.tbCiudades(ciud_Id)
);
GO
--Creacion de la tabla de Hoteles
CREATE TABLE agen.tbHoteles(
	hote_Id 				INT IDENTITY(1,1),
	hote_Nombre				NVARCHAR(100) NOT NULL,
	ciud_Id 				INT NOT NULL,
	hote_DireccionExacta	Nvarchar(500) NOT NULL,
	hote_Estellas			INT
	CONSTRAINT PK_agen_tbHoteles_hote_Id  PRIMARY KEY(hote_Id),
	CONSTRAINT FK_agen_tbHoteles_gral_tbCiudades_ciud_Id FOREIGN KEY(ciud_Id) REFERENCES gral.tbCiudades(ciud_Id)
);
GO 
--Creacion de la tabla de Categorias de las habitaciones
CREATE TABLE agen.tbCategoriasHabitacional(
	cath_Id 				INT IDENTITY(1,1),
	cath_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_agen_tbCategoriasHabitacional_cont_Id  PRIMARY KEY(cath_Id)
);
GO
--Creacion de la tabla de Habitaciones
CREATE TABLE agen.tbHabitaciones(
	habi_Id 				INT IDENTITY(1,1),
	habi_Nombre				NVARCHAR(100) NOT NULL,
	hote_Id 				INT NOT NULL,
	cath_Id 				INT NOT NULL,
	habi_Precio				decimal(18,2),
	CONSTRAINT PK_agen_tbHabitaciones_hote_Id  PRIMARY KEY(habi_Id),
	CONSTRAINT FK_agen_tbHabitaicones_agen_tbHoteles_hote_Id FOREIGN KEY(hote_Id) REFERENCES agen.tbHoteles(hote_Id),
	CONSTRAINT FK_agen_tbHabitaicones_agen_tbCategorias_cath_Id FOREIGN KEY(cath_Id) REFERENCES agen.tbCategoriasHabitacional(cath_Id)
);
GO
--Creacion de la tabla de agencias de Vuelo 
CREATE TABLE agen.tbAgenciasVuelos(
	agenvuel_Id 				INT IDENTITY(1,1),
	agenvuel_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_agen_tbAgenciasVuelos_agenvuel_Id  PRIMARY KEY(agenvuel_Id)
);
GO
--Creacion de la tabla de vuelos 
CREATE TABLE agen.tbVuelos(
	vuel_Id 					INT IDENTITY(1,1),
	vuel_FechaSalida			DATETIME NOT NULL,
	vuel_FechaLlegada			DATETIME NOT NULL,
	vuel_AeropuertoSalida		INT NOT NULL,
	vuel_AeropuertoLlegada		INT NOT NULL,
	agenvuel_Id 				INT NOT NULL
	CONSTRAINT PK_agen_tbVuelos_vuel_Id  PRIMARY KEY(vuel_Id),
	CONSTRAINT FK_agen_tbVuelos_agen_tbAeropuertos_vuel_AeropuertoSalida FOREIGN KEY(vuel_AeropuertoSalida) REFERENCES agen.tbAeropuertos(aero_Id),
	CONSTRAINT FK_agen_tbVuelos_agen_tbAeropuertos_vuel_AeropuertoLlegada FOREIGN KEY(vuel_AeropuertoLlegada) REFERENCES agen.tbAeropuertos(aero_Id)

);
GO
--Creacion de la tabla clases de Vuelos
CREATE TABLE agen.tbClasesVuelos(
	clasvuel_Id 				INT IDENTITY(1,1),
	clasvuel_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_agen_tbClasesVuelos_clasvuel_Id  PRIMARY KEY(clasvuel_Id)
);
GO
--Creacion de la tabla de Billetes
CREATE TABLE agen.tbBilletesAvion(
	bill_Id 				INT IDENTITY(1,1),
	vuel_Id 				INT NOT NULL,
	clasvuel_Id				INT NOT NULL,
	bill_Precio				DECIMAL(18,2)  NOT NULL
	CONSTRAINT PK_agen_tbBilletesAvion_bill_Id  PRIMARY KEY(bill_Id),
	CONSTRAINT FK_agen_tbBilletesAvion_agen_tbClasesVuelos_clasvuel_Id FOREIGN KEY(clasvuel_Id) REFERENCES agen.tbClasesVuelos(clasvuel_Id),
	CONSTRAINT FK_agen_tbBilletesAvion_agen_tbVuelos_vuel_Id FOREIGN KEY(vuel_Id) REFERENCES agen.tbVuelos(vuel_Id)

);
GO
--Creacion de la tabla de Paquetes
CREATE TABLE agen.tbPaquetes(
	paqu_Id 				INT IDENTITY(1,1),
	paqu_Nombre				NVARCHAR(100) NOT NULL,
	paqu_Imagen				NVARCHAR(MAX),
	vuel_Id 				INT NOT NULL ,
	habi_Id					INT NOT NULL ,
	paqu_Personas			INT NOT NULL ,
	paqu_Precio				DECIMAL(18,2) NOT NULL
	CONSTRAINT PK_agen_tbPaquetes_paqu_Id  PRIMARY KEY(paqu_Id),
	CONSTRAINT FK_agen_tbPaquetes_agen_tbHabitaciones_habi_Id FOREIGN KEY(habi_Id) REFERENCES agen.tbHabitaciones(habi_Id),
	CONSTRAINT FK_agen_tbPaquetes_agen_tbVuelos_vuel_Id FOREIGN KEY(vuel_Id) REFERENCES agen.tbVuelos(vuel_Id)

);
GO
--Creacion de la tabla de EstadosCiviles
CREATE TABLE gral.tbEstadosCiviles(
	estc_Id 				INT IDENTITY(1,1),
	estc_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_gral_tbEstadosCiviles_estc_Id  PRIMARY KEY(estc_Id)
);

INSERT INTO gral.tbEstadosCiviles
VALUES('Soltero(a)'),
	  ('Casado(a)'),
	  ('Divorciado(a)'),
	  ('Viudo(a)')

GO
--Creacion de la tabla de Personas
CREATE TABLE agen.tbPersonas(
	pers_Id 				INT IDENTITY(1,1),
	pers_Nombres			NVARCHAR(150) NOT NULL,
	pers_Apellidos			NVARCHAR(150) NOT NULL,
	pers_Identidad			NVARCHAR(15) NOT NULL,
	estc_Id 				INT NOT NULL,
	pers_FechaNacimiento	date NOT NULL,
	pers_Sexo				CHAR(1) NOT NULL,
	pers_Celular			NVARCHAR(20) NOT NULL ,
	pers_EsEmpleado			BIT
	CONSTRAINT PK_agen_tbPersonas_pers_Id  PRIMARY KEY(pers_Id),
	CONSTRAINT FK_agen_tbPersonas_agen_tbEstadosCiviles_estc_Id FOREIGN KEY(estc_Id) REFERENCES gral.tbEstadosCiviles(estc_Id)
);

INSERT INTO agen.tbPersonas
VALUES('Hernán', 'Estrada', '0501200345698', 1, '2003-01-25', 'F', '87896578', 1)

--********* ALTERAR TABLA USUARIOS **************--
--********* AGREGAR FK PERSONAS**************--
GO
ALTER TABLE [acce].[tbUsuarios]
ADD CONSTRAINT FK_acce_tbUsuarios_agen_tbPersonas_pers_Id  FOREIGN KEY(pers_Id) REFERENCES agen.tbPersonas(pers_Id)

GO
--Creacion de la tabla de Reservaciones
CREATE TABLE agen.tbReservaciones(
	rese_Id 				INT IDENTITY(1,1),
	paqu_Id  				INT NOT NULL,
	pers_Id 				INT NOT NULL
	CONSTRAINT PK_agen_tbReservaciones_rese_Id  PRIMARY KEY(rese_Id),
	CONSTRAINT FK_agen_tbReservaciones_agen_tbPaquetes_paqu_Id FOREIGN KEY(paqu_Id) REFERENCES agen.tbPaquetes(paqu_Id),
	CONSTRAINT FK_agen_tbReservaciones_agen_tbPersonas_pers_Id FOREIGN KEY(pers_Id) REFERENCES agen.tbPersonas(pers_Id)
);
GO




--**************INSERTS**************--
--Continentes
INSERT INTO gral.tbContinentes (cont_Nombre) VALUES ('África');
INSERT INTO gral.tbContinentes (cont_Nombre) VALUES ('América');
INSERT INTO gral.tbContinentes (cont_Nombre) VALUES ('Asia');
INSERT INTO gral.tbContinentes (cont_Nombre) VALUES ('Europa');
INSERT INTO gral.tbContinentes (cont_Nombre) VALUES ('Oceanía');


--Paises
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Estados Unidos', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Canadá', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('México', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Brasil', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Argentina', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Chile', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Perú', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('España', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Alemania', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Francia', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Italia', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Reino Unido', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Japón', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('China', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('India', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Rusia', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Australia', 5);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Nueva Zelanda', 5);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Papúa Nueva Guinea', 5);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Fiyi', 5);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Tonga', 5);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Colombia', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Venezuela', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Cuba', 2);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Australia', 5);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Nueva Zelanda', 5);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Indonesia', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Corea del Sur', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Filipinas', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Singapur', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Tailandia', 3);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Inglaterra', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Escocia', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Irlanda', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Grecia', 4);
INSERT INTO gral.tbPaises (pais_Nombre, cont_Id) VALUES ('Suiza', 4);


--Departamentos
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Alabama', 1);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Ontario', 2);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Jalisco', 3);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('São Paulo', 4);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Buenos Aires', 5);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Región Metropolitana', 6);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Madrid', 7);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Baviera', 8);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Provenza-Alpes-Costa Azul', 9);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Lombardía', 10);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Londres', 11);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Kanto', 12);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Shanghai', 13);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Mumbai', 14);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Moscú', 15);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Victoria', 16);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Auckland', 17);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Puerto Moresby', 18);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Suva', 19);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Nukuʻalofa', 20);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Atlántico', 21);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Zulia', 22);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('La Habana', 23);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Nueva Escocia', 24);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Java Occidental', 25);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Seúl', 26);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Manila', 27);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Singapur Central', 28);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('Bangkok', 29);
INSERT INTO gral.tbDepartamentos (depa_Nombre, pais_Id) VALUES ('California', 1);


--Ciudades
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Washington D.C.', 1);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Ottawa', 2);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Ciudad de México', 3);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Brasilia', 4);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Buenos Aires', 5);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Santiago de Chile', 6);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Lima', 7);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Madrid', 8);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Berlín', 9);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('París', 10);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Roma', 11);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Londres', 12);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Tokio', 13);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Pekín', 14);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Nueva Delhi', 15);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Moscú', 16);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Canberra', 17);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Wellington', 18);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Port Moresby', 19);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Suva', 20);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Nuku''alofa', 21);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Bogotá', 22);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Caracas', 23);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('La Habana', 24);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Sídney', 25);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Los Ángeles', 30);
INSERT INTO gral.tbCiudades(ciud_Nombre, depa_Id) VALUES ('Toronto', 2);

--Aeropuertos
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de la Ciudad de México', 3, 'Av Capitán Carlos León S/N, Peñón de los Baños, Venustiano Carranza, 15620 Ciudad de México, CDMX, México');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Los Angeles', 26, '1 World Way, Los Angeles, CA 90045, Estados Unidos');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Toronto', 27, '6301 Silver Dart Dr, Mississauga, ON L5P 1B2, Canadá');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Brasilia', 4, 'Lago Sul - Zona Industrial, Brasília - DF, Brasil');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional Ministro Pistarini', 11, 'Au. Teniente General Pablo Riccheri Km 33,5, B1802 Ezeiza, Provincia de Buenos Aires, Argentina');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional Comodoro Arturo Merino Benítez', 6, 'Comodoro Arturo Merino Benítez, Pudahuel, Región Metropolitana, Chile');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional Jorge Chávez', 7, 'Av. Elmer Faucett s/n, Callao 07031, Perú');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Adolfo Suárez Madrid-Barajas', 8, 'Av de la Hispanidad, s/n, 28042 Madrid, España');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de Fráncfort del Meno', 9, '60547 Frankfurt, Alemania');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de París-Charles de Gaulle', 10, '95700 Roissy-en-France, Francia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Roma-Fiumicino', 11, 'Via dell Aeroporto di Fiumicino, 00054 Fiumicino RM, Italia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Düsseldorf', 9, 'Flughafenstraße 120, 40474 Düsseldorf, Alemania');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Frankfurt', 9, '60547 Frankfurt, Alemania');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto de Heathrow', 12, 'Longford TW6, Reino Unido');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Narita', 13, '1-1 Furugome, Narita, Chiba 282-0004, Japón');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Pekín', 14, 'Shunyi, Pekín, China');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Nueva Delhi', 15, 'Indira Gandhi International Airport, New Delhi, Delhi 110037, India');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional Sheremétievo', 16, 'Khimki, Moskovskaya oblast, Rusia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto de Sídney', 25, 'Sydney NSW 2020, Australia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Auckland', 21, 'Auckland Airport (AKL), Auckland 2022, Nueva Zelanda');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Denpasar', 20, 'Jalan Raya Gusti Ngurah Rai, Tuban, Kuta, Kabupaten Badung, Bali 80362, Indonesia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Incheon', 21, '272 Gonghang-ro, Unseo-dong, Jung-gu, Incheon, Corea del Sur');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Manila', 22, 'Andrews Ave, Pasay, Metro Manila, Filipinas');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Queenstown', 23, 'Sir Henry Wigley Dr, Queenstown 9300, Nueva Zelanda');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de Dunedin', 24, 'Dunedin Airport (DUD), 25 Miller Rd, Momona, Dunedin 9073, Nueva Zelanda');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de Wellington', 25, 'Stewart Duff Dr, Rongotai, Wellington 6022, Nueva Zelanda');



--Hoteles
INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel Santa Lucia', 1, 'Calle 10 #20-30', 4);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel La Mansion', 2, 'Avenida Central #25-40', 3);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel el Dorado', 3, 'Carrera 8 #15-20', 2);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel San Francisco', 4, 'Calle 7 #12-30', 3);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel La Quinta', 5, 'Carrera 12 #10-30', 5);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel La Posada', 6, 'Carrera 5 #20-10', 2);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel La Palma', 7, 'Calle 15 #18-25', 4);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel El Parador', 8, 'Avenida 7 #22-15', 3);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel Los Pinos', 9, 'Carrera 10 #16-18', 2);

INSERT INTO agen.tbHoteles (hote_Nombre, ciud_Id, hote_DireccionExacta, hote_Estellas) 
VALUES ('Hotel Los Alamos', 10, 'Calle 20 #25-30', 5);


--Categorias de habitaciones
INSERT INTO agen.tbCategoriasHabitacional (cath_Nombre)
VALUES ('delux'), ('estandar'), ('superior'), ('suite'), ('presidencial');

--Habitaciones
INSERT INTO agen.tbHabitaciones (habi_Nombre, hote_Id, cath_Id, habi_Precio)
VALUES
	('Habitación 1', 1, 1, 100.00),
	('Habitación 2', 1, 2, 200.00),
	('Habitación 3', 2, 3, 150.00),
	('Habitación 4', 2, 4, 250.00),
	('Habitación 5', 3, 5, 120.00),
	('Habitación 6', 3, 1, 180.00),
	('Habitación 7', 4, 2, 300.00),
	('Habitación 8', 4, 3, 190.00),
	('Habitación 9', 5, 4, 220.00),
	('Habitación 10', 5, 5, 280.00),
	('Habitación 11', 6, 1, 120.00),
	('Habitación 12', 6, 2, 200.00),
	('Habitación 13', 7, 3, 250.00),
	('Habitación 14', 7, 4, 350.00),
	('Habitación 15', 8, 5, 150.00),
	('Habitación 16', 8, 1, 190.00),
	('Habitación 17', 9, 2, 220.00),
	('Habitación 18', 9, 3, 270.00),
	('Habitación 19', 10, 4, 200.00),
	('Habitación 20', 10, 5, 320.00);



--Agencias de vuelo
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('Aeroméxico');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('American Airlines');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('Delta Airlines');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('United Airlines');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('Air Canada');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('Avianca');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('LATAM');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('Interjet');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('Volaris');
INSERT INTO agen.tbAgenciasVuelos (agenvuel_Nombre) VALUES ('Spirit Airlines');

--Vuelos
INSERT INTO agen.tbVuelos(vuel_FechaSalida, vuel_FechaLlegada, vuel_AeropuertoSalida, vuel_AeropuertoLlegada, agenvuel_Id)
VALUES ('2023-04-15 08:00:00', '2023-04-15 10:30:00', 1, 5, 1);

INSERT INTO agen.tbVuelos(vuel_FechaSalida, vuel_FechaLlegada, vuel_AeropuertoSalida, vuel_AeropuertoLlegada, agenvuel_Id)
VALUES ('2023-04-17 14:30:00', '2023-04-17 19:00:00', 3, 8, 2);

INSERT INTO agen.tbVuelos(vuel_FechaSalida, vuel_FechaLlegada, vuel_AeropuertoSalida, vuel_AeropuertoLlegada, agenvuel_Id)
VALUES ('2023-04-20 10:15:00', '2023-04-20 12:45:00', 2, 4, 1);


--Paquetes
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Aventura', 'https://drive.google.com/uc?id=1L-4BfX7NHBeHQDos4Sd_g_sevdfLHyYj', 1, 1, 2, 3500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete Familiar', 'https://drive.google.com/u/0/uc?id=17XKJm4_hle99gfXFypdr1y6kFjic1v4o', 2, 2, 4, 5500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Playa', 'https://drive.google.com/uc?export=download&id=1AoyerGovDkbuPgNY_cnAVUiqNUm9m03O', 3, 5, 2, 4200.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete Romántico', 'https://drive.google.com/uc?id=1tGSSVt1N-4h4Jd3zj_zzKk1meE2agFeZ', 1, 8, 2, 6000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Aventura Extrema', 'https://drive.google.com/uc?export=view&id=1TgdFp6scZuGYuvlx9roHqjAbes5VPOD0', 3, 12, 1, 8500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Relax', 'https://drive.google.com/uc?id=1_4TC0l327R8CpOFHOzne9lIJ3xxgxR4W', 2, 14, 2, 4500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Diversión', 'https://drive.google.com/uc?id=1qzfLYLuas0MLl9GLKXk-i4gvfIPgbzQH', 1, 17, 3, 5500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Luna de Miel', 'https://drive.google.com/uc?id=1HDECezoWYb-ZIhxkpMD8_LEgbXPGW0M2', 2, 19, 2, 8000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Aventura Familiar', 'https://drive.google.com/uc?id=1W3RqMvaJnR4VbmPbKwj29Hx8UInVXcwx', 3, 4, 4, 7000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de Relax Familiar', 'https://drive.google.com/uc?id=1BP76oeBy3fD0EmC2yidIPrYYk2l12Bh_', 1, 11, 4, 8000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de playa en Acapulco', 'https://drive.google.com/uc?id=1FaWDYFECBn3BcsSVBLNNK7jHOhuapEyU"', 2, 12, 2, 2500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de aventura en la selva', 'https://drive.google.com/uc?export=view&id=12tlcd65ARSZZ0urYz8V-TffQ-7bv_KMk', 1, 7, 4, 4500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de lujo en Cancún', 'https://drive.google.com/uc?export=view&id=1jLyDxVl3ZVzoJne_IWi0UrN2guGmK_e8', 3, 18, 2, 8000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete cultural en Oaxaca', 'https://drive.google.com/uc?id=1nBenZx58h2BxVQeObjuG4caZLNox7dlN', 1, 3, 3, 4000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete romántico en San Miguel de Allende', 'https://drive.google.com/uc?id=1HliGZ4KcMAICMMJD88cSSOwoPoDMyYMt', 2, 8, 2, 5500.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de ski en Aspen', 'https://drive.google.com/uc?id=14i1joiBjFsS3zF3MNYEtWHzYJx0QOO-i', 3, 15, 4, 12000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de relax en Tulum', 'https://drive.google.com/uc?export=view&id=128L400z4e2_NcF2uVIb8MLupvyPZyeyT', 2, 10, 2, 3000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de aventura en Baja California', 'https://drive.google.com/uc?id=1rX_PNJNWoMj-OgueF6TMiUoZ8PnQPCAu', 1, 6, 4, 5000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de ciudad en Nueva York', 'https://drive.google.com/uc?export=view&id=1pEaViXi49wh2TflNgK0bb4SHx0wbhrLV', 3, 20, 2, 10000.00);
INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio) VALUES ('Paquete de playa en Puerto Escondido', 'https://drive.google.com/uc?id=1ddzaHYecUVD41st7gaSQuI0xvZ7qVjZf', 2, 11, 2, 2000.00);

INSERT INTO agen.tbPaquetes (paqu_Nombre, paqu_Imagen, vuel_Id, habi_Id, paqu_Personas, paqu_Precio)
VALUES ('Vacaciones en la playa', 'https://drive.google.com/uc?id=1VK6cK5sm2CEVU0niHmocZUqB979Tswus', 2, 8, 2, 800.00),
       ('Fin de semana en la montaña', 'https://drive.google.com/uc?id=1HTTBfT5yKoNQOiR9JNXXdyJiF700Q-7N', 1, 15, 4, 1200.00),
       ('Tour por Europa', 'https://drive.google.com/uc?id=1oEthbTNtYjaxCzmkoXL9ukL3aS3g3jNK', 3, 19, 2, 5000.00),
       ('Luna de miel en la ciudad', 'https://drive.google.com/uc?id=1MW4YKlXXyaqvHNqTj4BeaUqErywuZlX3', 3, 1, 2, 1500.00),
       ('Excursión en la naturaleza', 'https://drive.google.com/uc?export=view&id=1dOlfOcZynyoWVlGdZLMzoWPF4y-dl9A4', 1, 18, 4, 2500.00),
       ('Viaje de aniversario', 'https://drive.google.com/uc?id=1_zibAawkb31dGa6W1TDjLXiwBGNZ6v4p', 2, 5, 2, 1200.00),
       ('Descanso en la isla', 'https://drive.google.com/uc?id=1C4XpLvMYk_Zr-LwWeAd4cktQuKXYSQsY', 3, 14, 3, 3500.00),
       ('Aventura en el desierto', 'https://drive.google.com/uc?id=1wxssPLJJz0lnS5AOAYDEeqFHvwhU2KZr', 1, 7, 4, 2800.00);


--*******PROCEDIMIENTOS ALMACENADOS*******--

--Vista tbUsuarios
GO
CREATE OR ALTER VIEW acce.VW_tbUsuarios
AS
	SELECT T1.usua_Id, 
		   T1.usua_NombreUsuario, 
		   T1.usua_Correo, 
		   T1.usua_Contrasena, 
		   T1.pers_Id, 
		   (T2.pers_Nombres + ' ' + T2.pers_Apellidos) AS usua_PersonaNombreCompleto,
		   T1.usua_EsAdmin, 
		   T1.usua_UsuCreacion, 
		   T3.usua_NombreUsuario AS usua_NombreUsuarioCreacion,
		   T1.usua_FechaCreacion, 
		   T1.usua_UsuModificacion, 
		   T4.usua_NombreUsuario AS usua_NombreUsuarioModificacion,
		   T1.usua_FechaModificacion
	FROM [acce].[tbUsuarios] T1 INNER JOIN [agen].[tbPersonas] T2
	ON T1.pers_Id = T2.pers_Id INNER JOIN [acce].[tbUsuarios] T3
	ON T1.usua_UsuCreacion = T3.usua_Id LEFT JOIN [acce].[tbUsuarios] T4
	ON T1.usua_UsuModificacion = t4.usua_Id
	WHERE T1.usua_Estado = 1

GO
CREATE OR ALTER PROCEDURE acce.UDP_VW_tbUsuarios_List
AS
BEGIN
	SELECT * FROM acce.VW_tbUsuarios
END


GO
CREATE OR ALTER PROCEDURE acce.UDP_VW_tbUsuarios_Login 
    @usua_NombreUsuario        NVARCHAR(100),
    @usua_Correo            NVARCHAR(200),
    @usua_Contrasena        NVARCHAR(Max)
AS
BEGIN
	DECLARE @contraEncript NVARCHAR(MAX) = HASHBYTES('SHA2_512', @usua_Contrasena)
	SELECT * FROM acce.VW_tbUsuarios
	WHERE (usua_NombreUsuario = @usua_NombreUsuario OR usua_Correo = @usua_Correo)
	and	usua_Contrasena = @contraEncript

END


--Procedimiento insertar usuarios
GO
CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_Insert
	@usua_NombreUsuario		NVARCHAR(100),
	@usua_Correo			NVARCHAR(200),	
	@usua_Contrasena		NVARCHAR(Max),
	@pers_Id				INT,
	@usua_UsuCreacion		INT
AS
BEGIN
	BEGIN TRY
		DECLARE @contraEncript NVARCHAR(MAX) = HASHBYTES('SHA2_512', @usua_Contrasena)

		DECLARE @usua_EsAdmin BIT 

		IF (SELECT [pers_EsEmpleado] FROM [agen].[tbPersonas]) = 1
			SET @usua_EsAdmin = 1
		ELSE
			SET @usua_EsAdmin = 0


		IF NOT EXISTS (SELECT usua_NombreUsuario 
					   FROM acce.tbUsuarios 
					   WHERE usua_NombreUsuario = @usua_NombreUsuario)
			BEGIN			
				INSERT INTO [acce].[tbUsuarios](usua_NombreUsuario, 
												usua_Correo, 
												usua_Contrasena, 
												pers_Id, 
												usua_EsAdmin, 
												usua_UsuCreacion)
				VALUES (@usua_NombreUsuario, @usua_Correo, @contraEncript, @pers_Id, @usua_EsAdmin, @usua_UsuCreacion)

				SELECT 'El registro se ha insertado con éxito'
			END
		ELSE IF EXISTS (SELECT usua_NombreUsuario 
					    FROM acce.tbUsuarios  
					    WHERE usua_NombreUsuario = @usua_NombreUsuario
						AND usua_Estado = 1)
			BEGIN
				UPDATE acce.tbUsuarios
				SET usua_Estado = 1,
					usua_Correo = @usua_Correo,
					usua_Contrasena = @contraEncript,
					usua_EsAdmin = @usua_EsAdmin,
					pers_Id = @pers_Id,
					usua_UsuCreacion = @usua_UsuCreacion
				WHERE usua_NombreUsuario = @usua_NombreUsuario

				SELECT 'El registro se ha insertado con éxito'
			END
		ELSE
			SELECT 'Ya existe un usuario con este nombre'
	END TRY
	BEGIN CATCH
		SELECT 'Ha ocurrido un error'
	END CATCH
END

--Procedimiento editar usuarios
GO
CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_Edit
	@usua_Id					INT,
	@usua_NombreUsuario			NVARCHAR(100),
	@usua_Correo				NVARCHAR(200),	
	@usua_Contrasena			NVARCHAR(200),
	@pers_Id					INT,
	@usua_UsuModificacion		INT
AS
BEGIN 
	BEGIN TRY
	
		DECLARE @usua_EsAdmin BIT 

		IF (SELECT [pers_EsEmpleado] FROM [agen].[tbPersonas]) = 1
			SET @usua_EsAdmin = 1
		ELSE
			SET @usua_EsAdmin = 0

		IF NOT EXISTS (SELECT usua_Id FROM [acce].[tbUsuarios] WHERE usua_Id = @usua_Id)
			BEGIN 
				SELECT 'El registro que intenta editar no existe'
			END
		ELSE
			BEGIN
				IF NOT EXISTS (SELECT usua_NombreUsuario 
					   FROM [acce].[tbUsuarios] 
					   WHERE usua_NombreUsuario = @usua_NombreUsuario
					   AND usua_Id != @usua_Id)
					BEGIN
						UPDATE [acce].[tbUsuarios] 
						SET usua_NombreUsuario = @usua_NombreUsuario,
							usua_Correo = @usua_Correo,
							pers_Id = @pers_Id,
							usua_EsAdmin = @usua_EsAdmin,
							usua_UsuModificacion = @usua_UsuModificacion,
							usua_FechaModificacion = GETDATE()
						WHERE usua_Id = @usua_Id

						SELECT 'El registro ha sido editado con éxito'
					END
				ELSE IF EXISTS (SELECT usua_NombreUsuario 
								FROM [acce].[tbUsuarios] 
								WHERE usua_Estado = 0
								AND usua_NombreUsuario = @usua_NombreUsuario)
					BEGIN
						UPDATE [acce].[tbUsuarios] 
						SET usua_Estado = 1,
							usua_Correo = @usua_Correo,
							pers_Id = @pers_Id,
							usua_EsAdmin = @usua_EsAdmin
						WHERE usua_NombreUsuario = @usua_NombreUsuario

						SELECT 'El registro ha sido editado con éxito'
					END
				ELSE
					SELECT 'Ya existe un usuario con este nombre'
			END
	END TRY
	BEGIN CATCH
		SELECT 'Ha ocurrido un error'
	END CATCH
END

--Procedimiento eliminar usuarios
GO
CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_Delete
	@usua_Id	INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT usua_Id FROM [acce].[tbUsuarios] WHERE usua_Id = @usua_Id)
			BEGIN
				SELECT 'El registro que intenta eliminar no existe'
			END
		ELSE
			UPDATE [acce].[tbUsuarios]
			SET usua_Estado = 0
			WHERE usua_Id = @usua_Id

			SELECT 'El registro ha sido eliminado con éxito'
	END TRY
	BEGIN CATCH
		SELECT 'Ha ocurrido un error'
	END CATCH
END

--Procedimiento encontrar usuarios
GO
CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_Find
	@usua_Id	INT
AS
BEGIN
	SELECT * FROM acce.VW_tbUsuarios WHERE usua_Id = @usua_Id
END

--******PROCEDIMIENTOS PERSONAS******--
GO
CREATE OR ALTER VIEW agen.VW_tbPersonas
AS
	SELECT pers_Id, 
		   pers_Nombres, 
		   pers_Apellidos, 
		   (pers_Nombres + ' ' + pers_Apellidos) AS pers_NombreCompleto,
		   pers_Identidad, 
		   estc_Id, 
		   pers_FechaNacimiento, 
		   CASE WHEN pers_Sexo = 'F' THEN 'Femenino'
				ELSE 'Masculino'
			END AS pers_Sexo,
		   pers_Celular, 
		   pers_EsEmpleado
	FROM [agen].[tbPersonas]

--Procedimiento listar personas
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPersonas_List
AS
BEGIN
	SELECT * FROM agen.VW_tbPersonas
END

--Procedimiento insertar personas
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPersonas_Insert
	@pers_Nombres			NVARCHAR(200),
	@pers_Apellidos			NVARCHAR(200), 
	@pers_Identidad			NVARCHAR(15), 
	@estc_Id				INT, 
	@pers_FechaNacimiento	DATE, 
	@pers_Sexo				CHAR, 
	@pers_Celular			NVARCHAR(20), 
	@pers_EsEmpleado		BIT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
					   FROM [agen].[tbPersonas]
					   WHERE [pers_Identidad] = @pers_Identidad)
			BEGIN
				INSERT INTO [agen].[tbPersonas](pers_Nombres, pers_Apellidos, pers_Identidad, estc_Id, pers_FechaNacimiento, pers_Sexo, pers_Celular, pers_EsEmpleado)
				VALUES(@pers_Nombres, 
					   @pers_Apellidos, 
					   @pers_Identidad, 
					   @estc_Id, 
					   @pers_FechaNacimiento, 
					   @pers_Sexo, 
					   @pers_Celular, 
					   @pers_EsEmpleado)
				SELECT 'El registro ha sido insertado con éxito'

			END
		ELSE
			SELECT 'Ya existe una persona con este número de identidad'
	END TRY
	BEGIN CATCH
		SELECT 'Ha ocurrido un error'
	END CATCH
END




--******PROCEDIMIENTOS PAQUETES******--
GO
CREATE OR ALTER VIEW agen.VW_tbPaquetes
AS
SELECT [paqu_Id]
      ,[paqu_Nombre]
      ,[paqu_Imagen]
      ,T1.[vuel_Id]
	  ,T2.vuel_AeropuertoSalida
	  ,T10.aero_Nombre
	  ,(T11.ciud_Nombre + ', ' + T13.pais_Nombre) as ciud_Salida
	  ,T2.vuel_AeropuertoLlegada
	  ,T2.vuel_FechaSalida
	  ,T2.vuel_FechaLlegada
	  ,T2.agenvuel_Id
	  ,T3.agenvuel_Nombre
      ,T1.[habi_Id]
	  ,T4.habi_Nombre
	  ,T4.habi_Precio
	  ,t4.hote_Id
	  ,T5.hote_Nombre
	  ,T5.hote_DireccionExacta
      ,[paqu_Personas]
      ,[paqu_Precio]
	  ,T5.ciud_Id
	  ,T5.hote_Estellas
	  ,T6.ciud_Nombre
	  ,T7.depa_Id
	  ,T7.depa_Nombre
	  ,T8.pais_Id
	  ,T8.pais_Nombre
	  ,T9.cont_Id
	  ,T9.cont_Nombre
  FROM [agen].[tbPaquetes] T1 INNER JOIN agen.tbVuelos T2
  ON T1.vuel_Id = T2.vuel_Id INNER JOIN agen.tbAgenciasVuelos T3
  ON T3.agenvuel_Id = T2.agenvuel_Id INNER JOIN agen.tbHabitaciones T4
  ON t4.habi_Id = T1.habi_Id INNER JOIN agen.tbHoteles T5
  ON t5.hote_Id = T4.hote_Id INNER JOIN gral.tbCiudades T6
  ON T6.ciud_Id = t5.ciud_Id INNER JOIN gral.tbDepartamentos T7
  ON t7.depa_Id = T6.depa_Id INNER JOIN gral.tbPaises T8
  ON T8.pais_Id = T7.pais_Id INNER JOIN gral.tbContinentes T9
  On T8.cont_Id = T9.cont_Id INNER JOIN agen.tbAeropuertos T10
  ON T2.vuel_AeropuertoSalida = T10.aero_Id INNER JOIN gral.tbCiudades T11
  ON T10.ciud_Id = T11.ciud_Id INNER JOIN gral.tbDepartamentos T12
  ON T11.depa_Id = T12.depa_Id INNER JOIN gral.tbPaises T13
  ON T12.pais_Id = T13.pais_Id 
GO


--Procedimiento listar paquetes
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_List
AS
BEGIN
	SELECT * FROM agen.VW_tbPaquetes
END
--Procedimiento paise con mas paquetes
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListXPaises
AS
BEGIN
	SELECT TOP(5) pais_Nombre,COUNT(paqu_Id)AS CantidadPaquetes FROM agen.VW_tbPaquetes
	Group by (pais_Nombre)
	Order by CantidadPaquetes desc
END


GO

CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_Insert
@paqu_Nombre nvarchar(100),
@paqu_Imagen nvarchar(max),
@vuel_Id int,
@habi_Id int,
@paqu_Personas int,
@paqu_Precio decimal(18,2)

AS
BEGIN
BEGIN TRY

INSERT INTO [agen].[tbPaquetes]
           ([paqu_Nombre]
           ,[paqu_Imagen]
           ,[vuel_Id]
           ,[habi_Id]
           ,[paqu_Personas]
           ,[paqu_Precio])
     VALUES
           (@paqu_Nombre
           ,@paqu_Imagen
           ,@vuel_Id
           ,@habi_Id
           ,@paqu_Personas
           ,@paqu_Precio )

SELECT 'El registro ha sido insertado con éxito'
	END TRY
	BEGIN CATCH
		SELECT 'Ha ocurrido un error'
END CATCH
END





GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListTop5Caros
AS
BEGIN
	SELECT TOP(5) * FROM agen.VW_tbPaquetes T1
	order by T1.paqu_Precio desc
END

GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListTop10baratos
AS
BEGIN
	SELECT TOP(10) * FROM agen.VW_tbPaquetes T1
	order by T1.paqu_Precio
END

--Procedimiento encontrar paquete
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_Find 
	@paqu_Id INT 
AS
BEGIN
	SELECT * FROM agen.VW_tbPaquetes
	WHERE paqu_Id = @paqu_Id
END


--Procedimiento listar paquetes
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListXPerson 
	@pers_Id int
AS
BEGIN
	SELECT * 
	FROM agen.VW_tbPaquetes T1
	LEFT JOIN agen.tbReservaciones T2
	ON T1.paqu_Id = T2.paqu_Id
	WHERE pers_Id = @pers_Id
	ORDER BY vuel_FechaSalida
END

--Procedimiento listar paquetes x continente
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListXContinente 
	@cont_Nombre	NVARCHAR(100)
AS
BEGIN
	SELECT *
	FROM agen.VW_tbPaquetes
	WHERE cont_Nombre = @cont_Nombre
END

--Procedimiento listar paquetes x país
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListXPais
	@pais_Nombre	NVARCHAR(100)
AS
BEGIN
	SELECT *
	FROM agen.VW_tbPaquetes
	WHERE pais_Nombre = @pais_Nombre
END

--Procedimiento listar paquetes x ciudad
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListXCiudad 
	@ciud_Nombre	NVARCHAR(100)
AS
BEGIN
	SELECT *
	FROM agen.VW_tbPaquetes
	WHERE ciud_Nombre = @ciud_Nombre
END

--Procedimiento listar paquetes x cantidad de personas
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbPaquetes_ListXCantidadPersonas 
	@paqu_Personas	NVARCHAR(100)
AS
BEGIN
	SELECT *
	FROM agen.VW_tbPaquetes
	WHERE paqu_Personas = @paqu_Personas
END
--******PROCEDIMIENTOS RESERVACIONES******--

--Procedimiento insertar reservación
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbReservaciones_Insert 
	@paqu_Id	INT,
	@pers_Id	INT
AS
BEGIN
	BEGIN TRY
		INSERT INTO [agen].[tbReservaciones]
		VALUES(@paqu_Id, @pers_Id)

		SELECT 'El registro ha sido insertado con éxito'
	END TRY
	BEGIN CATCH
		SELECT 'Ha ocurrido un error'
	END CATCH
END

--Procedimiento eliminar reservación
GO
CREATE OR ALTER PROCEDURE agen.UDP_tbReservaciones_Delete 
	@rese_Id	INT
AS
BEGIN
	DELETE 
	FROM agen.tbReservaciones
	WHERE rese_Id = @rese_Id

	SELECT 'La reservacion ha sido cancelada'
END
--******PROCEDIMIENTOS CLIENTES******--
--Procedimiento insertar cliente

GO
CREATE OR ALTER PROCEDURE agen.UDP_InsertarCliente
		@pers_Nombres nvarchar(150),
        @pers_Apellidos nvarchar(150),
        @pers_Identidad nvarchar(15),
        @estc_Id int,
        @pers_FechaNacimiento date,
        @pers_Sexo char(1),
        @pers_Celular nvarchar(20),
        @pers_EsEmpleado bit,
		@usua_NombreUsuario		NVARCHAR(100),
		@usua_Correo			NVARCHAR(200),	
		@usua_Contrasena		NVARCHAR(Max),
		@usua_UsuCreacion		INT
AS
BEGIN

BEGIN TRY
		IF NOT EXISTS (SELECT *
					   FROM [agen].[tbPersonas]
					   WHERE [pers_Identidad] = @pers_Identidad)
			BEGIN
				INSERT INTO [agen].[tbPersonas](pers_Nombres, pers_Apellidos, pers_Identidad, estc_Id, pers_FechaNacimiento, pers_Sexo, pers_Celular, pers_EsEmpleado)
				VALUES(@pers_Nombres, 
					   @pers_Apellidos, 
					   @pers_Identidad, 
					   @estc_Id, 
					   @pers_FechaNacimiento, 
					   @pers_Sexo, 
					   @pers_Celular, 
					   @pers_EsEmpleado)

			   DECLARE @pers_Id INT = (SELECT SCOPE_IDENTITY());

			END
		ELSE
			SELECT 'Ya existe una persona con este número de identidad'
	

		DECLARE @contraEncript NVARCHAR(MAX) = HASHBYTES('SHA2_512', @usua_Contrasena)

		DECLARE @usua_EsAdmin BIT 

		IF (@pers_EsEmpleado = 1)
			SET @usua_EsAdmin = 1
		ELSE
			SET @usua_EsAdmin = 0


		IF NOT EXISTS (SELECT usua_NombreUsuario 
					   FROM acce.tbUsuarios 
					   WHERE usua_NombreUsuario = @usua_NombreUsuario)
			BEGIN			
				INSERT INTO [acce].[tbUsuarios](usua_NombreUsuario, 
												usua_Correo, 
												usua_Contrasena, 
												pers_Id, 
												usua_EsAdmin, 
												usua_UsuCreacion)
				VALUES (@usua_NombreUsuario, @usua_Correo, @contraEncript, @pers_Id, @usua_EsAdmin, @usua_UsuCreacion)

				SELECT 'El registro se ha insertado con éxito'
			END
		ELSE IF EXISTS (SELECT usua_NombreUsuario 
					    FROM acce.tbUsuarios  
					    WHERE usua_NombreUsuario = @usua_NombreUsuario
						AND usua_Estado = 1)
			BEGIN
				UPDATE acce.tbUsuarios
				SET usua_Estado = 1,
					usua_Correo = @usua_Correo,
					usua_Contrasena = @contraEncript,
					usua_EsAdmin = @usua_EsAdmin,
					pers_Id = @pers_Id,
					usua_UsuCreacion = @usua_UsuCreacion
				WHERE usua_NombreUsuario = @usua_NombreUsuario

				SELECT 'El registro se ha insertado con éxito'
			END
		ELSE
			SELECT 'Ya existe un usuario con este nombre'
	END TRY
	BEGIN CATCH
		SELECT 'Ha ocurrido un error'
	END CATCH

END

--Validar si el usuario existe
GO
CREATE OR ALTER PROCEDURE acce.UDP_UsuarioExiste
    @usua_NombreUsuario        NVARCHAR(100)
AS
BEGIN
        IF NOT EXISTS (SELECT * FROM acce.tbUsuarios WHERE usua_NombreUsuario = @usua_NombreUsuario)
        Begin
        select 'Si puede'
        END
        ELSE
        BEGIN
        select 'No puede'
        END


END

GO
CREATE OR ALTER PROCEDURE agen.UDP_IdentidadExiste
    @pers_Identidad        NVARCHAR(15)
AS
BEGIN
        IF NOT EXISTS (SELECT * FROM agen.tbPersonas WHERE pers_Identidad = @pers_Identidad)
        Begin
        select 'Si puede'
        END
        ELSE
        BEGIN
        select 'No puede'
        END
END

GO
CREATE OR ALTER PROCEDURE acce.UDP_CorreoExiste
    @usua_Correo        NVARCHAR(300)
AS
BEGIN
        IF NOT EXISTS (SELECT * FROM acce.tbUsuarios WHERE [usua_Correo] = @usua_Correo)
        Begin
        select 'No Existe'
        END
        ELSE
        BEGIN
        select 'Si Existe'
        END


END



GO
CREATE OR ALTER PROCEDURE acce.UDP_RecuperarUsuario
 @usua_Correo        NVARCHAR(300),
	@usua_Contrasena	NVARCHAR(MAX)
AS
BEGIN
BEGIN TRY

DECLARE @password NVARCHAR(MAX)=(SELECT HASHBYTES('Sha2_512', @usua_Contrasena));

UPDATE [acce].[tbUsuarios]
   SET [usua_Contrasena] = @password
 WHERE usua_Correo = @usua_Correo

 
 IF EXISTS (select * FROM acce.tbUsuarios WHERE usua_Correo = @usua_Correo
												AND [usua_Contrasena] = @password)
 BEGIN
 SELECT 'usuario recuperado' as Proceso
 END
 ELSE
 SELECT 'usuario errado' as Proceso
END TRY
BEGIN CATCH
 SELECT 'error en operacion' as Proceso
END CATCH

END

GO
CREATE OR ALTER VIEW agen.VW_tbHabitaciones
AS
SELECT [habi_Id]
      ,[habi_Nombre]
      ,T1.[hote_Id]
	  ,T2.hote_Nombre
      ,T1.[cath_Id]
	  ,T3.cath_Nombre
      ,[habi_Precio]
  FROM [agen].[tbHabitaciones] T1 INNER JOIN [agen].[tbHoteles] T2
  ON T1.hote_Id = T2.hote_Id INNER JOIN [agen].[tbCategoriasHabitacional] T3
  ON T3.cath_Id =  T1.cath_Id

GO

GO
CREATE OR ALTER PROCEDURE agen.UDP_tbHabitaciones_List
AS
BEGIN
	SELECT * FROM agen.VW_tbHabitaciones
END
GO


CREATE OR ALTER VIEW agen.VW_tbVuelos
AS
SELECT [vuel_Id]
      ,[vuel_FechaSalida]
      ,[vuel_FechaLlegada]
      ,[vuel_AeropuertoSalida]
      ,[vuel_AeropuertoLlegada]
      ,T1.[agenvuel_Id]
	  ,T2.agenvuel_Nombre
	  ,T2.agenvuel_Nombre + ' de ' + T3.aero_Nombre + ' a ' + T4.aero_Nombre as vuel_Info
	  ,T7.pais_Id
	  ,T7.pais_Nombre
  FROM [agen].[tbVuelos] T1 INNER JOIN [agen].[tbAgenciasVuelos] T2
  ON T1.agenvuel_Id = t2.agenvuel_Id INNER JOIN [agen].[tbAeropuertos] T3
  ON t3.aero_Id = T1.[vuel_AeropuertoSalida] INNER JOIN [agen].[tbAeropuertos] T4
  ON t4.aero_Id = T1.vuel_AeropuertoLlegada INNER JOIN [gral].[tbCiudades] T5
  ON T5.ciud_Id = T3.ciud_Id INNER JOIN [gral].[tbDepartamentos] T6
  ON T6.depa_Id = T5.depa_Id INNER JOIN [gral].[tbPaises] T7
  ON t7.pais_Id = T6.pais_Id

  GO


  GO
CREATE OR ALTER PROCEDURE agen.UDP_tbVuelos_List
AS
BEGIN
	SELECT * FROM agen.VW_tbVuelos
END



GO
  CREATE OR ALTER VIEw agen.VW_tbHoteles
  as
SELECT [hote_Id]
      ,[hote_Nombre]
      ,[ciud_Id]
      ,[hote_DireccionExacta]
      ,[hote_Estellas]
  FROM [agen].[tbHoteles]

GO


GO
CREATE OR ALTER PROCEDURE agen.UDP_tbHoteles_List
AS
BEGIN
	SELECT * FROM agen.VW_tbHoteles
END
GO

CREATE OR ALTER VIEW gral.VW_tbPaises
AS
SELECT [pais_Id]
      ,[pais_Nombre]
      ,[cont_Id]
  FROM [gral].[tbPaises]

GO

GO
CREATE OR ALTER PROCEDURE gral.UDP_tbPaises_List
AS
BEGIN
	SELECT * FROM gral.VW_tbPaises
END



