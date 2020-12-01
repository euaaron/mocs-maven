<%-- 
    Document   : pesquisaFuncionario
    Created on : 02/10/2019, 13:35:24
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pesquisar Funcionarios</title>
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
            <li>Pesquisar</li>
        </ul>
        <h1>Pesquisar Funcionarios</h1>
        <a href="ListaFuncionarioPestabelecimentoController?acao=filtrar">Lista de Funcionarios por Estabelecimento</a></br>
        <a href="ListaFuncionarioController?acao=emitir">Lista de Funcionarios</a>
        <table border = 1>
            <tr>
                <th>COD</th>
                <th>NOME</th>
                <th>FUNÇÃO</th>
                <th>STATUS</th>
                <th colspan="2">OPÇÕES</th>
            </tr>
            
            <c:forEach items="${funcionarios}" var="funcionario">
                <tr>
                    <td><c:out value="${funcionario.id}"/></td>
                    <td><c:out value="${funcionario.nome}"/></td>
                    <td><c:out value="${funcionario.getFuncao().getNome()}"/></td>
                    <td>
                        <c:if test="${funcionario.statusConta == 0}">
                            <c:out value="Desativada"/>
                        </c:if>
                        <c:if test="${funcionario.statusConta == 1}">
                            <c:out value="Ativada"/>
                        </c:if>                        
                    </td>
                    <td>
                        <a href="ManterFuncionarioController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${funcionario.id}" />" > Editar</a>
                    </td>
                    <td>
                        <a href="ManterFuncionarioController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="${funcionario.id}" />" > Excluir</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <form action="ManterFuncionarioController?acao=prepararOperacao&operacao=Incluir" method="post">
            <input type="submit" name="btnIncluir" value="Incluir">
        </form>
    </body>
</html>
