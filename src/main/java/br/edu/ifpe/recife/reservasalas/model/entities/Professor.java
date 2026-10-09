package br.edu.ifpe.recife.reservasalas.model.entities;

import java.util.ArrayList;
import java.util.List;

public class Professor {

    private int siape;
    private String nome;
    private String senha;

    private List<Aula> aulas;

    public Professor() {
        this.aulas = new ArrayList<>();
    }

    public int getSiape() {
        return siape;
    }

    public void setSiape(int siape) {
        this.siape = siape;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public List<Aula> getAulas() {
        return aulas;
    }

    public void setAulas(List<Aula> aulas) {
        this.aulas = aulas;
    }
}
