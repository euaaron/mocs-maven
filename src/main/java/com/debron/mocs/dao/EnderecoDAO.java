/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import com.debron.mocs.model.Endereco;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author Aaron & Debora
 */
public class EnderecoDAO {
  
  private static EnderecoDAO instancia = new EnderecoDAO();
  
  private EnderecoDAO() {}
  
  public static EnderecoDAO getInstancia() {
    return instancia;
  }
  
  public Endereco save(Endereco entity){
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
  
  public Endereco remove(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Endereco entity = null;
        try {
            entity = em.find(Endereco.class, id);
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
  
  public Endereco findById(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Endereco entity = null;
        try {
            entity = em.find(Endereco.class, id);
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entity;
    }
  
  public List<Endereco> findAll() {
        EntityManager em = new ConexaoFactory().getConexao();
        List<Endereco> entities = null;
        try {
            entities = em.createQuery("from Endereco e").getResultList();
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entities;
    }
  
}
