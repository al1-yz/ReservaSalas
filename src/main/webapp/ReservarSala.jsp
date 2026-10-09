<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ifpe" uri="https://portal.ifpe.edu.br/recife/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <title>Reserva de Salas - Reservar sala</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <ifpe:CarregaSalas/>
        <ifpe:CarregaEquipamentos/>

        <%-- reserva existente (editar) ou a que o professor acabou de digitar (erro de validacao) --%>
        <c:set var="editando" value="${sessionScope.aula ne null and sessionScope.aula.id gt 0}"/>

        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-12 col-md-9 col-lg-7">

                    <h3 class="mb-3">${editando ? 'Alterar reserva' : 'Reservar sala'}</h3>

                    <form method="post" action="Aulas">
                        <c:if test="${editando}">
                            <input type="hidden" name="operacao" value="editar"/>
                            <input type="hidden" name="id" value="${sessionScope.aula.id}"/>
                        </c:if>

                        <!-- Sala -->
                        <div class="mb-3">
                            <label for="salaInput" class="form-label">Sala</label>
                            <select class="form-select" name="salaId" id="salaInput" required>
                                <option value="">Selecione...</option>
                                <c:forEach var="sala" items="${pageScope.salas}">
                                    <option value="${sala.id}" ${sessionScope.aula.sala.id eq sala.id ? 'selected' : ''}>
                                        <c:out value="${sala.nome}"/> - <c:out value="${sala.localizacao}"/> (${sala.capacidade} lugares)
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Data, hora e duração -->
                        <div class="row">
                            <div class="col-12 col-sm-6 mb-3">
                                <label for="dataInput" class="form-label">Data</label>
                                <input type="date" class="form-control" name="data" id="dataInput"
                                       value="${sessionScope.aula.dataIso}" required>
                            </div>
                            <div class="col-6 col-sm-3 mb-3">
                                <label for="horaInput" class="form-label">Hora inicial</label>
                                <input type="number" class="form-control" name="hora" id="horaInput" min="0" max="23"
                                       placeholder="0 a 23"
                                       value="${sessionScope.aula.hora ge 0 ? sessionScope.aula.hora : ''}" required>
                            </div>
                            <div class="col-6 col-sm-3 mb-3">
                                <label for="duracaoInput" class="form-label">Duração (h)</label>
                                <input type="number" class="form-control" name="duracao" id="duracaoInput" min="1" max="24"
                                       placeholder="horas"
                                       value="${sessionScope.aula.duracao ge 0 ? sessionScope.aula.duracao : ''}" required>
                            </div>
                        </div>

                        <!-- Equipamentos (opcionais) -->
                        <div class="mb-3">
                            <label class="form-label">Equipamentos <small class="text-muted">(opcional - informe a quantidade)</small></label>
                            <table class="table table-sm">
                                <c:forEach var="equipamento" items="${pageScope.equipamentos}">
                                    <tr>
                                        <td>
                                            <c:out value="${equipamento.nome}"/>
                                            <small class="text-muted"><c:out value="${equipamento.marca}"/></small>
                                        </td>
                                        <td style="width: 7rem;">
                                            <input type="number" class="form-control form-control-sm" min="0"
                                                   name="qtd_${equipamento.id}"
                                                   value="${empty sessionScope.aula ? 0 : sessionScope.aula.getQuantidadeDe(equipamento.id)}">
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">${editando ? 'Salvar alterações' : 'Reservar'}</button>
                            <a class="btn btn-outline-secondary" href="indexProfessor.jsp">Voltar</a>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

        <c:remove var="aula" scope="session"/>

    </body>
</html>
