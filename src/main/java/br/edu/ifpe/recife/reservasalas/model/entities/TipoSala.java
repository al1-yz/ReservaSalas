package br.edu.ifpe.recife.reservasalas.model.entities;

public enum TipoSala {

    SALA_DE_AULA("Sala de aula"),
    LABORATORIO("Laboratório"),
    AUDITORIO("Auditório");

    private final String descricao;

    TipoSala(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }
}
