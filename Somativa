create database formativahogwarts;

use formativahogwarts;

ALTER TABLE usuarios ADD COLUMN telefone varchar(11);
ALTER TABLE usuarios ADD COLUMN photo varchar(200);


insert into task(task_name,task_descrition,task_limite_date,task_finish_date,ambient_name,task_solicitante) values 
("Vidro Trincado","O Vidro trincou devido as vibrações","2022-06-03","2022-05-02",2,4),
("Chao Quebrado","TC andou por la e rachou","2022-03-10","2022-02-09",4,5),
("Parede Destruida","Uma Pessoa tropeço e deu de cara com a parede","2022-09-15","2022-08-11",5,6),
("Pão Cru","Deixou pouco tempo no forno","2022-09-11","2022-10-15",3,3);

insert into task_responsable(id_task,id_user) values (1,3),(3,5),(5,2),(4,1),(2,4);

insert into status_photos (id_status,photo) values 
(1,"www.photo1.com"),
(4,"www.photo2.com"),
(3,"www.photo4.com"),
(2,"www.photo3.com");

insert into estado(estado_atual,task_id,coment) values
("Aberta",1,"Muita coisa para fazer omg"),
("Concluida",3,"Muita coisa para fazer omg"),
("Em Andamento",2,"Muita coisa para fazer omg"),
("Encerrada",4,"Muita coisa para fazer omg");

select * from locais;
select * from task;

create table task(
id bigint not null auto_increment,
task_name varchar(100) not null,
task_descrition varchar(200) not null,
task_limite_date datetime not null,
task_create_date datetime default now(),
task_finish_date datetime ,
ambient_name bigint not null,
task_solicitante bigint not null,
foreign key (ambient_name)references locais(id),
foreign key (task_solicitante) references usuarios(id),
primary key(id)
);

select * from usuarios;
drop table task_responsable;
drop table task;
drop table estado;

create table task_responsable(
id bigint not null auto_increment,
id_task bigint not null,
id_user bigint not null ,
foreign key (id_task) references task(id),
foreign key (id_task) references usuarios(id),
primary key(id)
);

create table status_photos(
id bigint not null auto_increment,
id_status bigint not null,
photo text not null,
foreign key (id_status) references estado(id),
primary key(id)
);

create table estado(
id bigint not null auto_increment,
estado_atual enum("Aberta","Em Andamento","Concluida","Encerrada") not null,
task_id bigint not null,
coment varchar(200) not null,
date_status datetime default now(),
foreign key (task_id) references task(id),
primary key(id)
);



