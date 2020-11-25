<%-- 
    Document   : cadastroComanda
    Created on : 06/10/2019, 10:19:50
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
        <title>MOCS | ${operacao} Comanda</title>
        <%-- Estilos, scripts e dependências de terceiros --%>
        <link rel="stylesheet" href="vendor/bootstrap/bootstrap.min.css"/>
        <script src="vendor/jquery-3.3.1.slim.min.js"></script>
        <script src="vendor/popper.min.js"></script>
        <script src="vendor/bootstrap/bootstrap.min.js"></script>
        <script src="vendor/fontawesome/js/all.min.js"></script>
        <%-- Estilos e scripts próprios --%>
        <link rel="stylesheet" href="./css/main.css"/>
        <link rel="stylesheet" href="./css/cadastro.css"/>
        <script src="./js/filtros.js"></script>
    </head>
    <body>
        <nav class="top-bar">
            <div class="total-center">
                <a class="navbar-brand" href="inicio">MOCS</a>
            </div>
        </nav>
        <ul class="breadcrumb">
            <li><a href="inicio">Menu</a></li>
            <li><a href="PesquisarComandaController">Pesquisar</a></li>
            <li>${operacao}</li>
        </ul>
        <div class="container">
            <h1>${operacao} Comanda</h1>
            <form id="incluir" action="ManterComandaController?acao=confirmarOperacao&operacao=${operacao}" name="frmManterUsuario" method="post" onsubmit="return validarFormulario()">
                <c:if test="${errorMsg != null}">
                    <div class="form-group row">
                        <div class="col">
                            <p class="error">${errorMsg}</p>
                        </div>
                    </div>
                </c:if>    
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="txtId">Id:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="number" min="1" name="txtId" id="txtId" maxlength="10" value="${comanda.id}" <c:if test="${operacao != 'Incluir'}"> readonly </c:if> />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="txtIdCliente">Cliente</label>
                        <div class="col-sm-2">
                            <select class="custom-select mr-sm-2" id="idCliente" name="txtIdCliente" <c:if test="${operacao == 'Excluir'}"> </c:if>>
                            <option value="0" <c:if test="${comanda.idCliente == null}"> selected</c:if>> </option>  
                            <c:forEach items="${clientes}" var="cliente">
                                <option value="${cliente.id}" <c:if test="${cliente.id == comanda.idCliente}"> selected</c:if> >${cliente.nome}</option>  
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="txtDataComanda">Data:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="date" name="txtDataComanda" id="dataComanda" value="${comanda.data}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="txtHoraComanda">Hora:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="time" name="txtHoraComanda" id="horaComanda" value="${comanda.hora}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>                    
                <button type="submit" class="btn btn-primary confirma" name="btnIncluir" value="Confirmar">Confirmar</button>
            </form>
        </div>
        <script>

            function campoNumerico(valor)
            {
                var caracteresValidos = "0123456789";
                var ehNumero = true;
                var umCaracter;
                for (i = 0; i < valor.length && ehNumero == true; i++)
                {
                    umCaracter = valor.charAt(i);
                    if (caracteresValidos.indexOf(umCaracter) == -1)
                    {
                        ehNumero = false;
                    }
                }
            }

            function validarFormulario() {
                var mensagem;
                mensagem = "";
                if (txtId.value == "") {
                    console.log("Comanda Id: " + txtId.value);
                    mensagem = mensagem + "Informe o Código da Comanda\n";
                }
                if (txtIdCliente.value == "0") {
                    console.log("Cliente: " + txtHoraComanda.value);
                    mensagem = mensagem + "Informe o Cliente\n";
                }
                if (txtDataComanda.value == "") {
                    console.log("Data: " + txtHoraComanda.value);
                    mensagem = mensagem + "Informe a data de abertura da comanda\n";
                }
                if (txtHoraComanda.value == "") {
                    console.log("Hora: " + txtHoraComanda.value);
                    mensagem = mensagem + "Informe a hora de abertura da comanda\n";
                }
                if (!campoNumerico(txtId.value)) {
                    console.log("Comanda Id: " + txtId.value);
                    mensagem = mensagem + "Código da Comanda deve ser numérico\n";
                }
                if (mensagem == "") {
                    enable();
                    return true;
                } else {
                    if("${operacao}" !== "Excluir") {
                        alert(mensagem);
                        return false;
                    }
                    return true;
                }
            }

            function enable() {
                txtIdCliente.disabled = false;
            }
        </script>
    </body>
</html>