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
    public class UsuarioController : Controller
    {

        private readonly AcceService _seguridadServivce;
        private readonly IMapper _mapper;

        public UsuarioController(AcceService seguridadService, IMapper mapper)
        {
            _seguridadServivce = seguridadService;
            _mapper = mapper;
        }


        [HttpGet("Listado")]
        public IActionResult Index()
        {
            var list = _seguridadServivce.ListadoUsuarios();
            return Ok(list);
        }

        [HttpPut("Login")]
        public IActionResult Login(UsuarioViewModel usuario)
        {
            var item = _mapper.Map<tbUsuarios>(usuario);
            var list = _seguridadServivce.Login(item);
            return Ok(list);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert(UsuarioViewModel usuarios)
        {
            var item = _mapper.Map<tbUsuarios>(usuarios);
            var response = _seguridadServivce.InsertarUsuarios(item);
            return Ok(response);
        }

        [HttpPut("Eliminar")]
        public IActionResult Delete(UsuarioViewModel usuarios)
        {
            var item = _mapper.Map<tbUsuarios>(usuarios);
            var result = _seguridadServivce.EliminarUsuarios(item);
            return Ok(result);
        }

        [HttpPost("Registrarse")]
        public IActionResult Registrarse(InsertarPersonaViewModel Persona)
        {
            var item = _mapper.Map<tbPersonas>(Persona);
            var item2 = _mapper.Map<tbUsuarios>(Persona);
            var response = _seguridadServivce.InsertarPersonaCliente(item, item2);
            return Ok(response);
        }
        
        [HttpGet("Existe")]
        public IActionResult Existe(string usuario)
        {
            var response = _seguridadServivce.Existe(usuario);
            return Ok(response);
        }

    }
}
