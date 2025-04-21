-- +goose Up
-- +goose StatementBegin

CREATE TABLE reserve (
  id TEXT PRIMARY KEY,
  public_id TEXT NOT NULL UNIQUE,
  slot_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  updated_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  deleted_at TEXT,
  FOREIGN KEY (slot_id) REFERENCES park_lot(id) ON DELETE CASCADE
);

CREATE TABLE reserve_history (
  id TEXT PRIMARY KEY,
  public_id TEXT NOT NULL UNIQUE,
  slot_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  timestamp_begin TIMESTAMP NOT NULL,
  timestamp_end TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  updated_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  deleted_at TEXT,
  FOREIGN KEY (slot_id) REFERENCES park_lot(id) ON DELETE CASCADE
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS reserve_history;
DROP TABLE IF EXISTS reserve;
-- +goose StatementEnd