<%-- 
    Document   : pesquisaPrato
    Created on : 02/10/2019, 13:25:31
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
  <title>Pesquisa de Pratos</title>

  <!-- Estilos e scripts próprios -->
  <link rel="stylesheet" href="./main.css" />
  <link rel="stylesheet" href="./css/pages/pesquisar.css" />
  <script src="./js/filtros.js"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
</head>

<body onload="setDate()">

  <nav class="row bg-tertiary">
    <div class="total-center">
      <a class="navbar-brand" href="/">
        <h1 class="logo">M<i class="fad fa-egg-fried"></i>CS</h1>
      </a>
    </div>
  </nav>

  <section class="container">
    <header>
      <div class="row breadcrumb">
        <ul>
          <li><a href="/">Menu Inicial</a></li>
          <li><i class="fas fa-arrow-right"></i></li>
          <li>&nbsp;Pesquisar Pratos</li>
        </ul>
      </div>

      <div class="col">
        <h1>Pesquisar Pratos</h1>
        <div>
          <a href="ListaPratoController?acao=emitir" title="Salvar em PDF"><i class="fad fa-print"></i>Emitir Pratos</a>
          <a href="ListaPratoPestabelecimentoController?acao=filtrar">Emitir Pratos por Estabelecimento</a>
          <a href="ManterPratoController?acao=prepararOperacao&operacao=Incluir" title="Adicionar novo Prato"><i
              class="fad fa-plus"></i></a>
        </div>
      </div>
    </header>

    <section class="wrap-reverse">
      <c:choose>
        <c:when test="${pratos.size() != 0}">
          <div class="cards">
            <c:forEach items="${pratos}" var="prato">
              <div class="card card-style">
                <image class="card-img-top prato" src="${prato.imagemUrl}">
                  <h4 class="card-subtitle-invert">R$ ${prato.preco}</h4>
                  <div class="card-header prato">
                    <h3 class="card-subtitle">
                      <c:out value="${prato.nome}" />
                    </h3>
                  </div>
                  <div class="card-body">
                    <p class="card-text">${prato.descricao}</p>
                  </div>
                  <div class="card-footer text-muted">
                    <div class="row">
                      <div class="col-sm">ID</div>
                      <div class="col">
                        Add. por
                      </div>
                      <div class="col">
                        Criado em
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-sm">
                        <b>
                          <c:out value="${prato.id}" /></b>
                      </div>
                      <div class="col">
                        <b class="data">${prato.createdAt}</b>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-sm">Exibir</div>
                      <div class="col">Opções</div>
                    </div>
                    <div class="row">
                      <div class="col-sm">
                        <b>
                          <c:if test="${prato.exibir == 0}">Não</c:if>
                          <c:if test="${prato.exibir == 1}">Sim</c:if>
                        </b>
                      </div>
                      <div class="col">
                        <a href="ManterPratoController?acao=prepararOperacao&operacao=Editar&id=<c:out value="
                          ${prato.id}" />" > <i class="fas fa-edit"></i> Editar</a>
                      </div>
                      <div class="col">
                        <a href="ManterPratoController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="
                          ${prato.id}" />" > <i class="fas fa-trash"></i> Excluir</a>
                      </div>
                    </div>
                  </div>
              </div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="col center">

            <h1><b><i class="fad fa-ghost huge"></i></b></h1>
            <h2 class="mv-2">Ooops...</h2>
            <h4> Não há pratos cadastrados.</h4>

            <form class="mt-3" action="ManterPratoController?acao=prepararOperacao&operacao=Incluir"
              method="post">
              <input type="hidden" name="page" value="/PesquisarPratoController" />
              <button type="submit">
                <i class="fas fa-plus"></i> Adicione agora!
              </button>
            </form>

          </div>
        </c:otherwise>
      </c:choose>
      </div>
    </section>
</body>

</html>
