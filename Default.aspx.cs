using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;
using BusinessLogicLayer;
using Entities;

namespace CRUD_EMPLEADOS
{
    public partial class _Default : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmpleados();
            }
        }

        private void LoadEmpleados() 
        {
            List<Empleado> list = EmpleadoBLL.SelectAll();

            repeaterEmpleado.DataSource = list;
            repeaterEmpleado.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string textoBusqueda = txtBusqueda.Text.Trim().ToLower();
            List<Empleado> empleadosFiltrados = new List<Empleado>();

            if (!string.IsNullOrEmpty(textoBusqueda))
            {
                empleadosFiltrados = EmpleadoBLL.SelectAll()
                    .Where(empleado => empleado.Nombre.ToLower().Contains(textoBusqueda))
                    .ToList();
            }

            repeaterEmpleado.DataSource = empleadosFiltrados;
            repeaterEmpleado.DataBind();
        }

        protected void txtBusqueda_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtBusqueda.Text))
            {
                LoadEmpleados();
            }
        }


        protected void modal_Click(object sender, EventArgs e)
        {
            string script = "$('#mymodal').modal('show')";
            ClientScript.RegisterStartupScript(this.GetType(),"Popup",script, true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string nombre = txtNombre.Text;
                string apellido = txtApellido.Text;
                string email = txtEmail.Text;
                decimal salario = decimal.Parse(txtSalario.Text);

                Empleado empleado = new Empleado
                {
                    Nombre = nombre,
                    Apellido = apellido,
                    Email = email,
                    Salario = salario
                };

                int resultado = EmpleadoBLL.Save(empleado);

                string successMessage = "Empleado guardado con éxito.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showSuccessModal",
                    "$('#customModalLabel').text('Éxito'); " +
                    "$('.modal-header').addClass('bg-success'); " +
                    "$('.modal-footer').addClass('bg-success'); " +
                    "$('#customModal .modal-footer .btn-primary').removeClass('btn-primary').addClass('btn-success');" +
                     "$('#customModalMessage').text('" + successMessage + "'); $('#customModal').modal('show');" +
                    "LimpiarCampos();", true);

                LoadEmpleados();
            } 
            catch (Exception ex)
            {
                string errorMessage = ex.Message;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorModal",
                    "$('#customModalLabel').text('Error'); " +
                    "$('.modal-header').addClass('bg-danger'); " +
                    "$('.modal-footer').addClass('bg-danger'); " +
                    "$('#customModal .modal-footer .btn-primary').removeClass('btn-primary').addClass('btn-danger');" +
                    "$('#customModalMessage').text('" + errorMessage + "'); $('#customModal').modal('show');" +
                    "LimpiarCampos();", true);
            }

        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (int.TryParse(hiddenEmpleadoId.Value, out int empleadoId))
            {
                string nombre = txtNombre.Text;
                string apellido = txtApellido.Text;
                string email = txtEmail.Text;
                decimal salario = decimal.Parse(txtSalario.Text);

                Empleado empleadoActualizado = new Empleado
                {
                    Id = empleadoId,
                    Nombre = nombre,
                    Apellido = apellido,
                    Email = email,
                    Salario = salario
                };

                try
                {
                    EmpleadoBLL.Update(empleadoActualizado);

                    string successMessage = "Empleado actualizado con éxito.";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showSuccessModal",
                        "$('#customModalLabel').text('Éxito'); " +
                        "$('.modal-header').addClass('bg-success'); " +
                        "$('.modal-footer').addClass('bg-success'); " +
                        "$('#customModal .modal-footer .btn-primary').removeClass('btn-primary').addClass('btn-success');" +
                        "$('#customModalMessage').text('" + successMessage + "'); $('#customModal').modal('show');", true);

                    LoadEmpleados();
                }
                catch (Exception ex)
                {
                    string errorMessage = ex.Message;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorModal",
                        "$('#customModalLabel').text('Error'); " +
                        "$('.modal-header').addClass('bg-danger'); " +
                        "$('.modal-footer').addClass('bg-danger'); " +
                        "$('#customModal .modal-footer .btn-primary').removeClass('btn-primary').addClass('btn-danger');" +
                        "$('#customModalMessage').text('" + errorMessage + "'); $('#customModal').modal('show');" +
                        "LimpiarCampos();", true);
                }
            }
        }


        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            string empleadoId = e.CommandArgument.ToString();

            if(int.TryParse(empleadoId, out int id))
            {
                
                try
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showDeleteConfirmationModal", "$('#deleteConfirmationModal').modal('show');", true);
                    hiddenEmpleadoId.Value = id.ToString();
                    EmpleadoBLL.Delete(id);
                    LoadEmpleados();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        protected void btnEdit_Command(object sender, CommandEventArgs e)
        {
            string empleadoId = e.CommandArgument.ToString();
            hiddenEmpleadoId.Value = empleadoId.ToString();
            if (int.TryParse(hiddenEmpleadoId.Value, out int Id))
            {
           
                Empleado emp = EmpleadoBLL.SelectEmpById(Id);

                try
                {
                    txtNombre.Text = emp.Nombre;
                    txtApellido.Text = emp.Apellido;
                    txtEmail.Text = emp.Email;
                    txtSalario.Text = (emp.Salario.ToString());

                    string script = "$('#mymodal').modal('show');";

                    if (Id == 0)
                    {
                        btnSave.Visible = true; 
                        btnEdit.Visible = false; 
                    }
                    else
                    {
                        btnSave.Visible = false;
                        btnEdit.Visible = true;  
                    }

                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
    }

}