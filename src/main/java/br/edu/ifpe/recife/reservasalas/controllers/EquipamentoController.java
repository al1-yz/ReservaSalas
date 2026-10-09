package br.edu.ifpe.recife.reservasalas.controllers;

import br.edu.ifpe.recife.reservasalas.model.entities.Equipamento;
import br.edu.ifpe.recife.reservasalas.model.repositories.AulaRepository;
import br.edu.ifpe.recife.reservasalas.model.repositories.EquipamentoRepository;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * CRUD de Equipamento. A listagem é feita por Equipamentos.jsp (tag CarregaEquipamentos).
 */
@WebServlet(name = "EquipamentoController", urlPatterns = {"/Equipamentos"})
public class EquipamentoController extends HttpServlet {

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

            Equipamento e = lerEquipamento(request.getParameter("id"));

            if (e == null) {
                session.setAttribute("msg", "Equipamento não encontrado.");
            } else {
                session.setAttribute("equipamento", e);
            }

            response.sendRedirect("Equipamentos.jsp");

            return;
        }

        if (op != null && op.equals("deletar")) {

            Equipamento e = lerEquipamento(request.getParameter("id"));

            if (e == null) {
                session.setAttribute("msg", "Equipamento não encontrado.");
            } else if (AulaRepository.existeComEquipamento(e.getId())) {
                session.setAttribute("msg", "Não é possível excluir o equipamento " + e.getNome()
                        + ": ele está em reservas.");
            } else {
                EquipamentoRepository.delete(e);
                session.setAttribute("msg", "Equipamento excluído com sucesso!");
            }

            response.sendRedirect("Equipamentos.jsp");

            return;
        }

        response.sendRedirect("Equipamentos.jsp");

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
        String marca = request.getParameter("marca");
        String tipo = request.getParameter("tipo");
        String utilidade = request.getParameter("utilidade");

        if (nome == null || nome.isBlank() || marca == null || marca.isBlank()
                || tipo == null || tipo.isBlank() || utilidade == null || utilidade.isBlank()) {
            session.setAttribute("msg", "Dados inválidos! Informe nome, marca, tipo e utilidade.");
            response.sendRedirect("Equipamentos.jsp");
            return;
        }

        // os quatro campos são texto: precisam ter ao menos uma letra (não pode ser só número)
        if (!temLetra(nome) || !temLetra(marca) || !temLetra(tipo) || !temLetra(utilidade)) {
            session.setAttribute("msg", "Dados inválidos! Nome, marca, tipo e utilidade devem ser texto e não podem ser só números.");
            response.sendRedirect("Equipamentos.jsp");
            return;
        }

        Equipamento e = new Equipamento();
        e.setNome(nome.trim());
        e.setMarca(marca.trim());
        e.setTipo(tipo.trim());
        e.setUtilidade(utilidade.trim());

        if (op != null && op.equals("editar")) {

            Equipamento existente = lerEquipamento(request.getParameter("id"));

            if (existente == null) {
                session.setAttribute("msg", "Equipamento não encontrado.");
            } else {
                e.setId(existente.getId());
                EquipamentoRepository.update(e);
                session.setAttribute("msg", "Equipamento alterado com sucesso!");
            }

        } else {

            EquipamentoRepository.create(e);

            session.setAttribute("msg", "Equipamento cadastrado com sucesso!");
        }

        response.sendRedirect("Equipamentos.jsp");

    }

    private boolean temLetra(String texto) {
        for (char c : texto.toCharArray()) {
            if (Character.isLetter(c)) {
                return true;
            }
        }
        return false;
    }

    private Equipamento lerEquipamento(String id) {
        try {
            return EquipamentoRepository.read(Integer.parseInt(id));
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    @Override
    public String getServletInfo() {
        return "CRUD de Equipamento";
    }
}
