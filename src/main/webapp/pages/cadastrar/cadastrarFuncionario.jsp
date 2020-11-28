<%-- 
    Document   : cadastroFuncionario
    Created on : 05/09/2019, 10:20:01
    Author     : Aaron Stiebler & Débora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | ${operacao} Funcionario</title>
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
                <li><a href="PesquisarFuncionarioController">Pesquisar</a></li>
                <li>${operacao}</li>
            </ul>
        </div>
        <div class="container">
            <h1>${operacao} Funcionario</h1>
            <form id="incluir" action="ManterFuncionarioController?acao=confirmarOperacao&operacao=${operacao}" name="frmManterFuncionario" method="post" onsubmit="return validarFormulario(this)">
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
                        <select class="custom-select mr-sm-2" name="txtIdEstabelecimento">
                            <option value="0" <c:if test="${funcionario.idEstabelecimento == null}"> selected</c:if>> </option>  
                            <c:forEach items="${estabelecimentos}" var="estabelecimento">
                                <option value="${estabelecimento.id}" <c:if test="${funcionario.idEstabelecimento == estabelecimento.id}"> selected</c:if>>${estabelecimento.nomeFantasia}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>                
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="idFuncionario">Id:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="text" min="1" name="txtIdFuncionario" id="idFuncionario" maxlength="10" value="${funcionario.id}" <c:if test="${operacao != 'Incluir'}"> readonly</c:if>/>
                        </div>
                    </div>                    
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="idFuncao">Função:</label>
                        <div class="col-sm-2">
                            <select class="custom-select mr-sm-2" id="idFuncao" name="txtIdFuncao">
                                <option value="0" <c:if test="${funcionario.idFuncao== null}"> selected</c:if>> </option>  
                            <c:forEach items="${funcoes}" var="funcao">                                    
                                <option value="${funcao.id}" <c:if test="${funcionario.idFuncao == funcao.id}"> selected</c:if>>${funcao.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>       
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="status">Status da Conta:</label>
                    <div class="col-sm-2">
                        <select class="custom-select mr-sm-2" id="status" name="txtStatusConta">
                            <option value="0">Desativada</option>
                            <option value="1">Ativada</option>
                        </select>
                    </div>
                </div>                    
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="nome">Nome:</label>
                    <div class="col-sm-2">
                        <input class="form-control" type="text" name="txtNome" id="nome" maxlength="45" value="${funcionario.nome}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="cpf">CPF:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" name="txtCpf" id="cpf" maxlength="14" onkeyup="filtra('cpf')" placeholder="000.000.000-00" value="${funcionario.cpf}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                        
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="dataNascimento">Data de Nascimento:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="date" name="txtDataNascimento" maxlength="10" id="dataNascimento" value="${funcionario.dataNascimento}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                        
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="email">Email:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" name="txtEmail" id="email" placeholder="exemplo@email.com" maxlength="45" value="${funcionario.email}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                        
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="telefone">Telefone:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" id="telefone" placeholder="(xx) xxxx-xxxx" name="txtTelefone" maxlength="30" value="${funcionario.telefone}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>                                        
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="senha">Senha:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="password" name="txtSenha" id="senha" maxlength="45" value="${funcionario.senha}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                        </div>
                    </div>    
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="senha">Repita a senha:</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="password" name="txtReSenha" id="confirmaSenha" maxlength="45" value="${funcionario.senha}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
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
                if (form.txtIdFuncionario.value == "") {
                    mensagem = mensagem + "Informe o Código do Funcionário\n";
                }
                if (form.txtStatusConta.value == "") {
                    mensagem = mensagem + "Informe o Status da Conta do Funcionário\n";
                }
                if (form.txtNome.value == "") {
                    mensagem = mensagem + "Informe o Nome do Funcionário\n";
                }
                if (form.txtCpf.value == "") {
                    mensagem = mensagem + "Informe o CPF do Funcionário\n";
                }
                if (form.txtEmail.value == "") {
                    mensagem = mensagem + "Informe o Email do Funcionário\n";
                }
                if (form.txtIdFuncao.value == "0") {
                    mensagem = mensagem + "Informe a Função do Funcionário\n";
                }
                if (form.txtSenha.value == "0") {
                    mensagem = mensagem + "Informe a Senha do Funcionário\n";
                }
                if (form.txtReSenha.value == "") {
                    mensagem = mensagem + "Digite a Senha do Funcionário novamente\n";
                }
                if (form.txtSenha.value != form.txtReSenha.value) {
                    mensagem = mensagem + "Campos de Senha diferentes\n";
                }
                if (!campoNumerico(form.txtIdFuncionario.value)) {
                    mensagem = mensagem + "Código do Funcionário deve ser numérico\n";
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
