using Agence.Entities.Entities;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agence.DataAccess.Repository
{
    public class ReservacionRepository : IRepository<tbReservaciones, VW_tbPaquetes>
    {
        public RequestStatus Delete(tbReservaciones item)
        {
            throw new NotImplementedException();
        }

        public VW_tbPaquetes find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbReservaciones item)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@paqu_Id", item.paqu_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@pers_Id", item.pers_Id, DbType.Int32, ParameterDirection.Input);

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Insertar_Reservaciones, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }

        public IEnumerable<VW_tbPaquetes> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbReservaciones item)
        {
            throw new NotImplementedException();
        }
    }
}
