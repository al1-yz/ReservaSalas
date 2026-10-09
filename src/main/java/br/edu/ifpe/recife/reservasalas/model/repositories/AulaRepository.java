package br.edu.ifpe.recife.reservasalas.model.repositories;

import br.edu.ifpe.recife.reservasalas.model.entities.Aula;
import br.edu.ifpe.recife.reservasalas.model.entities.ItemEquipamento;
import java.util.ArrayList;
import java.util.List;

public class AulaRepository {

    private static List<Aula> aulas = new ArrayList<>();
    private static int proximoIdAula = 1;
    private static int proximoIdItem = 1;

    public static void create(Aula aula) {
        aula.setId(proximoIdAula++);
        for (ItemEquipamento item : aula.getItens()) {
            item.setId(proximoIdItem++);
        }
        aulas.add(aula);
    }

    public static void update(Aula aula) {

        for (Aula a : aulas) {
            if (a.getId() == aula.getId()) {
                a.setData(aula.getData());
                a.setHora(aula.getHora());
                a.setDuracao(aula.getDuracao());
                a.setSala(aula.getSala());
                for (ItemEquipamento item : aula.getItens()) {
                    item.setId(proximoIdItem++);
                }
                a.setItens(aula.getItens());
                return;
            }
        }

    }

    public static Aula read(int id) {
        for (Aula a : aulas) {
            if (a.getId() == id) {
                return a;
            }
        }
        return null;
    }

    public static void delete(Aula aula) {
        aulas.remove(aula);
    }

    public static List<Aula> readAll() {
        return aulas;
    }

    /**
     * Devolve a reserva que entra em conflito de horario com a informada
     * (mesma sala e data, horas sobrepostas), ou null se nao houver.
     * A propria reserva e ignorada pelo id, o que permite usar na edicao.
     */
    public static Aula readConflito(Aula aula) {
        for (Aula a : aulas) {
            if (a.getId() != aula.getId() && a.conflitaCom(aula)) {
                return a;
            }
        }
        return null;
    }

    public static boolean existeComSala(int idSala) {
        for (Aula a : aulas) {
            if (a.getSala().getId() == idSala) {
                return true;
            }
        }
        return false;
    }

    public static boolean existeComEquipamento(int idEquipamento) {
        for (Aula a : aulas) {
            for (ItemEquipamento item : a.getItens()) {
                if (item.getEquipamento().getId() == idEquipamento) {
                    return true;
                }
            }
        }
        return false;
    }
}
