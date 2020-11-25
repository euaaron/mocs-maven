/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import com.debron.mocs.model.Pedido;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author Aaron & Debora
 */
public class PedidoDAO {
  
  private static PedidoDAO instancia = new PedidoDAO();
  
  private PedidoDAO() {}
  
  public static PedidoDAO getInstancia() {
    return instancia;
  }
  
  public Pedido save(Pedido entity){
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
  
  public Pedido remove(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Pedido entity = null;
        try {
            entity = em.find(Pedido.class, id);
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
  
  public Pedido findById(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Pedido entity = null;
        try {
            entity = em.find(Pedido.class, id);
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entity;
    }
  
  public List<Pedido> findAll() {
        EntityManager em = new ConexaoFactory().getConexao();
        List<Pedido> entities = null;
        try {
            entities = em.createQuery("from Pedido p").getResultList();
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entities;
    }
  
}
