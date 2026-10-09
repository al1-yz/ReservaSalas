package br.edu.ifpe.recife.reservasalas.controllers;

import br.edu.ifpe.recife.reservasalas.model.entities.Aula;
import br.edu.ifpe.recife.reservasalas.model.entities.Equipamento;
import br.edu.ifpe.recife.reservasalas.model.entities.ItemEquipamento;
import br.edu.ifpe.recife.reservasalas.model.entities.Professor;
import br.edu.ifpe.recife.reservasalas.model.repositories.AulaRepository;
import br.edu.ifpe.recife.reservasalas.model.repositories.EquipamentoRepository;
import br.edu.ifpe.recife.reservasalas.model.repositories.SalaRepository;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Reserva de salas pelo professor logado: reservar, editar e cancelar.
 * Cada professor so altera ou cancela as proprias reservas (validado aqui, no Servlet).
 */
@WebServlet(name = "AulaController", urlPatterns = {"/Aulas"})
public class AulaController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Professor professor = (Professor) session.getAttribute("professorLogado");

        if (professor == null) {
            response.sendRedirect("loginProfessor.jsp");
            return;
        }

        String op = request.getParameter("operacao");

        if (op != null && op.equals("editar")) {

            Aula aula = lerAula(request.getParameter("id"));
            String motivo = verificarResponsavel(professor, aula);

            if (motivo != null) {
                session.setAttribute("msg", motivo);
                response.sendRedirect("indexProfessor.jsp");
            } else {
                session.setAttribute("aula", aula);
                response.sendRedirect("ReservarSala.jsp");
            }

            return;
        }

        if (op != null && op.equals("cancelar")) {

            Aula aula = lerAula(request.getParameter("id"));
            String motivo = verificarResponsavel(professor, aula);

            if (motivo != null) {
                session.setAttribute("msg", motivo);
            } else {
                AulaRepository.delete(aula);
                professor.getAulas().remove(aula);
                session.setAttribute("msg", "Reserva cancelada com sucesso!");
            }

            response.sendRedirect("indexProfessor.jsp");

            return;
        }

        response.sendRedirect("indexProfessor.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Professor professor = (Professor) session.getAttribute("professorLogado");

        if (professor == null) {
            response.sendRedirect("loginProfessor.jsp");
            return;
        }

        String op = request.getParameter("operacao");
        boolean editando = op != null && op.equals("editar");

        // reserva montada com os dados do formulario
        Aula aula = new Aula();

        if (editando) {

            Aula existente = lerAula(request.getParameter("id"));
            String motivo = verificarResponsavel(professor, existente);

            if (motivo != null) {
                session.setAttribute("msg", motivo);
                response.sendRedirect("indexProfessor.jsp");
                return;
            }

            aula.setId(existente.getId());
        }

        aula.setSala(SalaRepository.read(lerInteiro(request.getParameter("salaId"))));
        aula.setData(lerData(request.getParameter("data")));
        aula.setHora(lerInteiro(request.getParameter("hora")));
        aula.setDuracao(lerInteiro(request.getParameter("duracao")));

        // equipamentos sao opcionais: so viram item os que tem quantidade maior que zero
        boolean quantidadeInvalida = false;

        for (Equipamento e : EquipamentoRepository.readAll()) {

            String texto = request.getParameter("qtd_" + e.getId());

            if (texto == null || texto.isBlank()) {
                continue;
            }

            int quantidade = lerInteiro(texto);

            if (quantidade < 0) {
                quantidadeInvalida = true;
            } else if (quantidade > 0) {
                ItemEquipamento item = new ItemEquipamento();
                item.setEquipamento(e);
                item.setQuantidadeUsada(quantidade);
                aula.getItens().add(item);
            }
        }

        String erro = null;

        if (aula.getSala() == null) {
            erro = "Escolha uma sala válida.";
        } else if (aula.getData() == null) {
            erro = "Informe uma data válida.";
        } else if (aula.getHora() < 0 || aula.getHora() > 23) {
            erro = "A hora de início deve estar entre 0 e 23.";
        } else if (aula.getDuracao() < 1 || aula.getDuracao() > 24 || aula.getHoraFim() > 24) {
            erro = "A duração deve ser de pelo menos 1 hora e a reserva deve terminar até as 24h.";
        } else if (quantidadeInvalida) {
            erro = "A quantidade de cada equipamento deve ser um número inteiro, zero ou maior.";
        } else {

            Aula conflito = AulaRepository.readConflito(aula);

            if (conflito != null) {
                erro = "A sala " + conflito.getSala().getNome() + " já está reservada em "
                        + conflito.getDataFormatada() + ", das " + conflito.getHora() + "h às "
                        + conflito.getHoraFim() + "h.";
            }
        }

        if (erro != null) {
            // volta ao formulario com o que foi digitado
            session.setAttribute("msg", erro);
            session.setAttribute("aula", aula);
            response.sendRedirect("ReservarSala.jsp");
            return;
        }

        if (editando) {

            // a reserva guardada e a mesma que esta na lista do professor
            AulaRepository.update(aula);

            session.setAttribute("msg", "Reserva alterada com sucesso!");

        } else {

            AulaRepository.create(aula);
            professor.getAulas().add(aula);

            session.setAttribute("msg", "Sala reservada com sucesso!");
        }

        response.sendRedirect("indexProfessor.jsp");

    }

    private Aula lerAula(String id) {
        return AulaRepository.read(lerInteiro(id));
    }

    // devolve o motivo de o professor nao poder mexer na reserva, ou null se ele e o responsavel
    private String verificarResponsavel(Professor professor, Aula aula) {

        if (aula == null) {
            return "Reserva não encontrada.";
        }

        if (!professor.getAulas().contains(aula)) {
            return "Você só pode alterar ou cancelar as suas próprias reservas.";
        }

        return null;
    }

    // -1 indica valor ausente, nao numerico ou negativo
    private int lerInteiro(String texto) {

        if (texto == null) {
            return -1;
        }

        try {
            int valor = Integer.parseInt(texto.trim());
            return valor < 0 ? -1 : valor;
        } catch (NumberFormatException ex) {
            return -1;
        }
    }

    // formato enviado pelo campo <input type="date">
    private Date lerData(String texto) {

        if (texto == null || texto.isBlank()) {
            return null;
        }

        try {
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            formato.setLenient(false);
            return formato.parse(texto.trim());
        } catch (ParseException ex) {
            return null;
        }
    }

    @Override
    public String getServletInfo() {
        return "Reservar, editar e cancelar reservas de salas";
    }
}
