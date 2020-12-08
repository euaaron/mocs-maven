<%-- 
    Document   : PesquisaUsuario
    Created on : 19/09/2019, 09:12:57
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pesquisar Usuários</title>

    <%-- Estilos e scripts próprios --%>
    <link rel="stylesheet" href="./main.css" />
    <link rel="stylesheet" href="./css/pages/pesquisar.css" />
    <script src="./js/filtros.js"></script>
    <script
      src="https://code.jquery.com/jquery-3.5.1.min.js"
      integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
  </head>

  <body>
    <nav class="row bg-tertiary">
      <div class="total-center">
        <a class="navbar-brand" href="/SessionController">
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
            <li>&nbsp;Pesquisar Usuários</li>
          </ul>
        </div>

        <div class="col">
          <h1>Pesquisar Usuarios</h1>
          <div class="row">
            <a href="ListaUsuarioController?acao=emitir" title="Salvar em PDF">
                <i class="fad fa-print"></i>
            </a>
            <a href="ManterUsuarioController?acao=prepararOperacao&operacao=Incluir" title="Adicionar novo usuário">
              <i class="fad fa-plus"></i>
            </a>
          </div>
        </div>
      </header>

      <section class="wrap-reverse">
        <c:choose>
          <c:when test="${usuarios.size() != 0}">
            <div class="row align-base">

              <div class="col flex-3">
                <div class="row">
                  <h4>NOME</h4>
                </div>
                <c:forEach items="${usuarios}" var="usuario">
                  <div class="row">
                    <span>
                      <c:out value="${usuario.nome}" /></span>
                  </div>
                </c:forEach>
              </div>

              <div class="col flex-3">
                <div class="row">
                  <h4>E-MAIL</h4>
                </div>
                <c:forEach items="${usuarios}" var="usuario">
                  <div class="row">
                    <span>
                      <c:out value="${usuario.email}" /></span>
                  </div>
                </c:forEach>
              </div>

              <div class="col flex-3">
                <div class="row">
                  <h4>TELEFONE</h4>
                </div>
                <c:forEach items="${usuarios}" var="usuario">
                  <div class="row">
                    <span>
                      <c:out value="${usuario.telefone}" /></span>
                      <c:if test="${usuario.id == userSession.id}">
                      <form action="ManterUsuarioController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${usuario.id}" />" method="post">
                        <input type="hidden" name="uriAtual" value="/PesquisarUsuarioController"/>
                        <a class="p-2" href="#" onclick="$(this).closest('form').submit()" /><i class="fas fa-edit"></i></a>
                      </form>
                      <form action="ManterUsuarioController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="${usuario.id}" />" method="post">
                        <input type="hidden" name="uriAtual" value="/PesquisarUsuarioController"/>
                        <a class="p-2 text-alert" href="#" onclick="$(this).closest('form').submit()" /><i class="fas fa-trash"></i></a>
                      </form>
                    </c:if>
                  </div>
                </c:forEach>
              </div>

            </div>

            <div>
              <i class="fad fa-users"></i>
              <p>Veja todos os usurários cadastrados no sistema.</p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="col center">
              <h1><b><i class="fad fa-ghost huge"></i></b></h1>
              <h2 class="mv-2">Ooops...</h2>
              <h4> Não há usuários cadastrados.</h4>
              <form class="mt-3" action="ManterEstabelecimentoController?acao=prepararOperacao&operacao=Incluir" method="post">
                <input type="hidden" name="page" value="/"/>
                <button type="submit">
                  <i class="fas fa-plus"></i> Adicione o seu!
                </button>
              </form>
            </div>
          </c:otherwise>
        </c:choose>
      </section>
    </section>
  </body>

</html>
