<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
                <h3 class="mb-0">Salas reservadas por você</h3>
                <a class="btn btn-success" href="ReservarSala.jsp">Reservar nova sala</a>
            </div>

            <c:choose>
                <c:when test="${empty sessionScope.professorLogado.aulas}">
                    <p class="text-muted">Você ainda não reservou nenhuma sala.</p>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th>Data</th><th>Horário</th><th>Sala</th><th>Equipamentos</th><th>Ações</th>
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
                                    <td>
                                        <a class="btn btn-info btn-sm"
                                           href="Aulas?id=${aula.id}&amp;operacao=editar">editar</a>
                                        <a class="btn btn-danger btn-sm"
                                           href="Aulas?id=${aula.id}&amp;operacao=cancelar"
                                           onclick="return confirm('Cancelar esta reserva?')">cancelar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    </body>
</html>
