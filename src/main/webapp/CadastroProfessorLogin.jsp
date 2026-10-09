<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${requestScope.abrirCadastro}">
    <div class="alert alert-danger"><c:out value="${requestScope.msg}"/></div>
</c:if>

<form method="post" action="ProfessorLogin">
    <input type="hidden" name="operacao" value="cadastro"/>

    <!-- Campo de SIAPE -->
    <div class="mb-3">
        <label for="cadSiapeInput" class="form-label">SIAPE</label>
        <input type="number" class="form-control" name="siape" id="cadSiapeInput" min="1"
               placeholder="Ex.: 1234567" value="<c:out value='${requestScope.cadSiape}'/>" required>
    </div>

    <!-- Campo de Nome -->
    <div class="mb-3">
        <label for="cadNomeInput" class="form-label">Nome completo</label>
        <input type="text" class="form-control" name="nome" id="cadNomeInput"
               placeholder="Ex.: João Silva" value="<c:out value='${requestScope.cadNome}'/>" required>
    </div>

    <!-- Campo de Senha -->
    <div class="mb-4">
        <label for="cadPasswordInput" class="form-label">Senha de acesso</label>
        <input type="password" name="senha" class="form-control" id="cadPasswordInput" placeholder="Crie uma senha" required>
    </div>

    <!-- Botão de Cadastrar -->
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-primary btn-lg">Cadastrar</button>
    </div>
</form>
