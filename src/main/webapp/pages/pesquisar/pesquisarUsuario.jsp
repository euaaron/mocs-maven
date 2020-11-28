<%-- 
    Document   : PesquisaUsuario
    Created on : 19/09/2019, 09:12:57
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pesquisar Usuários</title>

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
        <div class="container">
        <h1 class="page-title">Pesquisar Usuarios</h1>
        <c:if test="${usuarios.size() != 0}">
        <table>
            <tr class="text-center text-light bg-dark">
                <th>COD</th>
                <th></th>
                <th>NOME</th>
                <th></th>
                <th>E-MAIL</th>
                <th></th>
                <th>TELEFONE</th>
                <th></th>
                <th colspan="2">OPÇÕES</th>
            </tr>
            
            <c:forEach items="${usuarios}" var="usuario">
                <tr>
                    <td><c:out value="${usuario.id}"/></td>
                    <td></td>
                    <td><c:out value="${usuario.nome}"/></td>
                    <td></td>
                    <td><c:out value="${usuario.email}"/></td>
                    <td></td>
                    <td><c:out value="${usuario.telefone}"/></td>
                    <td></td>
                    <td>
                        <a href="ManterUsuarioController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${usuario.id}" />" ><i class="fas fa-edit"></i> Editar</a>
                    </td>
                    <td>
                        <a href="ManterUsuarioController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="${usuario.id}" />" ><i class="fas fa-trash"></i> Excluir</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </c:if>
        <form action="ManterUsuarioController?acao=prepararOperacao&operacao=Incluir" method="post">
            <button class="btn btn-primary" type="submit" name="btnIncluir" >Incluir</button>
        </form>
        </div>
        <div>
            <a href="ListaUsuarioController?acao=emitir">Lista de Usuarios</a>
        </div>
    </body>
</html>
