
CREATE DATABASE auction_db;

CREATE SCHEMA auction_schema;


CREATE TABLE auction_schema.item_categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE auction_schema.item_category_mapping (
    item_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (item_id, category_id),
    FOREIGN KEY (item_id) REFERENCES auction_schema.items(item_id),
    FOREIGN KEY (category_id) REFERENCES auction_schema.item_categories(category_id)
);

CREATE TABLE auction_schema.sellers (
    seller_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255) NOT NULL
);

CREATE TABLE auction_schema.items (
    item_id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    seller_id INT NOT NULL,
    start_price DECIMAL(10, 2) CHECK (start_price >= 0),
    FOREIGN KEY (seller_id) REFERENCES auction_schema.sellers(seller_id)
);

CREATE TABLE auction_schema.auctions (
    auction_id SERIAL PRIMARY KEY,
    date DATE NOT NULL CHECK (date > '2000-01-01'),
    location VARCHAR(255) NOT NULL,
    time TIME NOT NULL,
    details VARCHAR(255)
);

CREATE TABLE auction_schema.lots (
    lot_id SERIAL PRIMARY KEY,
    auction_id INT NOT NULL,
    item_id INT NOT NULL,
    FOREIGN KEY (auction_id) REFERENCES auction_schema.auctions(auction_id),
    FOREIGN KEY (item_id) REFERENCES auction_schema.items(item_id)
);

CREATE TABLE auction_schema.buyers (
    buyer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255) NOT NULL
);

CREATE TABLE auction_schema.transactions (
    transaction_id SERIAL PRIMARY KEY,
    lot_id INT NOT NULL,
    buyer_id INT NOT NULL,
    final_price DECIMAL(10, 2) CHECK (final_price >= 0),
    FOREIGN KEY (lot_id) REFERENCES auction_schema.lots(lot_id),
    FOREIGN KEY (buyer_id) REFERENCES auction_schema.buyers(buyer_id)
);

CREATE TABLE auction_schema.seller_buyer_mapping (
    seller_id INT NOT NULL,
    buyer_id INT NOT NULL,
    PRIMARY KEY (seller_id, buyer_id),
    FOREIGN KEY (seller_id) REFERENCES auction_schema.sellers(seller_id),
    FOREIGN KEY (buyer_id) REFERENCES auction_schema.buyers(buyer_id)
);


ALTER TABLE auction_schema.item_categories ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.item_category_mapping ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.sellers ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.items ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.auctions ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.lots ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.buyers ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.transactions ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE auction_schema.seller_buyer_mapping ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;


INSERT INTO auction_schema.item_categories (name) VALUES
('Antiques'),
('Paintings');


INSERT INTO auction_schema.sellers (name, contact_info) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com');


INSERT INTO auction_schema.buyers (name, contact_info) VALUES
('Alice Brown', 'alice.brown@example.com'),
('Bob Johnson', 'bob.johnson@example.com');


INSERT INTO auction_schema.items (description, seller_id, start_price) VALUES
('Vintage Vase', 1, 50.00),
('Oil Painting', 2, 200.00);


INSERT INTO auction_schema.auctions (date, location, time, details) VALUES
('2023-06-15', 'New York', '14:00', 'Estate auction'),
('2023-07-20', 'San Francisco', '12:00', 'Modern art auction');

INSERT INTO auction_schema.lots (auction_id, item_id) VALUES
(1, 1),
(2, 2);

INSERT INTO auction_schema.transactions (lot_id, buyer_id, final_price) VALUES
(1, 1, 75.00),
(2, 2, 250.00);

INSERT INTO auction_schema.item_category_mapping (item_id, category_id) VALUES
(1, 1),
(2, 2);

INSERT INTO auction_schema.seller_buyer_mapping (seller_id, buyer_id) VALUES
(1, 1),
(2, 2);
.



