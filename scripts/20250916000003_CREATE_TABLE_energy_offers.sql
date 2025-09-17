-- Crear tabla energy_offers
CREATE TABLE energy_offers (
    id SERIAL,
    user_id INTEGER,
    total_amount_kwh DECIMAL(10,2) NOT NULL,
    current_amount_kwh DECIMAL(10,2) NOT NULL,
    price_kwh DECIMAL(10,2) NOT NULL,
    offer_status offer_status DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    CONSTRAINT pk_energy_offers PRIMARY KEY (id),
    CONSTRAINT fk_energy_offers_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
