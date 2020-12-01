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
import com.debron.mocs.model.Endereco;
import com.debron.mocs.model.Estabelecimento;
import com.debron.mocs.model.Funcionario;
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
 * @author Aaron & Débora
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
      case "manterEndereco":
        manterEndereco(req, res);
        break;
      default:
        confirmarOperacao(req, res);
        break;
    }
  }

  public void manterEndereco(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {

    System.out.println("Deu");

  }

  public void prepararOperacao(HttpServletRequest req, HttpServletResponse res)
          throws ServletException, IOException {
    try {
      String operacao = req.getParameter("operacao");
      String uriAnterior = req.getParameter("page");
      req.setAttribute("uriAnterior", uriAnterior);
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
    String cnpj = req.getParameter("txtCnpj");
    String inscEstadual = req.getParameter("txtInscEstadual");
    String nomeFantasia = req.getParameter("txtNomeFantasia");
    String telefone = req.getParameter("txtTelefone");
    String proprietario = req.getParameter("txtProprietarioId");

    String cep = req.getParameter("txtCEP");
    String uf = req.getParameter("txtUF");
    String cidade = req.getParameter("txtCidade");
    String bairro = req.getParameter("txtBairro");
    String rua = req.getParameter("txtLogradouro");
    String num = req.getParameter("txtEdificio");
    String complemento = req.getParameter("txtComplemento");

    try {
      if (operacao.equalsIgnoreCase("excluir")) {
        FuncionarioDAO.getInstancia().removeAllFrom(idEstabelecimento);
        EstabelecimentoDAO.getInstancia().remove(idEstabelecimento);
      } else if (operacao.equalsIgnoreCase("incluir")) {

        String hoje = dateFormat.format(new Date());

        Endereco endereco = new Endereco();
        endereco.setId(RandomID.generate());
        endereco.setLogradouro(rua);
        endereco.setBairro(bairro);
        endereco.setCep(cep);
        endereco.setComplemento(complemento);
        endereco.setCidade(cidade);
        endereco.setEdificio(num);
        endereco.setUf(uf);
        endereco.setCreatedAt(hoje);
        endereco.setUpdatedAt(hoje);

        EnderecoDAO.getInstancia().save(endereco);

        Estabelecimento estabelecimento = new Estabelecimento();
        estabelecimento.setEndereco(endereco);
        estabelecimento.setId(RandomID.generate());
        estabelecimento.setNomeFantasia(nomeFantasia);
        estabelecimento.setCnpj(cnpj);
        estabelecimento.setInscEstadual(inscEstadual);
        estabelecimento.setTelefone(telefone);
        estabelecimento.setCreatedAt(hoje);
        estabelecimento.setUpdatedAt(hoje);

        EstabelecimentoDAO.getInstancia().save(estabelecimento);

        Funcionario administrador = new Funcionario();
        administrador.setCreatedAt(hoje);
        administrador.setUpdatedAt(hoje);
        administrador.setNivelPermissao(0);
        administrador.setStatusConta(Boolean.TRUE);
        administrador.setEstabelecimento(estabelecimento);
        administrador.setUsuario(UsuarioDAO.getInstancia().findById(proprietario));
        
        FuncionarioDAO.getInstancia().save(administrador);

      } else if (operacao.equalsIgnoreCase("editar")) {
        String hoje = dateFormat.format(new Date());

        Estabelecimento estabelecimento = EstabelecimentoDAO.getInstancia().findById(idEstabelecimento);

        Endereco endereco = estabelecimento.getEndereco();

        endereco.setLogradouro(rua);
        endereco.setBairro(bairro);
        endereco.setCep(cep);
        endereco.setComplemento(complemento);
        endereco.setCidade(cidade);
        endereco.setEdificio(num);
        endereco.setUf(uf);
        endereco.setUpdatedAt(hoje);

        EnderecoDAO.getInstancia().save(endereco);

        estabelecimento.setEndereco(endereco);
        estabelecimento.setNomeFantasia(nomeFantasia);
        estabelecimento.setCnpj(cnpj);
        estabelecimento.setInscEstadual(inscEstadual);
        estabelecimento.setTelefone(telefone);
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
   * @param request servlet request
   * @param response servlet response
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
   * @param request servlet request
   * @param response servlet response
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
