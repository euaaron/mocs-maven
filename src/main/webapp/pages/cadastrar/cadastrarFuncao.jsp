<%-- 
    Document   : cadastrarFuncao
    Created on : 24/10/2019, 10:15:46
    Author     : euaar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | ${operacao} Funcao</title>
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
        <div>
            <ul class="breadcrumb">
                <li><a href="inicio">Index Admin</a></li>
                <li><a href="PesquisarFuncaoController">Pesquisar</a></li>
                <li>${operacao}</li>
            </ul>
        </div>        
        <div class="container">
            <h1>${operacao} Funcao</h1>
            <form id="incluir" action="ManterFuncaoController?acao=confirmarOperacao&operacao=${operacao}" name="frmManterFuncao" method="post" onsubmit="return validarFormulario(this)">
                <c:if test="${errorMsg != null}">
                    <div class="form-group row">
                        <div class="col">
                            <p class="error">${errorMsg}</p>
                        </div>
                    </div>
                </c:if>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Estabelecimento:</label>
                    <div class="col-sm-2">
                        <select class="custom-select mr-sm-2" name="txtIdEstabelecimento" <c:if test="${operacao == 'Excluir'}"> </c:if>>
                            <option value="0" <c:if test="${funcao.idEstabelecimento == null}"> selected</c:if>> </option>  
                            <c:forEach items="${estabelecimentos}" var="estabelecimento">
                                <option value="${estabelecimento.id}" <c:if test="${funcao.idEstabelecimento == estabelecimento.id}"> selected</c:if>>${estabelecimento.nomeFantasia}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>                    
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="id">Id da Funcao:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="text" min="1" name="txtIdFuncao" id="id" maxlength="10" value="${funcao.id}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                    
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="nome">Nome:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" name="txtNome" id="nome" maxlength="45" value="${funcao.nome}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                    
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="descricao">Descrição:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" name="txtDescricao" id="descricao" maxlength="60" value="${funcao.descricao}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                    
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="nivelPermissao">Nível de Permissão:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="number" name="txtNivelPermissao" id="nivelPermissao" max="5" value="${funcao.nivelPermissao}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
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
                if (form.txtIdEstabelecimento.value == "0") {
                    mensagem = mensagem + "Informe o Estabelecimento\n";
                }
                if (form.txtIdFuncao.value == "") {
                    mensagem = mensagem + "Informe o Código da Função\n";
                }
                if (form.txtNome.value == "") {
                    mensagem = mensagem + "Informe o Nome da Função\n";
                }
                if (form.txtDescricao.value == "") {
                    mensagem = mensagem + "Informe a Descrição da Função\n";
                }
                if (form.txtNivelPermissao.value == "") {
                    mensagem = mensagem + "Informe o Nível de Permissão da Função\n";
                }
                if (!campoNumerico(form.txtIdFuncao.value)) {
                    mensagem = mensagem + "Código da Função deve ser numérico\n";
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
