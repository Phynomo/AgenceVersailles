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
    public class HabitacionRepository : IRepository<tbHabitaciones, VW_tbHabitaciones>
    {
        public RequestStatus Delete(tbHabitaciones item)
        {
            throw new NotImplementedException();
        }

        public VW_tbHabitaciones find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbHabitaciones item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbHabitaciones> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbHabitaciones>(ScriptsDataBase.UDP_Listar_Habitaciones, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbHabitaciones item)
        {
            throw new NotImplementedException();
        }
    }
}
