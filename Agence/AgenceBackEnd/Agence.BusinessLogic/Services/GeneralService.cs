using Agence.DataAccess.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agence.BusinessLogic.Services
{
    public class GeneralService
    {

        private readonly PaisRepository _paisesRepositorty;

        public GeneralService(PaisRepository paisRepository)
        {
            _paisesRepositorty = paisRepository;
        }



        //Vuelos

        public ServiceResult ListadoPaises()
        {
            var result = new ServiceResult();
            try
            {
                var list = _paisesRepositorty.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

    }
}
