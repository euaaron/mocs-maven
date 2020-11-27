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

        <!-- Estilos e scripts próprios -->
        <link rel="stylesheet" href="./css/alternate.css"/>
        <!-- link rel="stylesheet" href="./css/login.css" -->
        <script src="./js/filtros.js"></script>
    </head>
    <body>

        <div class="header total-center container-sm">
            <div>
                <div class="display-flex total-center">
                    <h1 class="font-md-r">Bem-vindo ao <br /><span
                            class="bold black">M<i class="fad fa-egg-fried"></i>CS</span></h1>
                </div>
                <h5 class="font-sm-r">O maior portal virtual de controle de pedidos do mundo.</h5>
            </div>
        </div>
        <div class="no-margin-left container-sm display-flex total-center">
            <div class="display-flex total-center">
                <div class="content">
                    <section id="formLogin">
                        <form id="login" action="<%=request.getContextPath()%>/SessionController" name="frmLogin" method="post">
                            <div class="input">
                                <label for="txtEmail">Email</label><br />
                                <div>
                                    <i class="fas fa-envelope"></i>
                                    <input id="txtEmail" name="txtEmail" type="text" name="txtEmail">
                                </div>
                            </div>
                            <div class="input">
                                <label for="txtSenha">Senha</label><br />
                                <div>
                                    <i class="fas fa-key"></i>
                                    <input id="txtSenha" name="txtSenha" type="password" name="txtSenha">
                                </div>
                            </div>

                            <button id="loginUser" submit>Entrar</button>
                            <a id="register" href="ManterUsuarioController?acao=prepararOperacao&operacao=Incluir">Registre-se</a>
                        </form>
                        <div>
                            <p id="loginGuest">Ou então <a href="inicio?acao=confirmarOperacao&operacao=logar&agente=0">entre como convidado</a>.</p>
                        </div>
                        <c:if test="${erro != null}"><p>${erro}</p></c:if>
                    </section>
                </div>
            </div>
        </div>

    </body>
</html>