using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Agence.API.Models
{
    public class InsertarPersonaViewModel
    {
        public string pers_Nombres { get; set; }
        public string pers_Apellidos { get; set; }
        public string pers_Identidad { get; set; }
        public int estc_Id { get; set; }
        public string usua_PerfilImage { get; set; }
        public DateTime pers_FechaNacimiento { get; set; }
        public string pers_Sexo { get; set; }
        public string pers_Celular { get; set; }
        public bool? pers_EsEmpleado { get; set; }
        public string usua_NombreUsuario { get; set; }
        public string usua_Correo { get; set; }
        public string usua_Contrasena { get; set; }
        public int usua_UsuCreacion { get; set; }

    }
}
