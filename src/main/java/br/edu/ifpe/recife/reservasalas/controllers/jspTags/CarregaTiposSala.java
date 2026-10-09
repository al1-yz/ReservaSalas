package br.edu.ifpe.recife.reservasalas.controllers.jspTags;

import br.edu.ifpe.recife.reservasalas.model.entities.TipoSala;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.PageContext;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 * Carrega os tipos de sala no escopo da pagina (variavel "tipos").
 */
public class CarregaTiposSala extends SimpleTagSupport {

    @Override
    public void doTag() throws JspException, IOException {

        getJspContext().setAttribute("tipos", TipoSala.values(), PageContext.PAGE_SCOPE);
    }
}
