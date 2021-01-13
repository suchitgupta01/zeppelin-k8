-- noinspection SqlNoDataSourceInspectionForFile

create schema zeppelin;

create table zeppelin.zeppelin_users
(
	id serial not null
		constraint zeppelin_users_pk
			primary key,
	username varchar(100) not null,
	password varchar(240) not null,
	created_at timestamp default now() not null,
	updated_at timestamp default now() not null
);
create table zeppelin.zeppelin_user_roles
(
	id serial not null
		constraint zeppelin_user_roles_pk
			primary key,
	username varchar(100) not null,
	role_name varchar(100) not null,
	created_at timestamp default now() not null,
	updated_at timestamp default now() not null
);

INSERT INTO zeppelin.zeppelin_users (id, username, password, created_at, updated_at)
VALUES (DEFAULT, 'zeppelin_ui_user', '$shiro1$SHA-256$500000$YdUEhfDpsx9KLGeyshFegQ==$m+4wcq4bJZo1HqDAGECx50LcEkRZI0zCyq99gtRqZDk=', DEFAULT, DEFAULT);

INSERT INTO zeppelin.zeppelin_user_roles (id, username, role_name, created_at, updated_at) VALUES (DEFAULT, 'zeppelin_ui_user', 'admin', DEFAULT, DEFAULT);

commit;