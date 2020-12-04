/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.UsuarioDAO;
import com.debron.mocs.model.Usuario;
import com.debron.mocs.utils.Crypto;
import com.debron.mocs.utils.RandomID;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Aaron & Debora
 */
public class ManterUsuarioController extends HttpServlet {

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
    String uriAnterior = req.getParameter("uriAtual");
    req.setAttribute("uriAnterior", uriAnterior);
    
    
    
    if (req.getSession(false) != null) {
      switch (acao) {
      case "prepararOperacao":
        prepararOperacao(req, res);
        break;
      default:
        confirmarOperacao(req, res);
        break;
    }
    } else {
      req.getRequestDispatcher("/").forward(req, res);
    }
  }

  public void prepararOperacao(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      req.setCharacterEncoding("utf-8");
      String operacao = req.getParameter("operacao");
      req.setAttribute("operacao", operacao);

      if (!operacao.equalsIgnoreCase("Incluir")) {
        String idUsuario = req.getParameter("id");
        Usuario usuario = UsuarioDAO.getInstancia().findById(idUsuario);
        req.setAttribute("usuario", usuario);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "/pages/cadastrar/cadastrarUsuario.jsp");
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

    String idUsuario = req.getParameter("txtIdUsuario");
    String nome = req.getParameter("txtNome");
    String cpf = req.getParameter("txtCpf");
    String dataNascimento = req.getParameter("txtDataNascimento");
    String email = req.getParameter("txtEmail");
    String telefone = req.getParameter("txtTelefone");
    String senha = req.getParameter("txtSenha");

    try {
      req.setCharacterEncoding("utf-8");
      if (operacao.equalsIgnoreCase("excluir")) {
        UsuarioDAO.getInstancia().remove(idUsuario);
      } else if (operacao.equalsIgnoreCase("incluir")) {

        String hoje = dateFormat.format(new Date());

        Usuario verificaEmail = UsuarioDAO.getInstancia().findByEmail(email);
        Usuario verificaCPF = UsuarioDAO.getInstancia().findByCPF(cpf);

        if (nome == null || cpf == null || dataNascimento == null || email == null || telefone == null || senha == null) {
          errorMsg.add("Não deixe nenhum campo vazio!");
        }

        if (verificaEmail != null) {
          errorMsg.add("E-mail já cadastrado no sistema!");
        }

        if (verificaCPF != null) {
          errorMsg.add("CPF já cadastrado no sistema!");
        }

        if (!errorMsg.isEmpty()) {
          req.setAttribute("errorMsg", errorMsg);
          req.getRequestDispatcher("/ManterUsuarioController?acao=prepararOperacao&operacao=Incluir").forward(req, res);
          return;
        } else {
          Usuario usuario = new Usuario();
          usuario.setId(RandomID.generate());
          usuario.setNome(nome);
          usuario.setCpf(cpf);
          usuario.setDataNascimento(dataNascimento);
          usuario.setEmail(email);
          usuario.setTelefone(telefone);
          usuario.setSenha(Crypto.encrypt(senha));
          usuario.setCreatedAt(hoje);
          usuario.setUpdatedAt(hoje);

          UsuarioDAO.getInstancia().save(usuario);
        }

      } else if (operacao.equalsIgnoreCase("editar")) {
        String hoje = dateFormat.format(new Date());

        Usuario verificaEmail = UsuarioDAO.getInstancia().findByEmail(email);
        Usuario verificaCPF = UsuarioDAO.getInstancia().findByCPF(cpf);
        Usuario usuario = UsuarioDAO.getInstancia().findById(idUsuario);

        if (nome == null || cpf == null || dataNascimento == null || email == null || telefone == null || senha == null) {
          errorMsg.add("Não deixe nenhum campo vazio!");
        }

        if (verificaEmail != null && verificaEmail.getEmail().equalsIgnoreCase(usuario.getEmail()) && !usuario.getEmail().equalsIgnoreCase(email)) {
          errorMsg.add("E-mail já cadastrado no sistema!");
        }

        if (verificaCPF != null && verificaCPF.getCpf().equalsIgnoreCase(usuario.getCpf()) && !usuario.getCpf().equalsIgnoreCase(cpf)) {
          errorMsg.add("CPF já cadastrado no sistema!");
        }

        if (!errorMsg.isEmpty()) {
          req.setAttribute("errorMsg", errorMsg);
          req.getRequestDispatcher(
                  "/ManterUsuarioController?acao=prepararOperacao&operacao=Editar&id="
                  + idUsuario
          ).forward(req, res);
          return;
        } else {
          usuario.setNome(nome);
          usuario.setCpf(cpf);
          usuario.setDataNascimento(dataNascimento);
          usuario.setEmail(email);
          usuario.setTelefone(telefone);
          usuario.setSenha(Crypto.encrypt(senha));
          usuario.setUpdatedAt(hoje);

          UsuarioDAO.getInstancia().save(usuario);
        }

      }
      RequestDispatcher view = req.getRequestDispatcher(
              "PesquisarUsuarioController");
      view.forward(req, res);
    } catch (IOException | NoSuchAlgorithmException e) {
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
   * @param req servlet request
   * @param res servlet response
   *
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
