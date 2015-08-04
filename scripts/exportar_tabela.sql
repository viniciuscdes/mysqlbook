/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
******************************************* 

Não esqueça de atribuir os valores para as variaveis @tabela  e @nome_arquivo!!

set @tabela = nome_tabela;
set @caminho_nome_arquivo = caminho_nome_arquivo;
*/

select * 
  from @tabela 
  into outfile @caminho_nome_arquivo
       fields terminated by ','
       enclosed by '''';