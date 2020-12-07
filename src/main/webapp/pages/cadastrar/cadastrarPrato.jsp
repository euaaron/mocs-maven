<%-- 
    Document   : cadastroRefeicao
    Created on : 07/09/2019, 18:45:11
    Author     : Aaron Stiebler & Débora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
    <title>MOCS | ${operacao} Prato</title>

    <%-- Estilos e scripts próprios --%>
    <link rel="stylesheet" href="./main.css" />
    <link rel="stylesheet" href="./css/pages/cadastro.css" />
    <script src="./js/filtros.js"></script>
  </head>

  <body>

    <section class="flex-2">
      <c:choose>
        <c:when test="${operacao.equalsIgnoreCase('editar')}">
          <i class="fad fa-cog"></i>
          <h2>Editar Prato</h2>
        </c:when>
        <c:when test="${operacao.equalsIgnoreCase('excluir')}">
          <i class="fad fa-slash"></i>
          <h2>Excluir Prato</h2>
        </c:when>
        <c:otherwise>
          <div class="row center">
            <i class="fad fa-utensils-alt huge text-primary"></i>
            <i class="fad fa-plus medium text-success"></i>
          </div>
          <h2>Novo Prato</h2>
        </c:otherwise>
      </c:choose>
      <h5 class="text-primary">
        ${estabelecimento.nomeFantasia}
      </h5>
    </section>

    <section class="form flex-4 wrap-reverse">

      <div class="container center">

        <form id="incluir" action="ManterPratoController?acao=confirmarOperacao&operacao=${operacao}"
              name="frmManterPrato" method="post" onsubmit="return validarFormulario(this)">

          <c:if test="${errorMsg != null}">
            <div class="row">
              <div class="col">
                <p class="error">${errorMsg}</p>
              </div>
            </div>
          </c:if>

          <div class="row">
            <label class="col-sm-2 col-form-label">Estabelecimento
              <div class="col-sm-2">
                <select name="txtIdEstabelecimento" class="custom-select mr-sm-2">
                  <option value="0" <c:if test="${prato.estabelecimento.id == null}"> selected</c:if>> </option>
                  <c:forEach items="${estabelecimentos}" var="estabelecimento">
                    <option value="${estabelecimento.id}" <c:if test="${prato.estabelecimento.id == estabelecimento.id}">
                            selected</c:if>
                      >${estabelecimento.nomeFantasia}</option>
                  </c:forEach>
                </select>
              </div>
            </label>
          </div>

          <div class="row">
            <label for="nome" class="col-sm-2 col-form-label">Nome
              <div class="col-sm-2">
                <input type="text" class="form-control" name="txtNome" id="nome" maxlength="45" value="${prato.nome}"
                       <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                </div>
              </label>
            </div>

            <div class="row">
              <label for="descricao" class="col-sm-2 col-form-label">Descricao
                <div class="col-sm-2">
                  <input type="text" class="form-control" name="txtDescricao" id="descricao" maxlength="60"
                         value="${prato.descricao}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                </div>
              </label>
            </div>

            <div class="row">
              <label for="imagem" class="col-sm-2 col-form-label">Url da Imagem
                <div class="col-sm-2">
                  <input type="text" class="form-control" name="txtImagemUrl" id="imagem" value="${prato.imagemUrl}" <c:if
                         test="${operacao == 'Excluir'}"> readonly</c:if>/>
                </div>
              </label>
            </div>

            <div class="row">
              <label for="preco" class="col-sm-2 col-form-label">Preco
                <div class="col-sm-2">
                  <input type="text" class="form-control" name="txtPreco" id="preco" maxlength="12" placeholder="00.00"
                         value="${prato.preco}" <c:if test="${operacao == 'Excluir'}"> readonly
                  </c:if>/>
              </div>
            </label>
          </div>



          <div class="row">
            <label class="col-sm-2 col-form-label">Exibir
              <div class="col-sm-2">
                <select name="txtExibir" class="custom-select mr-sm-2">
                  <option value="0" <c:if test="${prato.exibir == 0}"> selected</c:if>>Não</option>
                  <option value="1" <c:if test="${prato.exibir == 1}"> selected</c:if>>Sim</option>
                  </select>
                </div>
              </label>
            </div>

            <div>
            <c:choose>
              <c:when test="${operacao.equalsIgnoreCase('editar')}">
                <input type="hidden" name="txtIdUsuario" value="${prato.id}">
                <button type="submit" name="btnIncluir" value="Confirmar">Salvar</button>
              </c:when>
              <c:when test="${operacao.equalsIgnoreCase('excluir')}">
                <input type="hidden" name="txtIdUsuario" value="${prato.id}">
                <button type="submit" name="btnIncluir" value="Confirmar">Excluir prato</button>
              </c:when>
              <c:otherwise>
                <button type="submit" name="btnIncluir" value="Confirmar">Adicionar prato</button>
              </c:otherwise>
            </c:choose>
          </div>
        </form>
        <form action="/PesquisarPratoController" method="get">
          <input type="hidden" name="fonte" value="${estabelecimento.id}" />
          <a href="#"  onclick="$(this).closest('form').submit()"><i class="fad fa-chevron-left"></i> Voltar</a>
        </form>
      </div>
    </div>
    <script>
      function campoNumerico(valor) {
        var caracteresValidos = "0123456789";
        var ehNumero = true;
        var umCaracter;
        for (i = 0; i < valor.length && ehNumero == true; i++) {
          umCaracter = valor.charAt(i);
          if (caracteresValidos.indexOf(umCaracter) == -1) {
            ehNumero = false;
          }
        }
        return ehNumero;
      }
      function validarFormulario(form) {
        var mensagem;
        mensagem = "";

        if (form.txtIdFuncionario.value == "0") {
          mensagem = mensagem + "Informe o Funcionário\n";
        }
        if (form.txtIdEstabelecimento.value == "0") {
          mensagem = mensagem + "Informe o Estabelecimento\n";
        }
        if (form.txtId.value == "") {
          mensagem = mensagem + "Informe o Código do Prato\n";
        }
        if (form.txtNome.value == "") {
          mensagem = mensagem + "Informe o Nome do Prato\n";
        }
        if (form.txtDescricao.value == "") {
          mensagem = mensagem + "Informe a Descrição do Prato\n";
        }
        var antes;
        var depois;
        if (form.txtPreco.value == "") {
          mensagem = mensagem + "Informe o Preço do Prato\n";
        } else {
          antes = form.txtPreco.value;
          depois = antes.replace(",", ".");
          form.txtPreco.value = depois;
        }
        if (form.txtDataCriacao.value == "") {
          mensagem = mensagem + "Informe a Data da Criação do Prato\n";
        }
        if (form.txtExibir.value == "") {
          mensagem = mensagem + "Informe se quer esse Prato exibindo no Estabelecimento\n";
        }
        if (!campoNumerico(form.txtId.value)) {
          mensagem = mensagem + "Código do Prato deve ser numérico\n";
        }
        if (mensagem == "") {
          return true;
        } else {
          if ("${operacao}" !== "Excluir") {
            alert(mensagem);
            return false;
          }
          return true;
        }
      }
    </script>
</body>

</html>
