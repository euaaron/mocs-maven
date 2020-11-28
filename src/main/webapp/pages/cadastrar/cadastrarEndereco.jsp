<%-- 
    Document   : cadastroEndereco
    Created on : 26/09/2019, 09:51:38
    Author     : Aaron Stiebler e Débora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | Cadastro de Endereco</title>
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
        <div>
            <h1>Endereco - ${operacao}</h1>
        </div>        
        <div>
            <form id="incluir" action="ManterEnderecoController?acao=confirmarOperacao&operacao=${operacao}" name="frmManterEndereco" method="post">
                <table border="1">
                    <tbody>
                        <tr>
                            <td><label for="id">Id:</label></td>
                            <td><input type="text" id="id" name="txtId" min="1" maxlength="10" value="${endereco.id}" <c:if test="${operacao != 'Incluir'}"> readonly</c:if>/></td>
                        </tr>
                        <tr>
                            <td><label for="cep">CEP:</label></td>
                            <td><input type="text" id="cep" name="txtCEP" maxlength="10" placeholder="00.000-000" value="${endereco.cep}"/></td>
                        </tr>
                        <tr>
                            <td><label for="uf">UF:</label></td>
                            <td><input type="text" id="uf" name="txtUF" maxlength="4" value="${endereco.UF}"/></td>
                        </tr>
                        <tr>
                            <td><label for="cidade">Cidade:</label></td>
                            <td><input type="text" id="cidade" name="txtCidade" maxlength="45" value="${endereco.cidade}"/></td>
                        </tr>
                        <tr>
                            <td><label for="bairro">Bairro:</label></td>
                            <td><input type="text" id="bairro" name="txtBairro" maxlength="45" value="${usuario.bairro}"></td>
                        </tr>
                        <tr>
                            <td><label for="logradouro">Logradouro:</label></td>
                            <td><input type="text" id="logradouro" name="txtLogradouro" maxlength="45" value="${usuario.logradouro}"></td>
                        </tr>
                        <tr>
                            <td><label for="complemento">Complemento:</label></td>
                            <td><input type="text" id="complemento" name="txtComplemento" maxlength="30" value="${usuario.numComplemento}"></td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" name="btnIncluir" value="Confirmar">
                            </td>
                        </tr>
                    </tbody>
                </table>
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
                    if (caracteresValidos.indexOf(umCaracter) == - 1)
                    {
                        ehNumero = false;
                    }
                }
                return ehNumero;
            }

            document.getElementById("incluir").addEventListener("submit", () =>
            {
                let form = document.getElementById("incluir");
                let mensagem;
                mensagem = "";
                if (form.txtId.value === "") {
                    mensagem = mensagem + "Informe o Código da Comanda\n";
                }
                if (form.txtIdCliente.value === "") {
                    mensagem = mensagem + "Informe o Código do Cliente\n";
                }
                if (form.txtDataComanda.value === "") {
                    mensagem = mensagem + "Informe a data de abertura da comanda\n";
                }
                if (form.txtHoraComanda.value === "") {
                    mensagem = mensagem + "Informe a hora de abertura da comanda\n";
                }
                if (!campoNumerico(form.txtId.value)) {
                    mensagem = mensagem + "Código da Comanda deve ser numérico\n";
                }
                if (!campoNumerico(form.txtIdCliente.value)) {
                    mensagem = mensagem + "Código do Cliente deve ser numérico\n";
                }
                if (mensagem === "") {
                    return true;
                } else {
                    if("${operacao}" !== "Excluir") {
                        alert(mensagem);
                        return false;
                    }
                    return true;
                }
            });
        </script>
    </body>
</html>
