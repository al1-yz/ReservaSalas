<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ifpe" uri="https://portal.ifpe.edu.br/recife/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/reservasalas.css" rel="stylesheet">

        <title>Reserva de Salas - Reservar sala</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <ifpe:CarregaSalas/>
        <ifpe:CarregaEquipamentos/>

        <%-- reserva existente (editar) ou a que o professor acabou de digitar (erro de validacao) --%>
        <c:set var="editando" value="${sessionScope.aula ne null and sessionScope.aula.id gt 0}"/>

        <main class="page-container">

            <div class="page-intro">
                <div>
                    <span>${editando ? 'EDITAR RESERVA' : 'NOVA RESERVA'}</span>
                    <h1>${editando ? 'Alterar reserva' : 'Reservar sala'}</h1>
                </div>
            </div>

            <form method="post" action="Aulas" class="booking-layout">
                <c:if test="${editando}">
                    <input type="hidden" name="operacao" value="editar"/>
                    <input type="hidden" name="id" value="${sessionScope.aula.id}"/>
                </c:if>

                <div class="booking-fields">

                    <!-- Sala -->
                    <div class="form-section">
                        <span class="form-step">01</span>
                        <div class="form-section-content">
                            <h2>Escolha a sala</h2>
                            <label for="salaInput" class="form-label">Sala</label>
                            <select class="form-select" name="salaId" id="salaInput" required>
                                <option value="">Selecione...</option>
                                <c:forEach var="sala" items="${pageScope.salas}">
                                    <option value="${sala.id}" data-tipo="${sala.tipo}"
                                            data-nome="<c:out value='${sala.nome}'/>"
                                            data-local="<c:out value='${sala.localizacao}'/>"
                                            ${sessionScope.aula.sala.id eq sala.id ? 'selected' : ''}>
                                        <c:out value="${sala.nome}"/> - <c:out value="${sala.localizacao}"/> (${sala.capacidade} lugares)
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- Data, hora e duração -->
                    <div class="form-section">
                        <span class="form-step">02</span>
                        <div class="form-section-content">
                            <h2>Defina o horário</h2>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="dataInput" class="form-label">Data</label>
                                    <input type="date" class="form-control" name="data" id="dataInput"
                                           value="${sessionScope.aula.dataIso}" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="horaInput" class="form-label">Hora inicial</label>
                                    <input type="number" class="form-control" name="hora" id="horaInput" min="0" max="23"
                                           placeholder="0 a 23"
                                           value="${sessionScope.aula.hora ge 0 ? sessionScope.aula.hora : ''}" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="duracaoInput" class="form-label">Duração (h)</label>
                                    <input type="number" class="form-control" name="duracao" id="duracaoInput" min="1" max="24"
                                           placeholder="horas"
                                           value="${sessionScope.aula.duracao ge 0 ? sessionScope.aula.duracao : ''}" required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Equipamentos (opcionais) -->
                    <div class="form-section">
                        <span class="form-step">03</span>
                        <fieldset class="form-section-content equipment-fieldset">
                            <legend>Equipamentos <small>(opcional - informe a quantidade)</small></legend>
                            <div class="equipment-options">
                                <c:forEach var="equipamento" items="${pageScope.equipamentos}">
                                    <label>
                                        <span>
                                            <c:out value="${equipamento.nome}"/>
                                            <small><c:out value="${equipamento.marca}"/></small>
                                        </span>
                                        <input type="number" class="form-control" min="0"
                                               name="qtd_${equipamento.id}"
                                               aria-label="Quantidade de ${equipamento.nome}"
                                               value="${empty sessionScope.aula ? 0 : sessionScope.aula.getQuantidadeDe(equipamento.id)}">
                                    </label>
                                </c:forEach>
                            </div>
                        </fieldset>
                    </div>

                </div>

                <aside class="booking-summary">
                    <span class="summary-label">RESUMO DA RESERVA</span>
                    <div class="summary-room" id="resumoSala">
                        <span id="resumoSigla">--</span>
                        <div>
                            <strong id="resumoSalaNome">Nenhuma sala</strong>
                            <small id="resumoSalaLocal">Selecione uma sala</small>
                        </div>
                    </div>
                    <dl>
                        <div>
                            <dt>Data</dt>
                            <dd id="resumoData">Não informada</dd>
                        </div>
                        <div>
                            <dt>Hora inicial</dt>
                            <dd id="resumoHora">Não informada</dd>
                        </div>
                        <div>
                            <dt>Duração</dt>
                            <dd id="resumoDuracao">Não informada</dd>
                        </div>
                    </dl>
                    <button type="submit" class="btn btn-accent w-100">${editando ? 'Salvar alterações' : 'Reservar'}</button>
                    <a class="summary-back" href="indexProfessor.jsp">Voltar</a>
                </aside>
            </form>

        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

        <script>

            // o painel "Resumo da reserva" acompanha o que o professor digita; quem valida continua sendo o servidor
            const salaInput = document.getElementById('salaInput');
            const dataInput = document.getElementById('dataInput');
            const horaInput = document.getElementById('horaInput');
            const duracaoInput = document.getElementById('duracaoInput');

            function atualizarResumo() {
                const opcao = salaInput.options[salaInput.selectedIndex];
                const temSala = opcao.value !== '';

                document.getElementById('resumoSala').className = 'summary-room' + (temSala ? ' summary-room-' + opcao.dataset.tipo : '');
                document.getElementById('resumoSigla').textContent = temSala ? opcao.dataset.nome.substring(0, 2) : '--';
                document.getElementById('resumoSalaNome').textContent = temSala ? opcao.dataset.nome : 'Nenhuma sala';
                document.getElementById('resumoSalaLocal').textContent = temSala ? opcao.dataset.local : 'Selecione uma sala';

                document.getElementById('resumoData').textContent = dataInput.value ? dataInput.value.split('-').reverse().join('/') : 'Não informada';
                document.getElementById('resumoHora').textContent = horaInput.value !== '' ? horaInput.value + 'h' : 'Não informada';
                document.getElementById('resumoDuracao').textContent = duracaoInput.value !== '' ? duracaoInput.value + 'h' : 'Não informada';
            }

            [salaInput, dataInput, horaInput, duracaoInput].forEach(function (campo) {
                campo.addEventListener('input', atualizarResumo);
                campo.addEventListener('change', atualizarResumo);
            });

            atualizarResumo();

        </script>

        <c:remove var="aula" scope="session"/>

    </body>
</html>
