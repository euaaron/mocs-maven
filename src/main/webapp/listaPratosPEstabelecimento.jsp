<%-- 
    Document   : listaPratosPEstabelecimento
    Created on : 15/10/2020, 17:22:17
    Author     : Débora
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Pratos por Estabelecimento</title>
    </head>
    <body>
        <h1>Lista de Pratos por Estabelecimento</h1>
        <form action="ListaPratosPEstabelecimentoController?acao=emitir" method="post">
            Escolha o Estabelecimento
            <select name="txtIdEstabelecimento">
                <c:forEach items="${estabelecimentos}" var="estabelecimento">
                    <option value="${estabelecimento.id}">${estabelecimento.nomeFantasia}</option>  
                </c:forEach>
            </select>
            <br/>
            <input type="submit"/>
        </form>
    </body>
</html>
