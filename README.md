# Quantum Energy ScriptBD

Este repositorio contiene los scripts SQL para la base de datos del proyecto Quantum Energy, un marketplace P2P para intercambio de energía solar.

## Descripción del Proyecto

El proyecto propone el desarrollo de un marketplace en la nube que permita a los usuarios productores y consumidores de energía solar (prosumidores) intercambiar en tiempo real el excedente energético generado a partir de esquemas de generación distribuida.

Este tipo de iniciativas abren la puerta al desarrollo de modelos de intercambio energético peer-to-peer (P2P), en los cuales los usuarios dejan de ser simples consumidores pasivos para convertirse en actores activos dentro del mercado. Mediante una plataforma digital, la generación distribuida puede conectarse de manera directa con la demanda, posibilitando que las comunidades intercambien energía entre sí, establezcan reglas de compensación justas y construyan un ecosistema energético más autónomo y sostenible.

Un aspecto clave de esta propuesta es que los principales beneficiados serán los usuarios regulados del sistema eléctrico, quienes ya no estarían obligados a comprar su energía exclusivamente al comercializador tradicional ni a los precios definidos por este. En su lugar, contarían con la posibilidad de comprar y vender energía a un precio alternativo, promoviendo mayor competitividad, flexibilidad y autonomía en el acceso al servicio.

En este contexto, se plantea la creación de un proyecto mínimo viable (MVP) con el propósito de validar el modelo de negocio de un sistema P2P de intercambio de energía solar. Este piloto busca demostrar la viabilidad técnica, económica y social de un esquema descentralizado, en el cual la generación distribuida no solo atienda necesidades individuales, sino que además impulse la conformación de un nuevo mercado de microrred virtual.

## Esquema de Base de Datos

### Tablas

- **users**: Información de usuarios (prosumidores, consumidores, generadores)
  - id: SERIAL, CONSTRAINT pk_users PRIMARY KEY (id)
  - name: VARCHAR(255) NOT NULL
  - email: VARCHAR(255) UNIQUE NOT NULL
  - password: VARCHAR(255) NOT NULL
  - user_role: ENUM ('prosumidor', 'consumidor', 'generador') NOT NULL
  - location: VARCHAR(255) NOT NULL
  - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - updated_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - deleted_at: TIMESTAMP NULL

- **energy_offers**: Ofertas de energía disponibles
  - id: SERIAL, CONSTRAINT pk_energy_offers PRIMARY KEY (id)
  - user_id: INTEGER, CONSTRAINT fk_energy_offers_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
  - total_amount_kwh: DECIMAL(10,2) NOT NULL
  - current_amount_kwh: DECIMAL(10,2) NOT NULL
  - price_kwh: DECIMAL(10,2) NOT NULL
  - offer_status: ENUM ('available', 'unavailable') DEFAULT 'available'
  - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - updated_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - deleted_at: TIMESTAMP NULL

- **orders**: Pedidos de compra de energía
  - id: SERIAL, CONSTRAINT pk_orders PRIMARY KEY (id)
  - user_id: INTEGER, CONSTRAINT fk_orders_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
  - offer_id: INTEGER, CONSTRAINT fk_orders_offer_id FOREIGN KEY (offer_id) REFERENCES energy_offers(id) ON DELETE CASCADE
  - quantity_kwh: DECIMAL(10,2) NOT NULL
  - total_price: DECIMAL(10,2) NOT NULL
  - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - updated_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - deleted_at: TIMESTAMP NULL

- **energy_production_consumption**: Datos de producción y consumo de energía (mocked)
  - id: SERIAL, CONSTRAINT pk_energy_production_consumption PRIMARY KEY (id)
  - user_id: INTEGER, CONSTRAINT fk_energy_production_consumption_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
  - energy_produced_kwh: DECIMAL(10,2) NOT NULL
  - energy_consumed_kwh: DECIMAL(10,2) NOT NULL
  - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - updated_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - deleted_at: TIMESTAMP NULL

- **energy_price_per_hour**: Precios de energía por hora (mocked)
  - id: SERIAL, CONSTRAINT pk_energy_price_per_hour PRIMARY KEY (id)
  - provider_name: VARCHAR(255) NOT NULL
  - price_kwh: DECIMAL(10,2) NOT NULL
  - price_time: TIMESTAMP NOT NULL
  - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - updated_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  - deleted_at: TIMESTAMP NULL

### Enums

- user_role: 'prosumidor', 'consumidor', 'generador'
- offer_status: 'available', 'unavailable'

## Instrucciones para Ejecutar los Scripts

1. Asegúrate de tener PostgreSQL instalado y una base de datos creada.
2. Ejecuta los scripts en el orden numérico de los timestamps para crear las tablas y enums:

   - `20250916000001_CREATE_ENUMS.sql`
   - `20250916000002_CREATE_TABLE_users.sql`
   - `20250916000003_CREATE_TABLE_energy_offers.sql`
   - `20250916000004_CREATE_TABLE_orders.sql`
   - `20250916000005_CREATE_TABLE_energy_production_consumption.sql`
   - `20250916000006_CREATE_TABLE_energy_price_per_hour.sql`

3. Ejecuta los scripts de inserts para datos mocked (después de crear las tablas). Nota: Los inserts de usuarios y producción/consumo están comentados para evitar dependencias; se crearán desde el backend:

   - `20250916000007_INSERT_USERS.sql` (comentado)
   - `20250916000008_INSERT_ENERGY_PRODUCTION_CONSUMPTION.sql` (comentado)
   - `20250916000009_INSERT_ENERGY_PRICE_PER_HOUR.sql`

Ejemplo de comandos en terminal:

```bash
# Crear enums y tablas
psql -d quantum_energy_db -f scripts/20250916000001_CREATE_ENUMS.sql
psql -d quantum_energy_db -f scripts/20250916000002_CREATE_TABLE_users.sql
# ... repetir para cada archivo CREATE

# Insertar datos
psql -d quantum_energy_db -f scripts/20250916000007_INSERT_USERS.sql
# ... repetir para cada archivo INSERT
```

Nota: Los archivos están nombrados con timestamps para facilitar el orden de ejecución y versionado.

## Próximos Pasos

- Desarrollar el backend con Node.js + TypeScript.
- Desarrollar el frontend con React.
- Desplegar en AWS.