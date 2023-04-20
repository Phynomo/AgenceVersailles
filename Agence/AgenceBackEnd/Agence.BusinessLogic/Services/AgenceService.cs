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
        private readonly HabitacionRepository _habitacionRepository;
        private readonly HotelRepository _hotelRepository;
        private readonly VueloRepository _vueloRepository;

        public AgenceService(PaqueteRepository paqueteRepository,
                            PersonaRepository personaRepository,
                            ReservacionRepository reservacionRepository,
                            HabitacionRepository habitacionRepository,
                            HotelRepository hotelRepository,
                            VueloRepository vueloRepository
            )
        {
            _paqueteRepository = paqueteRepository;
            _personaRepository = personaRepository;
            _reservacionRepository = reservacionRepository;
            _habitacionRepository = habitacionRepository;
            _hotelRepository = hotelRepository;
            _vueloRepository = vueloRepository;
        }

        #region Paquetes

        public ServiceResult InsertarPaquete(tbPaquetes item)
        {
            var result = new ServiceResult();

            try
            {
                var insert = _paqueteRepository.Insert(item);

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
        
        public ServiceResult ListadoPaquetesPorPais()
        {
            var result = new ServiceResult();
            try
            {
                var list = _paqueteRepository.Toppaises();
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

        public ServiceResult Existe(string identidad)
        {
            var result = new ServiceResult();
            try
            {
                var list = _personaRepository.Existe(identidad);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
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





        //Hoteles

        public ServiceResult ListadoHoteles(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _hotelRepository.ListPorPais(id);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }


        //Habitaciones

        public ServiceResult ListadoHabitaciones(int hotel)
        {
            var result = new ServiceResult();
            try
            {
                var list = _habitacionRepository.ListXhotel(hotel);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }


        //Vuelos

        public ServiceResult ListadoVuelos(int Id_Pais)
        {
            var result = new ServiceResult();
            try
            {
                var list = _vueloRepository.ListXPais(Id_Pais);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }


    }
}
