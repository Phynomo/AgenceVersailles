using Agence.DataAccess.Repository;
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
        
        public AgenceService(PaqueteRepository paqueteRepository)
        {
            _paqueteRepository = paqueteRepository;
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
        #endregion

    }
}
