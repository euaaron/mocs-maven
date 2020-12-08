<%-- 
    Document   : cadastroFuncionario
    Created on : 05/09/2019, 10:20:01
    Author     : Aaron Stiebler & Débora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MOCS | ${operacao} Funcionario</title>

    <%-- Estilos e scripts próprios --%>
    <link rel="stylesheet" href="./main.css" />
    <link rel="stylesheet" href="./css/pages/cadastro.css" />
    <script src="./js/filtros.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
  </head>

  <body>

    <section class="flex-2">
      <c:choose>
        <c:when test="${operacao.equalsIgnoreCase('editar')}">
          <div class="row center">
            <i class="fad fa-user-tie huge text-light"></i>
            <i class="fad fa-cog medium text-light"></i>
          </div>
          <h2>Editar Funcionário</h2>
        </c:when>
        <c:when test="${operacao.equalsIgnoreCase('excluir')}">
          <i class="fad fa-user-slash text-alert"></i>
          <h2>Excluir Funcionário</h2>
        </c:when>
        <c:otherwise>
          <div class="row center">
            <i class="fad fa-user-tie huge text-light"></i>
            <i class="fad fa-plus medium text-light"></i>
          </div>
          <h2>Novo Funcionário</h2>
        </c:otherwise>
      </c:choose>
      <h5 class="text-primary">
        ${estabelecimento.nomeFantasia}
      </h5>
    </section>

    <section class="container flex-4">

      <form id="incluir" action="ManterFuncionarioController?acao=confirmarOperacao&operacao=${operacao}"
            name="frmManterFuncionario" method="post" onsubmit="return validarFormulario(this)">
        <input type="hidden" name="txtIdEstabelecimento" value="${estabelecimento.id}" />
        <c:if test="${!errorMsg.isEmpty()}">
          <div class="row">
            <div class="col">
              <c:forEach items="${errorMsg}" var="error">
                <p class="error bg-dark">${error}</p>
              </c:forEach>
            </div>
          </div>
        </c:if>

        <c:if test="${!operacao.equalsIgnoreCase('incluir')}">
          <div class="row wrap">
            <h2 class="wrap">${funcionario.usuario.nome}</h2>
          </div>
        </c:if>


        <div class="row">
          <label class="col flex-1" for="txtNivelPermissao">Função:
            <div class="col">
              <select class="custom-select mr-sm-2" id="idFuncao" name="txtNivelPermissao">
                <c:if test="${((consultor.nivelPermissao == 0 || consultor.nivelPermissao == 1) && (removeAdmin == true && funcionario.nivelPermissao == 0) || funcionario.nivelPermissao != 0)|| funcionario == null}">
                  <option 
                    value="3" 
                    <c:if test="${funcionario.nivelPermissao == null || funcionario.nivelPermissao == 3}"> 
                      selected</c:if>>
                      Garçom
                    </option>
                    <option value="4" <c:if test="${funcionario.nivelPermissao == 4}"> selected</c:if>>
                      Cheff
                    </option>
                    <option value="2" <c:if test="${funcionario.nivelPermissao == 2}"> selected</c:if>>
                      Supervisor
                    </option>
                </c:if>
                <c:if test="${consultor.nivelPermissao == 0}">
                  <c:if test="${((removeAdmin == true && funcionario.nivelPermissao == 0) || funcionario.nivelPermissao != 0)|| funcionario == null}">
                    <option value="1" <c:if test="${funcionario.nivelPermissao == 1}"> selected</c:if>>
                        Gerente
                      </option>
                  </c:if>
                  <option value="0" <c:if test="${funcionario.nivelPermissao == 0}"> selected</c:if>>
                      Administrador
                    </option>
                </c:if>
              </select>
            </div>
          </label>

          <div class="row ml-2">
            <label class="col-sm-2 col-form-label" for="status">Status da Conta:
              <div class="col-sm-2">
                <select class="custom-select mr-sm-2" id="status" name="txtStatusConta">
                  <c:if test="${((consultor.nivelPermissao == 0 || consultor.nivelPermissao == 1) && ((removeAdmin == true && funcionario.nivelPermissao == 0)) || funcionario.nivelPermissao != 0)|| funcionario == null}">
                    <option value="false"
                            <c:if test="${funcionario.statusConta == false}"> 
                              selected</c:if>>Desativada</option>
                  </c:if>
                  <option value="true" <c:if test="${funcionario.statusConta == true}"> 
                          selected</c:if>>Ativada</option>
                  </select>
                </div>
              </label>
            </div>
          </div>

          <div class="row mb-3">
            <label class="col-sm-2 col-form-label" for="cpf">CPF:
              <div class="col-sm-2">
                <input class="form-control" type="text" name="txtCpf" id="cpf" maxlength="14" onkeyup="filtra('cpf')"
                       placeholder="000.000.000-00" value="${consultor.nivelPermissao == 0 ? funcionario.usuario.cpf : ""}" <c:if test="${consultor.nivelPermissao != 0 || operacao.equalsIgnoreCase('excluir')}">readonly</c:if> />
              </div>
            </label>
          </div>

          <div class="col center mt-5">

          <c:choose>
            <c:when test="${operacao.equalsIgnoreCase('editar') && funcionario.nivelPermissao == 0 && consultor.nivelPermissao != 0}">
              <p class="text-alert bg-dark wrap ph-2">Você não tem permiassão para editar o Admin do estabelecimento!</p>
            </c:when>
            
            <c:when test="${operacao.equalsIgnoreCase('editar')}">
              <input type="hidden" name="txtIdFuncionario" value="${funcionario.id}" />
              <button type="submit" name="btnIncluir" value="Confirmar">Editar</button>
            </c:when>

            <c:when test="${operacao.equalsIgnoreCase('excluir') && removeAdmin == true}">
              <input type="hidden" name="txtIdFuncionario" value="${funcionario.id}" />
              <button type="submit" name="btnIncluir" value="Confirmar">Excluir</button>
            </c:when>

            <c:when test="${operacao.equalsIgnoreCase('excluir') && removeAdmin == false}">
              <p class="text-alert bg-dark wrap ph-2">Não é possível remover o único Admin do estabelecimento!</p>
            </c:when>

            <c:otherwise>
              <button type="submit" name="btnIncluir" value="Confirmar">Cadastrar</button>
            </c:otherwise>
          </c:choose>
          <a href="${uriAnterior}">
            <i class="fad fa-chevron-left"></i> 
            Voltar
          </a>
        </div>
      </form>
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
        if (form.txtIdEstabelecimento.value == "0") {
          mensagem = mensagem + "Informe o Estabelecimento\n";
        }
        if (form.txtIdFuncionario.value == "") {
          mensagem = mensagem + "Informe o Código do Funcionário\n";
        }
        if (form.txtStatusConta.value == "") {
          mensagem = mensagem + "Informe o Status da Conta do Funcionário\n";
        }
        if (form.txtNome.value == "") {
          mensagem = mensagem + "Informe o Nome do Funcionário\n";
        }
        if (form.txtCpf.value == "") {
          mensagem = mensagem + "Informe o CPF do Funcionário\n";
        }
        if (form.txtEmail.value == "") {
          mensagem = mensagem + "Informe o Email do Funcionário\n";
        }
        if (form.txtIdFuncao.value == "0") {
          mensagem = mensagem + "Informe a Função do Funcionário\n";
        }
        if (form.txtSenha.value == "0") {
          mensagem = mensagem + "Informe a Senha do Funcionário\n";
        }
        if (form.txtReSenha.value == "") {
          mensagem = mensagem + "Digite a Senha do Funcionário novamente\n";
        }
        if (form.txtSenha.value != form.txtReSenha.value) {
          mensagem = mensagem + "Campos de Senha diferentes\n";
        }
        if (!campoNumerico(form.txtIdFuncionario.value)) {
          mensagem = mensagem + "Código do Funcionário deve ser numérico\n";
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
