using ProyectoTest.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;

namespace ProyectoTest.Logica
{
    public class CompraLogica
    {
        private static CompraLogica _instancia = null;

        public CompraLogica()
        {

        }

        public static CompraLogica Instancia
        {
            get
            {
                if (_instancia == null)
                {
                    _instancia = new CompraLogica();
                }

                return _instancia;
            }
        }

        public List<Compra> ListarCompras()
        {
            List<Compra> rptListaCompras = new List<Compra>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.CN))
            {
                SqlCommand cmd = new SqlCommand("sp_obtenerCompras", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    oConexion.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        rptListaCompras.Add(new Compra()
                        {
                            IdCompra = Convert.ToInt32(dr["IdCompra"].ToString()),
                            IdUsuario = Convert.ToInt32(dr["IdUsuario"].ToString()),
                            TotalProducto = dr["TotalProducto"].ToString(),
                            Total = Convert.ToDecimal(dr["Total"].ToString(), new CultureInfo("es-PE")),
                            Contacto = dr["Contacto"].ToString(),
                            Telefono = dr["Telefono"].ToString(),
                            Direccion = dr["Direccion"].ToString(),
                            IdDistrito = dr["IdDistrito"].ToString(),
                            FechaTexto = dr["FechaCompra"].ToString()
                        });
                    }
                    dr.Close();

                    return rptListaCompras;

                }
                catch (Exception ex)
                {
                    rptListaCompras = null;
                    return rptListaCompras;
                }
            }
        }

        public bool Registrar(Compra oCompra)
        {

            bool respuesta = false;
            using (SqlConnection oConexion = new SqlConnection(Conexion.CN))
            {
                try
                {
                    StringBuilder query = new StringBuilder();
                    foreach (DetalleCompra dc in oCompra.oDetalleCompra) {
                        query.AppendLine("insert into detalle_compra(IdCompra,IdProducto,Cantidad,Total) values (¡idcompra!," + dc.IdProducto +","+dc.Cantidad+","+dc.Total+")");
                    }

                    SqlCommand cmd = new SqlCommand("sp_registrarCompra", oConexion);
                    cmd.Parameters.AddWithValue("IdUsuario", oCompra.IdUsuario);
                    cmd.Parameters.AddWithValue("TotalProducto", oCompra.TotalProducto);
                    cmd.Parameters.AddWithValue("Total", oCompra.Total);
                    cmd.Parameters.AddWithValue("Contacto", oCompra.Contacto);
                    cmd.Parameters.AddWithValue("Telefono", oCompra.Telefono);
                    cmd.Parameters.AddWithValue("Direccion", oCompra.Direccion);
                    cmd.Parameters.AddWithValue("IdDistrito", oCompra.IdDistrito);
                    cmd.Parameters.AddWithValue("QueryDetalleCompra", query.ToString());
                    cmd.Parameters.Add("Resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oConexion.Open();
                    cmd.ExecuteNonQuery();
                    respuesta = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);

                }
                catch (Exception ex)
                {
                    respuesta = false;
                }
            }
            return respuesta;
        }



    }
}