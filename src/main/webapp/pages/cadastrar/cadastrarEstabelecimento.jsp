<%-- 
    Document   : Estabelecimento
    Created on : 05/09/2019, 09:22:06
    Author     : Débora Lessa & Aaron Stiebler
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>MOCS | ${operacao} Estabelecimento</title>
  <script src="js/filtros.js"></script>

  <%-- Estilos e scripts próprios --%>
  <link rel="stylesheet" href="./main.css">
  <link rel="stylesheet" href="./css/pages/cadastro.css">

  <script src="./js/filtros.js"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
</head>

<body>

  <section class="flex-2">
    <c:choose>
      <c:when test="${operacao.equalsIgnoreCase('editar')}">
        <div class="row center">
          <i class="fad fa-store huge text-light"></i>
          <i class="fad fa-cog medium text-light"></i>
        </div>
        <h2>Editar Estabelecimento</h2>
      </c:when>
      <c:when test="${operacao.equalsIgnoreCase('excluir')}">
        <i class="fad fa-store-slash"></i>
        <h2>Excluir Estabelecimento</h2>
      </c:when>
      <c:otherwise>
        <div class="row center">
          <i class="fad fa-store huge text-light"></i>
          <i class="fad fa-plus medium text-light"></i>
        </div>
        <h2>Novo Estabelecimento</h2>
      </c:otherwise>
    </c:choose>
  </section>

  <section class="container flex-4">

    <form id="incluir" action="ManterEstabelecimentoController?acao=confirmarOperacao&operacao=${operacao}"
      name="frmManterEstabelecimento" method="post" onsubmit="return validarFormulario(this)">

      <c:if test="${errorMsg != null}">
        <div class="row">
          <div class="col">
            <p class="error">${errorMsg}</p>
          </div>
        </div>
      </c:if>

      <div class="row">
        <label class="col" for="nomeFantasia">Nome Fantasia:
          <div>
            <input class="form-control" type="text" name="txtNomeFantasia" id="nomeFantasia" maxlength="45"
              value="${estabelecimento.nomeFantasia}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>
      </div>

      <div class="row">
        <label class="col" for="cnpj">CNPJ:
          <div>
            <input type="text" onkeyup="filtra('cnpj')" name="txtCnpj" id="cnpj" placeholder="00.000.000/0000-00"
              maxlength="18" value="${estabelecimento.cnpj}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>

        <label class="col" for="inscEstadual">Inscrição Estadual:
          <div>
            <input class="form-control" type="text" onkeyup="filtra('inscEstadual')" name="txtInscEstadual"
              id="inscEstadual" maxlength="15" placeholder="000.000.000.000" value="${estabelecimento.inscEstadual}"
              <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>

        <label class="col" for="telefone">Telefone:
          <div>
            <input class="form-control" type="text" onkeyup="filtra('telefone')" name="txtTelefone" id="telefone"
              maxlength="30" placeholder="(xx) xxxx-xxxx" value="${estabelecimento.telefone}" <c:if
              test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>
      </div>

      <div class="row">
        <label class="col flex-2" for="cep">CEP:
          <div>
            <input class="form-control" onkeyup="filtra('cep')" type="text" id="cep" name="txtCEP" maxlength="10"
              placeholder="00.000-000" value="${estabelecimento.endereco.cep}" onkeyup="filtraCEP()" <c:if
              test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>

        <label class="col flex-1" for="uf">UF:
          <div>
            <input class="form-control" type="text" id="uf" name="txtUF" maxlength="4" value="${estabelecimento.endereco.uf}"
              <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>

        <label class="col flex-3" for="cidade">Cidade:
          <div>
            <input class="form-control" type="text" id="cidade" name="txtCidade" maxlength="45"
              value="${estabelecimento.endereco.cidade}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>

        <label class="col flex-4" for="bairro">Bairro:
          <div>
            <input class="form-control" type="text" id="bairro" name="txtBairro" maxlength="45"
              value="${estabelecimento.endereco.bairro}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>
      </div>

      <div class="row">
        <label class="col flex-3" for="logradouro">Rua:
          <div>
            <input class="form-control" type="text" id="logradouro" name="txtLogradouro" maxlength="45"
              value="${estabelecimento.endereco.logradouro}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>
        <label class="col flex-1" for="edificio">Nº.
          <div>
            <input class="form-control" type="text" id="edificio" name="txtEdificio" maxlength="9"
              value="${estabelecimento.endereco.edificio}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>
        <label class="col flex-2" for="complemento">Complemento:
          <div>
            <input class="form-control" type="text" id="complemento" name="txtComplemento" maxlength="29"
              value="${estabelecimento.endereco.complemento}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
          </div>
        </label>
      </div>

      <div class="col center mt-5">
        <input type="hidden" name="txtProprietarioId" value="${userSession.id}" />
        <input type="hidden" name="page" value="/ManterEstabelecimentoController?acao=prepararOperacao&operacao=Incluir" />

        <c:choose>
          <c:when test="${operacao.equalsIgnoreCase('editar')}">
            <input type="hidden" name="txtIdEstabelecimento" value="${estabelecimento.id}" />
            <button type="submit" name="btnIncluir" value="Confirmar">Salvar</button>
          </c:when>

          <c:when test="${operacao.equalsIgnoreCase('excluir')}">
            <input type="hidden" name="txtIdEstabelecimento" value="${estabelecimento.id}" />
            <button type="submit" name="btnIncluir" value="Confirmar">Excluir Estabelecimento</button>
          </c:when>

          <c:otherwise>
            <button type="submit" name="btnIncluir" value="Confirmar">Cadastrar Estabelecimento</button>
          </c:otherwise>
        </c:choose>
        <a href="${uriAnterior}"><i class="fad fa-chevron-left"></i> Voltar</a>
      </div>

    </form>
  </section>
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
      if (form.txtIdEstabelecimento.value == "") {
        mensagem = mensagem + "Informe o Código do Estabelecimento\n";
      }
      if (form.txtIdProprietario.value == "0") {
        mensagem = mensagem + "Informe o Proprietário\n";
      }
      if (form.txtCnpj.value == "") {
        mensagem = mensagem + "Informe o CNPJ do Estabelecimento\n";
      }
      if (form.txtNomeFantasia.value == "") {
        mensagem = mensagem + "Informe o Nome do Estabelecimento\n";
      }
      if (form.txtInscEstadual.value == "") {
        mensagem = mensagem + "Informe a Inscrição Estadual do Estabelecimento\n";
      }
      if (form.txtTelefone.value == "") {
        mensagem = mensagem + "Informe o Telefone\n";
      }
      if (form.txtCEP.value == "") {
        mensagem = mensagem + "Informe o CEP do Estabelecimento\n";
      }
      if (form.txtUF.value == "") {
        mensagem = mensagem + "Informe a Unidade de Federação\n";
      }
      if (form.txtCidade.value == "") {
        mensagem = mensagem + "Informe a Cidade do Estabelecimento\n";
      }
      if (form.txtLogradouro.value == "") {
        mensagem = mensagem + "Informe o Logradouro do Estabelecimento\n";
      }
      if (form.txtBairro.value == "") {
        mensagem = mensagem + "Informe o Bairro do Estabelecimento\n";
      }
      if (form.txtEdificio.value == "") {
        mensagem = mensagem + "Informe o Número do Edifício\n";
      }
      if (!campoNumerico(form.txtIdEstabelecimento.value)) {
        mensagem = mensagem + "Código do Estabelecimento deve ser numérico\n";
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
