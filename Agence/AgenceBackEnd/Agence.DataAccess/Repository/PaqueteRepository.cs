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
    public class PaqueteRepository : IRepository<tbPaquetes, VW_tbPaquetes>
    {
        public RequestStatus Delete(tbPaquetes item)
        {
            throw new NotImplementedException();
        }

        public VW_tbPaquetes find(int? id)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@paqu_Id", id, DbType.Int32, ParameterDirection.Input);
            return db.QueryFirst<VW_tbPaquetes>(ScriptsDataBase.UDP_Encontrar_Paquetes, parametros, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Insert(tbPaquetes item)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);

            var parametros = new DynamicParameters();
            parametros.Add("@paqu_Nombre", item.paqu_Nombre, DbType.String, ParameterDirection.Input); 
            parametros.Add("@paqu_Imagen", item.paqu_Imagen, DbType.String, ParameterDirection.Input); 
            parametros.Add("@vuel_Id", item.vuel_Id, DbType.Int32, ParameterDirection.Input); 
            parametros.Add("@habi_Id", item.habi_Id, DbType.Int32, ParameterDirection.Input); 
            parametros.Add("@paqu_Personas", item.paqu_Personas, DbType.Int32, ParameterDirection.Input); 
            parametros.Add("@paqu_Precio", item.paqu_Precio, DbType.Decimal, ParameterDirection.Input); 

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Insertar_Paquetes, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }

        public IEnumerable<VW_tbPaquetes> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbPaquetes>(ScriptsDataBase.UDP_Listar_Paquetes, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbPaquetes> ListCaros()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbPaquetes>(ScriptsDataBase.UDP_Listar_PaquetesCaros, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbPaquetes> ListBaratos()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbPaquetes>(ScriptsDataBase.UDP_Listar_PaquetesBaratos, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbPaquetes> ListXPerson(int id)
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);

            var parametros = new DynamicParameters();
            parametros.Add("@pers_Id", id, DbType.Int32, ParameterDirection.Input);

            return db.Query<VW_tbPaquetes>(ScriptsDataBase.UDP_Listar_PaquetesPorPersona, parametros, commandType: System.Data.CommandType.StoredProcedure);
        }


        public RequestStatus Update(tbPaquetes item)
        {
            throw new NotImplementedException();
        }
    }
}
