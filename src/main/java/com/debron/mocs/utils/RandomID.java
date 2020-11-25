/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.utils;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

/**
 *
 * @author Aaron
 */
public class RandomID {

  private RandomID() {
    throw new IllegalStateException("UUID Utility class");
  }

  public static String generate() throws NoSuchAlgorithmException, UnsupportedEncodingException {
    return UUID.randomUUID().toString();
  }
}
