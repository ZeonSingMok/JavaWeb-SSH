/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2017/5/16 16:11:33                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('t_Order') and o.name = 'FK_T_ORDER_REFERENCE_T_MOVIES')
alter table t_Order
   drop constraint FK_T_ORDER_REFERENCE_T_MOVIES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('t_Tickets') and o.name = 'FK_T_TICKET_REFERENCE_T_MOVIES')
alter table t_Tickets
   drop constraint FK_T_TICKET_REFERENCE_T_MOVIES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('t_Tickets') and o.name = 'FK_T_TICKET_REFERENCE_T_SHOWRO')
alter table t_Tickets
   drop constraint FK_T_TICKET_REFERENCE_T_SHOWRO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('t_showRoom') and o.name = 'FK_T_SHOWRO_REFERENCE_T_SEAT')
alter table t_showRoom
   drop constraint FK_T_SHOWRO_REFERENCE_T_SEAT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('t_Customer')
            and   type = 'U')
   drop table t_Customer
go

if exists (select 1
            from  sysobjects
           where  id = object_id('t_Manager')
            and   type = 'U')
   drop table t_Manager
go

if exists (select 1
            from  sysobjects
           where  id = object_id('t_Movies')
            and   type = 'U')
   drop table t_Movies
go

if exists (select 1
            from  sysobjects
           where  id = object_id('t_Order')
            and   type = 'U')
   drop table t_Order
go

if exists (select 1
            from  sysobjects
           where  id = object_id('t_Seat')
            and   type = 'U')
   drop table t_Seat
go

if exists (select 1
            from  sysobjects
           where  id = object_id('t_Tickets')
            and   type = 'U')
   drop table t_Tickets
go

if exists (select 1
            from  sysobjects
           where  id = object_id('t_showRoom')
            and   type = 'U')
   drop table t_showRoom
go

/*==============================================================*/
/* Table: t_Customer                                            */
/*==============================================================*/
create table t_Customer (
   C_ID                 char(10)             not null,
   C_Name               varchar(20)          not null,
   C_Password           varchar(20)          not null,
   C_Sex                varchar(10)          not null,
   C_Age                int                  null,
   Balance              int                  null,
   constraint PK_T_CUSTOMER primary key (C_ID)
)
go

/*==============================================================*/
/* Table: t_Manager                                             */
/*==============================================================*/
create table t_Manager (
   M_ID                 char(10)             not null,
   M_Name               varchar(20)          not null,
   M_Password           varchar(20)          not null,
   M_sex                varchar(10)          null,
   M_age                int                  null,
   M_Type               int                  null,
   ID                   int                  identity,
   constraint PK_T_MANAGER primary key (ID)
)
go

/*==============================================================*/
/* Table: t_Movies                                              */
/*==============================================================*/
create table t_Movies (
   MovieID              char(10)             not null,
   MovieName            varchar(25)          not null,
   RealeseTime          date                 not null,
   constraint PK_T_MOVIES primary key (MovieID)
)
go

/*==============================================================*/
/* Table: t_Order                                               */
/*==============================================================*/
create table t_Order (
   Order_ID             varchar(10)          not null,
   MovieID              char(10)             null,
   MovieName            varcahr(25)          not null,
   C_Name               varchar(20)          not null,
   Price                int                  null,
   Status               varchar(10)          not null,
   Poll                 int                  null,
   constraint PK_T_ORDER primary key (Order_ID)
)
go

/*==============================================================*/
/* Table: t_Seat                                                */
/*==============================================================*/
create table t_Seat (
   Seat_ID              varchar(20)          not null,
   Seat                 varchar(20)          not null,
   constraint PK_T_SEAT primary key (Seat_ID, Seat)
)
go

/*==============================================================*/
/* Table: t_Tickets                                             */
/*==============================================================*/
create table t_Tickets (
   T_ID                 char(10)             not null,
   MovieID              char(10)             null,
   SR_ID                char(10)             null,
   Price                int                  null,
   MovieName            varchar(25)          null,
   C_Name               varchar(25)          null,
   constraint PK_T_TICKETS primary key (T_ID)
)
go

/*==============================================================*/
/* Table: t_showRoom                                            */
/*==============================================================*/
create table t_showRoom (
   SR_ID                char(10)             not null,
   Seat_ID              varchar(20)          null,
   Seat                 varchar(20)          null,
   Seat_num             int                  null,
   Seart_ID             varchar(20)          not null,
   constraint PK_T_SHOWROOM primary key (SR_ID)
)
go

alter table t_Order
   add constraint FK_T_ORDER_REFERENCE_T_MOVIES foreign key (MovieID)
      references t_Movies (MovieID)
go

alter table t_Tickets
   add constraint FK_T_TICKET_REFERENCE_T_MOVIES foreign key (MovieID)
      references t_Movies (MovieID)
go

alter table t_Tickets
   add constraint FK_T_TICKET_REFERENCE_T_SHOWRO foreign key (SR_ID)
      references t_showRoom (SR_ID)
go

alter table t_showRoom
   add constraint FK_T_SHOWRO_REFERENCE_T_SEAT foreign key (Seat_ID, Seat)
      references t_Seat (Seat_ID, Seat)
go

 