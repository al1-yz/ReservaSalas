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

        <title>Reserva de Salas - Equipamentos</title>
    </head>
    <body>

        <jsp:directive.include file="menuProfessor.jsp"/>

        <ifpe:CarregaEquipamentos/>

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Equipamentos</h3>
                <button class="btn btn-success" data-bs-toggle="modal"
                        data-bs-target="#modalCadastro">Novo equipamento</button>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th>Nome</th><th>Marca</th><th>Tipo</th><th>Utilidade</th><th>Ações</th>
                    </tr>

                    <c:forEach var="equipamento" items="${pageScope.equipamentos}">
                        <tr>
                            <td><c:out value="${equipamento.nome}"/></td>
                            <td><c:out value="${equipamento.marca}"/></td>
                            <td><c:out value="${equipamento.tipo}"/></td>
                            <td><c:out value="${equipamento.utilidade}"/></td>
                            <td>
                                <a class="btn btn-info btn-sm"
                                   href="Equipamentos?id=${equipamento.id}&amp;operacao=editar">editar</a>
                                <a class="btn btn-danger btn-sm"
                                   href="Equipamentos?id=${equipamento.id}&amp;operacao=deletar"
                                   onclick="return confirm('Excluir este equipamento?')">excluir</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

        </div>

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
