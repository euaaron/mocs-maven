<%-- 
    Document   : listaPedidoPUsuario
    Created on : 15/10/2020, 16:03:10
    Author     : Débora
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Pedido por Usuario</title>
    </head>
    <body>
        <h1>Lista de Pedido por Usuario</h1>
        <form action="ListaPedidoPUsuarioController?acao=emitir" method="post">
            Escolha o Usuário
            <select name="txtIdUsuario">
                <c:forEach items="${usuarios}" var="usuario">
                    <option value="${usuario.id}">${usuario.nome}</option>  
                </c:forEach>
            </select>
            <br/>
            <input type="submit"/>
        </form>
    </body>
</html>
