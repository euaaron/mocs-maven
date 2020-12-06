/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.DAO;
import com.debron.mocs.dao.PratoDAO;
import com.debron.mocs.dao.EstabelecimentoDAO;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author Débora & Aaron
 */
public class ListaPratoPestabelecimentoController extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    String acao = request.getParameter("acao");
    if (acao.equals("filtrar")) {
      filtrar(request, response);
    } else {
      if (acao.equals("emitir")) {
        emitir(request, response);
      }
    }
  }

  public void filtrar(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    request.setAttribute("estabelecimentos", EstabelecimentoDAO.getInstancia().findAll());
    RequestDispatcher view
            = request.getRequestDispatcher("/listaPratoPestabelecimento.jsp");
    view.forward(request, response);
  }

  public void emitir(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    
    Connection conexao = null;
    
    try {
      DateFormat dateFormat = new SimpleDateFormat("ddMMyyyy_HHmmss");
      Date date = new Date();
      String nomeRelatorio = "ListaPratoPestabelecimento_" + dateFormat.format(date) + ".pdf";

      conexao = DAO.getConexao();

      HashMap parametros = new HashMap();

      parametros.put("P_ID_ESTABELECIMENTO", request.getParameter("txtIdEstabelecimento"));
      String relatorio = getServletContext().getRealPath("/WEB-INF") + "/ListaPratoPestabelecimento.jasper";
      JasperPrint jp = JasperFillManager.fillReport(relatorio, parametros, conexao);
      byte[] relat = JasperExportManager.exportReportToPdf(jp);
      response.setHeader("Content-Disposition", "attachment;filename=" + nomeRelatorio);
      response.setContentType("application/pdf");
      response.getOutputStream().write(relat);
    } catch (SQLException ex) {
      ex.printStackTrace();
    } catch (ClassNotFoundException ex) {
      ex.printStackTrace();
    } catch (JRException ex) {
      ex.printStackTrace();
    } catch (IOException ex) {
      ex.printStackTrace();
    } finally {
      try {
        DAO.fecharConexao(conexao, null);
      } catch (SQLException ex) {
        ex.printStackTrace();
      }
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
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
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
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
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
