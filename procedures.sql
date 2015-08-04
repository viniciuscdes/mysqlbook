/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
*******************************************

Arquivo: procedures.sql

*/


mysql> delimiter $$
mysql>create procedure processa_comissionamento(
		in  data_inicial     date,
        in  data_final       date  ,
		out total_processado int )
		begin
			
			declare total_venda    float(10,2) default 0;
			declare venda          int         default 0;
			declare vendedor       int         default 0;
			declare comissao       float(10,2) default 0;
			declare valor_comissao float(10,2) default 0;
			declare aux            int         default 0;
			
			## cursor para buscar os registros a serem 
			## processados entre a data inicial e data final
			## e valor total de venda é maior que zero
			declare busca_pedido cursor for 
				select n_numevenda,
				       n_totavenda,
					   n_numevende
				  from comvenda
				 where d_datavenda between data_inicial 
				 	and data_final
				  	and n_totavenda > 0 ;
				
            ## abro o cursor				
			open busca_pedido;
				
				## inicio do loop
				vendas: LOOP
				
				##recebo o resultado da consulta em cada variável
				fetch busca_pedido into venda, total_venda, 
				vendedor;
				
				## busco o valor do percentual de cada vendedor
				select n_porcvende 
			      into comissao 
			      from comvende
			     where n_numevende = vendedor;
				
				## verifico se o percentual do vendedor é maior
				## que zero logo após a condição deve ter o then
				if (comissao > 0 ) then 
				    ## calculo o valor da comissao
					set valor_comissao  = 
						((total_venda * comissao)  / 100);
					
					## faço o update na tabela comvenda com o 
					## valor da comissão
					update comvenda set 
					n_vcomvenda = valor_comissao
					where n_numevenda = vendedor;
					commit; 
				
				## verifico se o percentual do vendedor é igual 
				## zero na regra do nosso sistema se o vendedor 
				## tem 0 ele ganha 0 porcento de comissão
                elseif(comissao = 0) then
				    
					update comvenda set n_vcomvenda = 0
					where n_numevenda = vendedor;
					commit;
				
				## se ele não possuir registro no percentual de 
			    ## comissão ele irá ganhar 1 de comissão
				## isso pela regra de negócio do nosso sistema
				else 
					set comissao = 1;
					set valor_comissao = 
						((total_venda * comissao)  / 100);
					
					update 
						comvenda set n_vcomvenda = valor_comissao
					where n_numevenda = vendedor;
					commit;  
				## fecho o if	 
				end if;
				
				set comissao = 0;
				##utilizo a variável aux para contar a quantidade
				set  aux      = aux +1 ;
			end loop vendas;
				## atribuo o total de vendas para a variável de
				## saída
			set total_processado = aux;
			## fecho o cursor
			close busca_pedido;
		
			##retorno o total de vendas processadas
			
			
			end$$
			
mysql>delimiter ;	


mysql> call 
		processa_comissionamento('2015-01-01','2015-05-30' ,@a);
mysql> select @a;




mysql>delimiter $$
mysql> create function rt_nome_cliente(vn_numeclien int)
			returns varchar(50)
			
			begin
		
				declare nome varchar(50);
			
				select c_nomeclien  into nome
				  from comclien
				where n_numeclien = vn_numeclien;
			 
				return nome;
			 
			end $$
mysql> delimiter ;	   


mysql> select c_codivenda, 
              rt_nome_cliente(n_numeclien), 
			  d_datavenda
         from comvenda
        order by 2,3;
		
		
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