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
    public class PaqueteRepository : IRepository<tbPaquetes, VW_tbPaquetes>
    {
        public RequestStatus Delete(tbPaquetes item)
        {
            throw new NotImplementedException();
        }

        public VW_tbPaquetes find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbPaquetes item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbPaquetes> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbPaquetes>(ScriptsDataBase.UDP_Listar_Paquetes, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbPaquetes item)
        {
            throw new NotImplementedException();
        }
    }
}
