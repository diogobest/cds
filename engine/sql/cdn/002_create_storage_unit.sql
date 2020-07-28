-- +migrate Up

CREATE TABLE IF NOT EXISTS "storage_unit" (
  id VARCHAR(36) PRIMARY KEY,
  created TIMESTAMP WITH TIME ZONE NOT NULL,
  name VARCHAR(255) NOT NULL,
  config JSONB NOT NULL,
  sig BYTEA,
  signer TEXT
);

CREATE TABLE IF NOT EXISTS "storage_unit_index" (
  id VARCHAR(36) PRIMARY KEY,
  unit_id VARCHAR(36) NOT NULL,
  item_id VARCHAR(36) NOT NULL,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL,
  cipher_locator BYTEA,
  sig BYTEA,
  signer TEXT
);

SELECT create_foreign_key_idx_cascade('FK_storage_unit_index_index', 'storage_unit_index', 'index', 'item_id', 'id');
SELECT create_foreign_key('FK_storage_unit_index_unit', 'storage_unit_index', 'storage_unit', 'unit_id', 'id');
SELECT create_unique_index('storage_unit_index', 'IDX_storage_unit_index_unit_id_item_id', 'unit_id,item_id');

-- +migrate Down
DROP TABLE IF EXISTS "storage_unit";
