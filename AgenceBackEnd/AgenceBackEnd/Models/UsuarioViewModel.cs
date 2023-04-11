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
        public int pers_Id { get; set; }
        public bool usua_EsAdmin { get; set; }
        public int usua_UsuCreacion { get; set; }
        public int? usua_UsuModificacion { get; set; }
        public DateTime? usua_FechaModificacion { get; set; }
    }
}
