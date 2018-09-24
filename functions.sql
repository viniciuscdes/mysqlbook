/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
*******************************************

Arquivo: functions.sql

*/

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

mysql> delimiter $$
mysql> create function rt_percentual_comissao(vn_n_numevende int)
			returns float deterministic
			begin
				declare percentual_comissao float(10,2);
				select n_porcvende
					into percentual_comissao
					from comvende
				where n_numevende = vn_n_numevende;
				return percentual_comissao;
			end;
mysql> $$
mysql> delimiter ;


 
