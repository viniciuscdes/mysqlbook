/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
*******************************************

Arquivo: consultas.sql

*/
#Comandos  ddl 
				  
 
	mysql> create table nome_tabela(
			nome_coluna type,
			primary key(coluna_primaria);
	
	mysql> alter table nome_tabela add nome_coluna type;
	
	mysql> alter table nome_tabela drop column nome_coluna;

	mysql> alter table nome_tabela modify nome_coluna type;

	mysql> drop table nome_tabela;

	mysql> alter table nome_tabela add constraint primary key
			nome_constraint(nome_coluna);

	mysql> alter table nome_tabela add constraint nome_constraint
			foreign key(nome_coluna)
			references nome_tabela_referenciada(
			nome_coluna_referenciada)
			on delete no action
			on update no action;

	mysql> alter table nome_tabela drop constraint nome_constraint;				  
 
#Comandos dml 
				
 
	mysql> insert into nome_tabela(nome_coluna) values (valores);

	mysql> delete from nome_tabela where codicoes;

	mysql> update nome_tabela set nome_coluna = valor where codicoes;
 
				
 #Tipos de dados 
 
##Tipo Texto 

 
* **CHAR(tamanho) **: guarda um número fixo de caracteres. Pode conter letras, números e caracteres especiais. O tamanho deve ser declarado entre parênteses. Guarda até 255 caracteres.

* **VARCHAR(tamanho)**: possui as características do tipo %%CHAR%%, com a diferença de que, se você criar com mais de 255 caracteres, ele transforma-se no tipo %%TEXT%%. Ou seja, se for criar algum campo com mais de 255, já crie como %%TEXT%%.

* **TEXT**: guarda uma string com o tamanho máximo de 65.535 caracteres.

* **BLOB**: é o tipo de dado medido pela quantidade de bytes, em vez de pela quantidade de caracteres, conforme a maioria. Pode salvar por imagens, por exemplo, com o máximo de 65.535 bytes de arquivo.


## Tipo Numérico 
 
* **TINYINT**: guarda números do tipo inteiro. Suporta de -128 até 127 caracteres.

* **SMALLINT**: guarda números do tipo inteiro. Suporta de -32768 até 32767 caracteres.

* **MEDIUMINT**: guarda números do tipo inteiro. Suporta de -8388608 até 8388607 caracteres.

* **INT(tamanho)**: guarda números inteiros. Suporta de -2147483648 até 2147483647 caracteres. O número máximo de caracteres pode ser especificado entre parênteses.

* **BIGINT**: guarda números do tipo inteiro. Suporta de -9223372036854775808 até 9223372036854775807 caracteres.

* **FLOAT(tamanho,decimal)**: guarda números %%REAIS%%. O número máximo de caracteres pode ser especificado entre parênteses.
Deve-se especificar o tamanho inteiro e o tamanho numérico da coluna.

* **DOUBLE(tamanho,decimal)**: guarda números %%REAIS%%. O número máximo de caracteres pode ser especificado entre parênteses.
Deve-se especificar o tamanho inteiro e o tamanho numérico da coluna. Esse tipo armazena uma quantidade maior de número do que os campos do tipo %%FLOAT%%.
 
## Tipo data e tempo 

 
* **DATE()**: tipo de campo que armazenará datas no formato YYYY-MM-DD, onde Y refere-se ao ano, M ao mês e D ao dia.

* **DATETIME()**: a combinação de data e tempo no formato YYYY-MM-DD HH:MI:SS.

* **TIME()**: armazena horas, minutos e segundos no formato HH:MI:SS.

 

# Consultas
## Consultas Básicas 

mysql> select * from nome_tabela;

mysql> select * from nome_tabela order by 1;

mysql> select * from nome_tabela order by 1;

mysql> select *
		 from nome_tabela
		where codicoes
		order by 1;

mysql> select *
         from nome_tabela
        where nome_coluna = valor;

mysql> select *
		 from nome_tabela
		where nome_coluna <> valor;

mysql> select *
		 from nome_tabela
		where nome_coluna in (select nome_coluna
		                        from nome_tabela2);

mysql> select *
		 from nome_tabela
		where nome_coluna not in (select nome_coluna
		                            from nome_tabela2);

mysql> select campo1,campo2
         from nome_tabela
        group by campo1
        order by campo1;

## Consultas com Funções de Agregação 

 

## calcula o valor médio referente a uma coluna – avg()
mysql>select format(avg(campo_numerico),2) ‘avarage price’
        from nome_tabela;

## para contar registros – count()
mysql> select count(*) from nome_tabela;

## verificar quantidade – having count()
mysql> select campo1, count(campo2)
         from nome_tabela
       having count(campo2) > 1;

## valor máximo e valor mínimo – max() / min()
mysql> select max(campo1), min(campo1)
         from nome_tabela;

## somar campos – sum()
mysql> select sum(campo1) from nome_tabela;

## selecionar registros distintos de uma coluna – distinct()
mysql> select distinct(campo1)
         from nome_tabela;

## Consultas com Funções de Numéricas 

## retorna o arco co-seno de número acos(numero)
## ou null se x não estiver entre -1 e 1
mysql> select acos(numero) from nome_tabela;

## retorna o arco seno de número, asin(numero)
## ou null se número não estiver entre -1 e 1
mysql> select asin(numero) from nome_tabela;

## retorna o arco da tangente
mysql> select atan(numero) from nome_tabela;

## retorna o valor exponencial
mysql> select exp(numero) from nome_tabela;

## retorna o logaritmo natural base e
mysql> select log(3) from nome_tabela;

## retorna o logaritmo natural base 10
mysql> select log10(3) from nome_tabela;

## retorna a divisão de x por y.
mysql> select mod(x,y) from nome_tabela;

## retorna um valor aleatório
mysql> select rand(numero) from nome_tabela;

## arredondar números – round()
mysql> select round(campo_numerico)
		 from nome_tabela;

## tirar a raiz quadrada de um número – sqrt()
mysql> select sqrt(campo_numerico)
		 from nome_tabela;
 	

## Consultas com Funções de String 

## selecionar caracteres de uma string – substr
mysql> select substr(campo1,2)
		 from nome_tabela;

## contar quantidade de caracteres em uma string – length(campo)
mysql>select length(campo,2)
	    from nome_tabela;

## concatenar registros – concat() / concat_ws
mysql> select concat_ws(;,c_codiclien, c_razaclien, c_fantclien)
		 from comclien;
		where c_razaclien like ‘PEDR%';

## registros em mínusculo – lcase() / lower()
mysql> select lcase(c_razaclien)
         from comclien;

## registros em maiúsculo – ucase()
mysql> select ucase(c_razaclien)
         from comclien;

## completa uma string à direita com um caractere desejado
## na quantidade desejada
mysql> select rpad(string,10,’ ‘)
         from nome_coluna;

 
# Consultas com Funções de Data Tempo 
 
## retornar a diferença entre datas – datediff()
mysql>select (‘2015-03-15′,’2015-03-17′);

## converter de string para data – str_to_date()
mysql>select str_to_date(‘2013′,’%y’);

## consulta a data e hora atual – now()
mysql>select now();

## retorna o dia do mês de uma data
mysql> select dayofmonth(data) from nome_tabela;

## retorna o valor numérico do dia da semana
mysql> select dayofweek(data) from nome_tabela;
 

 

# Storage Procedures
 

mysql> delimiter $$
mysql> create procedure
		processa_comissionamento(in|out|inout parametro tipo)
		begin

		instruções;

		end
mysql> $$
mysql> delimiter ;

 

# Storage Functions
 

mysql> create function rt_nome_cliente(vn_numeclien int)
		returns varchar(50)

		begin
		declare variavel_retorno datatype;

		instruções;

		return retorno;
		end
mysql> $$
mysql> delimiter ;


# Event scheduler 
 

mysql> create event processa_comissao
on schedule every 1 [year|week|day|hour|minute|second
starts ‘data_hora_qualquer’
do
begin

instruções;

 
# Trigger
 
mysql> create or replace trigger nome_trigger
		[before|after insert|update|delete on nome_tabela
		for each row

		begin
		intruções;
		end;
mysql> drop trigger nome_trigger;

 

# Desempenho 
 
mysql> alter table nome_tabela
add index nome_index(nome_coluna);

mysql> alter table nome_tabela
add unique index nome_index(nome_coluna);

mysql> show index from nome_tabela;

mysql> alter table nome_tabela drop index nome_index;
 

# Views
 
## Não fique reescrevendo códigos repetitivos. Crie  views
 
mysql> create or replace view nome_view as
		select campos
		from tabelas
		where codições;

mysql> drop view nome_view;
 

# Crei Backup 
 
## Crie backups com frequência. Ele poderá salvar seu sistema um dia!
 
## Exportando uma tabela
mysql\bin> mysqldump -u root -p comercial comclien > c:/bkp_clien.sql

## Exportando tudo
mysql\bin> mysqldump -u root -p –routines –triggers comercial > c:/bkp_full.sql

## Importando tudo
mysql> mysql\bin> mysql -h localhost -u root -p comercial2 < c:/bkp_full.sql
 
 
## Listar as variáveis
mysql> show VARIABLES;

mysql> set nome_da_variavel = novo_valor;
 
# Visualizando e matando as conexões ativas em nosso banco de dados.
 
## Visualizando conexões ativas
mysql> show processlist;

## Matando conexões ativas
mysql> kill numero_PID;
 

	 
