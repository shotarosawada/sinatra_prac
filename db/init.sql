DROP TABLE IF EXISTS zip_codes;

create table zip_codes (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 zip_code INTEGER UNIQUE NOT NULL,
 prefecture TEXT NOT NULL,
 city TEXT NOT NULL,
 town_area TEXT NOT NULL,
 created_at TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
 updated_at TEXT NOT NULL DEFAULT (DATETIME('now','localtime'))
);


-- CREATE TRIGGER trigger_test_updated_at AFTER UPDATE ON test
-- BEGIN
--     UPDATE test SET updated_at = DATETIME('now', 'localtime') WHERE rowid == NEW.rowid;
-- END;