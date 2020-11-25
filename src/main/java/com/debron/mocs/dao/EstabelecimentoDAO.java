/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import com.debron.mocs.model.Estabelecimento;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author Aaron & Debora
 */
public class EstabelecimentoDAO {
  
  private static EstabelecimentoDAO instancia = new EstabelecimentoDAO();
  
  private EstabelecimentoDAO() {}
  
  public static EstabelecimentoDAO getInstancia() {
    return instancia;
  }
  
  public Estabelecimento save(Estabelecimento entity){
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
  
  public Estabelecimento remove(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Estabelecimento entity = null;
        try {
            entity = em.find(Estabelecimento.class, id);
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
  
  public Estabelecimento findById(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Estabelecimento entity = null;
        try {
            entity = em.find(Estabelecimento.class, id);
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entity;
    }
  
  public List<Estabelecimento> findAll() {
        EntityManager em = new ConexaoFactory().getConexao();
        List<Estabelecimento> entities = null;
        try {
            entities = em.createQuery("from Estabelecimento e").getResultList();
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entities;
    }
  
}
