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
    <c:choose>
      <c:when test="${estabelecimento != null}">
        <title>Cardápio | ${estabelecimento.nomeFantasia}</title>
      </c:when>
      <c:otherwise>
        <title>Pesquisar Pratos</title>
      </c:otherwise>
    </c:choose>

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
              <c:if test="${estabelecimento != null}">
              <li class="ph-2"><i class="fas fa-arrow-right"></i></li>
              <li><a href="/PesquisarEstabelecimentoController">Estabelecimentos</a></li>
              </c:if>
            <li class="ph-2"><i class="fas fa-arrow-right"></i></li>
              <c:choose>
                <c:when test="${estabelecimento != null}">
                <li>Cardápio | ${estabelecimento.nomeFantasia}</li>
                </c:when>
                <c:otherwise>
                <li>Pesquisar Pratos</li>
                </c:otherwise>
              </c:choose>
          </ul>
        </div>

        <div class="col">
          <c:choose>
            <c:when test="${estabelecimento != null}">
              <h1>Cardápio | ${estabelecimento.nomeFantasia}</h1>
            </c:when>
            <c:otherwise>
              <h1>Pesquisar Pratos</h1>
            </c:otherwise>
          </c:choose>
          <div class="mt-2">
            <c:choose>
              <c:when test="${estabelecimento != null}">
                <form action="ListaPratoPestabelecimentoController?acao=emitir" method="post">
                  <input type="hidden" name="txtIdEstabelecimento" value="${estabelecimento.id}"/>
                  <a href="#" title="Emitir PDF" onclick="$(this).closest('form').submit()">
                    <i class="fad fa-print"></i>
                  </a>
                </form>
              </c:when>

              <c:otherwise>
                <a href="ListaPratoController?acao=emitir" title="Emitir PDF">
                  <i class="fad fa-print"></i>
                </a>
              </c:otherwise>
            </c:choose>

            <c:if test="${estabelecimento != null && funcionario != null}">
              <form action="/ManterPratoController" method="post">
                <input type="hidden" name="uriAtual" value="/PesquisarEstabelecimentoController" />
                <input type="hidden" name="fonte" value="${estabelecimento.id}" />
                <input type="hidden" name="consultor" value="${funcionario.id}" />
                <input type="hidden" name="acao" value="prepararOperacao" />
                <input type="hidden" name="operacao" value="Incluir" />
                <a href="#" 
                   title="Adicionar novo Prato" 
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
          <c:when test="${pratos.size() != 0}">
            <div class="col flex-2">
              <c:forEach items="${pratos}" var="prato">
                <c:if test="${prato.exibir == 1 || funcionario != null}">
                  <div class="card row">
                    <aside class=" col flex-1 bg-dark image" style="background-image: url(${prato.imagemUrl});" alt="${prato.nome}">
                    </aside>

                    <aside class="col flex-3">

                      <div class="col mb-2">
                        <h2 class="card-subtitle">
                          ${prato.nome}
                        </h2>
                        <h4 class="card-title">R$ ${prato.preco}</h4>
                      </div>

                      <div class="row mb-2">
                        <p>${prato.descricao}</p>
                      </div>
                      <c:if test="${funcionario != null}">
                        <div class="row">

                          <div class="col flex-1">
                            Criado em
                          </div>

                          <div class="col flex-1">
                            Atualizado em
                          </div>
                        </div>
                        <div class="row">
                          <div class="col flex-1">
                            <b>${prato.createdAt}</b>
                          </div>

                          <div class="col flex-1">
                            <b>${prato.updatedAt}</b>
                          </div>
                        </div>
                      </c:if>
                    </aside>
                    <c:if test="${funcionario != null && (funcionario.nivelPermissao == 0 || funcionario.nivelPermissao == 1 || funcionario.nivelPermissao == 2 || funcionario.nivelPermissao == 4)}">
                      <aside class="col center bg-dark text-light">
                        <c:if test="${prato.exibir == 0}">
                          <i class="fas fa-eye-slash p-4" title="Ocultando do Cardápio">
                          </i>
                        </c:if>
                        <c:if test="${prato.exibir == 1}">
                          <i class="fas fa-eye p-4" title="Exibindo no Cardápio">
                          </i>
                        </c:if>
                        <form action="/ManterPratoController" method="post">
                          
                          <input type="hidden" name="uriAtual" value="/PesquisarPratoController" />
                          <input type="hidden" name="acao" value="prepararOperacao" />
                          <input type="hidden" name="operacao" value="Editar" />
                          <input type="hidden" name="id" value="${prato.id}" />
                          <a 
                            href="#" 
                            title="Editar" 
                            onclick="$(this).closest('form').submit()">
                            <i class="fas fa-edit p-4"></i>
                          </a>
                        </form>
                        <a class="text-alert m-0" href="ManterPratoController?acao=prepararOperacao&operacao=Excluir&id=<c:out value="
                               ${prato.id}" />" > 
                          <i class="fas fa-trash p-4" title="Excluir"></i>
                        </a>
                      </aside>
                    </c:if>
                  </div>
                </c:if>
              </c:forEach>
            </div>
            <div class="flex-1">
              <i class="fad fa-utensils-alt medium"></i>
              <p>Veja todos os pratos deliciosos que estão cadastrados no sistema.</p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="col center">

              <h1><b><i class="fad fa-ghost huge"></i></b></h1>
              <h2 class="mv-2">Ooops...</h2>
              <h4> Não há pratos cadastrados.</h4>
              <c:if test="${colsultor != null}">
                <form class="mt-3" action="ManterPratoController?acao=prepararOperacao&operacao=Incluir"
                      method="post">
                  <input type="hidden" name="uriAtual" value="/PesquisarPratoController" />
                  <button type="submit">
                    <i class="fas fa-plus"></i> Adicione agora!
                  </button>
                </form>
              </c:if>

            </div>
          </c:otherwise>
        </c:choose>
        </div>
      </section>
  </body>

</html>
