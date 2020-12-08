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
    <c:choose>
      <c:when test="${estabelecimento != null}">
        <title>Equipe ${estabelecimento.nomeFantasia}</title>
      </c:when>
      <c:otherwise>
        <title>Pesquisar Funcionários</title>
      </c:otherwise>
    </c:choose>

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
              <c:if test="${estabelecimento != null}">
              <li class="ph-2"><i class="fas fa-arrow-right"></i></li>
              <li><a href="/PesquisarEstabelecimentoController">Estabelecimentos</a></li>
              </c:if>
            <li class="ph-2"><i class="fas fa-arrow-right"></i></li>
              <c:choose>
                <c:when test="${estabelecimento != null}">
                <li>Equipe ${estabelecimento.nomeFantasia}</li>
                </c:when>
                <c:otherwise>
                <li>Pesquisar Funcionários</li>
                </c:otherwise>
              </c:choose>
          </ul>
        </div>

        <div class="col">
          <c:choose>
            <c:when test="${estabelecimento != null}">
              <h1>Equipe ${estabelecimento.nomeFantasia}</h1>
            </c:when>
            <c:otherwise>
              <h1>Pesquisar Funcionários</h1>
            </c:otherwise>
          </c:choose>
          <div>
            <c:choose>
              <c:when test="${estabelecimento != null}">
                <form action="ListaFuncionarioPestabelecimentoController?acao=emitir" method="post">
                  <input type="hidden" name="txtIdEstabelecimento" value="${estabelecimento.id}"/>
                  <a href="#" title="Emitir PDF" onclick="$(this).closest('form').submit()">
                    <i class="fad fa-print"></i>
                  </a>
                </form>
              </c:when>
              <c:otherwise>
                <a href="ListaFuncionarioController?acao=emitir" title="Emitir PDF">
                  <i class="fad fa-print"></i>
                </a>
              </c:otherwise>
            </c:choose>

            <c:if test="${estabelecimento != null && (consultor.nivelPermissao == 0 || consultor.nivelPermissao == 1)}">
              <form action="/ManterFuncionarioController" method="post">
                <input type="hidden" name="uriAtual" value="/PesquisarEstabelecimentoController" />
                <input type="hidden" name="fonte" value="${estabelecimento.id}" />
                <input type="hidden" name="consultor" value="${consultor.id}" />
                <input type="hidden" name="acao" value="prepararOperacao" />
                <input type="hidden" name="operacao" value="Incluir" />
                <a href="#" 
                   title="Adicionar novo Funcionário" 
                   onclick="$(this).closest('form').submit()"
                   >
                  <i class="fad fa-plus"></i>
                </a>
              </form>
            </c:if>

          </div>
        </div>
      </header>

      <section class="wrap-reverse">
        <c:choose>
          <c:when test="${funcionarios.size() != 0 && (consultor.nivelPermissao == 0 || consultor.nivelPermissao == 1 || consultor == null) }">
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
                      ${funcionario.usuario.nome}
                    </span>
                  </div>
                </c:forEach>
              </div>

              <div class="col">
                <div class="row">
                  <h4>POSIÇÃO</h4>
                </div>
                <c:forEach items="${funcionarios}" var="funcionario">
                  <div class="row wrap">
                    <span>
                      <c:if test="${funcionario.nivelPermissao == 0}">
                        <c:out value="Administrador" />
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
                    <c:if test="${estabelecimento != null && (consultor.nivelPermissao == 0 || consultor.nivelPermissao == 1)}">
                      <form action="/ManterFuncionarioController" method="post">
                        <input type="hidden" name="uriAtual" value="/PesquisarFuncionarioController" />
                        <input type="hidden" name="fonte" value="${estabelecimento.id}" />
                        <input type="hidden" name="consultor" value="${consultor.id}" />
                        <input type="hidden" name="acao" value="prepararOperacao" />
                        <input type="hidden" name="operacao" value="Editar" />
                        <input type="hidden" name="id" value="${funcionario.id}" />
                        <a href="#"
                           class="p-2"
                           title="Editar Funcionário" 
                           onclick="$(this).closest('form').submit()"
                           >
                          <i class="fad fa-edit"></i>
                        </a>
                      </form>
                      <form action="/ManterFuncionarioController" method="post">
                        <input type="hidden" name="uriAtual" value="/PesquisarFuncionarioController" />
                        <input type="hidden" name="fonte" value="${estabelecimento.id}" />
                        <input type="hidden" name="consultor" value="${consultor.id}" />
                        <input type="hidden" name="acao" value="prepararOperacao" />
                        <input type="hidden" name="operacao" value="Excluir" />
                        <input type="hidden" name="id" value="${funcionario.id}" />
                        <a href="#" 
                           class="p-2"
                           title="Excluir Funcionário" 
                           onclick="$(this).closest('form').submit()"
                           >
                          <i class="fad fa-trash"></i>
                        </a>
                      </form>
                    </c:if>
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
              <c:if test="${colsultor != null}">
                <form class="mt-3" action="ManterFuncionarioController?acao=prepararOperacao&operacao=Incluir"
                      method="post">
                  <input type="hidden" name="page" value="/PesquisarFuncionarioController" />
                  <button type="submit">
                    <i class="fas fa-plus"></i> Adicione um!
                  </button>
                </form>
              </c:if>

            </div>
          </c:otherwise>
        </c:choose>
      </section>

    </section>
  </body>

</html>
