<%-- 
    Document   : menu
    Created on : 03/09/2019, 09:18:20
    Author     : Aaron Stiebler e Debora Lessa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>

<html lang="pt_BR">

  <head>

    <meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
    <title>MOCS - Admin</title>

    <!-- Estilos e scripts próprios -->
    <link rel="stylesheet" href="./main.css">
    <link rel="stylesheet" href="./css/pages/home.css">
    <script src="./js/filtros.js"></script>

  </head>

  <body>

    <nav>
      <div>
        <a href="/">
          <h1>M<i class="fad fa-egg-fried"></i>CS</h1>
        </a>
      </div>
    </nav>

    <section>
      <div>
        <a href="PesquisarUsuarioController">
          <i class="fad fa-users"></i>
          <span class="nav-link">Pesquisar Usuários</span>
        </a>
      </div>
      <div>
        <a href="PesquisarEstabelecimentoController">
          <i class="fad fa-building"></i>
          <span class="nav-link">Pesquisar Estabelecimentos</span>
        </a>
      </div>
      <div>
        <a href="PesquisarFuncionarioController">
          <i class="fad fa-user-tie"></i>
          <span class="nav-link">Pesquisar Funcionários</span>
        </a>
      </div>
      <div>
        <a href="PesquisarPratoController">
          <i class="fad fa-utensils-alt"></i>
          <span class="nav-link">Pesquisar Pratos</span>
        </a>
      </div>
      <div>
        <a href="PesquisarComandaController">
          <i class="fad fa-ballot"></i>
          <span class="nav-link">Pesquisar Comandas</span>
        </a>
      </div>

    </section>

    <footer>
      <a href="<%=request.getContextPath()%>/?action=logout">
        <i class="fad fa-portal-exit"></i> Sair
      </a>
    </footer>
  </body>

</html>
