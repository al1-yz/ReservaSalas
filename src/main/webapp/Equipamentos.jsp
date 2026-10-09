<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="ifpe" uri="https://portal.ifpe.edu.br/recife/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/reservasalas.css" rel="stylesheet">

        <title>Reserva de Salas - Equipamentos</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <ifpe:CarregaEquipamentos/>

        <main class="page-container">

            <div class="page-intro">
                <div>
                    <span>RECURSOS</span>
                    <h1>Equipamentos</h1>
                </div>
                <button class="btn btn-accent" data-bs-toggle="modal"
                        data-bs-target="#modalCadastro">Novo equipamento</button>
            </div>

            <c:choose>
                <c:when test="${empty pageScope.equipamentos}">
                    <div class="empty-message">
                        <span class="empty-code">00</span>
                        <h2>Nenhum equipamento cadastrado.</h2>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="equipment-list">
                        <c:forEach var="equipamento" items="${pageScope.equipamentos}">
                            <article class="equipment-card">
                                <span class="equipment-code"><c:out value="${fn:substring(equipamento.nome, 0, 2)}"/></span>
                                <div class="equipment-name">
                                    <h2><c:out value="${equipamento.nome}"/></h2>
                                    <p><c:out value="${equipamento.marca}"/></p>
                                </div>
                                <span class="equipment-type"><c:out value="${equipamento.tipo}"/></span>
                                <p class="equipment-use"><c:out value="${equipamento.utilidade}"/></p>
                                <div class="equipment-actions">
                                    <a class="btn btn-outline-primary"
                                       href="Equipamentos?id=${equipamento.id}&amp;operacao=editar">editar</a>
                                    <a class="btn btn-light text-danger"
                                       href="Equipamentos?id=${equipamento.id}&amp;operacao=deletar"
                                       onclick="return confirm('Excluir este equipamento?')">excluir</a>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

        </main>

        <!-- Modal -->
        <div class="modal fade" id="modalCadastro" tabindex="-1" aria-labelledby="modalCadastroLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalCadastroLabel">${(sessionScope.equipamento ne null)?'Atualizar equipamento':'Novo equipamento'}</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <jsp:directive.include file="CadastroEquipamento.jsp"/>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

        <script>

            if(${(sessionScope.equipamento ne null)?'1':'0'}){
                const modalElement = document.getElementById('modalCadastro');
                const modal = new bootstrap.Modal(modalElement);
                modal.show()

                // ao fechar sem salvar, recarrega a pagina para "Novo equipamento" abrir o formulario vazio
                modalElement.addEventListener('hidden.bs.modal', function () {
                    location.href = 'Equipamentos.jsp';
                });
            }

        </script>

        <c:remove var="equipamento" scope="session"/>

    </body>
</html>
