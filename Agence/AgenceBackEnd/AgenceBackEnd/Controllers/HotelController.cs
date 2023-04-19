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
    public class HotelController : Controller
    {

        private readonly AgenceService _agenceService;
        private readonly IMapper _mapper;

        public HotelController(AgenceService agenceService, IMapper mapper)
        {
            _agenceService = agenceService;
            _mapper = mapper;
        }


        [HttpGet("Listado")]
        public IActionResult Index()
        {
            var list = _agenceService.ListadoHoteles();
            return Ok(list);
        }

    }
}
