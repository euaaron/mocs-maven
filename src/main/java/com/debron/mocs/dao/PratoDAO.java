/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import com.debron.mocs.model.Prato;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author Aaron & Debora
 */
public class PratoDAO {
  
  private static PratoDAO instancia = new PratoDAO();
  
  private PratoDAO() {}
  
  public static PratoDAO getInstancia() {
    return instancia;
  }
  
  public Prato save(Prato entity){
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
  
  public Prato remove(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Prato entity = null;
        try {
            entity = em.find(Prato.class, id);
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
  
  public Prato findById(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Prato entity = null;
        try {
            entity = em.find(Prato.class, id);
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entity;
    }
  
  public List<Prato> findAll() {
        EntityManager em = new ConexaoFactory().getConexao();
        List<Prato> entities = null;
        try {
            entities = em.createQuery("from Prato p").getResultList();
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entities;
    }
  
}
