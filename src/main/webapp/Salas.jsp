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

        <title>Reserva de Salas - Salas</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <ifpe:CarregaSalas/>
        <ifpe:CarregaTiposSala/>

        <main class="page-container">

            <div class="page-intro">
                <div>
                    <span>ESPAÇOS</span>
                    <h1>Salas</h1>
                </div>
                <button class="btn btn-accent" data-bs-toggle="modal"
                        data-bs-target="#modalCadastro">Nova sala</button>
            </div>

            <c:choose>
                <c:when test="${empty pageScope.salas}">
                    <div class="empty-message">
                        <span class="empty-code">00</span>
                        <h2>Nenhuma sala cadastrada.</h2>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="catalog-grid">
                        <c:forEach var="sala" items="${pageScope.salas}">
                            <article class="catalog-card">
                                <div class="catalog-visual catalog-visual-${sala.tipo}">
                                    <span>${sala.tipo.descricao}</span>
                                    <strong><c:out value="${fn:substring(sala.nome, 0, 2)}"/></strong>
                                </div>
                                <div class="catalog-body">
                                    <h2><c:out value="${sala.nome}"/></h2>
                                    <p><c:out value="${sala.localizacao}"/></p>
                                    <div class="catalog-meta">
                                        <span>Capacidade</span>
                                        <strong>${sala.capacidade} pessoas</strong>
                                    </div>
                                    <div class="catalog-actions">
                                        <a class="btn btn-outline-primary"
                                           href="Salas?id=${sala.id}&amp;operacao=editar">editar</a>
                                        <a class="btn btn-light text-danger"
                                           href="Salas?id=${sala.id}&amp;operacao=deletar"
                                           onclick="return confirm('Excluir esta sala?')">excluir</a>
                                    </div>
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
                        <h1 class="modal-title fs-5" id="modalCadastroLabel">${(sessionScope.sala ne null)?'Atualizar':'Nova'} sala</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <jsp:directive.include file="CadastroSala.jsp"/>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

        <script>

            if(${(sessionScope.sala ne null)?'1':'0'}){
                const modalElement = document.getElementById('modalCadastro');
                const modal = new bootstrap.Modal(modalElement);
                modal.show()

                // ao fechar sem salvar, recarrega a pagina para "Nova sala" abrir o formulario vazio
                modalElement.addEventListener('hidden.bs.modal', function () {
                    location.href = 'Salas.jsp';
                });
            }

        </script>

        <c:remove var="sala" scope="session"/>

    </body>
</html>
