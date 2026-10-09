package br.edu.ifpe.recife.reservasalas.controllers;

import br.edu.ifpe.recife.reservasalas.model.entities.Professor;
import br.edu.ifpe.recife.reservasalas.model.repositories.ProfessorRepository;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Login, logout e autocadastro do professor.
 */
@WebServlet(name = "ProfessorLogin", urlPatterns = {"/ProfessorLogin"})
public class ProfessorLogin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operacao = request.getParameter("operacao");

        if (operacao == null) {
            response.sendRedirect("loginProfessor.jsp");
            return;
        }

        switch (operacao) {
            case "logout":
                request.getSession().invalidate();
                response.sendRedirect("loginProfessor.jsp");
                return;

            default:
                response.sendRedirect("loginProfessor.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operacao = request.getParameter("operacao");

        if (operacao == null) {
            operacao = "";
        }

        switch (operacao) {
            case "login":

                Professor p = null;

                try {
                    p = ProfessorRepository.read(Integer.parseInt(request.getParameter("siape")));
                } catch (NumberFormatException ex) {
                    p = null;
                }

                if (p != null && p.getSenha().equals(request.getParameter("senha"))) {

                    request.getSession().setAttribute("professorLogado", p);

                    response.sendRedirect("indexProfessor.jsp");

                    return;

                } else {
                    request.setAttribute("msg", "Não foi possível fazer o login! SIAPE ou senha incorretos.");
                    request.setAttribute("siapeLogin", request.getParameter("siape"));
                    voltarParaLogin(request, response);

                    return;
                }

            case "cadastro":

                String siapeTexto = request.getParameter("siape");
                String nome = request.getParameter("nome");
                String senha = request.getParameter("senha");
                String erro = null;
                int siape = 0;

                try {
                    siape = Integer.parseInt(siapeTexto);
                } catch (NumberFormatException ex) {
                    siape = 0;
                }

                if (siape <= 0) {
                    erro = "Informe um SIAPE numérico, maior que zero.";
                } else if (nome == null || nome.isBlank() || senha == null || senha.isBlank()) {
                    erro = "Preencha o nome e a senha.";
                } else if (!nomeValido(nome)) {
                    erro = "O nome completo deve ter letras e não pode conter números.";
                } else if (ProfessorRepository.read(siape) != null) {
                    erro = "Já existe um professor cadastrado com o SIAPE " + siape + ".";
                }

                if (erro != null) {
                    request.setAttribute("msg", erro);
                    request.setAttribute("abrirCadastro", true);
                    request.setAttribute("cadSiape", siapeTexto);
                    request.setAttribute("cadNome", nome);
                    voltarParaLogin(request, response);

                    return;
                }

                Professor novo = new Professor();
                novo.setSiape(siape);
                novo.setNome(nome.trim());
                novo.setSenha(senha);

                ProfessorRepository.create(novo);

                request.setAttribute("msg", "Cadastro realizado com sucesso! Agora faça o login.");
                request.setAttribute("siapeLogin", siape);
                voltarParaLogin(request, response);

                return;

            default:
                response.sendRedirect("loginProfessor.jsp");
        }

    }

    private void voltarParaLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getServletContext().getRequestDispatcher("/loginProfessor.jsp")
                .forward(request, response);
    }

    // nome de pessoa: precisa ter ao menos uma letra e nenhum dígito
    private boolean nomeValido(String nome) {
        boolean temLetra = false;
        for (char c : nome.toCharArray()) {
            if (Character.isDigit(c)) {
                return false;
            }
            if (Character.isLetter(c)) {
                temLetra = true;
            }
        }
        return temLetra;
    }

    @Override
    public String getServletInfo() {
        return "Login, logout e autocadastro do professor";
    }
}
