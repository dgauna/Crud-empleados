<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CRUD_EMPLEADOS._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container">
    <div class="modal" id="mymodal" role="dialog" data-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-lg"> 
            <div class="modal-content">
                <div class="modal-header bg-dark text-light">
                    <h4 class="modal-title text-center">ABM Empleado</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" CssClass="form-control" placeholder="Nombre" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>Apellido</label>
                        <asp:TextBox ID="txtApellido" CssClass="form-control" placeholder="Apellido" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>Salario</label>
                        <asp:TextBox ID="txtSalario" CssClass="form-control" placeholder="Salario" runat="server" />
                        <asp:HiddenField ID="hdEmpleadoId" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" CssClass="btn btn-success" OnClick="btnSave_Click" Text="Guardar" runat="server" Visible="false" />
                    <asp:Button ID="btnEdit" CssClass="btn btn-primary" OnClick="btnEdit_Click" Text="Editar" runat="server" Visible="false" />
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
</div>

    <section id="section">
        <div class="row match-height">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="text-center">Listado de Empleados</h3>
                        <hr />
                        <div class="row justify-content-between">
                            <div class="col-md-4">
                                <div class="input-group">
                                    <asp:TextBox ID="txtBusqueda" OnTextChanged="txtBusqueda_TextChanged" AutoPostBack="true" OnClientKeyUp="handleKeyUp(event)" runat="server" CssClass="form-control" placeholder="Buscar por nombre..." />
                                    <div class="input-group-append">
                                        <asp:Button ID="btnBuscar" runat="server" CssClass="btn btn-primary" Text="Buscar" OnClick="btnBuscar_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8 text-md-right">
                                <asp:Button 
                                    Text="Nuevo Usuario" 
                                    ID="modal" 
                                    CssClass="btn btn-primary" 
                                    OnClick="modal_Click" 
                                    runat="server" 
                                    style="margin-bottom: 25px;" 
                                    BorderStyle="Solid"/>
                            </div>
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <table class="table table-hover table-striped table-bordered">
                                        <asp:Repeater runat="server" ID="repeaterEmpleado">
                                            <HeaderTemplate>
                                                <thead class="bg-dark text-white">
                                                    <tr>
                                                        <th scope="col" class="text-center">ID</th>
                                                        <th scope="col" class="text-center">Nombre</th>
                                                        <th scope="col" class="text-center">Apellido</th>
                                                        <th scope="col" class="text-center">Email</th>
                                                        <th scope="col" class="text-center">Salario</th>
                                                        <th scope="col" class="text-center">Accion</th>
                                                    </tr>
                                                </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr class="separator">
                                                    <td class="text-center"><%# Eval("ID") %></td>
                                                    <td class="text-center"><%# Eval("Nombre") %></td>
                                                    <td class="text-center"><%# Eval("Apellido") %></td>
                                                    <td class="text-center"><%# Eval("Email") %></td>
                                                    <td class="text-center"><%# Eval("Salario") %></td>
                                                    <td class="text-center">
                                                        <asp:LinkButton CommandName="Edit" ID="btnEdit" CommandArgument='<%#Eval("ID") %>' OnCommand="btnEdit_Command" CssClass="btn btn-sm btn-warning" runat="server"><i class="fa fa-pencil"></i></asp:LinkButton>
                                                        <asp:LinkButton CommandName="Delete" ID="btnDelete" CommandArgument='<%#Eval("ID") %>' OnCommand="btnDelete_Command" CssClass="btn btn-sm btn-danger" runat="server"><i class="fa fa-trash"></i></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal" id="customModal" tabindex="-1" role="dialog" aria-labelledby="customModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="customModalLabel"></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="customModalMessage"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal" id="deleteConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
                    <asp:HiddenField ID="hiddenEmpleadoId" runat="server" />
                        <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-warning">
                                <h5 class="modal-title text-white" id="deleteConfirmationModalLabel">Advertencia</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>¿Está seguro de eliminar al usuario?</p>
                            </div>
                            <div class="modal-footer">
                                <asp:LinkButton CommandName="Delete" ID="btnDelete" CommandArgument='<%#Eval("ID") %>' OnCommand="btnDelete_Command" CssClass="btn btn-danger" runat="server">Eliminar</asp:LinkButton>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>

                            </div>
                      </div>
                    </div>
                   </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        function LimpiarCampos() {
            document.getElementById('<%= txtNombre.ClientID %>').value = '';
            document.getElementById('<%= txtApellido.ClientID %>').value = '';
            document.getElementById('<%= txtEmail.ClientID %>').value = '';
            document.getElementById('<%= txtSalario.ClientID %>').value = '';
        }
    </script>
    <script type="text/javascript">
        function handleKeyUp(event) {
            if (event.code === "Backspace") {
                LoadEmpleados()
            }
        }
    </script>
</asp:Content>

