<%-- 
    Document   : PesquisaComanda
    Created on : 02/10/2019, 13:39:31
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | Pesquisar Comandas</title>
        
        <!-- Estilos, scripts e dependências de terceiros -->
        <link rel="stylesheet" href="vendor/bootstrap/bootstrap.min.css" />
        <script src="vendor/jquery-3.3.1.slim.min.js"></script>
        <script src="vendor/popper.min.js"></script>
        <script src="vendor/bootstrap/bootstrap.min.js"></script>
        <script src="vendor/fontawesome/js/all.min.js"></script>
        
        <!-- Estilos e scripts próprios -->
        <link rel="stylesheet" href="./css/main.css"/>
        <script src="./js/filtros.js"></script>
    </head>
    <body onload="setDate()">
        <nav class="top-bar">
            <div class="total-center">
                <a class="navbar-brand" href="inicio">MOCS</a>
            </div>
        </nav>
        <ul class="breadcrumb">
            <li><a href="inicio">Menu</a></li>
            <li>Pesquisar</li>
        </ul>
        <div class="container-fluid">
            <h1>Pesquisar Comandas</h1>
            <div class="max-width-rel total-center margin-3">
                <form action="ManterComandaController?acao=prepararOperacao&operacao=Incluir" method="post">
                    <button class="btn btn-primary btn-lg" type="submit" name="btnIncluir">Nova Comanda</button>
                </form>
            </div>
            <div class="cards"><c:forEach items="${comandas}" var="comanda">
                <div class="card card-style">
                    <div class="card-header">
                        <h3 class="card-subtitle">Comanda <c:out value="${comanda.id}" /></h3>
                        <h5>Aberta dia <span class="data"><c:out value="${comanda.data}" /></span> às <time><c:out value="${comanda.hora}"/></time></h5>
                    </div>
                    <div class="card-body">
                        <h4 class="card-subtitle-invert">Pedidos</h4>
                        <ul class="list-group list-group-flush"><c:forEach items="${pedidos}" var="pedido"><c:if test="${pedido.comanda.id == comanda.id}">
                            <li class="list-group-item">${pedido.quantidade}x ${pedido.prato.nome}
                                <div class="float-right">
                                    R$<fmt:formatNumber type="number" minFractionDigits="2" value="${pedido.prato.preco * pedido.quantidade}" />
                                </div>
                            </li></c:if></c:forEach>
                        </ul>
                    </div>
                    <div class="card-footer">
                        <div class="float-left">
                            <span>Cliente</span>
                            <p><c:out value="${comanda.cliente.nome}" /></p>
                        </div>
                        <div class="float-right">
                            <span>Total</span>
                            <p>R$<fmt:formatNumber type="number" maxFractionDigits="2" value="${comanda.obterTotal()}" /></p>
                        </div>
                    </div>
                    <div class="opcoes">
                        <div class="p-1 opcao">
                            <a href="ManterPedidoController?acao=prepararOperacao&operacao=Incluir&icm=<c:out value="${comanda.id}" />" /> <i class="fas fa-plus"></i> Pedido</a>
                        </div>
                        <div class="p-1 opcao">
                            <a href="ManterComandaController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${comanda.id}" />"><i class="fas fa-edit"></i> Editar</a>
                        </div>
                        <div class="p-1 opcao">
                            <a href="ManterComandaController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="${comanda.id}" />"><i class="fas fa-trash"></i> Excluir</a>
                        </div>
                    </div>
                </div></c:forEach>
            </div>
        </div>
        <script type="text/javascript">
            
        </script>
    </body>

</html>