package br.edu.ifpe.recife.reservasalas.controllers.jspTags;

import br.edu.ifpe.recife.reservasalas.model.entities.Aula;
import br.edu.ifpe.recife.reservasalas.model.repositories.AulaRepository;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.PageContext;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.List;

/**
 * Carrega todas as reservas no escopo da página (variável "aulas").
 */
public class CarregaAulas extends SimpleTagSupport {

    @Override
    public void doTag() throws JspException, IOException {

        List<Aula> aulas = AulaRepository.readAll();

        getJspContext().setAttribute("aulas", aulas, PageContext.PAGE_SCOPE);
    }
}
