const express = require("express");
const client = require("prom-client");
const pool = require("./db");

const app = express();


// Registro que vai guardar todas as métricas
const register = new client.Registry();

client.collectDefaultMetrics({
  register,
  prefix: "nodejs_",
});

const httpRequestsTotal = new client.Counter({
  name: "http_requests_total",
  help: "Total de requisições HTTP recebidas",
  labelNames: ["method", "route", "status_code"],
});
register.registerMetric(httpRequestsTotal);

const httpRequestDurationSeconds = new client.Histogram({
  name: "http_request_duration_seconds",
  help: "Duração das requisições HTTP em segundos",
  labelNames: ["method", "route", "status_code"],
  buckets: [0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2, 5],
});
register.registerMetric(httpRequestDurationSeconds);

const httpRequestsErrorsTotal = new client.Counter({
  name: "http_requests_errors_total",
  help: "Total de requisições HTTP que retornaram erro",
  labelNames: ["method", "route", "status_code"],
});
register.registerMetric(httpRequestsErrorsTotal);


app.use((req, res, next) => {
  const start = process.hrtime.bigint();

  res.on("finish", () => {
    const end = process.hrtime.bigint();
    const durationInSeconds = Number(end - start) / 1e9;

    const route = req.route?.path || req.path;
    const labels = {
      method: req.method,
      route,
      status_code: res.statusCode,
    };

    httpRequestsTotal.inc(labels);

    httpRequestDurationSeconds.observe(labels, durationInSeconds);

    if (res.statusCode >= 400) {
      httpRequestsErrorsTotal.inc(labels);
    }
  });

  next();
});


app.get("/health", (req, res) => {
  res.json({ status: "ok", message: "API de abastecimentos rodando" });
});

app.get("/abastecimentos", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT
         id,
         veiculo,
         tipo_combustivel,
         litros,
         valor_total,
         km_atual,
         data_abastecimento,
         posto,
         ativo
       FROM abastecimentos
       ORDER BY data_abastecimento DESC
       LIMIT 50`
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Erro ao buscar abastecimentos:", err);
    res.status(500).json({ error: "Erro ao buscar abastecimentos" });
  }
});

// Resumo de abastecimentos por veículo
app.get("/abastecimentos/resumo", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT
         veiculo,
         SUM(litros) AS total_litros,
         SUM(valor_total) AS total_gasto,
         AVG(valor_total / NULLIF(litros, 0)) AS preco_medio_litro
       FROM abastecimentos
       WHERE ativo =
