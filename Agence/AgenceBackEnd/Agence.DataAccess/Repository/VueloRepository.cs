using Agence.Entities.Entities;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agence.DataAccess.Repository
{
    public class VueloRepository : IRepository<tbVuelos, VW_tbVuelos>
    {
        public RequestStatus Delete(tbVuelos item)
        {
            throw new NotImplementedException();
        }

        public VW_tbVuelos find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbVuelos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbVuelos> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbVuelos>(ScriptsDataBase.UDP_Listar_Vuelos, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbVuelos item)
        {
            throw new NotImplementedException();
        }
    }
}
