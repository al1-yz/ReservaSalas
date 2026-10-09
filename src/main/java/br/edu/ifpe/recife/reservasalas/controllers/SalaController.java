package br.edu.ifpe.recife.reservasalas.controllers;

import br.edu.ifpe.recife.reservasalas.model.entities.Sala;
import br.edu.ifpe.recife.reservasalas.model.entities.TipoSala;
import br.edu.ifpe.recife.reservasalas.model.repositories.AulaRepository;
import br.edu.ifpe.recife.reservasalas.model.repositories.SalaRepository;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * CRUD de Sala. A listagem é feita por Salas.jsp (tag CarregaSalas).
 */
@WebServlet(name = "SalaController", urlPatterns = {"/Salas"})
public class SalaController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("professorLogado") == null) {
            response.sendRedirect("loginProfessor.jsp");
            return;
        }

        String op = request.getParameter("operacao");

        if (op != null && op.equals("editar")) {

            Sala s = lerSala(request.getParameter("id"));

            if (s == null) {
                session.setAttribute("msg", "Sala não encontrada.");
            } else if (s.isFixa()) {
                session.setAttribute("msg", "A sala " + s.getNome() + " é fixa e não pode ser editada.");
            } else {
                session.setAttribute("sala", s);
            }

            response.sendRedirect("Salas.jsp");

            return;
        }

        if (op != null && op.equals("deletar")) {

            Sala s = lerSala(request.getParameter("id"));

            if (s == null) {
                session.setAttribute("msg", "Sala não encontrada.");
            } else if (AulaRepository.existeComSala(s.getId())) {
                session.setAttribute("msg", "Não é possível excluir a sala " + s.getNome()
                        + ": ela possui reservas.");
            } else {
                SalaRepository.delete(s);
                session.setAttribute("msg", "Sala excluída com sucesso!");
            }

            response.sendRedirect("Salas.jsp");

            return;
        }

        response.sendRedirect("Salas.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("professorLogado") == null) {
            response.sendRedirect("loginProfessor.jsp");
            return;
        }

        String op = request.getParameter("operacao");
        String nome = request.getParameter("nome");
        String localizacao = request.getParameter("localizacao");
        TipoSala tipo = lerTipo(request.getParameter("tipo"));

        int capacidade = 0;

        try {
            capacidade = Integer.parseInt(request.getParameter("capacidade"));
        } catch (NumberFormatException ex) {
            capacidade = 0;
        }

        if (nome == null || nome.isBlank() || localizacao == null || localizacao.isBlank()
                || capacidade <= 0 || tipo == null) {
            session.setAttribute("msg", "Dados inválidos! Informe nome, localização, tipo e uma capacidade maior que zero.");
            response.sendRedirect("Salas.jsp");
            return;
        }

        // nome e localização são texto: precisam ter ao menos uma letra (não pode ser só número)
        if (!temLetra(nome) || !temLetra(localizacao)) {
            session.setAttribute("msg", "Dados inválidos! Nome e localização devem ser texto e não podem ser só números.");
            response.sendRedirect("Salas.jsp");
            return;
        }

        Sala s = new Sala();
        s.setNome(nome.trim());
        s.setLocalizacao(localizacao.trim());
        s.setCapacidade(capacidade);
        s.setTipo(tipo);

        if (op != null && op.equals("editar")) {

            Sala existente = lerSala(request.getParameter("id"));

            if (existente == null) {
                session.setAttribute("msg", "Sala não encontrada.");
            } else if (existente.isFixa()) {
                session.setAttribute("msg", "A sala " + existente.getNome() + " é fixa e não pode ser editada.");
            } else {
                s.setId(existente.getId());
                SalaRepository.update(s);
                session.setAttribute("msg", "Sala alterada com sucesso!");
            }

        } else {

            SalaRepository.create(s);

            session.setAttribute("msg", "Sala cadastrada com sucesso!");
        }

        response.sendRedirect("Salas.jsp");

    }

    private boolean temLetra(String texto) {
        for (char c : texto.toCharArray()) {
            if (Character.isLetter(c)) {
                return true;
            }
        }
        return false;
    }

    private Sala lerSala(String id) {
        try {
            return SalaRepository.read(Integer.parseInt(id));
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private TipoSala lerTipo(String nome) {
        for (TipoSala t : TipoSala.values()) {
            if (t.name().equals(nome)) {
                return t;
            }
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "CRUD de Sala";
    }
}
