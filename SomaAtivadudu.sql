create database formativahogwarts;

use formativahogwarts;

ALTER TABLE usuarios ADD COLUMN telefone varchar(11);
ALTER TABLE usuarios ADD COLUMN photo varchar(200);




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

create table task_responsable(
id bigint not null auto_increment,
id_task bigint not null,
id_user bigint not null ,
foreign key (id_task) references task(id),
foreign key (id_task) references usuarios(id),
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

create table status_photos(
id bigint not null auto_increment,
id_status bigint not null,
photo text not null,
foreign key (id_status) references estado(id),
primary key(id)
);

update usuarios set telefone = 19847382910 where id =1;
update usuarios set telefone = 19832582910 where id =2;
update usuarios set telefone = 15796424910 where id =3;
update usuarios set telefone = 15987654321 where id =4;
update usuarios set telefone = 19842654321 where id =5;
update usuarios set telefone = 19842698776 where id =6;

update usuarios set photo="www.photo1.com.br" where id =1;
update usuarios set photo="www.photo2.com.br" where id =2;
update usuarios set photo="www.photo3.com.br" where id =3;
update usuarios set photo="www.photo4.com.br" where id =4;
update usuarios set photo="www.photo5.com.br" where id =5;
update usuarios set photo="www.photo6.com.br" where id =6;




insert into task(task_name,task_descrition,task_limite_date,task_finish_date,ambient_name,task_solicitante) values 
("Vidro Trincado","O Vidro trincou devido as vibrações","2022-06-03","2022-05-02",2,4),
("Chao Quebrado","TC andou por la e rachou","2022-03-10","2022-02-09",4,5),
("Parede Destruida","Uma Pessoa tropeço e deu de cara com a parede","2022-09-15","2022-08-11",5,6),
("Pão Cru","Deixou pouco tempo no forno","2022-09-11","2022-10-15",3,3);

INSERT INTO task_responsable (id_task, id_user) VALUES (1, 3);
INSERT INTO task_responsable (id_task, id_user) VALUES (3, 5);
INSERT INTO task_responsable (id_task, id_user) VALUES (5, 2);
INSERT INTO task_responsable (id_task, id_user) VALUES (4, 1);
INSERT INTO task_responsable (id_task, id_user) VALUES (2, 4);

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



SELECT task.id, task.task_name, task.task_descrition, usuarios.id AS user_id, usuarios.nome AS user_nome
FROM task
INNER JOIN task_responsable ON task.id = task_responsable.id_task
INNER JOIN usuarios ON task_responsable.id_user = usuarios.id
WHERE task.task_finish_date IS NULL;
 


  
SELECT locais.id, locais.nome
FROM locais
INNER JOIN task ON locais.id = task.ambient_name
GROUP BY locais.id, locais.nome
HAVING COUNT(task.id) > 2;
 


  
SELECT usuarios.id, usuarios.nome
FROM usuarios
INNER JOIN task_responsable ON usuarios.id = task_responsable.id_user
GROUP BY usuarios.id, usuarios.nome
HAVING COUNT(task_responsable.id_task) >= 2;
 


  
SELECT eventos.id, eventos.nome AS evento_nome, task.id AS task_id, task.task_name AS task_nome, task.ambient_name
FROM eventos
INNER JOIN locais ON eventos.localFk = locais.id
INNER JOIN task ON locais.id = task.ambient_name
WHERE eventos.fim > NOW() AND task.task_finish_date IS NULL;
 


  
SELECT locais.id, locais.nome, COUNT(task.id) AS quantidade_tarefas
FROM locais
INNER JOIN task ON locais.id = task.ambient_name
GROUP BY locais.id, locais.nome;
 


  
SELECT locais.id, locais.nome, COUNT(task.id) AS quantidade_tarefas_concluidas
FROM locais
INNER JOIN task ON locais.id = task.ambient_name
INNER JOIN estado ON task.id = estado.task_id
WHERE estado.estado_atual = 'Concluida'
GROUP BY locais.id, locais.nome;
 


  
SELECT usuarios.id, usuarios.nome, COUNT(task_responsable.id_task) AS quantidade_tarefas_atribuidas
FROM usuarios
INNER JOIN task_responsable ON usuarios.id = task_responsable.id_user
GROUP BY usuarios.id, usuarios.nome;
 


  
SELECT usuarios.id, usuarios.nome, COUNT(task_responsable.id_task) AS quantidade_tarefas_concluidas
FROM usuarios
INNER JOIN task_responsable ON usuarios.id = task_responsable.id_user
INNER JOIN estado ON task_responsable.id_task = estado.task_id
WHERE estado.estado_atual = 'Concluida'
GROUP BY usuarios.id, usuarios.nome;
 



  
SELECT locais.id, locais.nome, YEAR(task.task_create_date) AS ano, MONTH(task.task_create_date) AS mes, COUNT(*) AS quantidade_tarefas
FROM locais
INNER JOIN task ON locais.id = task.ambient_name
GROUP BY locais.id, locais.nome, YEAR(task.task_create_date), MONTH(task.task_create_date);
