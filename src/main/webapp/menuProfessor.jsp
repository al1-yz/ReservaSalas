<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.professorLogado eq null}">
    <c:redirect url="loginProfessor.jsp"/>
</c:if>

<%-- pagina que incluiu o menu (para destacar o link ativo) --%>
<c:set var="paginaAtual" value="${pageContext.request.servletPath}"/>

<header class="app-header">
    <div class="header-inner">
        <a class="brand-button" href="indexProfessor.jsp">
            <span class="brand-symbol">RS</span>
            <span>Reserva de Salas</span>
        </a>

        <button class="btn menu-button" type="button" data-bs-toggle="collapse" data-bs-target="#menuPrincipal" aria-controls="menuPrincipal" aria-expanded="false" aria-label="Abrir ou fechar o menu">
            Menu
        </button>

        <nav class="main-nav collapse" id="menuPrincipal" aria-label="Menu principal">
            <a href="indexProfessor.jsp" class="${paginaAtual eq '/indexProfessor.jsp' ? 'active' : ''}">Início</a>
            <a href="ReservarSala.jsp" class="${paginaAtual eq '/ReservarSala.jsp' ? 'active' : ''}">Reservar sala</a>
            <a href="Salas.jsp" class="${paginaAtual eq '/Salas.jsp' ? 'active' : ''}">Salas</a>
            <a href="Equipamentos.jsp" class="${paginaAtual eq '/Equipamentos.jsp' ? 'active' : ''}">Equipamentos</a>
        </nav>

        <div class="dropdown user-dropdown">
            <button class="user-menu" type="button" id="menuUsuario" data-bs-toggle="dropdown" aria-expanded="false" aria-label="Menu do usuário">
                <span class="user-avatar" aria-hidden="true"><span></span></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="menuUsuario">
                <li><span class="dropdown-header"><c:out value="${sessionScope.professorLogado.nome}"/></span></li>
                <li><a class="dropdown-item" href="ProfessorLogin?operacao=logout">Sair</a></li>
            </ul>
        </div>
    </div>
</header>

<c:if test="${not empty sessionScope.msg}">
    <div class="flash-area">
        <div class="alert alert-info" role="alert"><c:out value="${sessionScope.msg}"/></div>
    </div>
    <c:remove var="msg" scope="session"/>
</c:if>
