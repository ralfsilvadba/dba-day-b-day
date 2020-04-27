CREATE TABLE control_migration (
    id_migration      NUMBER(2) ,
    s_directory       VARCHAR2(50),
    d_directory       VARCHAR2(50),
    s_database_link   VARCHAR2(30),
    nr_lock_files     NUMBER(1)
);


CREATE TABLE control_migration_file (
    id_migration   NUMBER(2),
    s_file_name    VARCHAR2(100),
    d_file_name    VARCHAR2(100),
    fl_stat        NUMBER(1),
    fl_lock        NUMBER(4)
);

CREATE TABLE control_migration_log (
    id_migration   NUMBER(2),
    dt_start       DATE,
    dt_end         DATE,
    d_file_name    VARCHAR2(100)
);

comment on column control_migration.id_migration is 'ID DE CONTROLE DE CONFIGURACAO';
comment on column control_migration.s_directory is 'NOME DO DIRETORIO DE ORIGEM';
comment on column control_migration.d_directory is 'NOME DO DIRETORIO DE DESTINO';
comment on column control_migration.s_database_link is 'NOME DO DATABASE LINK PARA OBTER OS DATAFILES';
comment on column control_migration.nr_lock_files is 'QUANTIDADE DE ARQUIVOS QUE A PROC VAI PROCESSAR POR VEZ';

comment on column control_migration_file.id_migration is 'ID DE REFERENCIA DO CONTROLE DE CONFIGURACAO';
comment on column control_migration_file.s_file_name is 'NOME DO DIRETORIO DE ORIGEM';
comment on column control_migration_file.d_file_name is 'NOME DO DIRETORIO DE ORIGEM';
comment on column control_migration_file.fl_stat is 'NOME DO DIRETORIO DE ORIGEM';
comment on column control_migration_file.fl_lock is 'NOME DO DIRETORIO DE ORIGEM';

comment on column control_migration_log.id_migration is 'ID DE REFERENCIA DO CONTROLE DE CONFIGURACAO';
comment on column control_migration_log.dt_start is 'DATA DE INICIO DE COPIA DO DATAFILE';
comment on column control_migration_log.dt_end is 'DATA DE TERMINO DE COPIA DO DATAFILE';
comment on column control_migration_log.d_file_name is 'NOME DO DATAFILE COPIADO';
