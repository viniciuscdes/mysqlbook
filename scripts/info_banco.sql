/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
******************************************* 

Para chamar a procedure utilize 

call info_banco(nome_banco);

*/

delimiter $$
create procedure info_banco (in nome_banco varchar(20))
begin
  select 
    (select schema_name 
	   from information_schema.schemata 
	  where schema_name=nome_banco) as "banco",
	(select round( sum( data_length + index_length ) / 1024 / 1024, 3 ) 
	   from information_schema.tables 
	  where table_schema=nome_banco
	  group by table_schema) as "tamanho do banco de dados em mega bytes",
	(select count(*) 
	   from information_schema.tables 
	  where table_schema=nome_banco 
	    and table_type='base table') as "quant. tabelas",
	(select count(*) 
	   from information_schema.statistics 
	  where table_schema=nome_banco) as "quant. índices",
	(select count(*) 
	   from information_schema.views 
	  where table_schema=nome_banco) as "quant. views",
	(select count(*) 
	   from information_schema.routines 
	  where routine_type ='function' 
	    and routine_schema=nome_banco) as "quant. funções",
	(select count(*) 
	   from information_schema.routines 
	  where routine_type ='procedure' 
	    and routine_schema=nome_banco) as "quant. procedimentos",
	(select count(*) 
	   from information_schema.triggers 
	  where trigger_schema=nome_banco) as "quant. triggers",
	(select count(*) 
	   from information_schema.events 
	  where event_schema=nome_banco) as "quant. eventos",
	(select default_collation_name 
	   from information_schema.schemata 
	  where schema_name=nome_banco)"default collation do banco de dados",
	(select default_character_set_name 
	   from information_schema.schemata 
	  where schema_name=nome_banco)"default charset do banco de dados",
	(select sum((select count(*) 
	               from information_schema.tables 
				  where table_schema=nome_banco 
				    and table_type='base table')+(select count(*) 
					                                from information_schema.statistics 
												   where table_schema=nome_banco)+(select count(*) 
												                                    from information_schema.views 
																				   where table_schema=nome_banco)+(select count(*) 
																				                                    from information_schema.routines 
																												   where routine_type ='function' 
																												     and routine_schema=nome_banco)+(select count(*) 
																													                                  from information_schema.routines 
																																					 where routine_type ='procedure' 
																																					   and routine_schema=nome_banco)+(select count(*) 
																																					                                    from information_schema.triggers 
																																													   where trigger_schema=nome_banco)+(select count(*) 
																																													                                      from information_schema.events 
																																																						 where event_schema=nome_banco))) as "total de objetos do banco de dados";

end $$
delimiter ;