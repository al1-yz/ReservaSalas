<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="editando" value="${sessionScope.sala ne null}"/>

<form method="post" action="Salas">
    <c:if test="${editando}">
        <input type="hidden" name="operacao" value="editar"/>
        <input type="hidden" name="id" value="${sessionScope.sala.id}"/>
    </c:if>

    <div class="mb-3">
        <label for="salaNomeInput" class="form-label">Nome</label>
        <input type="text" class="form-control" name="nome" id="salaNomeInput"
               value="<c:out value='${sessionScope.sala.nome}'/>" required>
    </div>

    <div class="mb-3">
        <label for="salaLocalizacaoInput" class="form-label">Localização</label>
        <input type="text" class="form-control" name="localizacao" id="salaLocalizacaoInput"
               value="<c:out value='${sessionScope.sala.localizacao}'/>" required>
    </div>

    <div class="mb-3">
        <label for="salaCapacidadeInput" class="form-label">Capacidade</label>
        <input type="number" class="form-control" name="capacidade" id="salaCapacidadeInput" min="1"
               value="${editando ? sessionScope.sala.capacidade : ''}" required>
    </div>

    <div class="mb-3">
        <label for="salaTipoInput" class="form-label">Tipo</label>
        <select class="form-select" name="tipo" id="salaTipoInput" required>
            <c:forEach var="t" items="${pageScope.tipos}">
                <option value="${t}" ${sessionScope.sala.tipo eq t ? 'selected' : ''}>${t.descricao}</option>
            </c:forEach>
        </select>
    </div>

    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-accent">${editando ? 'Atualizar' : 'Cadastrar'}</button>
    </div>
</form>
