# Desafio Capyba2

Este é um aplicativo Flutter com backend Firebase.

## Funcionalidades

- **Login e Cadastro**:
  - Cadastro e login via e-mail.
  - Exige selfie do usuário no momento de cadastro.
  - Persistência de login, mantendo o usuário logado após fechar e abrir o app novamente.

- **Área para Pessoas Logadas**:
  - Abas "Home" e "Restrito".
  - A aba "Home" é acessível para qualquer pessoa logada.
  - A aba "Restrito" só é acessível para pessoas com e-mail confirmado.

- **Meu Perfil**:
  - Página "Meu Perfil" acessível via menu lateral.
  - Permite edição das informações de cadastro do usuário.

- **Dados**:
  - Collection "home" para documentos exibidos na aba "Home".
  - Collection "restricted" para documentos exibidos na aba "Restrito".
  - Layout dos documentos seguindo um bom padrão de experiência do usuário.

- **Confirmação de E-mail**:
  - Opção no menu lateral "Validar E-mail" que direciona para a tela de confirmação de e-mail.

- **Integração com Google**:
  - Cadastro e login compatíveis via Google.

## Configuração do Projeto

1. Clone o repositório:
   ```bash
   git clone <url-do-repositorio>
