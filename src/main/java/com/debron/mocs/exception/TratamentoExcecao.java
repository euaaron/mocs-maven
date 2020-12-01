/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.exception;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Aaron
 */
public class TratamentoExcecao extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
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

        Throwable excecao = (Throwable) request.getAttribute("javax.servlet.error.exception");
        Integer codigoStatus = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String nomeServlet = (String) request.getAttribute("javax.servlet.error.servlet_name");
        String uriDestino = (String) request.getAttribute("javax.servlet.error.request_uri");
        
        if (nomeServlet == null) {
          nomeServlet = "Desconhecido";  
        } 
        
        if (uriDestino == null) {
            uriDestino = "Desconhecido";
        }
        
        request.setAttribute("excecao", excecao);
        request.setAttribute("nomeServlet", nomeServlet);
        request.setAttribute("codigoStatus", codigoStatus);
        request.setAttribute("uriDestino", uriDestino);
        
        if (!response.isCommitted()){
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
