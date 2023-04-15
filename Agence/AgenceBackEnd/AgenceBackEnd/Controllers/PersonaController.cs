using Agence.API.Models;
using Agence.BusinessLogic.Services;
using Agence.Entities.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Agence.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonaController : Controller
    {
        private readonly AgenceService _agenceService;
        private readonly IMapper _mapper;

        public PersonaController(AgenceService agenceService, IMapper mapper)
        {
            _agenceService = agenceService;
            _mapper = mapper;
        }

        [HttpGet("Listado")]
        public IActionResult Index()
        {
            var list = _agenceService.ListadoPersonas();
            return Ok(list);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert(PersonaViewModel Persona)
        {
            var item = _mapper.Map<tbPersonas>(Persona);
            var response = _agenceService.InsertarPersona(item);
            return Ok(response);
        }


    }
}
