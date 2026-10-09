<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.professorLogado ne null}">
    <c:redirect url="indexProfessor.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <title>Reserva de Salas - Login</title>
    </head>
    <body>

        <div class="container">
            <div class="row justify-content-center mt-5">
                <div class="col-12 col-sm-8 col-md-6 col-lg-4">
                    <!-- Cartão do Formulário -->
                    <div class="card shadow border-0 rounded-3">
                        <div class="card-body p-4 p-sm-5">
                            <h3 class="card-title text-center mb-4 fw-bold text-primary">Reserva de Salas</h3>

                            <form method="post" action="ProfessorLogin">
                                <input type="hidden" name="operacao" value="login"/>

                                <!-- Campo de SIAPE -->
                                <div class="mb-3">
                                    <label for="siapeInput" class="form-label">SIAPE</label>
                                    <input type="number" name="siape" class="form-control" id="siapeInput"
                                           placeholder="Seu SIAPE" value="<c:out value='${requestScope.siapeLogin}'/>" required>
                                </div>

                                <!-- Campo de Senha -->
                                <div class="mb-3">
                                    <label for="passwordInput" class="form-label">Senha</label>
                                    <input type="password" name="senha" class="form-control" id="passwordInput" placeholder="Sua senha" required>
                                </div>

                                <!-- Botão de Enviar -->
                                <div class="d-grid gap-2 mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg">Acessar</button>
                                </div>
                            </form>

                            <!-- Link de Cadastro -->
                            <div class="text-center mt-4">
                                <span class="text-muted small">Não tem uma conta?</span>
                                <a href="#" class="text-decoration-none small fw-bold" data-bs-toggle="modal"
                                   data-bs-target="#modalCadastro"> Cadastre-se</a>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty requestScope.msg and not requestScope.abrirCadastro}">
                        <div class="alert alert-info mt-3"><c:out value="${requestScope.msg}"/></div>
                    </c:if>
                </div>
            </div>
        </div>

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
