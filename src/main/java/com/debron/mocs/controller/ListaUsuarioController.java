/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.DAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
public class ListaUsuarioController extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {

    Connection conexao = null;
    try {
      DateFormat dateFormat = new SimpleDateFormat("ddMMyyyy-HHmmss");
      Date date = new Date();
      String nomeRelatorio = "ListaUsuario_" + dateFormat.format(date) + ".pdf";

      conexao = DAO.getConexao();

      HashMap parametros = new HashMap();

      String relatorio = getServletContext().getRealPath("/WEB-INF") + "/ListaUsuario.jasper";
      JasperPrint jp = JasperFillManager.fillReport(relatorio, parametros, conexao);
      
      byte[] relat = JasperExportManager.exportReportToPdf(jp);
      
      response.setHeader("Content-Disposition", "attachment;filename=" + nomeRelatorio);
      response.setContentType("application/pdf");
      response.getOutputStream().write(relat);
      
    } catch (JRException | ClassNotFoundException | SQLException | IOException ex) {
      throw new ServletException(ex);
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
