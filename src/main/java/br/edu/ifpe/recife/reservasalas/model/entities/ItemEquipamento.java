package br.edu.ifpe.recife.reservasalas.model.entities;

public class ItemEquipamento {

    private int id;
    private int quantidadeUsada;

    private Equipamento equipamento;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantidadeUsada() {
        return quantidadeUsada;
    }

    public void setQuantidadeUsada(int quantidadeUsada) {
        this.quantidadeUsada = quantidadeUsada;
    }

    public Equipamento getEquipamento() {
        return equipamento;
    }

    public void setEquipamento(Equipamento equipamento) {
        this.equipamento = equipamento;
    }
}
