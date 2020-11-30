 <%-- 
    Document   : pesquisaEstabelecimento
    Created on : 19/09/2019, 09:13:42
    Audivor     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOCS | Pesquisar Estabelecimentos</title>
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
        <div class="container">
            <h1 class="page-title">Pesquisar Estabelecimentos</h1>
            <a href="ListaEstabelecimentoController?acao=emitir" title="Salvar em PDF"><i class="fad fa-print"></i></a>
            <div class="max-width-rel">
                <form class="max-width-rel total-center" action="ManterEstabelecimentoController?acao=prepararOperacao&operacao=Incluir" method="post">
                    <button class="btn btn-primary margin-1" type="submit" name="btnIncluir"><i class="fas fa-plus"></i> Incluir Estabelecimento</button>
                </form>
            <table>
            <tr class="bg-dark text-light text-center">
                <th>COD</th>
                <th>NOME</th>
                <th>PROPRIETÁRIO</th>
                <th>CEP</th>
                <th>UF</th>
                <th>CIDADE</th>
                <th>BAIRRO</th>
                <th>LOGRADOURO</th>
                <th>EDIFÍCIO</th>
                <th>COMPLEMENTO</th>
                <th colspan="2">OPÇÕES</th>
            </tr>
            <c:forEach items="${estabelecimentos}" var="estabelecimento">
            <tr>
                <td><c:out value="${estabelecimento.id}"/></td>
                <td><c:out value="${estabelecimento.nomeFantasia}"/></td>
                <td><c:out value="${estabelecimento.getProprietario().getNome()}"/></td>
                <td><c:out value="${estabelecimento.getEndereco().getCep()}"/></td>
                <td><c:out value="${estabelecimento.getEndereco().getUf()}"/></td>
                <td><c:out value="${estabelecimento.getEndereco().getCidade()}"/></td>
                <td><c:out value="${estabelecimento.getEndereco().getBairro()}"/></td>
                <td><c:out value="${estabelecimento.getEndereco().getLogradouro()}"/></td>
                <td><c:out value="${estabelecimento.getEndereco().getNumEdificio()}"/></td>
                <td><c:out value="${estabelecimento.getEndereco().getNumComplemento()}"/></td>
                <td>
                    <a href="ManterEstabelecimentoController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${estabelecimento.id}" />" ><i class="fas fa-edit"></i>Editar</a>
                </td>
                <td>
                    <a href="ManterEstabelecimentoController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="${estabelecimento.id}" />" ><i class="fas fa-trash"></i>Excluir</a>
                </td>
            </tr>
            </c:forEach>
        </table>
            </div>
        </div>
    </body>
</html>
