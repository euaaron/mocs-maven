/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.controller;

import com.debron.mocs.dao.EstabelecimentoDAO;
import com.debron.mocs.dao.PratoDAO;
import com.debron.mocs.model.Prato;
import com.debron.mocs.utils.RandomID;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Débora
 */
public class ManterPratoController extends HttpServlet {

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
    
    String fonte = req.getParameter("fonte");
    
    req.setAttribute("estabelecimento", 
            EstabelecimentoDAO.getInstancia().findById(fonte)
    );
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
        String idPrato = req.getParameter("id");
        Prato prato = PratoDAO.getInstancia().findById(idPrato);
        req.setAttribute("prato", prato);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "/pages/cadastrar/cadastrarPrato.jsp");
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

    String idPrato = req.getParameter("txtIdPrato");
    String idEstabelecimento = req.getParameter("txtIdEstabelecimento");
    String nome = req.getParameter("txtNome");
    String descricao = req.getParameter("txtDescricao");
    Integer exibir = Integer.parseInt(req.getParameter("txtExibir"));
    String imgUrl = req.getParameter("txtImgUrl");
    float preco = Float.parseFloat(req.getParameter("txtPreco"));

    try {
      if (operacao.equalsIgnoreCase("excluir")) {
        PratoDAO.getInstancia().remove(idPrato);
      } else if (operacao.equalsIgnoreCase("incluir")) {

        String hoje = dateFormat.format(new Date());

        Prato prato = new Prato();
        prato.setId(RandomID.generate());
        prato.setEstabelecimento(EstabelecimentoDAO
                .getInstancia().findById(idEstabelecimento));
        prato.setNome(nome);
        prato.setDescricao(descricao);
        prato.setExibir(exibir);
        prato.setImagemUrl(imgUrl);
        prato.setPreco(preco);
        prato.setCreatedAt(hoje);
        prato.setUpdatedAt(hoje);

        PratoDAO.getInstancia().save(prato);

      } else if (operacao.equalsIgnoreCase("editar")) {
        String hoje = dateFormat.format(new Date());

        Prato prato = PratoDAO.getInstancia().findById(idPrato);
        prato.setNome(nome);
        prato.setDescricao(descricao);
        prato.setExibir(exibir);
        prato.setImagemUrl(imgUrl);
        prato.setPreco(preco);
        prato.setUpdatedAt(hoje);
        PratoDAO.getInstancia().save(prato);
      }
      RequestDispatcher view = req.getRequestDispatcher(
              "PesquisarPratoController");
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
