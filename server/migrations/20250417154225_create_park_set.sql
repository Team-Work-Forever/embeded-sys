-- +goose Up
-- +goose StatementBegin

CREATE TABLE park_set (
  id TEXT PRIMARY KEY,
  public_id TEXT NOT NULL UNIQUE,
  state INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  updated_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  deleted_at TEXT,
  CONSTRAINT valid_public_id CHECK (public_id != '')
);

CREATE TABLE park_lot (
  id TEXT PRIMARY KEY,
  public_id TEXT NOT NULL UNIQUE,
  park_set_id TEXT NOT NULL,
  state INTEGER NOT NULL,
  row INTEGER NOT NULL,
  col INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  updated_at TIMESTAMP DEFAULT (strftime('%s', 'now')),
  deleted_at TEXT,
  FOREIGN KEY (park_set_id) REFERENCES park_set(id) ON DELETE CASCADE
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS park_lot;
DROP TABLE IF EXISTS park_set;
-- +goose StatementEnd