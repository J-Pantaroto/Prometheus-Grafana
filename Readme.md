# dashb-abastecimentos

Aplicação simples de controle de abastecimentos com observabilidade usando Prometheus e Grafana.

## Tecnologias

- Node.js (Express)
- PostgreSQL
- Prometheus
- Grafana
- Docker Compose

## Estrutura

- `app/`
  - `index.js` — API (endpoints de abastecimentos e /metrics)
  - `db.js` — conexão com PostgreSQL
  - `package.json` — dependências Node.js
  - `Dockerfile` — imagem da aplicação
- `db/`
  - `init.sql` — criação da tabela `abastecimentos` e dados de exemplo
- `prometheus.yml` — configuração do Prometheus
- `docker-compose.yml` — orquestração dos serviços

## Endpoints principais

- `GET /health`  
  Verifica o status da API.

- `GET /abastecimentos`  
  Lista os últimos abastecimentos registrados.

- `GET /abastecimentos/resumo`  
  Retorna resumo por veículo (total de litros, total gasto, preço médio por litro).

- `GET /metrics`  
  Exposição de métricas no formato Prometheus.

## Métricas de observabilidade

Algumas métricas expostas:

- `http_requests_total` — total de requisições HTTP por método/rota/status
- `http_request_duration_seconds` — duração das requisições HTTP
- `http_requests_errors_total` — total de requisições com erro (4xx/5xx)
- Métricas padrão de Node.js (heap, event loop, etc.)

## Como executar

1. Certifique-se de ter Docker e Docker Compose instalados.
2. Na raiz do projeto, execute:

```bash
docker-compose up -d --build

## Como importar o dashboard no Grafana

1. Acesse o Grafana em: http://localhost:3000
2. Faça login (padrão): usuário `admin`, senha `admin`.
3. No menu lateral, vá em **Dashboards > New > Import**.
4. Clique em **Upload JSON file** e selecione o arquivo `grafana-dashboard.json` que está na raiz do projeto.
5. Na tela de importação:
   - Em **Prometheus data source**, selecione a fonte de dados `prometheus` que você criou.
   - Em **PostgreSQL data source**, selecione a fonte de dados `postgres` (ou o nome que você deu).
6. Clique em **Import**.

Após isso, o dashboard será carregado com todos os gráficos prontos (dados de abastecimento + métricas de observabilidade).
