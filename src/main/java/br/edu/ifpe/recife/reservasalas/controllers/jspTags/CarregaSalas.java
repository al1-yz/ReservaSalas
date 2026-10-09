package br.edu.ifpe.recife.reservasalas.controllers.jspTags;

import br.edu.ifpe.recife.reservasalas.model.entities.Sala;
import br.edu.ifpe.recife.reservasalas.model.repositories.SalaRepository;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.PageContext;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.List;

/**
 * Carrega as salas no escopo da página (variável "salas").
 */
public class CarregaSalas extends SimpleTagSupport {

    @Override
    public void doTag() throws JspException, IOException {

        List<Sala> salas = SalaRepository.readAll();

        getJspContext().setAttribute("salas", salas, PageContext.PAGE_SCOPE);
    }
}
