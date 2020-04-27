Este repositorio tem como objetivo facilitar o uso do pacote "DBMS_FILE_TRANSFER", a procedure é utilizada para efetuar copia de arquivos de dados de uma origem para o ambiente atual, na qual a mesma foi instalada.


Na origem, criar o diretorio correspondente ao caminho onde se encontram os seus arquivos de dados
````
create directory S_DIRECTORY as '<+DISKGROUP_NAME>/<DATABASE>/DATAFILE';
````
Os passos a seguir serão executados no ambiente de destino. 

Cadastrar a entrada de TNSNAMES apontando para o banco de dados de origem
````
vi $ORACLE_HOME/network/admin/tnsnames.ora

O_DATABASE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = server01.example)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = DBEXAMPLE)
    )
  )

````
No ambiente de destino, criar o diretorio para onde os arquivos de dados serão copiados
````
CREATE DIRECTORY D_DIRECTORY as '<+DISKGROUP_NAME>/<DATABASE>/DATAFILE';
````

Criar o database link para copiar os arquivos de dados
````
CREATE PUBLIC DATABASE LINK ODBEXAMPLE CONNECT TO SYSTEM IDENTIFIED BY ORACLE USING 'O_DATABASE';
````

Configurando a procedure para cópia

Na tabela de "CONTROL_MIGRATION" devemos cadastrar quais são os diretorios, database link e quantidade de arquivos que serão processados por procedure
````
INSERT INTO CONTROL_MIGRATION VALUES(1,'S_DIRECTORY','D_DIRECTORY','ODBEXAMPLE',3);
COMMIT;
````

Agora devemos inserir os arquivos de dados que queremos copiar
````
INSERT INTO CONTROL_MIGRATION_FILE VALUES (1,'TS_DAT_01.260.821609947','TS_DAT_01.260',0,0);
INSERT INTO CONTROL_MIGRATION_FILE VALUES (1,'TS_DAT_01.261.896570947','TS_DAT_01.261',0,0);
INSERT INTO CONTROL_MIGRATION_FILE VALUES (1,'TS_DAT_01.262.981610876','TS_DAT_01.262',0,0);
COMMIT;

````

Executar a procedure

````
sqlplus -s / as sysdba @proc_migra_datafile.sql
````

Na tabela de log podemos consultar quais são os datafiles que já foram copiados e o tempo percorrido com a consulta abaixo
````
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select  cml.*, trunc(mod(mod(NVL(DT_END,SYSDATE) - DT_START,1)*24,1)*60) as mins from CONTROL_MIGRATION_LOG cml where TO_CHAR(DT_START,'DD/MM/YYYY') = TO_CHAR(SYSDATE,'DD/MM/YYYY');
````


#### Limitações

* Apenas um diretório de origem por vez pode ser copiado;
* Atente-se a Limitações do pacote "DBMS_FILE_TRANSFER";
