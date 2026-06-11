--テーブルを作成
CREATE TABLE users (
    id serial primary key,
    screen_name text not null,
    created timestamp with time zone not null default CURRENT_TIMESTAMP,
    updated timestamp with time zone not null default CURRENT_TIMESTAMP
);

--テーブルにデータを挿入
INSERT INTO users("screen_name") VALUES ('go');