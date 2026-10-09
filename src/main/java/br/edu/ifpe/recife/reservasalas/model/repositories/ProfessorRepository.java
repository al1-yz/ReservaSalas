package br.edu.ifpe.recife.reservasalas.model.repositories;

import br.edu.ifpe.recife.reservasalas.model.entities.Aula;
import br.edu.ifpe.recife.reservasalas.model.entities.ItemEquipamento;
import br.edu.ifpe.recife.reservasalas.model.entities.Professor;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class ProfessorRepository {

    private static List<Professor> professores;

    static {
        professores = new ArrayList<>();

        Professor ana = new Professor();
        ana.setSiape(1001);
        ana.setNome("Ana Souza");
        ana.setSenha("123");
        professores.add(ana);

        Professor carlos = new Professor();
        carlos.setSiape(1002);
        carlos.setNome("Carlos Lima");
        carlos.setSenha("123");
        professores.add(carlos);

        /*
         Reservas iniciais: cada uma e criada no AulaRepository e tambem ligada
         ao professor (a lista de aulas dele), como o EntregadorRepository faz
         com a lista de entregadores da loja. Ficam aqui para que ja existam
         assim que o primeiro professor for carregado.
        */
        Calendar amanha = Calendar.getInstance();
        amanha.add(Calendar.DAY_OF_MONTH, 1);

        Calendar depoisDeAmanha = Calendar.getInstance();
        depoisDeAmanha.add(Calendar.DAY_OF_MONTH, 2);

        Aula a = new Aula();
        a.setData(amanha.getTime());
        a.setHora(8);
        a.setDuracao(2);
        a.setSala(SalaRepository.readAll().get(0));
        a.getItens().add(item(0, 1));
        AulaRepository.create(a);
        ana.getAulas().add(a);

        a = new Aula();
        a.setData(depoisDeAmanha.getTime());
        a.setHora(14);
        a.setDuracao(3);
        a.setSala(SalaRepository.readAll().get(2));
        a.getItens().add(item(1, 20));
        a.getItens().add(item(0, 1));
        AulaRepository.create(a);
        ana.getAulas().add(a);

        a = new Aula();
        a.setData(amanha.getTime());
        a.setHora(10);
        a.setDuracao(2);
        a.setSala(SalaRepository.readAll().get(3));
        a.getItens().add(item(3, 2));
        a.getItens().add(item(2, 1));
        AulaRepository.create(a);
        carlos.getAulas().add(a);

        // reserva sem equipamentos (os itens sao opcionais)
        a = new Aula();
        a.setData(depoisDeAmanha.getTime());
        a.setHora(8);
        a.setDuracao(1);
        a.setSala(SalaRepository.readAll().get(1));
        AulaRepository.create(a);
        carlos.getAulas().add(a);
    }

    private static ItemEquipamento item(int indiceEquipamento, int quantidade) {
        ItemEquipamento item = new ItemEquipamento();
        item.setEquipamento(EquipamentoRepository.readAll().get(indiceEquipamento));
        item.setQuantidadeUsada(quantidade);
        return item;
    }

    public static void create(Professor professor) {
        professores.add(professor);
    }

    public static Professor read(int siape) {
        for (Professor p : professores) {
            if (p.getSiape() == siape) {
                return p;
            }
        }
        return null;
    }

    public static List<Professor> readAll() {
        return professores;
    }
}
