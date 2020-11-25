/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import com.debron.mocs.model.Comanda;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author Aaron & Debora
 */
public class ComandaDAO {
  
  private static ComandaDAO instancia = new ComandaDAO();
  
  private ComandaDAO() {}
  
  public static ComandaDAO getInstancia() {
    return instancia;
  }
  
  public Comanda save(Comanda entity){
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
  
  public Comanda remove(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Comanda entity = null;
        try {
            entity = em.find(Comanda.class, id);
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
  
  public Comanda findById(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Comanda entity = null;
        try {
            entity = em.find(Comanda.class, id);
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entity;
    }
  
  public List<Comanda> findAll() {
        EntityManager em = new ConexaoFactory().getConexao();
        List<Comanda> entities = null;
        try {
            entities = em.createQuery("from Comanda c").getResultList();
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entities;
    }
  
}
