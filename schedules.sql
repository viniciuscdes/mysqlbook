/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
*******************************************



*/

		
mysql> delimiter $$
mysql> create event processa_comissao
	   on schedule every 1 week starts '2015-03-01 23:38:00'
	   do 
	     begin		           
		   call processa_comissionamento( 
		   	current_date() - interval 7 day, 
			current_date(), @a );
		 end 
mysql> $$
mysql> delimiter ;	

mysql> select c_codivenda Codigo, 
              n_totavenda Total, 
			  n_vcomvenda Comissao
         from comvenda
		where 
			d_datavenda between current_date() - interval 60 day 
		    and current_date();
			
			
			
mysql> delimiter $$
mysql> create event processa_comissao_event
	   on schedule every 10 minute
	   starts current_timestamp
	   ends current_timestamp + interval 30 minute
	   do
		begin
		   call processa_comissionamento( 
		   	current_date() - interval 7 day, 
		    current_date(), 
			@a);
		end 
mysql> $$    
Query OK, 0 rows affected (0.02 sec)

mysql> delimiter ;	