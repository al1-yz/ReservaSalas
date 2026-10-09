package br.edu.ifpe.recife.reservasalas.model.repositories;

import br.edu.ifpe.recife.reservasalas.model.entities.Equipamento;
import java.util.ArrayList;
import java.util.List;

public class EquipamentoRepository {

    private static List<Equipamento> equipamentos;
    private static int proximoId = 1;

    static {
        equipamentos = new ArrayList<>();

        Equipamento e = new Equipamento();
        e.setNome("Projetor");
        e.setMarca("Epson");
        e.setTipo("Multimídia");
        e.setUtilidade("Exibir apresentações e vídeos");
        create(e);

        e = new Equipamento();
        e.setNome("Notebook");
        e.setMarca("Dell");
        e.setTipo("Computador");
        e.setUtilidade("Aulas práticas e apresentações");
        create(e);

        e = new Equipamento();
        e.setNome("Caixa de som");
        e.setMarca("JBL");
        e.setTipo("Áudio");
        e.setUtilidade("Amplificar o som em salas grandes");
        create(e);

        e = new Equipamento();
        e.setNome("Microfone sem fio");
        e.setMarca("Shure");
        e.setTipo("Áudio");
        e.setUtilidade("Captar a voz em auditórios");
        create(e);
    }

    public static void create(Equipamento equipamento) {
        equipamento.setId(proximoId++);
        equipamentos.add(equipamento);
    }

    public static void update(Equipamento equipamento) {

        for (Equipamento e : equipamentos) {
            if (e.getId() == equipamento.getId()) {
                e.setNome(equipamento.getNome());
                e.setMarca(equipamento.getMarca());
                e.setTipo(equipamento.getTipo());
                e.setUtilidade(equipamento.getUtilidade());
                return;
            }
        }

    }

    public static Equipamento read(int id) {
        for (Equipamento e : equipamentos) {
            if (e.getId() == id) {
                return e;
            }
        }
        return null;
    }

    public static void delete(Equipamento equipamento) {
        equipamentos.remove(equipamento);
    }

    public static List<Equipamento> readAll() {
        return equipamentos;
    }
}
