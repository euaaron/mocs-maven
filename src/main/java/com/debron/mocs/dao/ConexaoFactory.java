/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Aaron & Debora
 */
public class ConexaoFactory {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("mocsPU");
    
    public EntityManager getConexao() {
        return emf.createEntityManager();
    }
}
