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

        <!-- Estilos, scripts e dependências de terceiros -->
        <link rel="stylesheet" href="./vendor/bootstrap/bootstrap.min.css" />
        <script src="./vendor/jquery-3.3.1.slim.min.js"></script>
        <script src="./vendor/popper.min.js"></script>
        <script src="./vendor/bootstrap/bootstrap.min.js"></script>
        <script src="./vendor/fontawesome/js/all.min.js"></script>

        <!-- Estilos e scripts próprios -->
        <link rel="stylesheet" href="./css/main.css" />
        <script src="./js/filtros.js"></script>

    </head>
    
    <body>
        
        <div class="container">
            <div class="text-center">
                <h1 class="black bold">Erro ${codigoStatus}</h1>
            </div>
            <div>
                <h2>Informação sobre a exceção</h2>
                <h5>Código do status:</h5>
                <code>${codigoStatus}</code>
                <h5>Nome do servlet:</h5>
                <code>${nomeServlet}</code>
                <h5>Tipo de exceção:</h5>
                <code>${excecao.getClass().getName()}</code>
                <h5>URI da requisição:</h5>
                <code>${uriRequisicao}</code>
                <h5>Mensagem:</h5>
                <code>${excecao.getMessage()}</code>
                <a href="${uriAnterior}">Voltar à página anterior</a>.
            </div>
        </div>
        
    </body>
    
</html>