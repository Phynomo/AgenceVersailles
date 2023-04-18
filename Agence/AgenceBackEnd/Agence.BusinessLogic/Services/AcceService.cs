using Agence.DataAccess.Repository;
using Agence.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agence.BusinessLogic.Services
{
    public class AcceService
    {
        private readonly UsuarioRepository _usuarioRepository;

        public AcceService(UsuarioRepository usuarioRepository)
        {
            _usuarioRepository = usuarioRepository;
        }

        #region Usuarios

        public ServiceResult ListadoUsuarios()
        {
            var result = new ServiceResult();
            try 
            {
                var list = _usuarioRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

        public ServiceResult Login(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var list = _usuarioRepository.Login(item);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

        public ServiceResult Existe(string usuario)
        {
            var result = new ServiceResult();
            try
            {
                var list = _usuarioRepository.Existe(usuario);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

         public ServiceResult ExisteCorreo(string usuario)
        {
            var result = new ServiceResult();
            try
            {
                var list = _usuarioRepository.ExisteCorreo(usuario);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }


        public ServiceResult InsertarUsuarios(tbUsuarios item)
        {
            var result = new ServiceResult();

            try
            {
                var insert = _usuarioRepository.Insert(item);

                if (insert.MessageStatus == "El registro se ha insertado con éxito")
                    return result.SetMessage(insert.MessageStatus, ServiceResultType.Success);
                else if (insert.MessageStatus == "Ya existe un usuario con este nombre")
                    return result.Conflict(insert.MessageStatus);
                else if (insert.MessageStatus == "Ha ocurrido un error")
                    return result.Error("Algun dato ha sido enviado de forma incorrecta");
                else
                    return result.SetMessage("Conexión perdida", ServiceResultType.Error);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult RecuperarUsuarios(tbUsuarios item)
        {
            var result = new ServiceResult();

            try
            {
                var insert = _usuarioRepository.Recuperar(item);

                if (insert.MessageStatus == "usuario recuperado")
                    return result.SetMessage(insert.MessageStatus, ServiceResultType.Success);
                else if (insert.MessageStatus == "usuario errado")
                    return result.Conflict(insert.MessageStatus);
                else if (insert.MessageStatus == "error en operacion")
                    return result.Error("Algun dato ha sido enviado de forma incorrecta");
                else
                    return result.SetMessage("Conexión perdida", ServiceResultType.Error);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }


        public ServiceResult EliminarUsuarios(tbUsuarios item)
        {
            var result = new ServiceResult();

            try
            {
                var insert = _usuarioRepository.Delete(item);

                if (insert.MessageStatus == "El registro ha sido eliminado con éxito")
                    return result.SetMessage(insert.MessageStatus, ServiceResultType.Success);
                else if (insert.MessageStatus == "El registro que intenta eliminar no existe")
                    return result.Conflict(insert.MessageStatus);
                else if (insert.MessageStatus == "Ha ocurrido un error")
                    return result.Error("Algun dato ha sido enviado de forma incorrecta");
                else
                    return result.SetMessage("Conexión perdida", ServiceResultType.Error);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion


        public ServiceResult InsertarPersonaCliente(tbPersonas item, tbUsuarios item2)
        {
            var result = new ServiceResult();

            try
            {
                var insert = _usuarioRepository.InsertCliente(item, item2);

                if (insert.MessageStatus == "El registro se ha insertado con éxito")
                    return result.SetMessage(insert.MessageStatus, ServiceResultType.Success);
                else if (insert.MessageStatus == "Ya existe una persona con este número de identidad")
                    return result.Conflict(insert.MessageStatus);
                else if (insert.MessageStatus == "Ya existe un usuario con este nombre")
                    return result.Conflict(insert.MessageStatus);
                else if (insert.MessageStatus == "Ha ocurrido un error")
                    return result.Error("Algun dato ha sido enviado de forma incorrecta");
                else
                    return result.SetMessage("Conexión perdida", ServiceResultType.Error);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

    }
}
