﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Agence.API.Models
{
    public class PaqueteViewModel
    {
        public int paqu_Id { get; set; }
        public string paqu_Nombre { get; set; }
        public string paqu_Imagen { get; set; }
        public int vuel_Id { get; set; }
        public int vuel_AeropuertoSalida { get; set; }
        public string aero_Nombre { get; set; }
        public string ciud_Salida { get; set; }
        public int vuel_AeropuertoLlegada { get; set; }
        public DateTime vuel_FechaSalida { get; set; }
        public DateTime vuel_FechaLlegada { get; set; }
        public int agenvuel_Id { get; set; }
        public string agenvuel_Nombre { get; set; }
        public int habi_Id { get; set; }
        public string habi_Nombre { get; set; }
        public decimal? habi_Precio { get; set; }
        public int hote_Id { get; set; }
        public string hote_Nombre { get; set; }
        public string hote_DireccionExacta { get; set; }
        public int paqu_Personas { get; set; }
        public decimal paqu_Precio { get; set; }
        public int ciud_Id { get; set; }
        public int? hote_Estellas { get; set; }
        public string ciud_Nombre { get; set; }
        public int depa_Id { get; set; }
        public string depa_Nombre { get; set; }
        public int pais_Id { get; set; }
        public string pais_Nombre { get; set; }
        public int cont_Id { get; set; }
        public string cont_Nombre { get; set; }
        [NotMapped]
        public int? rese_Id { get; set; }
        [NotMapped]
        public int? pers_Id { get; set; }
        [NotMapped]
        public int CantidadPaquetes { get; set; }

    }
}
