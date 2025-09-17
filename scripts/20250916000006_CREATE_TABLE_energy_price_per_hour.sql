-- Crear tabla energy_price_per_hour
CREATE TABLE energy_price_per_hour (
    id SERIAL,
    provider_name VARCHAR(255) NOT NULL,
    price_kwh DECIMAL(10,2) NOT NULL,
    price_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    CONSTRAINT pk_energy_price_per_hour PRIMARY KEY (id)
);
