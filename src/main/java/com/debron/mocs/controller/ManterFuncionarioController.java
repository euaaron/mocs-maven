/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.EnderecoDAO;
import com.debron.mocs.dao.EstabelecimentoDAO;
import com.debron.mocs.dao.FuncionarioDAO;
import com.debron.mocs.dao.UsuarioDAO;
import com.debron.mocs.model.Funcionario;
import com.debron.mocs.model.Usuario;
import com.debron.mocs.utils.Crypto;
import com.debron.mocs.utils.RandomID;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

/**
 *
 * @author Débora
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
    String errorMsg;

    String idFuncionario = req.getParameter("txtIdFuncionario");
    String idEstabelecimento = req.getParameter("txtIdEstabelecimento");
    String idUsuario = req.getParameter("txtIdUsuario");
    int nivelPermissao = Integer.parseInt(req.getParameter("txtnivelPermissao"));
    boolean statusConta = Boolean.parseBoolean(req.getParameter("txtStatusConta"));

    try {
      if (operacao.equalsIgnoreCase("excluir")) {
        FuncionarioDAO.getInstancia().remove(idFuncionario);
      } else if (operacao.equalsIgnoreCase("incluir")) {

        String hoje = dateFormat.format(new Date());

        Funcionario funcionario = new Funcionario();
        funcionario.setId(RandomID.generate());
        funcionario.setNivelPermissao(nivelPermissao);
        funcionario.setStatusConta(statusConta);
        funcionario.setEstabelecimento(
                EstabelecimentoDAO.getInstancia()
                        .findById(idEstabelecimento)
        );
        funcionario.setUsuario(UsuarioDAO.getInstancia()
                .findById(idUsuario));
        funcionario.setCreatedAt(hoje);
        funcionario.setUpdatedAt(hoje);

        FuncionarioDAO.getInstancia().save(funcionario);

      } else if (operacao.equalsIgnoreCase("editar")) {
        String hoje = dateFormat.format(new Date());

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
