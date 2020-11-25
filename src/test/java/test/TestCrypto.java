/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import com.debron.mocs.utils.Crypto;

/**
 *
 * @author Aaron
 */
public class TestCrypto {
  public static void main(String[] args) {
    String senha = "123456";
    String senhaCodificada = "$2a$10$r9yj6rus.1ED8vHEjFCm8ueEurGTSoOa1acuoXUNDN1RzVOK9t4YO";
    
    if(Crypto.checkPass(senha, senhaCodificada)){
      System.err.println("=========== Confere ============");
    }
  }
}
