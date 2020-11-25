/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.utils;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Aaron
 */
public class Crypto {
  
  private Crypto() {
    throw new IllegalStateException("Crypto Utility class");
  }
  
  public static String encrypt(String pass) throws NoSuchAlgorithmException, UnsupportedEncodingException{
    return BCrypt.hashpw(pass, BCrypt.gensalt());
  }
  
  public static Boolean checkPass(String defaultPass, String cryptoPass) {
    return BCrypt.checkpw(defaultPass, cryptoPass);
  }
  
}
