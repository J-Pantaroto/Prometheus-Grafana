CREATE TABLE IF NOT EXISTS abastecimentos (
  id SERIAL PRIMARY KEY,
  veiculo VARCHAR(50) NOT NULL,
  tipo_combustivel VARCHAR(20) NOT NULL,
  litros NUMERIC(10, 2) NOT NULL,
  valor_total NUMERIC(10, 2) NOT NULL,
  km_atual INTEGER NOT NULL,
  data_abastecimento TIMESTAMP NOT NULL DEFAULT NOW(),
  posto VARCHAR(100),
  ativo BOOLEAN NOT NULL DEFAULT TRUE
);

INSERT INTO abastecimentos (veiculo, tipo_combustivel, litros, valor_total, km_atual, data_abastecimento, posto, ativo) VALUES
('Carro A', 'Gasolina', 40.0, 260.00, 12000, NOW() - INTERVAL '20 days', 'Posto Central', TRUE),
('Carro A', 'Gasolina', 42.5, 280.00, 12350, NOW() - INTERVAL '17 days', 'Posto Central', TRUE),
('Carro A', 'Gasolina', 38.0, 250.00, 12700, NOW() - INTERVAL '14 days', 'Posto Sul', TRUE),

('Carro B', 'Etanol', 35.0, 175.00, 30000, NOW() - INTERVAL '18 days', 'Posto Norte', TRUE),
('Carro B', 'Etanol', 36.5, 182.50, 30350, NOW() - INTERVAL '15 days', 'Posto Norte', TRUE),
('Carro B', 'Etanol', 37.0, 185.00, 30700, NOW() - INTERVAL '12 days', 'Posto Leste', TRUE),

('Carro C', 'Diesel', 60.0, 420.00, 50000, NOW() - INTERVAL '19 days', 'Posto Oeste', TRUE),
('Carro C', 'Diesel', 58.0, 406.00, 50500, NOW() - INTERVAL '16 days', 'Posto Oeste', TRUE),
('Carro C', 'Diesel', 62.0, 434.00, 51050, NOW() - INTERVAL '13 days', 'Posto Central', TRUE),

('Moto X', 'Gasolina', 15.0, 97.50, 8000, NOW() - INTERVAL '11 days', 'Posto Sul', TRUE),
('Moto X', 'Gasolina', 13.5, 87.75, 8250, NOW() - INTERVAL '9 days', 'Posto Sul', TRUE),
('Moto X', 'Gasolina', 14.0, 91.00, 8500, NOW() - INTERVAL '7 days', 'Posto Norte', TRUE),

('Carro D', 'Gasolina', 45.0, 292.50, 20000, NOW() - INTERVAL '10 days', 'Posto Leste', TRUE),
('Carro D', 'Gasolina', 47.0, 305.50, 20450, NOW() - INTERVAL '8 days', 'Posto Leste', TRUE),

('Carro E', 'Diesel', 70.0, 490.00, 70000, NOW() - INTERVAL '6 days', 'Posto Oeste', TRUE),
('Carro E', 'Diesel', 68.0, 476.00, 70600, NOW() - INTERVAL '4 days', 'Posto Central', TRUE),

('Carro F', 'Gasolina', 50.0, 325.00, 15000, NOW() - INTERVAL '5 days', 'Posto Central', TRUE),
('Carro F', 'Gasolina', 48.0, 312.00, 15400, NOW() - INTERVAL '3 days', 'Posto Sul', TRUE),

('Carro G', 'Etanol', 40.0, 200.00, 25000, NOW() - INTERVAL '2 days', 'Posto Norte', TRUE),
('Carro G', 'Etanol', 39.0, 195.00, 25400, NOW() - INTERVAL '1 days', 'Posto Norte', TRUE);
