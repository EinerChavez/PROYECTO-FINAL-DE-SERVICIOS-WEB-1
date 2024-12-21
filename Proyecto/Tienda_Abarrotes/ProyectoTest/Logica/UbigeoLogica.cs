using ProyectoTest.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ProyectoTest.Logica
{
    public class UbigeoLogica
    {
        
        private static UbigeoLogica _instancia = null;

        public UbigeoLogica()
        {

        }

        public static UbigeoLogica Instancia
        {
            get {
                if (_instancia == null) {
                    _instancia = new UbigeoLogica();
                }
                return _instancia;
            }
        }

        public List<Distrito> ObtenerDistrito()
        {
            List<Distrito> lst = new List<Distrito>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.CN))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("select * from DISTRITO", oConexion);
                    cmd.CommandType = CommandType.Text;
                    oConexion.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lst.Add(new Distrito()
                            {
                                IdDistrito = dr["IdDistrito"].ToString(),
                                Descripcion = dr["Descripcion"].ToString(),
                            });
                        }
                    }

                }
                catch (Exception ex)
                {
                    lst = new List<Distrito>();
                }
            }
            return lst;
        }

    }
}