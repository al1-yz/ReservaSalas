package br.edu.ifpe.recife.reservasalas.model.repositories;

import br.edu.ifpe.recife.reservasalas.model.entities.Sala;
import br.edu.ifpe.recife.reservasalas.model.entities.TipoSala;
import java.util.ArrayList;
import java.util.List;

public class SalaRepository {

    private static List<Sala> salas;
    private static int proximoId = 1;

    static {
        salas = new ArrayList<>();

        Sala s = new Sala();
        s.setNome("Sala 101");
        s.setLocalizacao("Bloco A - 1º andar");
        s.setCapacidade(40);
        s.setTipo(TipoSala.SALA_DE_AULA);
        create(s);

        s = new Sala();
        s.setNome("Sala 102");
        s.setLocalizacao("Bloco A - 1º andar");
        s.setCapacidade(35);
        s.setTipo(TipoSala.SALA_DE_AULA);
        create(s);

        s = new Sala();
        s.setNome("Laboratório de Informática 1");
        s.setLocalizacao("Bloco B - térreo");
        s.setCapacidade(30);
        s.setTipo(TipoSala.LABORATORIO);
        create(s);

        s = new Sala();
        s.setNome("Auditório Central");
        s.setLocalizacao("Bloco C");
        s.setCapacidade(120);
        s.setTipo(TipoSala.AUDITORIO);
        create(s);
    }

    public static void create(Sala sala) {
        sala.setId(proximoId++);
        salas.add(sala);
    }

    public static void update(Sala sala) {

        for (Sala s : salas) {
            if (s.getId() == sala.getId()) {
                s.setNome(sala.getNome());
                s.setLocalizacao(sala.getLocalizacao());
                s.setCapacidade(sala.getCapacidade());
                s.setTipo(sala.getTipo());
                return;
            }
        }

    }

    public static Sala read(int id) {
        for (Sala s : salas) {
            if (s.getId() == id) {
                return s;
            }
        }
        return null;
    }

    public static void delete(Sala sala) {
        salas.remove(sala);
    }

    public static List<Sala> readAll() {
        return salas;
    }
}
