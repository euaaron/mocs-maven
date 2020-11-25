<%-- 
    Document   : Estabelecimento
    Created on : 05/09/2019, 09:22:06
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | ${operacao} Estabelecimento</title>
        <script src="js/filtros.js"></script>
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
            <li><a href="PesquisarEstabelecimentoController">Pesquisar</a></li>
            <li>${operacao}</li>
        </ul>
        <div class="container">
            <h1 class="page-title">${operacao} Estabelecimento</h1>
            <div class="centralize">
            <form id="incluir" action="ManterEstabelecimentoController?acao=confirmarOperacao&operacao=${operacao}" name="frmManterEstabelecimento" method="post" onsubmit="return validarFormulario(this)">
                <c:if test="${errorMsg != null}">
                    <div class="form-group row">
                        <div class="col">
                            <p class="error">${errorMsg}</p>
                        </div>
                    </div>
                </c:if>
                <div class="form-group row">
                    <label class="col-sm-1 col-form-label" for="idEstabelecimento">Id:</label>
                    <div class="col-sm-1">
                        <input class="form-control" type="number" min="1" name="txtIdEstabelecimento" id="idEstabelecimento" maxlength="10" value="${estabelecimento.id}" <c:if test="${operacao != 'Incluir'}"> readonly</c:if>>
                    </div>
                    <label class="col-sm col-form-label" for="idProprietario">Proprietario:</label>
                    <div class="col-sm-2">
                        <select class="custom-select mr-sm-2" id="idProprietario" name="txtIdProprietario" <c:if test="${operacao == 'Excluir'}"> </c:if>>
                        <option value="0" <c:if test="${estabelecimento.proprietario.id == null}"> selected</c:if>> </option>  
                        <c:forEach items="${proprietarios}" var="proprietario">
                            <option value="${proprietario.id}" <c:if test="${proprietario.id == estabelecimento.proprietario.id}"> selected</c:if> >${proprietario.nome}</option>  
                        </c:forEach>
                        </select>
                    </div>
                    <label class="col-sm col-form-label" for="nomeFantasia">Nome Fantasia:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="txtNomeFantasia" id="nomeFantasia" maxlength="45" value="${estabelecimento.nomeFantasia}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1 col-form-label" for="cnpj">CNPJ:</label>
                    <div class="col-sm-3">
                        <input class="form-control" type="text" onkeyup="filtra('cnpj')" name="txtCnpj" id="cnpj" placeholder="00.000.000/0000-00" maxlength="18" value="${estabelecimento.cnpj}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>                    
                    <label class="col-sm col-form-label" for="inscEstadual">Inscrição Estadual:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="text" onkeyup="filtra('inscEstadual')" name="txtInscEstadual" id="inscEstadual" maxlength="15" placeholder="000.000.000.000" value="${estabelecimento.inscEstadual}"  <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                    <label class="col-sm col-form-label" for="telefone">Telefone:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="text" onkeyup="filtra('telefone')" name="txtTelefone" id="telefone" maxlength="30" placeholder="(xx) xxxx-xxxx" value="${estabelecimento.telefone}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>                    
                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label" for="cep">CEP:</label>
                        <div class="col-sm-2">
                            <input class="form-control" onkeyup="filtra('cep')" type="text" id="cep" name="txtCEP" maxlength="10" placeholder="00.000-000" value="${endestabelecimento.cep}" onkeyup="filtraCEP()"<c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                        <label class="col-sm-1 col-form-label" for="uf">UF:</label>
                        <div class="col-sm-1">
                            <input class="form-control" type="text" id="uf" name="txtUF" maxlength="4" value="${endestabelecimento.uf}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                        <label class="col-sm-1 col-form-label" for="cidade">Cidade:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" id="cidade" name="txtCidade" maxlength="45" value="${endestabelecimento.cidade}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                        <label class="col-sm-1 col-form-label" for="bairro">Bairro:</label>
                        <div class="col-sm-3">
                            <input class="form-control" type="text" id="bairro" name="txtBairro" maxlength="45" value="${endestabelecimento.bairro}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                                                                
                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label" for="logradouro">Logradouro:</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="logradouro" name="txtLogradouro" maxlength="45" value="${endestabelecimento.logradouro}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                        <label class="col-sm col-form-label" for="edificio">Número do Edifício:</label>
                        <div class="col-sm-1">
                            <input class="form-control" type="text" id="edificio" name="txtEdificio" maxlength="9" value="${endestabelecimento.numEdificio}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                        <label class="col-sm col-form-label" for="complemento">Complemento:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" id="complemento" name="txtComplemento" maxlength="29" value="${endestabelecimento.numComplemento}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>
                    <div>
                        <button type="submit" class="btn btn-primary confirma" name="btnIncluir" value="Confirmar">Confirmar</button>
                    </div>
                </form>
            </div>
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
                if (form.txtIdEstabelecimento.value == "") {
                    mensagem = mensagem + "Informe o Código do Estabelecimento\n";
                }
                if (form.txtIdProprietario.value == "0") {
                    mensagem = mensagem + "Informe o Proprietário\n";
                }
                if (form.txtCnpj.value == "") {
                    mensagem = mensagem + "Informe o CNPJ do Estabelecimento\n";
                }
                if (form.txtNomeFantasia.value == "") {
                    mensagem = mensagem + "Informe o Nome do Estabelecimento\n";
                }
                if (form.txtInscEstadual.value == "") {
                    mensagem = mensagem + "Informe a Inscrição Estadual do Estabelecimento\n";
                }
                if (form.txtTelefone.value == "") {
                    mensagem = mensagem + "Informe o Telefone\n";
                }
                if (form.txtCEP.value == "") {
                    mensagem = mensagem + "Informe o CEP do Estabelecimento\n";
                }
                if (form.txtUF.value == "") {
                    mensagem = mensagem + "Informe a Unidade de Federação\n";
                }
                if (form.txtCidade.value == "") {
                    mensagem = mensagem + "Informe a Cidade do Estabelecimento\n";
                }
                if (form.txtLogradouro.value == "") {
                    mensagem = mensagem + "Informe o Logradouro do Estabelecimento\n";
                }
                if (form.txtBairro.value == "") {
                    mensagem = mensagem + "Informe o Bairro do Estabelecimento\n";
                }
                if (form.txtEdificio.value == "") {
                    mensagem = mensagem + "Informe o Número do Edifício\n";
                }
                if (!campoNumerico(form.txtIdEstabelecimento.value)) {
                    mensagem = mensagem + "Código do Estabelecimento deve ser numérico\n";
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
