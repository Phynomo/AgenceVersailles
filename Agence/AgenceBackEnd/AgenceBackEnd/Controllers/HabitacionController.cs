using Agence.BusinessLogic.Services;
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
    public class HabitacionController : Controller
    {

        private readonly AgenceService _agenceService;
        private readonly IMapper _mapper;

        public HabitacionController(AgenceService agenceService, IMapper mapper)
        {
            _agenceService = agenceService;
            _mapper = mapper;
        }


        [HttpGet("ListadoXHotel")]
        public IActionResult ListadoXHotel(int hotel)
        {
            var list = _agenceService.ListadoHabitaciones(hotel);
            return Ok(list);
        }
    }
}
