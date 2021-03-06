/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.UsuarioDAO;
import com.debron.mocs.model.Usuario;
import com.debron.mocs.utils.Crypto;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Aaron & Débora
 */
public class SessionController extends HttpServlet {

  private static final long serialVersionUID = 1L;
  String home = "/home.jsp";
  String login = "/login.jsp";

  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param req servlet request
   * @param res servlet response
   *
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {

    if (req.getSession(false) != null) {
      String action = req.getParameter("action");
      
      if (action != null && action.equalsIgnoreCase("logout")) {
        req.getSession().invalidate();
        req.getRequestDispatcher(login).forward(req, res);
      
      } else {
        HttpSession session=req.getSession();
        Usuario user = (Usuario) session.getAttribute("userSession");
        if(user != null) {
          req.getRequestDispatcher(home).forward(req, res);
        } else {
          req.getRequestDispatcher(login).forward(req, res);
        }
    }
    } else {
      req.getRequestDispatcher(login).forward(req, res);
    }

  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param req servlet request
   * @param res servlet response
   *
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    String email = req.getParameter("txtEmail");
    String senha = req.getParameter("txtSenha");
    
    String errormsg = "Email ou senha incorretos!";
    try {
      Usuario user = null;
      user = UsuarioDAO.getInstancia().findByEmail(email);

      if (user == null) {
        req.setAttribute("errorMsg", errormsg);
        req.getRequestDispatcher(login).forward(req, res);
      } else {
        Boolean validar = Crypto.checkPass(senha, user.getSenha());
        user.setSenha("");
        if (Boolean.TRUE.equals(validar)) {
          req.getSession().invalidate();
          HttpSession session = req.getSession(true);
          session.setAttribute("userSession", user);
          req.getRequestDispatcher(home).forward(req, res);
        } else {
          req.setAttribute("errorMsg", errormsg);
          req.getRequestDispatcher(login).forward(req, res);
        }
      }
      if (!res.isCommitted()) {
        req.setAttribute("errorMsg", errormsg);
        req.getRequestDispatcher(login).forward(req, res);
      }

    } catch (Exception e) {
      throw new ServletException(e);
    }
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Servlet que controla Login e Logout do sistema.";
  }// </editor-fold>

}
