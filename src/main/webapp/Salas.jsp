<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ifpe" uri="https://portal.ifpe.edu.br/recife/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <title>Reserva de Salas - Salas</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <ifpe:CarregaSalas/>
        <ifpe:CarregaTiposSala/>

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Salas</h3>
                <button class="btn btn-success" data-bs-toggle="modal"
                        data-bs-target="#modalCadastro">Nova sala</button>
            </div>

            <table class="table">
                <tr>
                    <th>Nome</th><th>Localização</th><th>Capacidade</th><th>Tipo</th><th>Ações</th>
                </tr>

                <c:forEach var="sala" items="${pageScope.salas}">
                    <tr>
                        <td><c:out value="${sala.nome}"/></td>
                        <td><c:out value="${sala.localizacao}"/></td>
                        <td>${sala.capacidade}</td>
                        <td>${sala.tipo.descricao}</td>
                        <td>
                            <a class="btn btn-info btn-sm"
                               href="Salas?id=${sala.id}&amp;operacao=editar">editar</a>
                            <a class="btn btn-danger btn-sm"
                               href="Salas?id=${sala.id}&amp;operacao=deletar"
                               onclick="return confirm('Excluir esta sala?')">excluir</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>

        </div>

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
