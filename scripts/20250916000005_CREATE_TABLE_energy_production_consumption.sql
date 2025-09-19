-- Crear tabla energy_production_consumption
CREATE TABLE energy_production_consumption (
    id SERIAL,
    user_id INTEGER,
    energy_produced_kwh DECIMAL(10,2) NOT NULL,
    energy_consumed_kwh DECIMAL(10,2) NOT NULL,
    used_kwh DECIMAL(10, 2) DEFAULT 0,        -- Energía bloqueada en ofertas activas
    consumed_kwh DECIMAL(10, 2) DEFAULT 0,    -- Energía vendida/consumida
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    CONSTRAINT pk_energy_production_consumption PRIMARY KEY (id),
    CONSTRAINT fk_energy_production_consumption_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
