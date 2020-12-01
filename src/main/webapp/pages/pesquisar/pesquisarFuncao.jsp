<%-- 
    Document   : pesquisarFuncao
    Created on : 24/10/2019, 10:33:46
    Author     : euaar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pesquisar Funcões</title>
    <%-- Estilos, scripts e dependências de terceiros --%>
    <link rel="stylesheet" href="vendor/bootstrap/bootstrap.min.css"/>
    <script src="vendor/jquery-3.3.1.slim.min.js"></script>
    <script src="vendor/popper.min.js"></script>
    <script src="vendor/bootstrap/bootstrap.min.js"></script>
    <%-- Estilos e scripts próprios --%>
    <link rel="stylesheet" href="./css/main.css"/>
    <script src="./js/filtros.js"></script>
    <script
      src="https://code.jquery.com/jquery-3.5.1.min.js"
      integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
      crossorigin="anonymous"></script>
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
    <h1>Pesquisar Funcões</h1>
    <table border = 1>
      <tr>
        <th>Cod. Funcão</th>
        <th>Nome</th>
        <th colspan="2">Opções</th>
      </tr>

      <c:forEach items="${funcoes}" var="funcao">
        <tr>
          <td><c:out value="${funcao.id}"/></td>
          <td><c:out value="${funcao.nome}"/></td>
          <td>
            <a href="ManterFuncaoController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${funcao.id}" />" > Editar</a>
            <a href="ManterFuncaoController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="${funcao.id}" />" > Excluir</a>
          </td>
        </tr>
      </c:forEach>
    </table>
    <form action="ManterFuncaoController?acao=prepararOperacao&operacao=Incluir" method="post">
      <input type="submit" name="btnIncluir" value="Incluir">
    </form>
  </body>
</html>