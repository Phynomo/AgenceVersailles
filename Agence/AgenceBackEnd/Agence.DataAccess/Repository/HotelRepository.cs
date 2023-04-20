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
    public class HotelRepository : IRepository<tbHoteles, VW_tbHoteles>
    {
        public RequestStatus Delete(tbHoteles item)
        {
            throw new NotImplementedException();
        }

        public VW_tbHoteles find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbHoteles item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbHoteles> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbHoteles>(ScriptsDataBase.UDP_Listar_Hoteles, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbHoteles> ListPorPais(int id)
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);

            var parametros = new DynamicParameters();
            parametros.Add("@pais_Id", id, DbType.Int32, ParameterDirection.Input);

            return db.Query<VW_tbHoteles>(ScriptsDataBase.UDP_Listar_Hoteles, parametros, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbHoteles item)
        {
            throw new NotImplementedException();
        }
    }
}
