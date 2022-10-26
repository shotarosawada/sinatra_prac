DROP TABLE IF EXISTS myapp;

create table myapp (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 main TEXT NOT NULL
);

insert into myapp values (1, "テストレコード1");
insert into myapp values (2, "テストレコード2");