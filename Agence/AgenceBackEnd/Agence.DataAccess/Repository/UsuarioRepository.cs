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



        public RequestStatus Recuperar(tbUsuarios item)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_Correo", item.usua_Correo, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Contrasena", item.usua_Contrasena, DbType.String, ParameterDirection.Input);

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Recuperar_Usuarios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }

        public RequestStatus InsertCliente(tbPersonas item, tbUsuarios item2)
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
            parametros.Add("@usua_NombreUsuario", item2.usua_NombreUsuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Correo", item2.usua_Correo, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Contrasena", item2.usua_Contrasena, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_UsuCreacion", item2.usua_UsuCreacion, DbType.Int32, ParameterDirection.Input);

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Insertar_Cliente, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }

        public IEnumerable<VW_tbUsuarios> List()
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            return db.Query<VW_tbUsuarios>(ScriptsDataBase.UDP_Listar_Usuarios, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbUsuarios> Login(tbUsuarios item)
        {
            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_NombreUsuario", item.usua_NombreUsuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Correo", item.usua_Correo, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Contrasena", item.usua_Contrasena, DbType.String, ParameterDirection.Input);

            return db.Query<VW_tbUsuarios>(ScriptsDataBase.UDP_Login, parametros, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Existe(string usuario)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_NombreUsuario", usuario, DbType.String, ParameterDirection.Input);

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_Existe, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }
          public RequestStatus ExisteCorreo(string usuario)
        {
            RequestStatus result = new RequestStatus();

            using var db = new SqlConnection(AgenceContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_Correo", usuario, DbType.String, ParameterDirection.Input);

            var resultado = db.QueryFirst<string>(ScriptsDataBase.UDP_ExisteCorreo, parametros, commandType: System.Data.CommandType.StoredProcedure);
            result.MessageStatus = resultado;

            return result;
        }

        public RequestStatus Update(tbUsuarios item)
        {
            throw new NotImplementedException();
        }
    }
}
