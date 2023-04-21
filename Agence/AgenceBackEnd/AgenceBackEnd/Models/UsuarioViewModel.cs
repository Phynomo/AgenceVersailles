using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Agence.API.Models
{
    public class UsuarioViewModel
    {
        public int usua_Id { get; set; }
        public string usua_NombreUsuario { get; set; }
        public string usua_Correo { get; set; }
        public string usua_Contrasena { get; set; }
        public string usua_PerfilImage { get; set; }
        public int pers_Id { get; set; }
        public string usua_PersonaNombreCompleto { get; set; }
        public string pers_Celular { get; set; }
        public DateTime pers_FechaNacimiento { get; set; }
        public string pers_Identidad { get; set; }
        public string pers_Sexo { get; set; }
        public bool usua_EsAdmin { get; set; }
        public int usua_UsuCreacion { get; set; }
        public string usua_NombreUsuarioCreacion { get; set; }
        public DateTime usua_FechaCreacion { get; set; }
        public int? usua_UsuModificacion { get; set; }
        public string usua_NombreUsuarioModificacion { get; set; }
        public DateTime? usua_FechaModificacion { get; set; }
    }
}
