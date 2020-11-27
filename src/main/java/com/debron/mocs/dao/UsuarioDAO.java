/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import com.debron.mocs.model.Usuario;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author Aaron & Debora
 */
public class UsuarioDAO {

  private static UsuarioDAO instancia = new UsuarioDAO();

  private UsuarioDAO() {
  }

  public static UsuarioDAO getInstancia() {
    return instancia;
  }

  public Usuario save(Usuario entity) {
    EntityManager em = new ConexaoFactory().getConexao();
    try {
      em.getTransaction().begin();
      if (entity.getId() == null) {
        em.persist(entity);
      } else {
        em.merge(entity);
      }
      em.getTransaction().commit();
    } catch (Exception e) {
      em.getTransaction().rollback();
      System.err.println(e);
    } finally {
      em.close();
    }
    return entity;
  }

  public Usuario remove(String id) {
    EntityManager em = new ConexaoFactory().getConexao();
    Usuario entity = null;
    try {
      entity = em.find(Usuario.class, id);
      em.getTransaction().begin();
      em.remove(entity);
      em.getTransaction().commit();
    } catch (Exception e) {
      em.getTransaction().rollback();
      System.err.println(e);
    } finally {
      em.close();
    }
    return entity;
  }

  public Usuario findById(String id) {
    EntityManager em = new ConexaoFactory().getConexao();
    Usuario entity = null;
    try {
      entity = em.find(Usuario.class, id);
    } catch (Exception e) {
      System.err.println(e);
    } finally {
      em.close();
    }
    return entity;
  }

  public Usuario findByCPF(String cpf) {
    Usuario entity = null;
    EntityManager em = new ConexaoFactory().getConexao();
    em.setProperty("cpfnum", cpf);
    try {
      entity = (Usuario) em
              .createQuery("FROM Usuario u WHERE 'u.CPF' = :cpfnum")
              .getSingleResult();

    } catch (Exception e) {
      System.err.println(e);
    } finally {
      em.close();
    }
    return entity;
  }

  public Usuario findByEmail(String email) {
    EntityManager em = new ConexaoFactory().getConexao();
    Usuario entity = null;
    em.setProperty("email", email);
    try {
      entity = (Usuario) em.createNativeQuery(
              "SELECT * FROM Usuario u WHERE u.EMAIL = '" + email + "'",
              Usuario.class
      ).getSingleResult();
    } catch (Exception e) {
      System.err.println(e);
    } finally {
      em.close();
    }
    return entity;
  }

  public List<Usuario> findAll() {
    EntityManager em = new ConexaoFactory().getConexao();
    List<Usuario> entities = null;
    try {
      entities = em.createQuery("from Usuario u").getResultList();
    } catch (Exception e) {
      System.err.println(e);
    } finally {
      em.close();
    }
    return entities;
  }

}
