﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agence.Entities.Entities
{
    public partial class tbAeropuertos
    {
        public tbAeropuertos()
        {
            tbVuelosvuel_AeropuertoLlegadaNavigation = new HashSet<tbVuelos>();
            tbVuelosvuel_AeropuertoSalidaNavigation = new HashSet<tbVuelos>();
        }

        public int aero_Id { get; set; }
        public string aero_Nombre { get; set; }
        public int? ciud_Id { get; set; }
        public string aero_DireccionExacta { get; set; }

        public virtual tbCiudades ciud { get; set; }
        public virtual ICollection<tbVuelos> tbVuelosvuel_AeropuertoLlegadaNavigation { get; set; }
        public virtual ICollection<tbVuelos> tbVuelosvuel_AeropuertoSalidaNavigation { get; set; }
    }
}