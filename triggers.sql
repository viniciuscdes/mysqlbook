/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
*******************************************

Arquivo: triggers.sql

*/

mysql>  delimiter $$
mysql>  create trigger tri_vendas_bi
		before insert on comvenda 
		for each row

		begin
		  declare percentual_comissao float(10,2);
          declare valor_comissao      float(10,2);
		  
		  ## busco o percentual de comissão que o vendedor deve
		  ## receber
		  select rt_percentual_comissao(new.n_numevende)
		    into percentual_comissao;
		  
		  ## calculo a comissão
		  set valor_comissao = ((new.n_totavenda * percentual_comissao)  / 100);
		  
		  ## recebo no novo valor de comissão
		  set new.n_vcomvenda = valor_comissao;
			
		end
mysql> $$		
mysql> delimiter ;


mysql>  delimiter $$
mysql>  create trigger tri_vendas_bu
		before update on comvenda 
		for each row

		begin
		declare percentual_comissao float(10,2);
		declare valor_comissao      float(10,2);
			
		  ## No update, verifico se o valor total novo da venda
		  ## é diferente do total anterior, pois se forem iguais,
		  ## não há necessidade do cálculo
		  if (old.n_totavenda <> new.n_totavenda) then
		  	select rt_percentual_comissao(new.n_numevende)
		  	  into percentual_comissao;
          
		  	## cálculo da comissão
		  	set 
			valor_comissao = ((new.n_totavenda * percentual_comissao) / 100);

		  	## recebo no novo valor de comissão
		  	set new.n_vcomvenda = valor_comissao;
		  end if;
		end
mysql> $$
mysql> delimiter ;


mysql> delimiter $$
mysql> create trigger tri_vendas_ai
	   after insert on comivenda 
	   for each row
	   begin
	     ## declaro as variáveis que utilizarei
	     declare vtotal_itens float(10,2) default 0;
	     declare total_item   float(10,2) default 0;
		 declare fimLoop boolean default false;

		 ## cursor para buscar os itens já registrados da venda
		 declare busca_itens cursor for
		   select n_valoivenda
		     from comivenda
		    where n_numevenda = new.n_numevenda;
			
		 ##Handler para encerrar o loop antes da última linha
		 declare continue handler for
			sqlstate '02000' 
			set fimLoop = true;
		
		  ## abro o cursor
		  open busca_itens;
		  ## declaro e inicio o loop
		  itens : loop
			fetch busca_itens into total_item;
			
			#encerra o bloco quando o cursor não retornar mais linhas.
			if fimLoop then
				leave itens;
			end if;
		  		  	
		  	## somo o valor total dos itens(produtos)
		  	set vtotal_itens = vtotal_itens + total_item;
          
		  end loop itens;
          
		  close busca_itens;

		  ## atualizo o total da venda
		  update comvenda set n_totavenda = vtotal_itens
		   where n_numevenda = new.n_numevenda;

	     end
mysql> $$
mysql> delimiter ;



mysql> delimiter $$
mysql> create trigger tri_ivendas_au
	   after update on comivenda 
	   for each row
	   begin
	     ## declaro as variáveis que utilizarei
	     declare vtotal_itens float(10,2) default 0;
	     declare total_item  float(10,2) default 0;
         declare fimLoop boolean default false;
		 
		 ## cursor para buscar os itens já registrados da venda
		   declare busca_itens cursor for
		   	select n_valoivenda
		   	  from comivenda
		   	 where n_numevenda = new.n_numevenda;
		 
		 ##Handler para encerrar o loop antes da última linha
		   declare continue handler for
			sqlstate '02000' 
			set fimLoop = true;
		
		 
	     ## verifico se há necessidade de alteração
	     ## faço somente se o novo valor for alterado
	     if new.n_valoivenda <> old.n_valoivenda then 

		   ## abro o cursor
		   open busca_itens;
		     ## declaro e inicio o loop
		     itens : loop
             
		     fetch busca_itens into total_item;
			 
			 #encerra o bloco quando o cursor não retornar mais linhas.
			 if fimLoop then
				leave itens;
			 end if;
			 
		     ## somo o valor total dos itens(produtos)
		     set vtotal_itens = vtotal_itens + total_item;
           
		   end loop itens;

           close busca_itens;
           
           ## atualizo o total da venda
           update comvenda set n_totavenda = vtotal_itens
            where n_numevenda = new.n_numevenda;
           
		 end if;
	   end
mysql> $$
mysql> delimiter ;



mysql> delimiter $$
mysql> create trigger tri_ivendas_af
	   after delete on comivenda 
	   for each row
	   begin
	     ## declaro as variáveis que utilizarei
	     declare vtotal_itens float(10,2) default 0;
	     declare total_item  float(10,2) default 0;
         declare fimLoop boolean default false;
	     
	     ## cursor para buscar os itens já registrados da venda
	     declare busca_itens cursor for
	       select n_valoivenda
		     from comivenda
		    where n_numevenda = old.n_numevenda;
         
		 ##Handler para encerrar o loop antes da última linha
		   declare continue handler for
			sqlstate '02000' 
			set fimLoop = true;
		 
	     ## abro o cursor
	     open busca_itens;
	     
         ## declaro e inicio o loop
	     itens : loop
         
	       fetch busca_itens into total_item;
		   
		   #encerra o bloco quando o cursor não retornar mais linhas.
		   if fimLoop then
			leave itens;
		   end if;
		   
	       ## somo o valor total dos itens(produtos)
	       set vtotal_itens = vtotal_itens + total_item;
         
	     end loop itens;
         
         close busca_itens;
         
         ## atualizo o total da venda 
         update comvenda set n_totavenda = vtotal_itens
          where n_numevenda = old.n_numevenda;
		  		 		
	    end
mysql> $$
mysql> delimiter ;



mysql> delimiter $$
mysql> create trigger tri_vendas_bf
	   before delete on comvenda 
	   for each row
	   begin
	     ## declaro as variáveis que utilizarei
	     declare vtotal_itens float(10,2) default 0;
	     declare total_item  float(10,2) default 0;
         declare fimLoop boolean default false;
		 
	     ## verifico se há necessidade de alteração
	     ## faço somente se o novo valor for alterado
	     ## cursor para buscar os itens já registrados da venda
 	     	declare busca_itens cursor for 
	         select n_valoivenda
	     	   from comivenda
	     	  where n_numevenda = old.n_numevenda;
         
		 ##Handler para encerrar o loop antes da última linha
			declare continue handler for
			 sqlstate '02000' 
			 set fimLoop = true;
		 
	     ## abro o cursor
	     open busca_itens;
	     ## declaro e inicio o loop
	       itens : loop 
           
	         fetch busca_itens into total_item;
			 
			 #encerra o bloco quando o cursor não retornar mais linhas.
			 if fimLoop then
				leave itens;
			 end if;
			 
	         ## somo o valor total dos itens(produtos)
	         set vtotal_itens = vtotal_itens + total_item;
           
	       end loop itens;
         
	    close busca_itens;
         
	    ## atualizo o total da venda
	    delete from comivenda where n_numevenda = old.n_numevenda;
	   end
mysql> $$
mysql> delimiter ;
