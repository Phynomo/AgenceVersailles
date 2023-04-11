using Dapper;
using Microsoft.Data.SqlClient;
using Agence.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Agence.DataAccess.Repository
{
    public class UsuarioRepository : IRepository<tbUsuarios, VW_tbUsuarios>
    {
        public RequestStatus Delete(tbUsuarios item)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_Id", item.usua_Id, DbType.Int32, ParameterDirection.Input);
            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Eliminar_Usuarios, parametros, commandType: System.Data.CommandType.StoredProcedure);

            result.MessageStatus = resultado;

            return result;
        }

        public VW_tbUsuarios find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbUsuarios item)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_NombreUsuario", item.usua_NombreUsuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Correo", item.usua_Correo, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Contrasena", item.usua_Contrasena, DbType.String, ParameterDirection.Input);
            parametros.Add("@pers_Id", item.pers_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@usua_UsuCreacion", item.usua_UsuCreacion, DbType.Int32, ParameterDirection.Input); 

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Insertar_Usuarios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }

        public IEnumerable<VW_tbUsuarios> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbUsuarios>(ScriptsDataBase.UDP_Listar_Usuarios, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbUsuarios item)
        {
            throw new NotImplementedException();
        }
    }
}
