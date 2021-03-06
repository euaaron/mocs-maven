/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.EstabelecimentoDAO;
import com.debron.mocs.dao.FuncionarioDAO;
import com.debron.mocs.model.Funcionario;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Débora & Aaron
 */
public class PesquisarFuncionarioController extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param req servlet request
   * @param res servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {

    String consultorId = req.getParameter("consultor");
    
    String estabelecimentoId = req.getParameter("fonte");
    
    final List<Funcionario> funcionarios = new ArrayList<>();
    List<Funcionario> temp = FuncionarioDAO.getInstancia().findAll();
    
    Predicate<Funcionario> porLugar = funcionario -> funcionario.getEstabelecimento().getId().equals(estabelecimentoId);
    
    if(estabelecimentoId != null) {
      temp.stream().filter(porLugar).forEach(funcionario -> funcionarios.add(funcionario));
    } else {
      temp.forEach(funcionario -> funcionarios.add(funcionario));
    }
    
    req.setAttribute("funcionarios", funcionarios);
    
    req.setAttribute(
            "estabelecimento", 
            EstabelecimentoDAO.getInstancia().findById(estabelecimentoId)
    );
    
    req.setAttribute("consultor", FuncionarioDAO.getInstancia().findById(consultorId));
    
    req.setAttribute("uriAnterior", req.getParameter("uriAtual"));

    req.getRequestDispatcher(
            "/pages/pesquisar/pesquisarFuncionario.jsp"
    ).forward(req, res);
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
