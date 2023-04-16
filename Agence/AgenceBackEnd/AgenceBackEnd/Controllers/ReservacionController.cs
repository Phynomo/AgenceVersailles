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
    public class ReservacionController : Controller
    {
        private readonly AgenceService _agenceService;
        private readonly IMapper _mapper;
        public ReservacionController(AgenceService agenceService, IMapper mapper)
        {
            _agenceService = agenceService;
            _mapper = mapper;
        }

        //public IActionResult Index()
        //{
        //    return View();
        //}

        [HttpPost("Insertar")]
        public IActionResult Insert(ReservacionViewModel reservaciones)
        {
            var item = _mapper.Map<tbReservaciones>(reservaciones);
            var response = _agenceService.InsertarReservacion(item);
            return Ok(response);
        }
    }
}
