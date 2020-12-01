<%-- 
    Document   : index
    Created on : 24/11/2020, 18:48:24
    Author     : @euaaron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="pt_BR">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MOCS</title>

    <link rel="stylesheet" href="./main.css">
    <link rel="stylesheet" href="./css/pages/login.css">
    <script src="./js/filtros.js"></script>
    <script
      src="https://code.jquery.com/jquery-3.5.1.min.js"
      integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
  </head>

  <body>
    <section id="logo">
      <h1>M<i class="fad fa-egg-fried"></i>CS</h1>
      <p>Menu and Order Control System</p>
    </section>

    <section id="form">
      <i class="fad fa-portal-enter"></i>
      <h2>Entrar</h2>
      <c:if test="${errorMsg != null}">
        <p class="error"><i class="far fa-exclamation-circle"></i> ${errorMsg}</p>
      </c:if>
      <form id="login" action="/" name="frmLogin" method="post">
        <div>

          <label for="txtEmail">
            <div>
              <i class="fas fa-envelope"></i>
              <input type="email" name="txtEmail" id="txtEmail">
            </div>
          </label>

          <label for="txtSenha">
            <div>
              <i class="fas fa-key"></i>
              <input type="password" name="txtSenha" minlength="6" id="txtSenha">
            </div>
          </label>

        </div>
        <div>
          <button type="submit"><i class="fad fa-sign-in"></i> Entre agora</button>
        </div>
      </form>
      <form action="ManterUsuarioController?acao=prepararOperacao&operacao=Incluir" name="frmSignup" method="post">
        <input type="hidden" name="page" value="/"/>
        <p>ou&nbsp;<a href="#" onclick="$(this).closest('form').submit()">crie uma conta</a>.</p>
      </form>
    </section>
  </body>

</html>
