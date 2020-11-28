/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

/**
 *
 * @author Aaron & Débora
 */
@Entity
public class EnderecosUsuario {
  
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private String id;
  
  @OneToOne
  private Usuario usuario;
  
  @OneToOne
  private Endereco endereco;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public Usuario getUsuario() {
    return usuario;
  }

  public void setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }

  public Endereco getEndereco() {
    return endereco;
  }

  public void setEndereco(Endereco endereco) {
    this.endereco = endereco;
  }
  
  
}
