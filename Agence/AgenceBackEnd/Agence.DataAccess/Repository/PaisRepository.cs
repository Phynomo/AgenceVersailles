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
    public class PaisRepository : IRepository<tbPaises, VW_tbPaises>
    {
        public RequestStatus Delete(tbPaises item)
        {
            throw new NotImplementedException();
        }

        public VW_tbPaises find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbPaises item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbPaises> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbPaises>(ScriptsDataBase.UDP_Listar_Paises, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbPaises item)
        {
            throw new NotImplementedException();
        }
    }
}
