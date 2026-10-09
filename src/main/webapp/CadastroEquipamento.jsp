<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="editando" value="${sessionScope.equipamento ne null}"/>

<form method="post" action="Equipamentos">
    <c:if test="${editando}">
        <input type="hidden" name="operacao" value="editar"/>
        <input type="hidden" name="id" value="${sessionScope.equipamento.id}"/>
    </c:if>

    <div class="mb-3">
        <label for="equipNomeInput" class="form-label">Nome</label>
        <input type="text" class="form-control" name="nome" id="equipNomeInput"
               value="<c:out value='${sessionScope.equipamento.nome}'/>" pattern=".*[A-Za-zÀ-ÿ].*" title="Use texto: não pode ser só número" required>
    </div>

    <div class="mb-3">
        <label for="equipMarcaInput" class="form-label">Marca</label>
        <input type="text" class="form-control" name="marca" id="equipMarcaInput"
               value="<c:out value='${sessionScope.equipamento.marca}'/>" pattern=".*[A-Za-zÀ-ÿ].*" title="Use texto: não pode ser só número" required>
    </div>

    <div class="mb-3">
        <label for="equipTipoInput" class="form-label">Tipo</label>
        <input type="text" class="form-control" name="tipo" id="equipTipoInput"
               value="<c:out value='${sessionScope.equipamento.tipo}'/>" pattern=".*[A-Za-zÀ-ÿ].*" title="Use texto: não pode ser só número" required>
    </div>

    <div class="mb-3">
        <label for="equipUtilidadeInput" class="form-label">Utilidade</label>
        <input type="text" class="form-control" name="utilidade" id="equipUtilidadeInput"
               value="<c:out value='${sessionScope.equipamento.utilidade}'/>" pattern=".*[A-Za-zÀ-ÿ].*" title="Use texto: não pode ser só número" required>
    </div>

    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-accent">${editando ? 'Atualizar' : 'Cadastrar'}</button>
    </div>
</form>
