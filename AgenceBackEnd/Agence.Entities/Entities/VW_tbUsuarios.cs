﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agence.Entities.Entities
{
    public partial class VW_tbUsuarios
    {
        public int usua_Id { get; set; }
        public string usua_NombreUsuario { get; set; }
        public string usua_Correo { get; set; }
        public string usua_Contrasena { get; set; }
        public int pers_Id { get; set; }
        public string usua_PersonaNombreCompleto { get; set; }
        public bool usua_EsAdmin { get; set; }
        public int usua_UsuCreacion { get; set; }
        public string usua_NombreUsuarioCreacion { get; set; }
        public DateTime usua_FechaCreacion { get; set; }
        public int? usua_UsuModificacion { get; set; }
        public string usua_NombreUsuarioModificacion { get; set; }
        public DateTime? usua_FechaModificacion { get; set; }
    }
}