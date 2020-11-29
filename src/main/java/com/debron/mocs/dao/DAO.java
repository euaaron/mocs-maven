/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Aaron & Débora
 */
public class DAO {
  
  private DAO(){}

  public static Connection getConexao()
          throws ClassNotFoundException, SQLException {
    
    Class.forName("com.mysql.jdbc.Driver");
    
    String url = "jdbc:mysql://us-cdbr-east-02.cleardb.com:3306/heroku_e1fb7268a5ce6ae";
    
    return DriverManager.getConnection(url, "b6893baf2c505c", "13370d51");
  }

  public static void fecharConexao(Connection conexao, Statement comando)
          throws SQLException {
    if (comando != null) {
      comando.close();
    }
    if (conexao != null) {
      conexao.close();
    }
  }

}
