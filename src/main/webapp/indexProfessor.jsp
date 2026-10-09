<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <title>Reserva de Salas - Minhas reservas</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <div class="container mt-4">

            <h3 class="mb-3">Salas reservadas por você</h3>

            <c:choose>
                <c:when test="${empty sessionScope.professorLogado.aulas}">
                    <p class="text-muted">Você ainda não reservou nenhuma sala.</p>
                </c:when>
                <c:otherwise>
                    <table class="table">
                        <tr>
                            <th>Data</th><th>Horário</th><th>Sala</th><th>Equipamentos</th>
                        </tr>

                        <c:forEach var="aula" items="${sessionScope.professorLogado.aulas}">
                            <tr>
                                <td>${aula.dataFormatada}</td>
                                <td>${aula.hora}h às ${aula.horaFim}h</td>
                                <td>
                                    <c:out value="${aula.sala.nome}"/>
                                    <small class="text-muted">(<c:out value="${aula.sala.localizacao}"/>)</small>
                                </td>
                                <td>
                                    <c:forEach var="item" items="${aula.itens}">
                                        <c:out value="${item.equipamento.nome}"/> x${item.quantidadeUsada}<br/>
                                    </c:forEach>
                                    <c:if test="${empty aula.itens}">-</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    </body>
</html>
