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

        [HttpGet("Login")]
        public IActionResult Login(string usuario, string contrasena)
        {
            var list = _seguridadServivce.Login(usuario, contrasena);
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


        [HttpGet("ExisteCorreo")]
        public IActionResult ExisteCorreo(string correo)
        {
            var response = _seguridadServivce.ExisteCorreo(correo);
            return Ok(response);
        }

        [HttpPut("Recuperar")]
        public IActionResult Recuperar(UsuarioViewModel usuarios)
        {
            var item = _mapper.Map<tbUsuarios>(usuarios);
            var response = _seguridadServivce.RecuperarUsuarios(item);
            return Ok(response);
        }
        
        [HttpPut("EditarFoto")]
        public IActionResult EditarFoto(UsuarioViewModel usuarios)
        {
            var item = _mapper.Map<tbUsuarios>(usuarios);
            var response = _seguridadServivce.EditarFoto(item);
            return Ok(response);
        }


    }
}