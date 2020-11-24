/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.UsuarioDAO;
import com.debron.mocs.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

/**
 *
 * @author Aaron & Debora
 */
public class ManterUsuarioController extends HttpServlet {
  
  private DateFormat dateFormat = new SimpleDateFormat("ddMMyyyy_HHmmss");

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param req servlet request
   * @param res servlet response
   *
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException      if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest req, HttpServletResponse res)
          throws ServletException,
          IOException,
          SQLException,
          ClassNotFoundException {
    String acao = req.getParameter("acao");
    switch (acao) {
      case "confirmar":
        confirmarOperacao(req, res);
        break;
      case "emitir":
        emitir(req, res);
        break;
      default:
        prepararOperacao(req, res);
        break;
    }
  }

  public void emitir(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    Connection conexao = null;
    try {
      Date date = new Date();
      String nomeRelatorio = "Relatorio_" + dateFormat.format(date) + ".pdf";

      HashMap parametros;
      parametros = new HashMap();
      parametros.put("P_COD_CURSO", Integer.parseInt(req.getParameter(
              "txtCodCurso")));
      String relatorio = getServletContext().getRealPath("/WEB-INF") + "/Relatorio.jasper";
      JasperPrint jp = JasperFillManager.fillReport(relatorio, parametros,
              conexao);
      byte[] relat = JasperExportManager.exportReportToPdf(jp);

      res.setHeader("Content-Disposition",
              "attachment;filename=" + nomeRelatorio);
      res.setContentType("application/pdf");
      res.getOutputStream().write(relat);
    } catch (JRException | IOException ex) {
      ex.printStackTrace();
    }
  }

  public void prepararOperacao(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      String operacao = req.getParameter("operacao");
      req.setAttribute("operacao", operacao);
      if (!operacao.equals("Incluir")) {
        int idUsuario = Integer.parseInt(req.getParameter("id"));
        Usuario usuario = UsuarioDAO.getInstancia().findById(idUsuario);
        req.setAttribute("usuario", usuario);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "/cadastrarUsuario.jsp");
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

    Integer idUsuario = Integer.parseInt(req.getParameter("txtIdUsuario"));
    String nome = req.getParameter("txtNome");
    String cpf = req.getParameter("txtCpf");
    String dataNascimento = req.getParameter("txtDataNascimento");
    String email = req.getParameter("txtEmail");
    String telefone = req.getParameter("txtTelefone");
    String senha = req.getParameter("txtSenha");

    try {
      if (operacao.equalsIgnoreCase("excluir")) {
        UsuarioDAO.getInstancia().remove(idUsuario);
      } else if (operacao.equalsIgnoreCase("incluir")) {

        if (UsuarioDAO.getInstancia().findById(idUsuario) != null) {
          String hoje = dateFormat.format(new Date());
          
          Usuario usuario = new Usuario();
          usuario.setId(idUsuario);
          usuario.setNome(nome);
          usuario.setCpf(cpf);
          usuario.setDataNascimento(dataNascimento);
          usuario.setEmail(email);
          usuario.setTelefone(telefone);
          usuario.setSenha(senha);
          usuario.setCreatedAt(hoje);
          usuario.setUpdatedAt(hoje);

          UsuarioDAO.getInstancia().save(usuario);
        } else {
          errorMsg = "O usuário já existe ou o ID "
                  + idUsuario
                  + " já foi utilizado.";
          req.setAttribute("errorMsg", errorMsg);
          RequestDispatcher view = req.getRequestDispatcher(
                  "ManterUsuarioController?acao=prepararOperacao&operacao=Incluir"
          );
          view.forward(req, res);
        }
      } else if (operacao.equalsIgnoreCase("editar")) {
        String hoje = dateFormat.format(new Date());
        
        Usuario usuario = UsuarioDAO.getInstancia().findById(idUsuario);
        usuario.setNome(nome);
        usuario.setCpf(cpf);
        usuario.setDataNascimento(dataNascimento);
        usuario.setEmail(email);
        usuario.setTelefone(telefone);
        usuario.setSenha(senha);
        usuario.setUpdatedAt(hoje);
        UsuarioDAO.getInstancia().save(usuario);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "PesquisarUsuarioController");
      view.forward(req, res);
    } catch (IOException e) {
      throw new ServletException(e);
    }
  }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param req servlet request
   * @param res servlet response
   *
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException      if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      processRequest(req, res);
    } catch (SQLException ex) {
      Logger.getLogger(ManterUsuarioController.class.getName()).
              log(Level.SEVERE, null, ex);
    } catch (ClassNotFoundException ex) {
      Logger.getLogger(ManterUsuarioController.class.getName()).
              log(Level.SEVERE, null, ex);
    }
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request  servlet request
   * @param response servlet response
   *
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException      if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      processRequest(req, res);
    } catch (SQLException ex) {
      Logger.getLogger(ManterUsuarioController.class.getName()).
              log(Level.SEVERE, null, ex);
    } catch (ClassNotFoundException ex) {
      Logger.getLogger(ManterUsuarioController.class.getName()).
              log(Level.SEVERE, null, ex);
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
