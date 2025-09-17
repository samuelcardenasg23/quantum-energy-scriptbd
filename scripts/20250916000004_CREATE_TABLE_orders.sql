-- Crear tabla orders
CREATE TABLE orders (
    id SERIAL,
    user_id INTEGER,
    offer_id INTEGER,
    quantity_kwh DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    CONSTRAINT pk_orders PRIMARY KEY (id),
    CONSTRAINT fk_orders_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_orders_offer_id FOREIGN KEY (offer_id) REFERENCES energy_offers(id) ON DELETE CASCADE
);
