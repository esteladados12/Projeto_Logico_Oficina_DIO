# 🛠️ Sistema de Gerenciamento de Oficina Mecânica (MySQL)

Este projeto foi desenvolvido como parte de um desafio para modelar e implementar um sistema de controle e gerenciamento de ordens de serviço para uma oficina mecânica. O projeto cobre desde a concepção do modelo ER até a execução de queries complexas para análise de dados.

## 📌 Contexto do Desafio
O objetivo foi criar um banco de dados capaz de gerenciar:
- **Clientes e Veículos:** Cadastro de proprietários e seus automóveis.
- **Equipe:** Mecânicos e suas especialidades.
- **Serviços e Peças:** Tabela de preços de mão de obra e estoque de componentes.
- **Ordens de Serviço (OS):** Registro de serviços realizados, prazos, status e valores totais.

## 📐 Modelo de Dados
O banco de dados foi estruturado com as seguintes entidades principais:
- `Clients`: Informações dos proprietários.
- `Vehicles`: Dados dos veículos vinculados aos clientes.
- `Mechanics`: Profissionais da oficina.
- `ServiceOrder`: O cabeçalho da manutenção (datas, status, valor total).
- `ServiceReference`: Catálogo de serviços disponíveis.
- `Parts`: Catálogo de peças.
- `OrderItems`: Tabela de ligação que detalha quais serviços e peças compõem cada OS.

---

## 🚀 Tecnologias Utilizadas
- **SQL / MySQL**: Linguagem para manipulação e consulta de dados.
- **TablePlus**: Ferramenta utilizada para administração do banco.
- **Markdown**: Para documentação.

---

## 📊 Queries Implementadas
Durante o projeto, foram desenvolvidas consultas SQL para responder a perguntas de negócio, tais como:

* **Ranking de Produtividade:** Faturamento total por mecânico usando `LEFT JOIN` e `SUM`.
* **Análise de Margem:** Cálculo de lucro bruto por OS (Valor Total - Custo de Peças).
* **Gestão de Pátio:** Listagem de veículos em status "Em conserto" ou "Para avaliar".
* **Clientes High-Ticket:** Identificação de clientes que gastaram mais de R$ 500,00 utilizando a cláusula `HAVING`.
* **Ranking de Serviços:** Identificação dos 3 serviços mais realizados na oficina.

---

## 💻 Como rodar o projeto
1. Clone este repositório.
2. Execute o script de criação das tabelas (fornecido nos arquivos do projeto).
3. Execute o script de inserção de dados (SEED) para popular o banco.
4. Utilize o arquivo de queries para testar as consultas gerenciais.

---

## ✍️ Autor
Desenvolvido por **Estela Marques** durante os estudos.

---
