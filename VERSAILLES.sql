CREATE DATABASE tbAgenceVersailles
GO
use tbAgeceVersailles
GO
CREATE SCHEMA gral
GO
CREATE SCHEMA acce
GO
CREATE SCHEMA [agen]
GO

GO 
CREATE TABLE acce.tbUsuarios(
	usua_Id 				INT IDENTITY(1,1),
	usua_NombreUsuario		NVARCHAR(100) NOT NULL,
	usua_Correo				NVARCHAR(200) NOT NULL,
	usua_Contrasena			NVARCHAR(MAX) NOT NULL,
	usua_EsAdmin			BIT,    
	CONSTRAINT PK_acce_tbUsuarios_user_Id  PRIMARY KEY(usua_Id)
);

GO 
CREATE TABLE gral.tbContinentes(
	cont_Id 				INT IDENTITY(1,1),
	cont_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_gral_tbContinentes_cont_Id  PRIMARY KEY(cont_Id)
);

GO 
CREATE TABLE gral.tbPaises(
	pais_Id 				INT IDENTITY(1,1),
	pais_Nombre				NVARCHAR(100) NOT NULL,
	cont_Id 				INT
	CONSTRAINT PK_gral_tbPaises_pais_Id  PRIMARY KEY(pais_Id),
	CONSTRAINT FK_gral_tbPaises_gral_tbContientes_cont_Id FOREIGN KEY(cont_Id) REFERENCES gral.tbContinentes(cont_Id)
);


GO 
CREATE TABLE gral.tbDepartamentos(
	depa_Id 				INT IDENTITY(1,1),
	depa_Nombre				NVARCHAR(100) NOT NULL,
	pais_Id 				INT
	CONSTRAINT PK_gral_tbDepartamentos_depa_Id  PRIMARY KEY(depa_Id),
	CONSTRAINT FK_gral_tbDepartamentos_gral_tbPaises_pais_Id FOREIGN KEY(pais_Id) REFERENCES gral.tbPaises(pais_Id)
);
GO
CREATE TABLE gral.tbCiudades(
	ciud_Id 				INT IDENTITY(1,1),
	ciud_Nombre				NVARCHAR(100) NOT NULL,
	depa_Id 				INT 
	CONSTRAINT PK_gral_tbCuidades_ciud_Id  PRIMARY KEY(ciud_Id),
	CONSTRAINT FK_gral_tbCiudades_gral_tbDepartamentos_depa_Id FOREIGN KEY(depa_Id) REFERENCES gral.tbDepartamentos(depa_Id)
);
GO
CREATE TABLE agen.tbAeropuertos(
	aero_Id 				INT IDENTITY(1,1),
	aero_Nombre				NVARCHAR(100) NOT NULL,
	ciud_Id 				INT,
	aero_DireccionExacta	Nvarchar(500)
	CONSTRAINT PK_gral_tbAeropurtos_aero_Id  PRIMARY KEY(aero_Id),
	CONSTRAINT FK_gral_tbAeropuertos_gral_tbCiudades_ciud_Id FOREIGN KEY(ciud_Id) REFERENCES gral.tbCiudades(ciud_Id)
);
GO
CREATE TABLE agen.tbHoteles(
	hote_Id 				INT IDENTITY(1,1),
	hote_Nombre				NVARCHAR(100) NOT NULL,
	ciud_Id 				INT,
	hote_DireccionExacta	Nvarchar(500),
	hote_Estellas			INT
	CONSTRAINT PK_gral_tbHoteles_hote_Id  PRIMARY KEY(hote_Id),
	CONSTRAINT FK_gral_tbHoteles_gral_tbCiudades_ciud_Id FOREIGN KEY(ciud_Id) REFERENCES gral.tbCiudades(ciud_Id)
);
GO 
CREATE TABLE agen.tbCategoriasHabitacional(
	cath_Id 				INT IDENTITY(1,1),
	cath_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_gral_tbCategoriasHabitacional_cont_Id  PRIMARY KEY(cath_Id)
);
GO
CREATE TABLE agen.tbHabitaciones(
	habi_Id 				INT IDENTITY(1,1),
	habi_Nombre				NVARCHAR(100) NOT NULL,
	hote_Id 				INT,
	cath_Id 				INT,
	habi_Precio				decimal(18,2),
	CONSTRAINT PK_gral_tbHabitaciones_hote_Id  PRIMARY KEY(habi_Id),
	CONSTRAINT FK_gral_tbHabitaicones_gral_tbHoteles_hote_Id FOREIGN KEY(hote_Id) REFERENCES agen.tbHoteles(hote_Id),
	CONSTRAINT FK_gral_tbHabitaicones_gral_tbCategorias_cath_Id FOREIGN KEY(cath_Id) REFERENCES agen.tbCategoriasHabitacional(cath_Id)
);
GO
CREATE TABLE agen.tbAgenciasVuelos(
	agenvuel_Id 				INT IDENTITY(1,1),
	agenvuel_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_gral_tbAgenciasVuelos_agenvuel_Id  PRIMARY KEY(agenvuel_Id)
);
GO
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
CREATE TABLE agen.tbClasesVuelos(
	clasvuel_Id 				INT IDENTITY(1,1),
	clasvuel_Nombre				NVARCHAR(100) NOT NULL
	CONSTRAINT PK_gral_tbAgenciasVuelos_agenvuel_Id  PRIMARY KEY(clasvuel_Id)
);
GO
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
