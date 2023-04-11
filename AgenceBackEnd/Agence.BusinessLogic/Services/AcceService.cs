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
        #endregion


    }
}
