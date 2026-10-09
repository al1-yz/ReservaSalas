package br.edu.ifpe.recife.reservasalas.controllers.jspTags;

import br.edu.ifpe.recife.reservasalas.model.entities.Equipamento;
import br.edu.ifpe.recife.reservasalas.model.repositories.EquipamentoRepository;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.PageContext;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.List;

/**
 * Carrega os equipamentos no escopo da pagina (variavel "equipamentos").
 */
public class CarregaEquipamentos extends SimpleTagSupport {

    @Override
    public void doTag() throws JspException, IOException {

        List<Equipamento> equipamentos = EquipamentoRepository.readAll();

        getJspContext().setAttribute("equipamentos", equipamentos, PageContext.PAGE_SCOPE);
    }
}
