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
    public class PersonaRepository : IRepository<tbPersonas, VW_tbPersonas>
    {
        public RequestStatus Delete(tbPersonas item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Existe(string identidad)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@pers_Identidad", identidad, DbType.String, ParameterDirection.Input);

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_ExisteIdentidad, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }

        public VW_tbPersonas find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbPersonas item)
        {
              RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@pers_Nombres", item.pers_Nombres, DbType.String, ParameterDirection.Input);
            parametros.Add("@pers_Apellidos", item.pers_Apellidos, DbType.String, ParameterDirection.Input);
            parametros.Add("@pers_Identidad", item.pers_Identidad, DbType.String, ParameterDirection.Input);
            parametros.Add("@estc_Id", item.estc_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@pers_FechaNacimiento", item.pers_FechaNacimiento, DbType.Date, ParameterDirection.Input);
            parametros.Add("@pers_Sexo", item.pers_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@pers_Celular", item.pers_Celular, DbType.String, ParameterDirection.Input);
            parametros.Add("@pers_EsEmpleado", item.pers_EsEmpleado, DbType.Int32, ParameterDirection.Input);

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Insertar_Personas, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }


        public IEnumerable<VW_tbPersonas> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbPersonas>(ScriptsDataBase.UDP_Listar_Personas, null, commandType: System.Data.CommandType.StoredProcedure);

        }

        public RequestStatus Update(tbPersonas item)
        {
            throw new NotImplementedException();
        }
    }
}
