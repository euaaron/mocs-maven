<%-- 
    Document   : cadastroRefeicao
    Created on : 07/09/2019, 18:45:11
    Author     : Aaron Stiebler & Débora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
        <title>MOCS | ${operacao} Prato</title>
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
            <li><a href="inicio">Index Admin</a></li>
            <li><a href="PesquisarPratoController">Pesquisar</a></li>
            <li>${operacao}</li>
        </ul>
        <div class="container">
            <h1>${operacao} Prato</h1>
            <form id="incluir" action="ManterPratoController?acao=confirmarOperacao&operacao=${operacao}" name="frmManterPrato" method="post" onsubmit="return validarFormulario(this)">
                <c:if test="${errorMsg != null}">
                    <div class="form-group row">
                        <div class="col">
                            <p class="error">${errorMsg}</p>
                        </div>
                    </div>
                </c:if>
                <div class="form-group row">
                    <label for="id" class="col-sm-2 col-form-label">Id:</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" name="txtId" maxlength="10" min="1" id="idPrato" value="${prato.id}" <c:if test="${operacao != 'Incluir'}"> readonly</c:if>/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">Funcionario:</label>
                        <div class="col-sm-2">
                            <select name="txtIdFuncionario" class="custom-select mr-sm-2" <c:if test="${operacao == 'Excluir'}"> </c:if>>
                            <option value="0" <c:if test="${prato.idFuncionario == null}"> selected</c:if>> </option>  
                            <c:forEach items="${funcionarios}" var="funcionario">                                    
                                <option value="${funcionario.id}" <c:if test="${prato.idFuncionario == funcionario.id}"> selected</c:if>>${funcionario.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Estabelecimento:</label>
                    <div class="col-sm-2">
                        <select name="txtIdEstabelecimento" class="custom-select mr-sm-2">
                            <option value="0" <c:if test="${prato.idEstabelecimento == null}"> selected</c:if>> </option>  
                            <c:forEach items="${estabelecimentos}" var="estabelecimento">
                                <option value="${estabelecimento.id}" <c:if test="${prato.idEstabelecimento == estabelecimento.id}"> selected</c:if>>${estabelecimento.nomeFantasia}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="nome" class="col-sm-2 col-form-label">Nome:</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" name="txtNome" id="nome" maxlength="45" value="${prato.nome}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="descricao" class="col-sm-2 col-form-label">Descricao:</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" name="txtDescricao" id="descricao" maxlength="60" value="${prato.descricao}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                
                    <div class="form-group row">
                        <label for="imagem" class="col-sm-2 col-form-label">Url da Imagem:</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" name="txtImagemUrl" id="imagem" value="${prato.imagemUrl}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="preco" class="col-sm-2 col-form-label">Preco</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" name="txtPreco" id="preco" maxlength="12" placeholder="00.00" value="${prato.preco}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                
                    <div class="form-group row">
                        <label for="dataCriacao" class="col-sm-2 col-form-label">Data da Criação:</label>
                        <div class="col-sm-2">
                            <input type="date" class="form-control" name="txtDataCriacao" id="dataCriacao" value="${prato.dataCriacao}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">Exibir:</label>
                        <div class="col-sm-2">
                            <select name="txtExibir" class="custom-select mr-sm-2">
                                <option value="0" <c:if test="${prato.exibir == 0}"> selected</c:if>>Não</option>
                            <option value="1" <c:if test="${prato.exibir == 1}"> selected</c:if>>Sim</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" name="btnIncluir" value="Confirmar">Confirmar</button>
            </form>
        </div>
        <script>
            function campoNumerico(valor) {
                var caracteresValidos = "0123456789";
                var ehNumero = true;
                var umCaracter;
                for (i = 0; i < valor.length && ehNumero == true; i++) {
                    umCaracter = valor.charAt(i);
                    if (caracteresValidos.indexOf(umCaracter) == -1) {
                        ehNumero = false;
                    }
                }
                return ehNumero;
            }
            function validarFormulario(form) {
                var mensagem;
                mensagem = "";

                if (form.txtIdFuncionario.value == "0") {
                    mensagem = mensagem + "Informe o Funcionário\n";
                }
                if (form.txtIdEstabelecimento.value == "0") {
                    mensagem = mensagem + "Informe o Estabelecimento\n";
                }
                if (form.txtId.value == "") {
                    mensagem = mensagem + "Informe o Código do Prato\n";
                }
                if (form.txtNome.value == "") {
                    mensagem = mensagem + "Informe o Nome do Prato\n";
                }
                if (form.txtDescricao.value == "") {
                    mensagem = mensagem + "Informe a Descrição do Prato\n";
                }
                var antes;
                var depois;
                if (form.txtPreco.value == "") {
                    mensagem = mensagem + "Informe o Preço do Prato\n";
                } else {
                    antes = form.txtPreco.value;
                    depois = antes.replace(",", ".");
                    form.txtPreco.value = depois;
                }
                if (form.txtDataCriacao.value == "") {
                    mensagem = mensagem + "Informe a Data da Criação do Prato\n";
                }
                if (form.txtExibir.value == "") {
                    mensagem = mensagem + "Informe se quer esse Prato exibindo no Estabelecimento\n";
                }
                if (!campoNumerico(form.txtId.value)) {
                    mensagem = mensagem + "Código do Prato deve ser numérico\n";
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
