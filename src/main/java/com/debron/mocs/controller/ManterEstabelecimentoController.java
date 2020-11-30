/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.EstabelecimentoDAO;
import com.debron.mocs.model.Estabelecimento;
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
import java.util.logging.Level;
import java.util.logging.Logger;
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
 * @author euaar & Débora
 */
public class ManterEstabelecimentoController extends HttpServlet {
  private DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy_HH:mm:ss");

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
      case "prepararOperacao":
        prepararOperacao(req, res);
        break;
      case "emitirRelatorio":
        emitirRelatorio(req, res);
        break;
      default:
        confirmarOperacao(req, res);
        break;
    }
  }

  public void emitirRelatorio(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    Connection conexao = null;
    try {
      Date date = new Date();
      String nomeRelatorio = "Relatorio_" + dateFormat.format(date) + ".pdf";

      HashMap parametros = new HashMap();
      parametros.put(
              "estabelecimento_id", 
              Integer.parseInt(req.getParameter("txtEstabelecimentoId")));
      String relatorio = getServletContext().getRealPath("/WEB-INF") + "/Relatorio.jasper";
      JasperPrint jp = JasperFillManager.fillReport(relatorio, parametros,
              conexao);
      byte[] relat = JasperExportManager.exportReportToPdf(jp);

      res.setHeader("Content-Disposition",
              "attachment;filename=" + nomeRelatorio);
      res.setContentType("application/pdf");
      res.getOutputStream().write(relat);
    } catch (JRException | IOException ex) {
      throw new ServletException(ex);
    }
  }

  public void prepararOperacao(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      String operacao = req.getParameter("operacao");
      req.setAttribute("operacao", operacao);
      if (!operacao.equalsIgnoreCase("Incluir")) {
        String idEstabelecimento = req.getParameter("id");
        Estabelecimento estabelecimento = EstabelecimentoDAO.getInstancia().findById(idEstabelecimento);
        req.setAttribute("estabelecimento", estabelecimento);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "/pages/cadastrar/cadastrarEstabelecimento.jsp");
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

    String idEstabelecimento = req.getParameter("txtIdEstabelecimento");
    String cnpj = req.getParameter("txtCNPJ");
    String inscEstadual = req.getParameter("txtInscEstadual");
    String nomeFantasia = req.getParameter("txtNomeFantasia");
    String telefone = req.getParameter("txtTelefone");

    try {
      if (operacao.equalsIgnoreCase("excluir")) {
        EstabelecimentoDAO.getInstancia().remove(idEstabelecimento);
      } else if (operacao.equalsIgnoreCase("incluir")) {

        String hoje = dateFormat.format(new Date());
        
        Estabelecimento estabelecimento = new Estabelecimento();
        estabelecimento.setId(RandomID.generate());
        estabelecimento.setNomeFantasia(nomeFantasia);
        estabelecimento.setCnpj(cnpj);
        estabelecimento.setInscEstadual(inscEstadual);
        estabelecimento.setTelefone(telefone);
        estabelecimento.setCreatedAt(hoje);
        estabelecimento.setUpdatedAt(hoje);

        EstabelecimentoDAO.getInstancia().save(estabelecimento);

      } else if (operacao.equalsIgnoreCase("editar")) {
        String hoje = dateFormat.format(new Date());

        Estabelecimento estabelecimento = EstabelecimentoDAO.getInstancia().findById(idEstabelecimento);
        
        estabelecimento.setNomeFantasia(nomeFantasia);
        estabelecimento.setCnpj(cnpj);
        estabelecimento.setInscEstadual(inscEstadual);
        estabelecimento.setTelefone(telefone);
        estabelecimento.setCreatedAt(hoje);
        estabelecimento.setUpdatedAt(hoje);
        
        EstabelecimentoDAO.getInstancia().save(estabelecimento);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "PesquisarEstabelecimentoController");
      view.forward(req, res);
    } catch (IOException | NoSuchAlgorithmException e) {
      throw new ServletException(e);
    } 
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request  servlet request
   * @param response servlet response
   *
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException      if an I/O error occurs
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
