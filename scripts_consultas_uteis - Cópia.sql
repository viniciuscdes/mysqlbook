/*
*******************************************
*   Editora: Casa do Código               *
*   Livro..: MySQL do básico ao Avançado  *
*   ISBN...:                              *  
*   Autor..: Vinicius Carvalho de Souza   *
*******************************************

Arquivo: scripts_consultas_uteis.sql

*/


-- Verificar a versão do MySQL
mysql> show variables like 'version%';

-- para consultar os usuarios criados 
mysql> select user,	host 
			  from mysql.user;

-- update no banco de dados
mysql> UPDATE mysql.user SET Password=PASSWORD('MyNewPass') WHERE User='root';
mysql> FLUSH PRIVILEGES;