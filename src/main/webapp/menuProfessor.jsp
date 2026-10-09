<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.professorLogado eq null}">
    <c:redirect url="loginProfessor.jsp"/>
</c:if>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="indexProfessor.jsp">Reserva de Salas</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="indexProfessor.jsp">Início</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ReservarSala.jsp">Reservar sala</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Salas.jsp">Salas</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Equipamentos.jsp">Equipamentos</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <c:out value="${sessionScope.professorLogado.nome}"/>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="ProfessorLogin?operacao=logout">Sair</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<c:if test="${not empty sessionScope.msg}">
    <div class="container mt-3">
        <div class="alert alert-info"><c:out value="${sessionScope.msg}"/></div>
    </div>
    <c:remove var="msg" scope="session"/>
</c:if>
