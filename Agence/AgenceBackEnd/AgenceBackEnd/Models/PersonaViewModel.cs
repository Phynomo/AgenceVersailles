using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Agence.API.Models
{
    public class PersonaViewModel
    {
        public int pers_Id { get; set; }
        public string pers_Nombres { get; set; }
        public string pers_Apellidos { get; set; }
        public string pers_NombreCompleto { get; set; }
        public string pers_Identidad { get; set; }
        public int estc_Id { get; set; }
        public DateTime pers_FechaNacimiento { get; set; }
        public string pers_Sexo { get; set; }
        public string pers_Celular { get; set; }
        public bool? pers_EsEmpleado { get; set; }

    }
}
