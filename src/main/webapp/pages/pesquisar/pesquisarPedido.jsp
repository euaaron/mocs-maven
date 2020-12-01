<%-- 
    Document   : pesquisaPedido
    Created on : 02/10/2019, 13:49:11
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pesquisar Pedidos</title>
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
    <h1>Pesquisar Pedidos</h1>
    <a href="ListaPedidoPUsuarioController?acao=filtrar">Lista de Pedido por Usuario</a>
    <table border = 1>
      <tr>
        <th>COD</th>
        <th>DIA</th>
        <th>CLIENTE</th>
        <th>PRATO</th>
        <th>QUANTIDADE</th>
        <th colspan="2">OPÇÕES</th>
      </tr>

      <c:forEach items="${pedidos}" var="pedido">
        <tr>
          <td>P<c:out value="${pedido.id}"/>/C<c:out value="${pedido.comanda.id}"/></td>
          <td><c:out value="${pedido.comanda.data}"/></td>
          <td><c:out value="${pedido.comanda.cliente.nome}"/></td>
          <td><c:out value="${pedido.prato.nome}"/></td>
          <td><c:out value="${pedido.quantidade}"/></td>
          <td>
            <a href="ManterPedidoController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${pedido.id}" />" > Editar</a>
          </td>
          <td>
            <a href="ManterPedidoController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="${pedido.id}" />" > Excluir</a>
          </td>
        </tr>
      </c:forEach>
    </table>
    <form action="ManterPedidoController?acao=prepararOperacao&operacao=Incluir" method="post">
      <input type="submit" name="btnIncluir" value="Incluir">
    </form>
  </body>
</html>
