<%-- 
    Document   : listaEstabelecimentoPUsuario
    Created on : 15/10/2020, 11:25:56
    Author     : Débora
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Estabelecimentos por Usuário</title>
    </head>
    <body>
        <h1>Lista de Estabelecimentos por Usuário</h1>
        <form action="ListaEstabelecimentoPUsuarioController?acao=emitir" method="post">
            Escolha o usuário
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
