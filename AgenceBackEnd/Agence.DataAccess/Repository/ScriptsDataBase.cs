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
        public static string UDP_Insertar_Usuarios = "acce.UDP_tbUsuarios_Insert";
        public static string UDP_Editar_Usuarios = "acce.UDP_tbUsuarios_Edit";
        public static string UDP_Eliminar_Usuarios = "acce.UDP_tbUsuarios_Delete";
        public static string UDP_Find_Usuarios = "acce.UDP_tbUsuarios_Find";
        #endregion


        #region Paquetes
        public static string UDP_Listar_Paquetes = "agen.UDP_tbPaquetes_List";
        //public static string UDP_Insertar_Usuarios = "acce.UDP_tbUsuarios_Insert";
        //public static string UDP_Editar_Usuarios = "acce.UDP_tbUsuarios_Edit";
        //public static string UDP_Eliminar_Usuarios = "acce.UDP_tbUsuarios_Delete";
        //public static string UDP_Find_Usuarios = "acce.UDP_tbUsuarios_Find";
        #endregion

    }
}
