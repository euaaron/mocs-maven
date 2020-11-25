<%-- 
    Document   : cadastroPedido
    Created on : 04/10/2019, 17:24:39
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | ${operacao} Pedido</title>
        <%-- Estilos, scripts e dependências de terceiros --%>
        <link rel="stylesheet" href="vendor/bootstrap/bootstrap.min.css"/>
        <script src="vendor/jquery-3.3.1.slim.min.js"></script>
        <script src="vendor/popper.min.js"></script>
        <script src="vendor/bootstrap/bootstrap.min.js"></script>
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
            <li><a href="PesquisarPedidoController">Pesquisar</a></li>
            <li>${operacao}</li>
        </ul>
        <div class="container">
            <h1>${operacao} Pedido</h1>
            <form id="incluir" action="ManterPedidoController?acao=confirmarOperacao&operacao=${operacao}<c:if test="${comanda != null}">&icm=${comanda.id}</c:if>" name="frmManterPedido" method="post" onsubmit="return validarFormulario(this)">
                <c:if test="${errorMsg != null}">
                    <div class="form-group row">
                        <div class="col">
                            <p class="error">${errorMsg}</p>
                        </div>
                    </div>
                </c:if>                
                <c:if test="${comanda != null}"> Comanda ${comanda.id} de ${comanda.cliente.nome} </c:if>
                <c:if test="${comanda == null}">
                    <div class="form-group row">
                        <label for="idComanda" class="col-sm-2 col-form-label">Comanda:</label>
                        <div class="col-sm-2">
                            <select id="idComanda" name="txtIdComanda" class="custom-select mr-sm-2">
                                <option value="0" <c:if test="${pedido.idComanda == null}"> selected</c:if>> </option>
                                <c:forEach items="${comandas}" var="comanda">
                                    <option value="${comanda.id}" <c:if test="${pedido.idComanda == comanda.id}"> selected</c:if>>${comanda.id} - ${comanda.cliente.nome}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>    
                </c:if>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="idPedido">Id:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="number" min="1" name="txtId" id="idPedido" maxlength="10" value="${pedido.id}" <c:if test="${operacao != 'Incluir'}"> readonly</c:if>/>
                        </div>
                    </div>                
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="idPedido" for="idPrato">Prato:</label>
                        <div class="col-sm-2">
                            <select class="custom-select mr-sm-2" id="idPrato" name="txtIdPrato">
                                <option value="0" <c:if test="${pedido.idPrato == null}"> selected</c:if>> </option>
                            <c:forEach items="${pratos}" var="prato">
                                <option value="${prato.id}" <c:if test="${pedido.idPrato == prato.id}"> selected</c:if>>${prato.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>                          
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="quantidade">Quantidade:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="number" name="txtQuantidade" id="quantidade" min="1" value="${pedido.quantidade}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>                                        
                <button type="submit" class="btn btn-primary" name="btnIncluir" value="Confirmar">Confirmar</button>
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
                return ehNumero;
            }

            function validarFormulario(form) {
                var mensagem;
                mensagem = "";
                if (form.txtId.value == "") {
                    mensagem = mensagem + "Informe o Código do Pedido\n";
                }
                if (form.txtIdPrato.value == "0") {
                    mensagem = mensagem + "Informe o Prato\n";
                }
                if (form.txtQuantidade.value == "") {
                    mensagem = mensagem + "Informe a Quantidade\n";
                }
                if (form.txtIdComanda.value == "0") {
                    mensagem = mensagem + "Informe a Comanda\n";
                }
                if (!campoNumerico(form.txtId.value)) {
                    mensagem = mensagem + "Código do Pedido deve ser numérico\n";
                }
                if (!campoNumerico(form.txtQuantidade.value)) {
                    mensagem = mensagem + "A quantidade deve ser numérico e inteiro\n";
                }
                if (mensagem == "") {
                    return true;
                } else {
                    if("${operacao}" !== "Excluir") {
                        alert(mensagem);
                        return false;
                    }
                    return true;
                }
            }
        </script>
    </body>
</html>
