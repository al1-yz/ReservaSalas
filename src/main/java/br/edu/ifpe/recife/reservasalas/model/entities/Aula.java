package br.edu.ifpe.recife.reservasalas.model.entities;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Registro de uma reserva de sala feita por um professor.
 */
public class Aula {

    private int id;
    private Date data;
    private int hora;
    private int duracao;

    private Sala sala;
    private List<ItemEquipamento> itens;

    public Aula() {
        this.itens = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public int getHora() {
        return hora;
    }

    public void setHora(int hora) {
        this.hora = hora;
    }

    public int getDuracao() {
        return duracao;
    }

    public void setDuracao(int duracao) {
        this.duracao = duracao;
    }

    public Sala getSala() {
        return sala;
    }

    public void setSala(Sala sala) {
        this.sala = sala;
    }

    public List<ItemEquipamento> getItens() {
        return itens;
    }

    public void setItens(List<ItemEquipamento> itens) {
        this.itens = itens;
    }

    public String getDataFormatada() {
        if (this.data == null) {
            return "";
        }
        return new SimpleDateFormat("dd/MM/yyyy").format(this.data);
    }

    // formato esperado pelo campo <input type="date">
    public String getDataIso() {
        if (this.data == null) {
            return "";
        }
        return new SimpleDateFormat("yyyy-MM-dd").format(this.data);
    }

    public int getHoraFim() {
        return this.hora + this.duracao;
    }

    public int getQuantidadeDe(int idEquipamento) {
        for (ItemEquipamento item : this.itens) {
            if (item.getEquipamento().getId() == idEquipamento) {
                return item.getQuantidadeUsada();
            }
        }
        return 0;
    }

    // mesma sala, mesmo dia e intervalos de horas que se sobrepõem
    public boolean conflitaCom(Aula outra) {
        return this.sala.getId() == outra.sala.getId()
                && this.getDataIso().equals(outra.getDataIso())
                && this.hora < outra.getHoraFim()
                && outra.hora < this.getHoraFim();
    }
}
