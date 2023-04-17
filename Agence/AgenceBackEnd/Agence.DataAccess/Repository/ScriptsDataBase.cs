using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agence.DataAccess.Repository
{
    public class ScriptsDataBase
    {
        #region Usuarios
        public static string UDP_Listar_Usuarios = "acce.UDP_VW_tbUsuarios_List";
        public static string UDP_Login = "acce.UDP_VW_tbUsuarios_Login";
        public static string UDP_Insertar_Usuarios = "acce.UDP_tbUsuarios_Insert";
        public static string UDP_Editar_Usuarios = "acce.UDP_tbUsuarios_Edit";
        public static string UDP_Eliminar_Usuarios = "acce.UDP_tbUsuarios_Delete";
        public static string UDP_Find_Usuarios = "acce.UDP_tbUsuarios_Find";
        public static string UDP_Existe = "acce.UDP_UsuarioExiste";
        public static string UDP_ExisteIdentidad = "agen.UDP_IdentidadExiste";
        #endregion


        #region Paquetes
        public static string UDP_Listar_Paquetes = "agen.UDP_tbPaquetes_List";
        public static string UDP_Listar_PaquetesCaros = "agen.UDP_tbPaquetes_ListTop5Caros";
        public static string UDP_Listar_PaquetesBaratos = "agen.UDP_tbPaquetes_ListTop10baratos";
        public static string UDP_Listar_PaquetesPorPersona = "agen.UDP_tbPaquetes_ListXPerson";
        public static string UDP_Encontrar_Paquetes = "agen.UDP_tbPaquetes_Find";
        //public static string UDP_Insertar_Usuarios = "acce.UDP_tbUsuarios_Insert";
        //public static string UDP_Editar_Usuarios = "acce.UDP_tbUsuarios_Edit";
        //public static string UDP_Eliminar_Usuarios = "acce.UDP_tbUsuarios_Delete";
        //public static string UDP_Find_Usuarios = "acce.UDP_tbUsuarios_Find";
        #endregion

        #region Paquetes
        public static string UDP_Listar_Personas = "agen.UDP_tbPersonas_List";
        public static string UDP_Insertar_Personas = "agen.UDP_tbPersonas_Insert";
        public static string UDP_Insertar_Cliente = "agen.UDP_InsertarCliente";
        //public static string UDP_Editar_Usuarios = "acce.UDP_tbUsuarios_Edit";
        //public static string UDP_Eliminar_Usuarios = "acce.UDP_tbUsuarios_Delete";
        //public static string UDP_Find_Usuarios = "acce.UDP_tbUsuarios_Find";
        #endregion


    }
}
