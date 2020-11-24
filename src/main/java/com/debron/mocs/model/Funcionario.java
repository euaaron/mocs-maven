/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.debron.mocs.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

/**
 *
 * @author Aaron e Debora
 */
@Entity
public class Funcionario {

  
  @Id
  @GeneratedValue(strategy=GenerationType.IDENTITY)
  private Integer id;
  private Integer nivelPermissao;
  private Boolean statusConta;
  @OneToOne(targetEntity = Estabelecimento.class, fetch = FetchType.LAZY, cascade = CascadeType.ALL)
  @JoinColumn(name="estabelecimentoId")
  private Estabelecimento estabelecimento;
  @OneToOne(targetEntity = Usuario.class, fetch = FetchType.LAZY, cascade = CascadeType.ALL)
  @JoinColumn(name="usuarioId")
  private Usuario usuario;
  private String createdAt;
  private String updatedAt;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public Integer getNivelPermissao() {
    return nivelPermissao;
  }

  public void setNivelPermissao(Integer nivelPermissao) {
    this.nivelPermissao = nivelPermissao;
  }

  public Boolean getStatusConta() {
    return statusConta;
  }

  public void setStatusConta(Boolean statusConta) {
    this.statusConta = statusConta;
  }

  public Estabelecimento getEstabelecimento() {
    return estabelecimento;
  }

  public void setEstabelecimento(Estabelecimento estabelecimento) {
    this.estabelecimento = estabelecimento;
  }

  public Usuario getUsuario() {
    return usuario;
  }

  public void setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }

  public String getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(String createdAt) {
    this.createdAt = createdAt;
  }

  public String getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(String updatedAt) {
    this.updatedAt = updatedAt;
  }
  
  
}
