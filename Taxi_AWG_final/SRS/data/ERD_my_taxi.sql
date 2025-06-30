
CREATE TABLE addresses
(
  country      uuid            ,
  region       uuid            ,
  province     varchar         ,
  area         varchar         ,
  district     varchar         ,
  locality     varchar         ,
  street       varchar         ,
  house        varchar         ,
  building     varchar         ,
  full_address varchar         ,
  postal_code  varchar         ,
  latitude     double precision,
  longitude    double precision,
  created_at   timestamptz     ,
  id           uuid             NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE addresses IS 'Адрес';

CREATE TABLE car_lease_contract
(
  id            UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  number        varchar     NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  signed_at     timestamptz,
  ended_at      timestamptz,
  contract_text text       ,
  driver_id     uuid       ,
  car_id        uuid       
);

COMMENT ON TABLE car_lease_contract IS 'Договор на аренду автомобиля';

CREATE TABLE cars
(
  number              varchar NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  brand               varchar NOT NULL,
  model               varchar NOT NULL,
  color               varchar NOT NULL,
  body_type           varchar NOT NULL,
  vin                 varchar NOT NULL UNIQUE,
  registration_number varchar NOT NULL UNIQUE,
  owned_by_company    bool    NOT NULL DEFAULT true,
  id                  UUID    NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE cars IS 'Автомобиль';

CREATE TABLE currencies
(
  id   UUID    NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  name varchar NOT NULL,
  code varchar NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE currencies IS 'Валюты';

CREATE TABLE customers
(
  google_id      varchar     UNIQUE,
  active         boolean     NOT NULL DEFAULT true,
  created_at     timestamptz NOT NULL,
  updated_at     timestamptz NOT NULL,
  name           varchar    ,
  phone          varchar(15) NOT NULL UNIQUE,
  phone_active   boolean     DEFAULT true,
  phone_verified boolean     DEFAULT false,
  email          varchar     UNIQUE,
  email_verified boolean     DEFAULT false,
  is_deleted     boolean     DEFAULT false,
  deleted_at     timestamptz,
  photo          varchar    ,
  id             UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE customers IS 'Клиент';

CREATE TABLE driver_statuses
(
  name       varchar    ,
  created_at timestamptz NOT NULL,
  id         UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE driver_statuses IS 'Статусы водителя';

CREATE TABLE drivers
(
  name           varchar    ,
  phone          varchar(15) NOT NULL UNIQUE,
  passport_data  TEXT       ,
  license_number TEXT       ,
  status_set_at  timestamp   NOT NULL,
  id             UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  status         uuid        NOT NULL,
  car_id         uuid       ,
  PRIMARY KEY (id)
);

COMMENT ON TABLE drivers IS 'Водитель';

CREATE TABLE income_cash_order
(
  payment_id uuid       ,
  number     varchar     NOT NULL,
  created_at timestamptz NOT NULL,
  sum        numeric     NOT NULL,
  id         uuid       ,
  PRIMARY KEY (id)
);

COMMENT ON TABLE income_cash_order IS 'ПКО';

CREATE TABLE payments
(
  number            varchar     NOT NULL,
  created_at        timestamptz NOT NULL,
  sum               numeric     NOT NULL,
  currency          UUID        NOT NULL,
  payment_system_id UUID        NOT NULL,
  trip_id           UUID       ,
  is_deleted        boolean     NOT NULL,
  comment           varchar     DEFAULT null,
  trip_id           UUID       ,
  id                UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  id                UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE payments IS 'Оплата';

CREATE TABLE receipts
(
  number       varchar     NOT NULL UNIQUE,
  created_at   timestamptz NOT NULL,
  payment_type uuid        NOT NULL,
  vat_amount   numeric    ,
  vat_rate     numeric    ,
  item         varchar     NOT NULL,
  sum          numeric     NOT NULL,
  fiscal_data  text        NOT NULL,
  qr           varchar    ,
  payment_id   uuid       ,
  id           UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE
);

COMMENT ON TABLE receipts IS 'Чек';

CREATE TABLE request_status_history
(
  id            UUID      NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  status_set_at timestamp NOT NULL,
  set_by        UUID     ,
  comment       TEXT     ,
  status        uuid      NOT NULL,
  request_id    UUID      NOT NULL
);

COMMENT ON TABLE request_status_history IS 'История статусов заявки';

CREATE TABLE request_statuses
(
  name       varchar     NOT NULL,
  created_at timestamptz NOT NULL,
  id         UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE request_statuses IS 'Статусы заявки';

CREATE TABLE requests
(
  id             UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  number         varchar     NOT NULL GENERATED ALWAYS AS IDENTITY,
  created_at     timestamptz NOT NULL,
  client_id      uuid        NOT NULL,
  customer_phone varchar(15) NOT NULL,
  status         varchar     NOT NULL,
  status_id      uuid        NOT NULL,
  status_set_at  timestamp   NOT NULL,
  currency       uuid        NOT NULL,
  cost           numeric     DEFAULT null,
  is_deleted     boolean     DEFAULT false,
  PRIMARY KEY (id)
);

COMMENT ON TABLE requests IS 'Заявка на поездку ';

CREATE TABLE ride
(
  id                  UUID             NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  created_at          timestamptz      NOT NULL,
  desired_start_time  timestamptz      DEFAULT null,
  start_time          timestamptz      DEFAULT null,
  customer_comment    varchar          DEFAULT null,
  comment             varchar          DEFAULT null,
  distance            bigint           DEFAULT null,
  duration            bigint           DEFAULT null,
  cost                numeric          DEFAULT null,
  navi_url            TEXT            ,
  waiting_duration    INTEGER         ,
  trip_fare_id        varchar          NOT NULL,
  type                varchar          NOT NULL,
  driver_id           UUID             NOT NULL,
  trip_id             uuid             NOT NULL,
  request_id          uuid             NOT NULL,
  sort                integer          NOT NULL,
  active              boolean          NOT NULL DEFAULT true,
  start_address_id    uuid             DEFAULT null,
  start_full_address  varchar          NOT NULL,
  start_latitude      double precision NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  start_longitude     double precision,
  finish_address_id   uuid             DEFAULT null,
  finish_full_address varchar          NOT NULL,
  finish_latitude     double precision,
  finish_longitude    double precision,
  PRIMARY KEY (id)
);

COMMENT ON TABLE ride IS 'Маршрут';

CREATE TABLE trip_fares
(
  id             varchar     NOT NULL UNIQUE,
  created_at     timestamptz NOT NULL,
  is_active      boolean     NOT NULL DEFAULT true,
  deactivated_at timestamptz NOT NULL DEFAULT false,
  name           varchar     NOT NULL,
  min_price      numeric     NOT NULL,
  currency       uuid        NOT NULL,
  price_per_km   numeric     NOT NULL,
  price_per_min  numeric     NOT NULL,
  country        uuid        NOT NULL,
  region         uuid        NOT NULL,
  currency       uuid        NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON TABLE trip_fares IS 'Тариф';

CREATE TABLE trip_status_history
(
  set_at  timestamptz,
  comment varchar    ,
  id      uuid        NOT NULL,
  trip_id uuid       ,
  trip_id uuid       ,
  PRIMARY KEY (id)
);

COMMENT ON TABLE trip_status_history IS 'История статусов поездки';

CREATE TABLE trip_statuses
(
  name       varchar    ,
  created_at timestamptz NOT NULL,
  id         UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  PRIMARY KEY (id)
);

COMMENT ON TABLE trip_statuses IS 'Статусы поездки';

CREATE TABLE trips
(
  id            UUID        NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  number        varchar     NOT NULL GENERATED ALWAYS AS IDENTITY,
  created_at    timestamptz NOT NULL,
  is_deleted    boolean     DEFAULT false,
  request_id    UUID        DEFAULT null,
  status        varchar     NOT NULL,
  status_id     uuid        NOT NULL,
  status_set_at timestamp   NOT NULL,
  cost          numeric     DEFAULT null,
  currency      uuid        NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON TABLE trips IS 'Поездка';

ALTER TABLE requests
  ADD CONSTRAINT FK_customers_TO_requests
    FOREIGN KEY (client_id)
    REFERENCES customers (id);

ALTER TABLE request_status_history
  ADD CONSTRAINT FK_request_statuses_TO_request_status_history
    FOREIGN KEY (status)
    REFERENCES request_statuses (id);

ALTER TABLE request_status_history
  ADD CONSTRAINT FK_requests_TO_request_status_history
    FOREIGN KEY (request_id)
    REFERENCES requests (id);

ALTER TABLE requests
  ADD CONSTRAINT FK_request_statuses_TO_requests
    FOREIGN KEY (status_id)
    REFERENCES request_statuses (id);

ALTER TABLE trips
  ADD CONSTRAINT FK_requests_TO_trips
    FOREIGN KEY (request_id)
    REFERENCES requests (id);

ALTER TABLE trip_status_history
  ADD CONSTRAINT FK_trip_statuses_TO_trip_status_history
    FOREIGN KEY (trip_id)
    REFERENCES trip_statuses (id);

ALTER TABLE trips
  ADD CONSTRAINT FK_trip_statuses_TO_trips
    FOREIGN KEY (status_id)
    REFERENCES trip_statuses (id);

ALTER TABLE ride
  ADD CONSTRAINT FK_trip_fares_TO_ride
    FOREIGN KEY (trip_fare_id)
    REFERENCES trip_fares (id);

ALTER TABLE drivers
  ADD CONSTRAINT FK_driver_statuses_TO_drivers
    FOREIGN KEY (status)
    REFERENCES driver_statuses (id);

ALTER TABLE drivers
  ADD CONSTRAINT FK_cars_TO_drivers
    FOREIGN KEY (car_id)
    REFERENCES cars (id);

ALTER TABLE car_lease_contract
  ADD CONSTRAINT FK_drivers_TO_car_lease_contract
    FOREIGN KEY (driver_id)
    REFERENCES drivers (id);

ALTER TABLE car_lease_contract
  ADD CONSTRAINT FK_cars_TO_car_lease_contract
    FOREIGN KEY (car_id)
    REFERENCES cars (id);

ALTER TABLE payments
  ADD CONSTRAINT FK_trips_TO_payments
    FOREIGN KEY (trip_id)
    REFERENCES trips (id);

ALTER TABLE receipts
  ADD CONSTRAINT FK_payments_TO_receipts
    FOREIGN KEY (id)
    REFERENCES payments (id);

ALTER TABLE payments
  ADD CONSTRAINT FK_income_cash_order_TO_payments
    FOREIGN KEY (id)
    REFERENCES income_cash_order (id);

ALTER TABLE trip_fares
  ADD CONSTRAINT FK_currencies_TO_trip_fares
    FOREIGN KEY (currency)
    REFERENCES currencies (id);

ALTER TABLE requests
  ADD CONSTRAINT FK_currencies_TO_requests
    FOREIGN KEY (currency)
    REFERENCES currencies (id);

ALTER TABLE ride
  ADD CONSTRAINT FK_drivers_TO_ride
    FOREIGN KEY (driver_id)
    REFERENCES drivers (id);

ALTER TABLE ride
  ADD CONSTRAINT FK_trips_TO_ride
    FOREIGN KEY (trip_id)
    REFERENCES trips (id);

ALTER TABLE ride
  ADD CONSTRAINT FK_requests_TO_ride
    FOREIGN KEY (request_id)
    REFERENCES requests (id);

ALTER TABLE trips
  ADD CONSTRAINT FK_currencies_TO_trips
    FOREIGN KEY (currency)
    REFERENCES currencies (id);

ALTER TABLE ride
  ADD CONSTRAINT FK_addresses_TO_ride
    FOREIGN KEY (start_address_id)
    REFERENCES addresses (id);

ALTER TABLE ride
  ADD CONSTRAINT FK_addresses_TO_ride1
    FOREIGN KEY (finish_address_id)
    REFERENCES addresses (id);
