/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.EstabelecimentoDAO;
import com.debron.mocs.dao.FuncionarioDAO;
import com.debron.mocs.dao.UsuarioDAO;
import com.debron.mocs.model.Funcionario;
import com.debron.mocs.model.Usuario;
import com.debron.mocs.utils.RandomID;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.function.Predicate;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Débora & Aaron
 */
public class ManterFuncionarioController extends HttpServlet {

  private DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy_HH:mm:ss");

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param req servlet request
   * @param res servlet response
   *
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest req, HttpServletResponse res)
          throws ServletException,
          IOException,
          SQLException,
          ClassNotFoundException {
    String consultorId = req.getParameter("consultor");

    String estabelecimentoId = req.getParameter("fonte");

    Boolean removeAdmin = false;

    final List<Funcionario> admins = new ArrayList<>();
    final List<Funcionario> staff = new ArrayList<>();

    List<Funcionario> temp = FuncionarioDAO.getInstancia().findAll();

    Predicate<Funcionario> porLugar = funcionario -> funcionario.getEstabelecimento().getId().equals(estabelecimentoId);

    Predicate<Funcionario> porPermissao = funcionario -> funcionario.getNivelPermissao() == 0;

    temp.stream().filter(porLugar).forEach(funcionario -> staff.add(funcionario));

    staff.stream().filter(porPermissao).forEach(funcionario -> admins.add(funcionario));

    if (admins.size() > 1) {
      removeAdmin = true;
    }

    req.setAttribute("removeAdmin", removeAdmin);

    req.setAttribute(
            "estabelecimento",
            EstabelecimentoDAO.getInstancia().findById(estabelecimentoId)
    );

    req.setAttribute("consultor", FuncionarioDAO.getInstancia().findById(consultorId));

    req.setAttribute("uriAnterior", req.getParameter("uriAtual"));

    String acao = req.getParameter("acao");

    switch (acao) {
      case "prepararOperacao":
        prepararOperacao(req, res);
        break;
      default:
        confirmarOperacao(req, res);
        break;
    }
  }

  public void prepararOperacao(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      String operacao = req.getParameter("operacao");
      req.setAttribute("operacao", operacao);
      if (!operacao.equalsIgnoreCase("Incluir")) {
        String idFuncionario = req.getParameter("id");
        Funcionario funcionario = FuncionarioDAO.getInstancia().findById(idFuncionario);
        req.setAttribute("funcionario", funcionario);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "/pages/cadastrar/cadastrarFuncionario.jsp");
      view.forward(req, res);
    } catch (ServletException e) {
      throw e;
    } catch (IOException e) {
      throw new ServletException(e);
    }
  }

  public void confirmarOperacao(HttpServletRequest req, HttpServletResponse res)
          throws SQLException, ClassNotFoundException, ServletException {
    String operacao = req.getParameter("operacao");
    List<String> errorMsg = new ArrayList<>();

    String idEstabelecimento = req.getParameter("txtIdEstabelecimento");
    String cpf = req.getParameter("txtCpf");
    Integer nivelPermissao = Integer.parseInt(req.getParameter("txtNivelPermissao"));
    boolean statusConta = Boolean.parseBoolean(req.getParameter("txtStatusConta"));

    try {
      req.setCharacterEncoding("utf-8");
      if (operacao.equalsIgnoreCase("excluir")) {
        String idFuncionario = req.getParameter("txtIdFuncionario");
        FuncionarioDAO.getInstancia().remove(idFuncionario);
      } else if (operacao.equalsIgnoreCase("incluir")) {

        String hoje = dateFormat.format(new Date());
        Usuario verificaCPF = UsuarioDAO.getInstancia().findByCPF(cpf);
        List<Funcionario> temp = FuncionarioDAO.getInstancia().findAll();
        final List<Funcionario> duplicados = new ArrayList<>();
        final List<Funcionario> staff = new ArrayList<>();

        Predicate<Funcionario> porLugar = funcionario -> funcionario.getEstabelecimento().getId().equals(idEstabelecimento);

        Predicate<Funcionario> duplicado = funcionario -> funcionario.getUsuario().getCpf().equals(cpf);

        temp.stream().filter(porLugar).forEach(funcionario -> staff.add(funcionario));
        staff.stream().filter(duplicado).forEach(funcionario -> duplicados.add(funcionario));

        if (cpf == null) {
          errorMsg.add("Não é possível cadastrar sem o CPF!");
        }

        if (verificaCPF == null) {
          errorMsg.add("Usuário não cadastrado no sistema!");
        }
        
        if (idEstabelecimento == null) {
          errorMsg.add("Não é possível adicionar um funcionário à lugar nenhum!");
        }

        if (!duplicados.isEmpty()) {
          errorMsg.add("Funcionário já cadastrado!");
        }

        if (!errorMsg.isEmpty()) {
          req.setAttribute("errorMsg", errorMsg);
          req.setAttribute(
            "estabelecimento",
            EstabelecimentoDAO.getInstancia().findById(idEstabelecimento)
    );
          req.getRequestDispatcher(
                  "/ManterFuncionarioController?acao=prepararOperacao&operacao=Incluir&id="
                  + idEstabelecimento
          ).forward(req, res);
          return;
        } else {
          Funcionario funcionario = new Funcionario();
          funcionario.setId(RandomID.generate());
          funcionario.setNivelPermissao(nivelPermissao);
          funcionario.setStatusConta(statusConta);
          funcionario.setEstabelecimento(
                  EstabelecimentoDAO.getInstancia()
                          .findById(idEstabelecimento)
          );
          funcionario.setUsuario(UsuarioDAO.getInstancia()
                  .findByCPF(cpf));
          funcionario.setCreatedAt(hoje);
          funcionario.setUpdatedAt(hoje);

          FuncionarioDAO.getInstancia().save(funcionario);
        }

      } else if (operacao.equalsIgnoreCase("editar")) {
        String hoje = dateFormat.format(new Date());
        String idFuncionario = req.getParameter("txtIdFuncionario");
        Funcionario funcionario = FuncionarioDAO.getInstancia().findById(idFuncionario);
        funcionario.setNivelPermissao(nivelPermissao);
        funcionario.setStatusConta(statusConta);
        funcionario.setUpdatedAt(hoje);
        FuncionarioDAO.getInstancia().save(funcionario);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "PesquisarFuncionarioController");
      view.forward(req, res);
    } catch (IOException | NoSuchAlgorithmException e) {
      throw new ServletException(e);
    }
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      processRequest(req, res);
    } catch (SQLException | ClassNotFoundException ex) {
      throw new ServletException(ex);
    }
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      processRequest(req, res);
    } catch (SQLException | ClassNotFoundException ex) {
      throw new ServletException(ex);
    }
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
