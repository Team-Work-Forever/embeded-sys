-- +goose Up
-- +goose StatementBegin
CREATE TABLE component (
    id TEXT not null,  -- Use TEXT for UUIDs
    email TEXT(50) not null,  -- Use TEXT for email (SQLite doesn't have VARCHAR)
    password TEXT not null,
    salt TEXT not null,
    created_at TEXT default CURRENT_TIMESTAMP,  -- Use CURRENT_TIMESTAMP for default timestamp
    updated_at TEXT default CURRENT_TIMESTAMP,  -- Same for default timestamp
    deleted_at TEXT default NULL,  -- Use TEXT for nullable timestamps
    PRIMARY KEY (id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE component;
-- +goose StatementEnd
