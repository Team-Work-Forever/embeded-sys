-- +goose Up
-- +goose StatementBegin
CREATE TABLE auths (
  id TEXT NOT NULL,
  public_id TEXT NOT NULL UNIQUE,
  licence_plate TEXT NOT NULL UNIQUE,
  secret_key TEXT NOT NULL,
  create_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT,
  PRIMARY KEY (id),
  CONSTRAINT valid_public_id CHECK(public_id != '')
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE auths;
-- +goose StatementEnd
