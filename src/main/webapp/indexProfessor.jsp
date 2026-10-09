<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="ifpe" uri="https://portal.ifpe.edu.br/recife/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/reservasalas.css" rel="stylesheet">

        <title>Reserva de Salas - Minhas reservas</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <ifpe:CarregaSalas/>
        <fmt:setLocale value="pt_BR"/>

        <%-- resumo: total de horas das reservas do professor logado --%>
        <c:set var="totalHoras" value="0"/>
        <c:forEach var="aula" items="${sessionScope.professorLogado.aulas}">
            <c:set var="totalHoras" value="${totalHoras + aula.duracao}"/>
        </c:forEach>
        <c:set var="totalReservas" value="${sessionScope.professorLogado.aulas.size()}"/>
        <c:set var="totalSalas" value="${pageScope.salas.size()}"/>

        <main class="page-container">

            <div class="page-intro">
                <div>
                    <span>INÍCIO</span>
                    <h1>Salas reservadas por você</h1>
                </div>
                <a class="btn btn-accent" href="ReservarSala.jsp">Reservar nova sala</a>
            </div>

            <div class="home-layout">

                <div class="reservation-area">
                    <c:choose>
                        <c:when test="${empty sessionScope.professorLogado.aulas}">
                            <div class="empty-message">
                                <span class="empty-code">00</span>
                                <h2>Você não possui salas reservadas.</h2>
                                <a class="btn btn-accent" href="ReservarSala.jsp">Reservar nova sala</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="aula" items="${sessionScope.professorLogado.aulas}">
                                <fmt:formatDate value="${aula.data}" pattern="MMM" var="mesReserva"/>
                                <fmt:formatDate value="${aula.data}" pattern="d" var="diaReserva"/>
                                <fmt:formatDate value="${aula.data}" pattern="EEEE" var="semanaReserva"/>

                                <article class="reservation-card">
                                    <div class="reservation-date" title="${aula.dataFormatada}">
                                        <span>${mesReserva}</span>
                                        <strong>${diaReserva}</strong>
                                        <small>${semanaReserva}</small>
                                    </div>

                                    <div class="reservation-main">
                                        <div class="reservation-status">Confirmada</div>
                                        <h2><c:out value="${aula.sala.nome}"/></h2>
                                        <p><c:out value="${aula.sala.localizacao}"/></p>
                                        <div class="reservation-details">
                                            <div>
                                                <span>Horário</span>
                                                <strong>${aula.hora}h às ${aula.horaFim}h</strong>
                                            </div>
                                            <div>
                                                <span>Equipamentos</span>
                                                <strong>
                                                    <c:forEach var="item" items="${aula.itens}">
                                                        <c:out value="${item.equipamento.nome}"/> x${item.quantidadeUsada}<br/>
                                                    </c:forEach>
                                                    <c:if test="${empty aula.itens}">Nenhum</c:if>
                                                </strong>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="reservation-actions">
                                        <a class="btn btn-outline-primary"
                                           href="Aulas?id=${aula.id}&amp;operacao=editar">editar</a>
                                        <a class="btn btn-light text-danger"
                                           href="Aulas?id=${aula.id}&amp;operacao=cancelar"
                                           onclick="return confirm('Cancelar esta reserva?')">cancelar</a>
                                    </div>
                                </article>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <aside class="home-summary" aria-label="Resumo">
                    <div class="summary-heading">
                        <span>RESUMO</span>
                    </div>
                    <div class="summary-stat">
                        <strong>${totalReservas}</strong>
                        <small>${totalReservas eq 1 ? 'reserva' : 'reservas'}</small>
                    </div>
                    <div class="summary-stat">
                        <strong>${totalHoras}h</strong>
                        <small>tempo reservado</small>
                    </div>
                    <div class="summary-stat summary-stat-availability">
                        <strong>${totalSalas}</strong>
                        <small>${totalSalas eq 1 ? 'sala cadastrada' : 'salas cadastradas'}</small>
                    </div>
                    <a class="summary-link" href="Salas.jsp">Ver todas as salas</a>
                </aside>

            </div>

        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    </body>
</html>
