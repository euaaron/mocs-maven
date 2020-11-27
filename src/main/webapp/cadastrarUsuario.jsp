<%-- 
    Document   : usuario
    Created on : 05/09/2019, 09:21:37
    Author     : Aaron Stiebler & Débora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | ${operacao} Usuário</title>
        <%-- Estilos, scripts e dependências de terceiros --%>
        <link rel="stylesheet" href="vendor/bootstrap/bootstrap.min.css"/>
        <script src="vendor/jquery-3.3.1.slim.min.js"></script>
        <script src="vendor/popper.min.js"></script>
        <script src="vendor/bootstrap/bootstrap.min.js"></script>
        <%-- Estilos e scripts próprios --%>
        <link rel="stylesheet" href="./css/main.css"/>
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
            <li><a href="PesquisarUsuarioController">Pesquisar</a></li>
            <li>${operacao}</li>
        </ul>
        <div class="container">
            <h1 class="page-title">${operacao} Usuário</h1>
            <div class="centralize">
            <form id="incluir" name="frmManterUsuario" method="post" onsubmit="return validarFormulario(this)" action="ManterUsuarioController?acao=confirmarOperacao&operacao=${operacao}&agente=${agente}<c:if test="${idUser != null && idUser != 0}" >&idUser=${idUser}</c:if>">
                <c:if test="${errorMsg != null}">
                    <div class="form-group row">
                        <div class="col">
                            <p class="error">${errorMsg}</p>
                        </div>
                    </div>
                </c:if>
                <div class="form-group row">
                    <label for="nome" class="col-sm-2 col-form-label">Nome:</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" name="txtNome" id="nome" maxlength="45" value="${usuario.nome}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="cpf" class="col-sm-2 col-form-label">CPF:</label>
                    <div class="col-sm-2">
                        <input type="text" onkeyup="filtra('cpf')" class="form-control" name="txtCpf" id="cpf" maxlength="14" placeholder="000.000.000-00" value="${usuario.cpf}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="dataNascimento" class="col-sm-2 col-form-label">Data de Nascimento:</label>
                    <div class="col-sm-2">
                        <input type="date" class="form-control" name="txtDataNascimento" id="dataNascimento" value="${usuario.dataNascimento}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="email" class="col-sm-2 col-form-label">Email:</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="email" maxlength="45" name="txtEmail" value="${usuario.email}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>        
                    </div>
                </div>
                <div class="form-group row">
                    <label for="telefone" class="col-sm-2 col-form-label">Telefone:</label>
                    <div class="col-sm-2">
                        <input type="text" onkeyup="filtra('telefone')" class="form-control" id="telefone" maxlength="30" placeholder="(xx) xxxx-xxxx" name="txtTelefone" value="${usuario.telefone}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="senha" class="col-sm-2 col-form-label">Senha:</label>
                    <div class="col-sm-2">
                        <input type="password" class="form-control" id="senha" name="txtSenha" minlength="6" maxlength="45" value="${usuario.senha}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="confirmaSenha" class="col-sm-2 col-form-label">Repita a senha:</label>
                    <div class="col-sm-2">
                        <input type="password" class="form-control" id="confirmaSenha" name="txtReSenha" minlength="6" maxlength="45" value="${usuario.senha}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                    </div>
                </div>
                <div class="form-group row">
                    <button type="submit" class="btn btn-primary confirma" name="btnIncluir" value="Confirmar">Confirmar</button>
                </div>
            </form>
            </div>
        </div>
        <script>            
            var hoje = new Date().toLocaleDateString().split("/");
            var dataHoje = hoje[2] + "-" + hoje[1] + "-" + hoje[0];
            var inputDate = document.getElementById('dataNascimento');
            inputDate.setAttribute('max', dataHoje);
            
            function campoNumerico(valor)
            {
                var caracteresValidos = "0123456789";
                var ehNumero = true;
                var umCaracter;
                for (i = 0; i < valor.length && ehNumero == true; i++)
                {
                    umCaracter = valor.charAt(i);
                    if (caracteresValidos.indexOf(umCaracter) == - 1)
                    {
                        ehNumero = false;
                    }
                }
                return ehNumero;
            }

            function validarFormulario(form){
                var mensagem;
                mensagem = "";
                if (inputDate.value == "") {
                    inputDate.value == dataHoje;
                }
                if (new Date(inputDate.value) > new Date(dataHoje)) {
                    mensagem = mensagem + "Data inválida, tente novamente\n";
                }
                if (form.txtIdUsuario.value == "") {
                    mensagem = mensagem + "Informe o Código do Usuário\n";
                }
                if (form.txtNome.value == "") {
                    mensagem = mensagem + "Informe o Nome do Usuário\n";
                }
                if (form.txtCpf.value == "") {
                    mensagem = mensagem + "Informe o CPF do Usuário\n";
                }
                if (form.txtEmail.value == "") {
                    mensagem = mensagem + "Digite o Email, ele será usado para login\n";
                }
                if (form.txtSenha.value == "") {
                    mensagem = mensagem + "Informe a Senha do Usuário\n";
                }
                if (form.txtReSenha.value == "") {
                    mensagem = mensagem + "Digite a Senha do Usuário novamente\n";
                }
                if (form.txtSenha.value != form.txtReSenha.value) {
                    mensagem = mensagem + "Campos de Senha diferentes\n";
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
