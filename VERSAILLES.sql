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
	cont_Id 				INT
	CONSTRAINT PK_gral_tbPaises_pais_Id  PRIMARY KEY(pais_Id),
	CONSTRAINT FK_gral_tbPaises_gral_tbContientes_cont_Id FOREIGN KEY(cont_Id) REFERENCES gral.tbContinentes(cont_Id)
);
GO 
--Creacion de la tabla de Departamentos 
CREATE TABLE gral.tbDepartamentos(
	depa_Id 				INT IDENTITY(1,1),
	depa_Nombre				NVARCHAR(100) NOT NULL,
	pais_Id 				INT
	CONSTRAINT PK_gral_tbDepartamentos_depa_Id  PRIMARY KEY(depa_Id),
	CONSTRAINT FK_gral_tbDepartamentos_gral_tbPaises_pais_Id FOREIGN KEY(pais_Id) REFERENCES gral.tbPaises(pais_Id)
);
GO
--Creacion de la tabla de Cuidades
CREATE TABLE gral.tbCiudades(
	ciud_Id 				INT IDENTITY(1,1),
	ciud_Nombre				NVARCHAR(100) NOT NULL,
	depa_Id 				INT 
	CONSTRAINT PK_gral_tbCuidades_ciud_Id  PRIMARY KEY(ciud_Id),
	CONSTRAINT FK_gral_tbCiudades_gral_tbDepartamentos_depa_Id FOREIGN KEY(depa_Id) REFERENCES gral.tbDepartamentos(depa_Id)
);
GO
--Creacion de la tabla de Aeropuertos
CREATE TABLE agen.tbAeropuertos(
	aero_Id 				INT IDENTITY(1,1),
	aero_Nombre				NVARCHAR(100) NOT NULL,
	ciud_Id 				INT,
	aero_DireccionExacta	Nvarchar(500)
	CONSTRAINT PK_agen_tbAeropurtos_aero_Id  PRIMARY KEY(aero_Id),
	CONSTRAINT FK_agen_tbAeropuertos_gral_tbCiudades_ciud_Id FOREIGN KEY(ciud_Id) REFERENCES gral.tbCiudades(ciud_Id)
);
GO
--Creacion de la tabla de Hoteles
CREATE TABLE agen.tbHoteles(
	hote_Id 				INT IDENTITY(1,1),
	hote_Nombre				NVARCHAR(100) NOT NULL,
	ciud_Id 				INT,
	hote_DireccionExacta	Nvarchar(500),
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
	hote_Id 				INT,
	cath_Id 				INT,
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
	agenvuel_Id 				INT
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
	vuel_Id 				INT,
	clasvuel_Id				INT,
	bill_Precio				DECIMAL(18,2)
	CONSTRAINT PK_agen_tbBilletesAvion_bill_Id  PRIMARY KEY(bill_Id),
	CONSTRAINT FK_agen_tbBilletesAvion_agen_tbClasesVuelos_clasvuel_Id FOREIGN KEY(clasvuel_Id) REFERENCES agen.tbClasesVuelos(clasvuel_Id),
	CONSTRAINT FK_agen_tbBilletesAvion_agen_tbVuelos_vuel_Id FOREIGN KEY(vuel_Id) REFERENCES agen.tbVuelos(vuel_Id)

);
GO
--Creacion de la tabla de Paquetes
CREATE TABLE agen.tbPaquetes(
	paqu_Id 				INT IDENTITY(1,1),
	paqu_Nombre				NVARCHAR(100) NOT NULL,
	vuel_Id 				INT,
	habi_Id					INT,
	paqu_Personas			INT,
	paqu_Precio				DECIMAL(18,2)
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
	pers_Celular			NVARCHAR(20),
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

--Aeropuertos
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de la Ciudad de México', 1, 'Av Capitán Carlos León S/N, Peñón de los Baños, Venustiano Carranza, 15620 Ciudad de México, CDMX, México');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Los Angeles', 2, '1 World Way, Los Angeles, CA 90045, Estados Unidos');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Toronto', 3, '6301 Silver Dart Dr, Mississauga, ON L5P 1B2, Canadá');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Brasilia', 4, 'Lago Sul - Zona Industrial, Brasília - DF, Brasil');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional Ministro Pistarini', 5, 'Au. Teniente General Pablo Riccheri Km 33,5, B1802 Ezeiza, Provincia de Buenos Aires, Argentina');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional Comodoro Arturo Merino Benítez', 6, 'Comodoro Arturo Merino Benítez, Pudahuel, Región Metropolitana, Chile');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional Jorge Chávez', 7, 'Av. Elmer Faucett s/n, Callao 07031, Perú');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Adolfo Suárez Madrid-Barajas', 8, 'Av de la Hispanidad, s/n, 28042 Madrid, España');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de Fráncfort del Meno', 9, '60547 Frankfurt, Alemania');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de París-Charles de Gaulle', 10, '95700 Roissy-en-France, Francia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Roma-Fiumicino', 11, 'Via dell Aeroporto di Fiumicino, 00054 Fiumicino RM, Italia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Düsseldorf', 11, 'Flughafenstraße 120, 40474 Düsseldorf, Alemania');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Frankfurt', 12, '60547 Frankfurt, Alemania');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto de Heathrow', 13, 'Longford TW6, Reino Unido');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Narita', 14, '1-1 Furugome, Narita, Chiba 282-0004, Japón');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Pekín', 15, 'Shunyi, Pekín, China');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Nueva Delhi', 16, 'Indira Gandhi International Airport, New Delhi, Delhi 110037, India');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional Sheremétievo', 17, 'Khimki, Moskovskaya oblast, Rusia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto de Sídney', 18, 'Sydney NSW 2020, Australia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Auckland', 19, 'Auckland Airport (AKL), Auckland 2022, Nueva Zelanda');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Denpasar', 20, 'Jalan Raya Gusti Ngurah Rai, Tuban, Kuta, Kabupaten Badung, Bali 80362, Indonesia');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Incheon', 21, '272 Gonghang-ro, Unseo-dong, Jung-gu, Incheon, Corea del Sur');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES('Aeropuerto Internacional de Manila', 22, 'Andrews Ave, Pasay, Metro Manila, Filipinas');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto Internacional de Queenstown', 23, 'Sir Henry Wigley Dr, Queenstown 9300, Nueva Zelanda');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de Dunedin', 24, 'Dunedin Airport (DUD), 25 Miller Rd, Momona, Dunedin 9073, Nueva Zelanda');
INSERT INTO agen.tbAeropuertos (aero_Nombre, ciud_Id, aero_DireccionExacta) VALUES ('Aeropuerto de Wellington', 25, 'Stewart Duff Dr, Rongotai, Wellington 6022, Nueva Zelanda');

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

--Procedimiento insertar usuarios
GO
CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_Insert
	@usua_NombreUsuario		NVARCHAR(100),
	@usua_Correo			NVARCHAR(200),	
	@usua_Contrasena		NVARCHAR(200),
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


