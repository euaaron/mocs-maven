<%-- 
    Document   : pesquisaFuncionario
    Created on : 02/10/2019, 13:35:24
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pesquisar Funcionarios</title>

    <%-- Estilos e scripts próprios --%>
    <link rel="stylesheet" href="./main.css" />
    <link rel="stylesheet" href="./css/pages/pesquisar.css" />
    <script src="./js/filtros.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
  </head>

  <body>
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
          <ul class="breadcrumb">
            <li><a href="/">Menu Inicial</a></li>
            <li class="ph-2"><i class="fas fa-arrow-right"></i></li>
            <li><a href="/PesquisarEstabelecimentoController">Pesquisar Estabelecimentos</a></li>
            <li class="ph-2"><i class="fas fa-arrow-right"></i></li>
            <li>&nbsp;Pesquisar Funcionários</li>
          </ul>
        </div>
        <div class="col">
          <h1>Pesquisar Funcionários</h1>
          <div>
            <a href="ListaFuncionarioPestabelecimentoController?acao=filtrar">
              <i class="fad fa-print"></i>
              Funcionários por Estabelecimento
            </a>
            <a href="ListaFuncionarioController?acao=emitir">
              <i class="fad fa-print"></i> Funcionarios
            </a>
            <a href="ManterFuncionarioController?acao=prepararOperacao&operacao=Incluir" method="post">
              <i class="fad fa-plus"></i>
            </a>
          </div>
        </div>
      </header>

      <section class="wrap-reverse">
        <c:choose>
          <c:when test="${funcionarios.size() != 0 && (consultor.permissao == 0 || consultor.permissao == 5)}">
            <div class="row align-base">

              <div class="col flex-3">
                <div class="row">
                  <h4>EMPRESA</h4>
                </div>
                <c:forEach items="${funcionarios}" var="funcionario">
                  <div class="row wrap">
                    <span>
                      <c:out value="${funcionario.estabelecimento.nomeFantasia}" />
                    </span>
                  </div>
                </c:forEach>
              </div>
              
              <div class="col flex-2">
                <div class="row">
                  <h4>NOME</h4>
                </div>
                <c:forEach items="${funcionarios}" var="funcionario">
                  
                  <div class="row wrap">
                    <span>
                      <c:out value="${funcionario.usuario.nome}" />
                    </span>

                  </div>
                </c:forEach>
              </div>

              <div class="col">
                <div class="row">
                  <h4>CARGO</h4>
                </div>
                <c:forEach items="${funcionarios}" var="funcionario">
                  <div class="row wrap">
                    <span>
                      <c:if test="${funcionario.nivelPermissao == 0}">
                        <c:out value="Proprietário" />
                      </c:if>
                      <c:if test="${funcionario.nivelPermissao == 1}">
                        <c:out value="Gerente" />
                      </c:if>
                      <c:if test="${funcionario.nivelPermissao == 2}">
                        <c:out value="Supervisor" />
                      </c:if>
                      <c:if test="${funcionario.nivelPermissao == 3}">
                        <c:out value="Garçom" />
                      </c:if>
                      <c:if test="${funcionario.nivelPermissao == 4}">
                        <c:out value="Cheff" />
                      </c:if>
                      <c:if test="${funcionario.nivelPermissao == 5}">
                        <c:out value="Recrutador" />
                      </c:if>
                    </span>
                  </div>
                </c:forEach>
              </div>

              <div class="col">
                <div class="row">
                  <h4>&nbsp;</h4>
                </div>
                <c:forEach items="${funcionarios}" var="funcionario">
                  <div class="row">
                    <a class="p-2" href="ManterFuncionarioController?acao=prepararOperacao&operacao=Editar&id=<c:out value="${funcionario.id}"
                           />" >
                      <i class="fad fa-edit"></i>
                    </a>
                    <a class="p-2" href="ManterFuncionarioController?acao=prepararOperacao&operacao=Excluir&id=<c:out value=
                           "${funcionario.id}" />" >
                      <i class="fad fa-trash"></i>
                    </a>
                  </div>
                </c:forEach>

              </div>

            </div>
            <div>
              <i class="fad fa-users"></i>
              <i class="fad fa-cord"></i>
              <p>Veja todos os funcionários cadastrados no sistema.</p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="col center">

              <h1><b><i class="fad fa-ghost huge"></i></b></h1>
              <h2 class="mv-2">Ooops...</h2>
              <h4> Não há Funcionários cadastrados.</h4>

              <form class="mt-3" action="ManterFuncionarioController?acao=prepararOperacao&operacao=Incluir"
                    method="post">
                <input type="hidden" name="page" value="/PesquisarFuncionarioController" />
                <button type="submit">
                  <i class="fas fa-plus"></i> Adicione um!
                </button>
              </form>

            </div>
          </c:otherwise>
        </c:choose>
      </section>

    </section>
  </body>

</html>
