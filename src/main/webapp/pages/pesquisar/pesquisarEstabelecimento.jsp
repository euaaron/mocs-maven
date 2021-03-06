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
    <title>MOCS | Estabelecimentos</title>

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
          <ul>
            <li><a href="/">Menu Inicial</a></li>
            <li><i class="fas fa-arrow-right"></i></li>
            <li>&nbsp;Estabelecimentos</li>
          </ul>
        </div>

        <div class="col">
          <h1>Estabelecimentos</h1>
          <div>
            <a href="ListaEstabelecimentoController?acao=emitir" title="Emitir PDF">
              <i class="fad fa-print"></i>
            </a>
            <form action="ManterEstabelecimentoController?acao=prepararOperacao&operacao=Incluir" method="post">
              <input type="hidden" name="uriAtual" value="/PesquisarEstabelecimentoController"/>
              <a href="#" title="Adicionar Estabelecimento" onclick="$(this).closest('form').submit()">
                <i class="fad fa-plus"></i>
              </a>
            </form>
          </div>
        </div>
      </header>

      <section class="wrap-reverse">
        <c:choose>
          <c:when test="${estabelecimentos.size() != 0}">
            <div class="row align-base flex-3">

              <div class="col">
                <div class="row">
                  <h4>&nbsp;</h4>
                </div>
                <c:forEach items="${estabelecimentos}" var="estabelecimento">
                  <div class="row">

                    <form action="/PesquisarPratoController" >
                      <input type="hidden" name="uriAtual" value="/PesquisarEstabelecimentoController" />
                      <input type="hidden" name="fonte" value="${estabelecimento.id}" />

                      <c:forEach items="${funcionarios}" var="funcionario">
                        <c:if
                          test="${funcionario.estabelecimento.id.equals(estabelecimento.id) && funcionario.usuario.id.equals(userSession.id)}">
                          <input type="hidden" name="consultor" value="${funcionario.id}" />
                        </c:if>
                      </c:forEach>

                      <a href="#" class="p-2" onclick="$(this).closest('form').submit()" title="Pratos">
                        <i class="fad fa-utensils-alt"></i>
                      </a>
                    </form>

                    <c:forEach items="${funcionarios}" var="funcionario">
                      <c:if
                        test="${funcionario.estabelecimento.id.equals(estabelecimento.id) && funcionario.usuario.id.equals(userSession.id)}">
                        <form action="/PesquisarFuncionarioController" >
                          <input type="hidden" name="uriAtual" value="/PesquisarEstabelecimentoController" />
                          <input type="hidden" name="consultor" value="${funcionario.id}" />
                          <input type="hidden" name="fonte" value="${estabelecimento.id}" />
                          <a href="#" class="p-2" onclick="$(this).closest('form').submit()" title="Funcionários">
                            <i class="fad fa-user-tie"></i>
                          </a>
                        </form>
                      </c:if>
                    </c:forEach>

                  </div>
                </c:forEach>
              </div>

              <div class="col flex-3">
                <div class="row">
                  <h4>NOME</h4>
                </div>
                <c:forEach items="${estabelecimentos}" var="estabelecimento">
                  <div class="row wrap">
                    <span>
                      <c:out value="${estabelecimento.nomeFantasia}" />
                    </span>
                  </div>
                </c:forEach>
              </div>

              <div class="col flex-2">
                <div class="row">
                  <h4>CIDADE</h4>
                </div>
                <c:forEach items="${estabelecimentos}" var="estabelecimento">
                  <div class="row wrap">
                    <span>
                      <c:out value="${estabelecimento.endereco.cidade}" />
                    </span>
                  </div>
                </c:forEach>
              </div>

              <div class="col flex-2">
                <div class="row">
                  <h4>BAIRRO</h4>
                </div>
                <c:forEach items="${estabelecimentos}" var="estabelecimento">
                  <div class="row wrap">
                    <span>
                      <c:out value="${estabelecimento.endereco.bairro}" />
                    </span>
                  </div>
                </c:forEach>
              </div>

              <div class="col">
                <div class="row">
                  <h4>TELEFONE</h4>
                </div>
                <c:forEach items="${estabelecimentos}" var="estabelecimento">
                  <div class="row">
                    <span>
                      <c:out value="${estabelecimento.telefone}" />
                    </span>
                    <c:forEach items="${funcionarios}" var="funcionario">
                      <c:if
                        test="${funcionario.estabelecimento.id.equals(estabelecimento.id) && funcionario.usuario.id.equals(userSession.id)}">
                        <div class="row">
                          <form action="ManterEstabelecimentoController" method="post">
                            <input type="hidden" name="uriAtual" value="/PesquisarEstabelecimentoController" />
                            <input type="hidden" name="acao" value="prepararOperacao" />
                            <input type="hidden" name="operacao" value="Editar" />
                            <input type="hidden" name="id" value="${estabelecimento.id}" />
                            <a href="#" class="p-2" onclick="$(this).closest('form').submit()">
                              <i class="fas fa-edit" title="Editar estabelecimento"></i>
                            </a>
                          </form>
                          <form action="ManterEstabelecimentoController" method="post">
                            <input type="hidden" name="uriAtual" value="/PesquisarEstabelecimentoController" />
                            <input type="hidden" name="acao" value="prepararOperacao" />
                            <input type="hidden" name="operacao" value="Excluir" />
                            <input type="hidden" name="id" value="${estabelecimento.id}" />
                            <a href="#" class="p-2" onclick="$(this).closest('form').submit()">
                              <i class="fas fa-trash" title="Excluir estabelecimento"></i>
                            </a>
                          </form>
                        </div>
                      </c:if>
                    </c:forEach>
                  </div>
                </c:forEach>
              </div>
            </div>
            <div class="flex-1">
              <i class="fad fa-store medium"></i>
              <p>Veja todos os estabelecimentos cadastrados no sistema.</p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="col center">

              <h1><b><i class="fad fa-ghost huge"></i></b></h1>
              <h2 class="mv-2">Ooops...</h2>
              <h4> Não há estabelecimentos cadastrados.</h4>

              <form class="mt-3" action="ManterEstabelecimentoController?acao=prepararOperacao&operacao=Incluir"
                    method="post">
                <input type="hidden" name="page" value="/PesquisarEstabelecimentoController" />
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
