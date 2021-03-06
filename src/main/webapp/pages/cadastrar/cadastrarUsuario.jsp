<%-- 
    Document   : usuario
    Created on : 05/09/2019, 09:21:37
    Author     : Aaron Stiebler & Débora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MOCS | ${operacao} Usuário</title>

    <%-- Estilos e scripts próprios --%>
    <link rel="stylesheet" href="./main.css">
    <link rel="stylesheet" href="./css/pages/cadastro.css">
    <script src="./js/filtros.js"></script>
    <script
      src="https://code.jquery.com/jquery-3.5.1.min.js"
      integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
  </head>

  <body>

    <section>
      <c:choose>
        <c:when test="${operacao.equalsIgnoreCase('editar')}">
          <i class="fad fa-user-edit"></i>
          <h2>Editar Usuário</h2>
        </c:when>
        <c:when test="${operacao.equalsIgnoreCase('excluir')}">
          <i class="fad fa-user-times"></i>
          <h2>Excluir Usuário</h2>
        </c:when>
        <c:otherwise>
          <i class="fad fa-user-plus"></i>
          <h2>Novo Usuário</h2>
        </c:otherwise>
      </c:choose>
    </section>

    <section id="form">

      <form id="incluir" name="frmManterUsuario" method="post" onsubmit="return validarFormulario(this)"
            action="ManterUsuarioController?acao=confirmarOperacao&operacao=${operacao}&agente=${agente}<c:if test=" ${idUser
                                                                              !=null && idUser !=0}">&idUser=${idUser}</c:if>">
            <c:if test="${!errorMsg.isEmpty()}">
              <c:forEach items="${errorMsg}" var="error">
                <p class="error">${error}</p>
              </c:forEach>
            </c:if>
            <div>

              <label for="nome">Nome
                <div>
                  <i class="fas fa-user"></i>
                  <input type="text" name="txtNome" id="nome" maxlength="28" value="${usuario.nome}" required <c:if
                           test="${operacao == 'Excluir'}"> readonly</c:if>/>
                  </div>
                </label>

                <label for="cpf">CPF
                  <div>
                    <i class="fas fa-id-card"></i>
                    <input type="text" onkeyup="filtra('cpf')" name="txtCpf" id="cpf" maxlength="14" value="${usuario.cpf}"
                         required <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                  </div>
                </label>

                <label for="dataNascimento">Data de Nascimento
                  <div>
                    <input type="date" name="txtDataNascimento" id="dataNascimento" value="${usuario.dataNascimento}" required <c:if
                           test="${operacao == 'Excluir'}"> readonly</c:if>/>
                  </div>
                </label>

                <label for="email">Email
                  <div>
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" maxlength="45" name="txtEmail" value="${usuario.email}" required <c:if
                           test="${operacao == 'Excluir'}"> readonly</c:if> />
                  </div>
                </label>

                <label for="telefone">Telefone
                  <div>
                    <i class="fas fa-phone"></i>
                    <input type="text" onkeyup="filtra('telefone')" id="telefone" maxlength="30" name="txtTelefone"
                           value="${usuario.telefone}" <c:if test="${operacao == 'Excluir'}"> readonly</c:if>/>
                  </div>
                </label>
              <c:choose>
                <c:when test="${operacao.equalsIgnoreCase('editar') || operacao.equalsIgnoreCase('excluir') }">
                  <label for="senha">Senha
                    <div>
                      <i class="fas fa-key"></i>
                      <input type="password" id="senha" name="txtSenha" minlength="6" maxlength="45" required/>
                    </div>
                  </label>
                </c:when>
                <c:otherwise>
                  <label for="senha">Senha
                    <div>
                      <i class="fas fa-key"></i>
                      <input type="password" id="senha" name="txtSenha" minlength="6" maxlength="45" required/>
                    </div>
                  </label>
                  <label for="confirmaSenha">Repita a senha
                    <div>
                      <i class="fas fa-key"></i>
                      <input type="password" id="confirmaSenha" name="txtReSenha" minlength="6" maxlength="45" required/>
                    </div>
                  </label>
                </c:otherwise>
              </c:choose>
            </div>

            <div>
              <c:choose>
                <c:when test="${operacao.equalsIgnoreCase('editar')}">
                  <input type="hidden" name="txtIdUsuario" value="${usuario.id}">
                  <button type="submit" name="btnIncluir" value="Confirmar">Salvar</button>
                </c:when>
                <c:when test="${operacao.equalsIgnoreCase('excluir')}">
                  <input type="hidden" name="txtIdUsuario" value="${usuario.id}">
                  <button type="submit" name="btnIncluir" value="Confirmar">Excluir conta</button>
                </c:when>
                <c:otherwise>
                  <button type="submit" name="btnIncluir" value="Confirmar">Criar conta</button>
                </c:otherwise>
              </c:choose>
              
              <a href="${uriAnterior}"><i class="fad fa-chevron-left"></i> Voltar</a>
            </div>
      </form>

    </section>


    <script>
      var hoje = new Date().toLocaleDateString().split("/");
      var dataHoje = hoje[2] + "-" + hoje[1] + "-" + hoje[0];
      var inputDate = document.getElementById('dataNascimento');
      inputDate.setAttribute('max', dataHoje);

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
        if (inputDate.value == "") {
          inputDate.value == dataHoje;
        }
        if (new Date(inputDate.value) > new Date(dataHoje)) {
          mensagem = mensagem + "Data inválida, tente novamente\n";
        }
        if (form.txtIdUsuario.value == "") {
          mensagem = mensagem + "Informe o Código do Usuário\n";
        }
        if (form.txtNome.value == "") {
          mensagem = mensagem + "Informe o Nome do Usuário\n";
        }
        if (form.txtCpf.value == "") {
          mensagem = mensagem + "Informe o CPF do Usuário\n";
        }
        if (form.txtEmail.value == "") {
          mensagem = mensagem + "Digite o Email, ele será usado para login\n";
        }
        if (form.txtSenha.value == "") {
          mensagem = mensagem + "Informe a Senha do Usuário\n";
        }
        if (form.txtReSenha.value == "") {
          mensagem = mensagem + "Digite a Senha do Usuário novamente\n";
        }
        if (form.txtSenha.value != form.txtReSenha.value) {
          mensagem = mensagem + "Campos de Senha diferentes\n";
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
