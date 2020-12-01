<%-- 
    Document   : ErrorPage
    Created on : 16/012/2019, 12:58:28
    Author     : Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>

<html lang="pt">

  <head>
    <meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
    <title>MOCS - Erro ${codigoStatus}</title>

    <!-- Estilos e scripts próprios -->
    <link rel="stylesheet" href="./main.css" />
    <link rel="stylesheet" href="./css/pages/error.css">
    <script src="./js/filtros.js"></script>

  </head>

  <body>

    <section>
      <i class="fas fa-debug"></i>
      <h1>Encontramos um Bug!</h1>
    </section>
    <section>
      <c:if test="${codigoStatus != 0}">
        <h5>Código do erro</h5>
        <code>${codigoStatus}</code>
      </c:if>
      <c:if test="${nomeServlet != null}">
        <h5>Nome do servlet:</h5>
        <code>${nomeServlet}</code>
      </c:if>
      <c:if test="${excecao != null}">
        <h5>Tipo de exceção:</h5>
        <code>${excecao.getClass().getName()}</code>
      </c:if>
      <c:if test="${uriDestino != null}">
        <h5>Endereço requisitado</h5>
        <code>${uriDestino}</code>
      </c:if>
      <c:if test="${excecao.getMessage() != null}">
        <h5>Mensagem:</h5>
        <code>${excecao.getMessage()}</code>
      </c:if>

      <a href="/">Voltar à home</a>.
          
    </section>

  </body>

</html>