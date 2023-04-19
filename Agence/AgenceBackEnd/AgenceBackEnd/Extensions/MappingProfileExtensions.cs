using Agence.API.Models;
using Agence.Entities.Entities;
using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Agence.API.Extensions
{
    public class MappingProfileExtensions : Profile
    {
        public MappingProfileExtensions()
        {
            CreateMap<UsuarioViewModel, tbUsuarios>().ReverseMap();
            CreateMap<PersonaViewModel, tbPersonas>().ReverseMap();
            CreateMap<ReservacionViewModel, tbReservaciones>().ReverseMap();
            CreateMap<InsertarPersonaViewModel, tbPersonas>().ReverseMap();
            CreateMap<InsertarPersonaViewModel, tbUsuarios>().ReverseMap();
            CreateMap<PaqueteViewModel, tbPaquetes>().ReverseMap();
        }
    }
}