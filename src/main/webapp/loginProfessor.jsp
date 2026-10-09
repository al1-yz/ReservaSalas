<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.professorLogado ne null}">
    <c:redirect url="indexProfessor.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/reservasalas.css" rel="stylesheet">

        <title>Reserva de Salas - Login</title>
    </head>
    <body>

        <main class="auth-page">
            <!-- Cartão do Formulário -->
            <div class="auth-card">
                <div class="auth-brand">
                    <span class="brand-symbol">RS</span>
                    <h1>Reserva de Salas</h1>
                </div>

                <form method="post" action="ProfessorLogin">
                    <input type="hidden" name="operacao" value="login"/>

                    <!-- Campo de SIAPE -->
                    <div class="mb-3">
                        <label for="siapeInput" class="form-label">SIAPE</label>
                        <input type="text" inputmode="numeric" pattern="[0-9]+" title="Digite apenas números" autocomplete="off" name="siape" class="form-control" id="siapeInput"
                               placeholder="Seu SIAPE" value="<c:out value='${requestScope.siapeLogin}'/>" required>
                    </div>

                    <!-- Campo de Senha -->
                    <div class="mb-3">
                        <label for="passwordInput" class="form-label">Senha</label>
                        <input type="password" name="senha" class="form-control" id="passwordInput" placeholder="Sua senha" required>
                    </div>

                    <!-- Botão de Enviar -->
                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-accent">Acessar</button>
                    </div>
                </form>

                <!-- Link de Cadastro -->
                <p class="auth-switch">
                    Não tem uma conta?
                    <a href="#" data-bs-toggle="modal" data-bs-target="#modalCadastro">Cadastre-se</a>
                </p>

                <c:if test="${not empty requestScope.msg and not requestScope.abrirCadastro}">
                    <div class="alert alert-info" role="alert"><c:out value="${requestScope.msg}"/></div>
                </c:if>
            </div>
        </main>

        <!-- Modal -->
        <div class="modal fade" id="modalCadastro" tabindex="-1" aria-labelledby="modalCadastroLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalCadastroLabel">Cadastro de professor</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <jsp:directive.include file="CadastroProfessorLogin.jsp"/>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

        <script>

            if(${requestScope.abrirCadastro ? '1' : '0'}){
                const modal = new bootstrap.Modal(document.getElementById('modalCadastro'));
                modal.show()
            }

        </script>

    </body>
</html>
