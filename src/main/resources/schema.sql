PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    can_sell INTEGER NOT NULL DEFAULT 1,
    can_rent INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL REFERENCES categories(id),
    name TEXT NOT NULL,
    model_code TEXT,
    default_sale_price REAL,
    default_rental_price REAL,
    cleaning_buffer_days INTEGER DEFAULT 2,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS product_variants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    size TEXT,
    color TEXT,
    barcode TEXT UNIQUE,
    virtual_stock INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS stock_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    variant_id INTEGER NOT NULL REFERENCES product_variants(id) ON DELETE CASCADE,
    serial_code TEXT UNIQUE,
    rentable INTEGER NOT NULL DEFAULT 1,
    status TEXT NOT NULL DEFAULT 'available'
);

CREATE TABLE IF NOT EXISTS customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    phone TEXT,
    national_id TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER REFERENCES customers(id),
    sold_at TEXT NOT NULL DEFAULT (datetime('now')),
    total_amount REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS sale_lines (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_id INTEGER NOT NULL REFERENCES sales(id) ON DELETE CASCADE,
    variant_id INTEGER NOT NULL REFERENCES product_variants(id),
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    line_total REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS reservations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL REFERENCES customers(id),
    stock_item_id INTEGER NOT NULL REFERENCES stock_items(id),
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    deposit_due REAL DEFAULT 0,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE (stock_item_id, start_date, end_date)
);

CREATE TABLE IF NOT EXISTS rentals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL REFERENCES customers(id),
    stock_item_id INTEGER NOT NULL REFERENCES stock_items(id),
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    rental_fee REAL NOT NULL,
    deposit REAL DEFAULT 0,
    status TEXT NOT NULL DEFAULT 'checked_out',
    checked_out_at TEXT NOT NULL DEFAULT (datetime('now')),
    returned_at TEXT,
    late_fee REAL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS payments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ref_type TEXT NOT NULL,
    ref_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    method TEXT NOT NULL,
    paid_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Seed kategoriler
INSERT OR IGNORE INTO categories(name, can_sell, can_rent) VALUES
('Abiye', 1, 1),
('Günlük', 1, 0),
('Başörtüsü', 1, 0),
('Çanta', 1, 1);