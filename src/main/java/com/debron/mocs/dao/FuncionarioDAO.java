/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import com.debron.mocs.model.Funcionario;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author Aaron & Debora
 */
public class FuncionarioDAO {
  
  private static FuncionarioDAO instancia = new FuncionarioDAO();
  
  private FuncionarioDAO() {}
  
  public static FuncionarioDAO getInstancia() {
    return instancia;
  }
  
  public Funcionario save(Funcionario entity){
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
  
  public Funcionario remove(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Funcionario entity = null;
        try {
            entity = em.find(Funcionario.class, id);
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
  
  public Funcionario findById(String id) {
        EntityManager em = new ConexaoFactory().getConexao();
        Funcionario entity = null;
        try {
            entity = em.find(Funcionario.class, id);
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entity;
    }
  
  public List<Funcionario> findAll() {
        EntityManager em = new ConexaoFactory().getConexao();
        List<Funcionario> entities = null;
        try {
            entities = em.createQuery("from Funcionario f").getResultList();
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            em.close();
        }
        return entities;
    }
  
}
