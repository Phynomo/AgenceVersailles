using Agence.DataAccess.Repository;
using Agence.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agence.BusinessLogic.Services
{
    public class AgenceService
    {
        private readonly PaqueteRepository _paqueteRepository;
        private readonly PersonaRepository _personaRepository;
        private readonly ReservacionRepository _reservacionRepository;

        public AgenceService(PaqueteRepository paqueteRepository,
                            PersonaRepository personaRepository,
                            ReservacionRepository reservacionRepository
            )
        {
            _paqueteRepository = paqueteRepository;
            _personaRepository = personaRepository;
            _reservacionRepository = reservacionRepository;
        }

        #region Paquetes
        public ServiceResult FindPaquetes(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _paqueteRepository.find(id);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

        public ServiceResult ListadoPaquetes()
        {
            var result = new ServiceResult();
            try
            {
                var list = _paqueteRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

        public ServiceResult ListadoPaquetesCaros()
        {
            var result = new ServiceResult();
            try
            {
                var list = _paqueteRepository.ListCaros();
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }    

         public ServiceResult ListadoPaquetesBaratos()
        {
            var result = new ServiceResult();
            try
            {
                var list = _paqueteRepository.ListBaratos();
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }
        
        public ServiceResult ListadoPorPersona(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _paqueteRepository.ListXPerson(id);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }
        #endregion

        #region Personas
        public ServiceResult ListadoPersonas()
        {
            var result = new ServiceResult();
            try
            {
                var list = _personaRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

        public ServiceResult InsertarPersona(tbPersonas item)
        {
            var result = new ServiceResult();

            try
            {
                var insert = _personaRepository.Insert(item);

                if (insert.MessageStatus == "El registro ha sido insertado con éxito")
                    return result.SetMessage(insert.MessageStatus, ServiceResultType.Success);
                else if (insert.MessageStatus == "Ya existe una persona con este número de identidad")
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

        #region Reservaciones
        public ServiceResult InsertarReservacion(tbReservaciones item)
        {
            var result = new ServiceResult();

            try
            {
                var insert = _reservacionRepository.Insert(item);

                if (insert.MessageStatus == "El registro ha sido insertado con éxito")
                    return result.SetMessage(insert.MessageStatus, ServiceResultType.Success);
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
        public ServiceResult EliminarReservacion(tbReservaciones item)
        {
            var result = new ServiceResult();

            try
            {
                var delete = _reservacionRepository.Delete(item);

                if (delete.MessageStatus == "La reservacion ha sido cancelada")
                    return result.SetMessage(delete.MessageStatus, ServiceResultType.Success);
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
