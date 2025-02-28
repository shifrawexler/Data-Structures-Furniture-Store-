prompt PL/SQL Developer import file
prompt Created on Monday, 12 June 2023 by Eliana
set feedback off
set define off
prompt Creating COFFEE_SHOP...
create table COFFEE_SHOP
(
  shop_id       INTEGER not null,
  sphone_number INTEGER not null,
  area          INTEGER not null,
  state         INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COFFEE_SHOP
  add primary key (SHOP_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating LOCATIONS...
create table LOCATIONS
(
  lid       NUMBER(4) not null,
  area_name VARCHAR2(15) not null,
  state     INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LOCATIONS
  add primary key (LID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CUSTOMER...
create table CUSTOMER
(
  cid           INTEGER not null,
  cname         VARCHAR2(15) not null,
  cphone_number NUMBER(10) not null,
  lid           NUMBER(4)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMER
  add primary key (CID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMER
  add foreign key (LID)
  references LOCATIONS (LID);

prompt Creating BRANCH...
create table BRANCH
(
  bid   NUMBER(3) not null,
  bname VARCHAR2(15) not null,
  lid   NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BRANCH
  add primary key (BID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BRANCH
  add foreign key (LID)
  references LOCATIONS (LID);

prompt Creating EMPLOYEE...
create table EMPLOYEE
(
  eid           INTEGER not null,
  ename         VARCHAR2(150) not null,
  ephone_number NUMBER(10) not null,
  bid           NUMBER(3),
  shop_id       INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index INX_ENAME on EMPLOYEE (ENAME)
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYEE
  add primary key (EID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYEE
  add constraint FK_EMPLOYEE_COFFEE_SHOP foreign key (SHOP_ID)
  references COFFEE_SHOP (SHOP_ID);
alter table EMPLOYEE
  add foreign key (BID)
  references BRANCH (BID);

prompt Creating ORDERS...
create table ORDERS
(
  ordrid         INTEGER not null,
  order_price    FLOAT,
  order_date     DATE,
  cid            INTEGER,
  description    INTEGER,
  time_completed INTEGER,
  eid            INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index INX_ORDER_PRICE on ORDERS (ORDER_PRICE)
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add primary key (ORDRID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add constraint FK_ORDERS_EMPLOYEE foreign key (EID)
  references EMPLOYEE (EID);
alter table ORDERS
  add foreign key (CID)
  references CUSTOMER (CID);

prompt Creating BILL...
create table BILL
(
  bill_id      INTEGER not null,
  bill_date    INTEGER not null,
  tip          INTEGER not null,
  total        INTEGER not null,
  bill_time    INTEGER not null,
  descriptions INTEGER not null,
  ordrid       NUMBER(3),
  shop_id      INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index INX_BILL_DATE on BILL (BILL_DATE)
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BILL
  add primary key (BILL_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BILL
  add foreign key (ORDRID)
  references ORDERS (ORDRID);
alter table BILL
  add foreign key (SHOP_ID)
  references COFFEE_SHOP (SHOP_ID);
alter table BILL
  add constraint CHECK_BILL_TOTAL
  check (total >= 0);

prompt Creating INVTYPE...
create table INVTYPE
(
  tid   NUMBER(3) not null,
  tname VARCHAR2(15) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INVTYPE
  add primary key (TID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SUPPLIERS...
create table SUPPLIERS
(
  sid   NUMBER(3) not null,
  sname VARCHAR2(15) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SUPPLIERS
  add primary key (SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating INVENTORY...
create table INVENTORY
(
  iid    INTEGER not null,
  iname  VARCHAR2(150) not null,
  color  VARCHAR2(15) default 'Brown',
  price  FLOAT not null,
  tid    NUMBER(3),
  sid    NUMBER(3),
  ordrid NUMBER(3),
  notes  VARCHAR2(200)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INVENTORY
  add primary key (IID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INVENTORY
  add foreign key (TID)
  references INVTYPE (TID);
alter table INVENTORY
  add foreign key (SID)
  references SUPPLIERS (SID);
alter table INVENTORY
  add foreign key (ORDRID)
  references ORDERS (ORDRID);

prompt Creating SHOPS...
create table SHOPS
(
  cid NUMBER(3) not null,
  bid NUMBER(3) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SHOPS
  add primary key (CID, BID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SHOPS
  add foreign key (CID)
  references CUSTOMER (CID);
alter table SHOPS
  add foreign key (BID)
  references BRANCH (BID);

prompt Disabling triggers for COFFEE_SHOP...
alter table COFFEE_SHOP disable all triggers;
prompt Disabling triggers for LOCATIONS...
alter table LOCATIONS disable all triggers;
prompt Disabling triggers for CUSTOMER...
alter table CUSTOMER disable all triggers;
prompt Disabling triggers for BRANCH...
alter table BRANCH disable all triggers;
prompt Disabling triggers for EMPLOYEE...
alter table EMPLOYEE disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for BILL...
alter table BILL disable all triggers;
prompt Disabling triggers for INVTYPE...
alter table INVTYPE disable all triggers;
prompt Disabling triggers for SUPPLIERS...
alter table SUPPLIERS disable all triggers;
prompt Disabling triggers for INVENTORY...
alter table INVENTORY disable all triggers;
prompt Disabling triggers for SHOPS...
alter table SHOPS disable all triggers;
prompt Disabling foreign key constraints for CUSTOMER...
alter table CUSTOMER disable constraint SYS_C007736;
prompt Disabling foreign key constraints for BRANCH...
alter table BRANCH disable constraint SYS_C007740;
prompt Disabling foreign key constraints for EMPLOYEE...
alter table EMPLOYEE disable constraint FK_EMPLOYEE_COFFEE_SHOP;
alter table EMPLOYEE disable constraint SYS_C007746;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint FK_ORDERS_EMPLOYEE;
alter table ORDERS disable constraint SYS_C007750;
prompt Disabling foreign key constraints for BILL...
alter table BILL disable constraint SYS_C007759;
alter table BILL disable constraint SYS_C007760;
prompt Disabling foreign key constraints for INVENTORY...
alter table INVENTORY disable constraint SYS_C007772;
alter table INVENTORY disable constraint SYS_C007773;
alter table INVENTORY disable constraint SYS_C007774;
prompt Disabling foreign key constraints for SHOPS...
alter table SHOPS disable constraint SYS_C007778;
alter table SHOPS disable constraint SYS_C007779;
prompt Deleting SHOPS...
delete from SHOPS;
commit;
prompt Deleting INVENTORY...
delete from INVENTORY;
commit;
prompt Deleting SUPPLIERS...
delete from SUPPLIERS;
commit;
prompt Deleting INVTYPE...
delete from INVTYPE;
commit;
prompt Deleting BILL...
delete from BILL;
commit;
prompt Deleting ORDERS...
delete from ORDERS;
commit;
prompt Deleting EMPLOYEE...
delete from EMPLOYEE;
commit;
prompt Deleting BRANCH...
delete from BRANCH;
commit;
prompt Deleting CUSTOMER...
delete from CUSTOMER;
commit;
prompt Deleting LOCATIONS...
delete from LOCATIONS;
commit;
prompt Deleting COFFEE_SHOP...
delete from COFFEE_SHOP;
commit;
prompt Loading COFFEE_SHOP...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (1, 2127250637, 10016, 1);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (2, 2136260466, 90071, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (3, 3055344613, 33139, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (4, 856235941, 22502, 25);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (5, 193778848, 30055, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (6, 376877815, 26067, 26);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (8, 165421814, 35970, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (9, 517228855, 26152, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (10, 626132637, 3645, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (12, 985159896, 21580, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (14, 616118424, 28214, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (15, 827819544, 5749, 45);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (16, 519533451, 25842, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (18, 288385829, 16423, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (19, 279667863, 26126, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (21, 338449361, 30057, 45);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (22, 395628182, 7429, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (23, 139393175, 40235, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (24, 154377129, 16215, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (25, 155816195, 17815, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (26, 486428528, 40909, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (27, 595634448, 8924, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (28, 123425549, 34423, 18);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (29, 722131418, 34713, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (30, 119233124, 32922, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (31, 573919799, 37875, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (32, 551276957, 31543, 32);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (33, 215348714, 35810, 73);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (34, 239148448, 4805, 89);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (36, 724286133, 32952, 60);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (37, 641861331, 11753, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (38, 862233777, 34330, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (40, 747454135, 29094, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (41, 525143418, 13482, 58);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (42, 171893984, 38172, 7);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (43, 971182934, 33376, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (46, 197939732, 29910, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (47, 253153621, 1828, 58);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (48, 358844359, 27554, 21);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (49, 268245813, 6960, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (50, 657964513, 9900, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (51, 691826738, 21074, 11);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (52, 836825896, 24256, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (53, 719837837, 3289, 19);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (54, 796879744, 18000, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (55, 561887752, 20846, 42);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (56, 451889895, 15309, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (57, 236579363, 4779, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (58, 257444691, 22291, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (59, 668963954, 7526, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (61, 777118161, 4756, 12);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (62, 727188489, 3591, 69);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (63, 316195393, 39728, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (65, 563992541, 10146, 92);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (66, 394287561, 5926, 69);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (67, 273991582, 11076, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (68, 661532788, 3857, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (69, 148198411, 25089, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (70, 638529361, 18754, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (71, 579447939, 8484, 89);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (72, 785443975, 25067, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (73, 479697544, 33463, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (74, 428373795, 31581, 19);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (75, 376778432, 39630, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (76, 796191385, 25170, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (78, 762346986, 17642, 36);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (79, 565846135, 28470, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (80, 742737231, 35795, 16);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (81, 143743713, 8619, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (82, 984492963, 35062, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (83, 734123482, 34549, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (84, 913269967, 27660, 30);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (85, 561675683, 11221, 30);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (86, 653919146, 33465, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (87, 549711279, 13581, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (88, 394665488, 40497, 51);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (89, 562934478, 20651, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (90, 983833855, 6114, 35);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (91, 555197518, 33674, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (94, 616246112, 34591, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (95, 611159258, 25036, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (96, 356331666, 12224, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (97, 125668714, 18349, 78);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (98, 473215482, 7248, 66);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (99, 612777345, 31309, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (100, 446149528, 18723, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (101, 494259891, 5882, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (102, 484419763, 17290, 79);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (103, 794871612, 13536, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (106, 331358844, 14645, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (107, 915959119, 29788, 69);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (108, 427364479, 28191, 85);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (109, 745198912, 2336, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (110, 799617495, 12102, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (111, 945931312, 4102, 38);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (112, 147844638, 8990, 49);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (113, 525758416, 4413, 16);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (114, 191971742, 22136, 57);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (115, 625128889, 9104, 25);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (116, 278941994, 16478, 2);
commit;
prompt 100 records committed...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (117, 192444867, 28346, 30);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (118, 352532449, 15674, 66);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (119, 578692277, 23223, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (120, 684348214, 22581, 45);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (122, 929514656, 4210, 79);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (123, 644912192, 1776, 43);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (124, 743481648, 10292, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (125, 585625329, 39540, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (126, 581794485, 12972, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (127, 925434672, 26524, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (129, 955213292, 12494, 16);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (130, 663398777, 16285, 43);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (131, 242155631, 37556, 45);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (132, 983557566, 40009, 7);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (133, 165574783, 17435, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (134, 557222262, 7218, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (135, 919749697, 31322, 89);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (136, 761596696, 11803, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (137, 134182832, 16815, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (138, 188477944, 14752, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (139, 161246392, 27332, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (140, 985877281, 1094, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (141, 273541655, 16376, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (142, 978666447, 9421, 8);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (143, 882748914, 13746, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (144, 998615994, 27593, 15);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (145, 533955256, 17857, 99);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (146, 715584563, 34035, 92);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (147, 779314169, 24763, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (148, 234244277, 35414, 69);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (149, 656595833, 27088, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (150, 491682278, 29180, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (151, 431216744, 9279, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (152, 899197569, 2008, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (153, 137488175, 32906, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (154, 731822136, 3137, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (156, 973843427, 3005, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (157, 764685818, 40258, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (159, 319295428, 13556, 75);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (160, 771338959, 36604, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (162, 823177664, 1773, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (163, 282223298, 16061, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (164, 225265725, 40505, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (165, 972434512, 20240, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (166, 385647676, 35369, 36);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (167, 758458465, 20027, 51);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (168, 569419791, 40246, 10);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (169, 229417681, 24614, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (171, 499957377, 21881, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (172, 445234749, 8542, 57);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (173, 942836656, 1185, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (174, 291747934, 14627, 57);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (175, 519228554, 37906, 75);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (176, 863252571, 25735, 60);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (177, 616372139, 23669, 42);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (178, 696676577, 3188, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (179, 729546984, 30177, 76);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (180, 178186534, 20637, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (181, 863117982, 23665, 55);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (182, 954967977, 19361, 79);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (183, 161446484, 14099, 67);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (184, 474686534, 15427, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (185, 753276296, 12718, 94);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (186, 597399468, 30435, 40);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (187, 817113723, 5043, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (188, 959144694, 7770, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (189, 585442935, 10102, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (190, 388716242, 30584, 100);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (191, 779984159, 40467, 67);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (192, 484964673, 33248, 82);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (193, 424387788, 27899, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (194, 371567919, 6246, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (195, 154332542, 28510, 30);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (196, 982591489, 14905, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (197, 523996133, 37268, 48);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (198, 842929415, 17869, 36);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (199, 826243574, 16905, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (200, 846525544, 38074, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (201, 388416114, 32164, 26);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (202, 132578674, 13335, 38);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (203, 876374774, 11286, 10);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (204, 135318769, 24197, 46);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (205, 199492295, 27494, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (206, 671476429, 29311, 84);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (207, 847371753, 36854, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (208, 665399966, 15639, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (209, 484677837, 7487, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (211, 598646715, 22271, 26);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (212, 355399874, 40849, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (213, 988675988, 23962, 76);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (214, 351596996, 39401, 99);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (215, 535212437, 40061, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (217, 646559396, 18295, 10);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (218, 149693328, 16660, 79);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (219, 129151221, 24410, 19);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (220, 147959616, 21875, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (221, 312676495, 31313, 78);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (222, 532795884, 40583, 69);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (223, 868154288, 35457, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (225, 772242981, 39843, 26);
commit;
prompt 200 records committed...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (226, 956658647, 17854, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (227, 871111191, 15452, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (228, 395175461, 34723, 7);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (229, 947413814, 37584, 84);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (230, 176534444, 32883, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (231, 462233678, 19284, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (232, 713999895, 34868, 7);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (233, 718448224, 37352, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (234, 257779331, 39638, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (235, 437135346, 16999, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (237, 244366327, 15440, 78);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (238, 586522987, 18729, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (239, 191116837, 9042, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (240, 549456653, 30372, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (242, 574679678, 26019, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (243, 868226544, 4239, 11);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (245, 646269535, 27032, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (246, 541535871, 16063, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (247, 753776986, 16654, 73);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (248, 269515369, 40158, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (249, 661957646, 31742, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (251, 758921978, 14842, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (252, 784167626, 35924, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (253, 392624733, 31652, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (254, 132295137, 4596, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (255, 625474874, 9392, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (256, 126188157, 23400, 42);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (257, 994366855, 35629, 6);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (258, 946172753, 34944, 48);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (259, 347864651, 31462, 10);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (260, 794822373, 26759, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (261, 222875193, 36321, 27);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (262, 575849552, 25234, 16);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (263, 386628211, 15073, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (265, 299147589, 6096, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (266, 616711755, 2828, 18);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (267, 451651196, 35377, 18);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (268, 389914335, 7170, 12);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (269, 833168846, 24782, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (270, 155623684, 40449, 67);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (271, 454273548, 29611, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (272, 549493119, 15587, 67);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (273, 986563114, 15259, 25);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (274, 647936217, 1339, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (276, 591699971, 18645, 48);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (277, 293279366, 35597, 48);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (278, 773647345, 36767, 22);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (279, 331585568, 32554, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (280, 698778667, 5298, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (281, 334796895, 10108, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (282, 853379259, 8823, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (283, 528756566, 26807, 49);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (284, 513481759, 12128, 37);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (285, 536337978, 11495, 57);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (286, 785771837, 12201, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (287, 995492933, 29990, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (288, 525183385, 18683, 56);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (289, 315197968, 5564, 84);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (290, 944131146, 19141, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (291, 929611653, 39411, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (292, 554741395, 21486, 100);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (293, 876784344, 18326, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (294, 413981461, 28700, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (295, 211743552, 36150, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (296, 732837486, 27934, 15);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (297, 517872172, 18302, 49);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (298, 185658884, 31937, 46);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (300, 735693733, 7687, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (301, 375389494, 6115, 22);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (302, 354683696, 1879, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (303, 786625618, 34792, 67);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (304, 353384383, 29542, 73);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (305, 818377949, 16158, 100);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (306, 952468847, 4972, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (308, 992444152, 32448, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (309, 257354335, 18158, 73);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (310, 998667822, 32602, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (311, 633283877, 14512, 48);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (312, 239833883, 24801, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (313, 938346988, 19234, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (315, 672113195, 24931, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (316, 997196514, 31542, 55);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (317, 578526687, 6989, 60);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (318, 694961911, 11946, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (319, 112671729, 20780, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (320, 118197135, 22438, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (321, 497844248, 10588, 49);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (322, 437268876, 32721, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (323, 379878438, 8058, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (325, 672133575, 4781, 49);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (326, 857398523, 7689, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (327, 224354358, 40573, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (328, 222228535, 35821, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (329, 475632595, 4719, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (330, 716383779, 22527, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (331, 482255989, 13965, 40);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (332, 635881839, 36859, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (333, 996839285, 34705, 57);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (334, 488629795, 27357, 42);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (335, 124175692, 21158, 73);
commit;
prompt 300 records committed...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (336, 623858165, 34954, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (337, 984782883, 5385, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (338, 989591462, 30980, 16);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (339, 192666217, 7503, 45);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (340, 968532372, 28993, 26);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (341, 322494837, 24529, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (342, 328669355, 28335, 38);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (343, 749651333, 22429, 76);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (344, 425322129, 21312, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (345, 447956781, 30960, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (346, 692634864, 6091, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (347, 426415282, 29495, 61);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (348, 135143737, 24077, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (349, 219747548, 32291, 18);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (350, 573897429, 11319, 36);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (351, 217972214, 1865, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (352, 157978386, 18438, 1);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (353, 287916144, 26598, 25);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (357, 186415293, 37626, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (358, 952937916, 32077, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (359, 331351968, 28099, 66);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (360, 977211447, 17925, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (361, 424692496, 38309, 78);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (362, 394112791, 4296, 82);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (363, 263258162, 5905, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (364, 243198598, 28063, 21);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (365, 424298452, 24271, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (366, 898173377, 2485, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (367, 564796373, 37762, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (368, 793795652, 29231, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (369, 921497383, 3555, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (370, 675326645, 25781, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (371, 338421241, 21722, 8);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (372, 189475891, 40085, 30);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (373, 859788531, 40326, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (374, 811665797, 3725, 49);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (375, 342337567, 5964, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (376, 912214459, 26957, 100);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (377, 316182797, 11508, 35);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (378, 281636471, 25004, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (379, 268921748, 23851, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (380, 948396737, 36727, 15);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (381, 342444276, 1162, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (382, 396857547, 20585, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (383, 441399853, 40643, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (384, 148442956, 9708, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (385, 651967513, 19186, 26);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (386, 529454659, 4566, 85);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (387, 318564614, 10498, 73);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (388, 432221266, 31332, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (389, 398736199, 10223, 26);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (390, 354994986, 10614, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (392, 422919818, 38232, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (393, 687851992, 38937, 56);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (394, 732834193, 23575, 90);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (395, 234869556, 22002, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (396, 239822193, 7029, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (397, 481559518, 27272, 69);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (398, 152828482, 10308, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (399, 212516995, 37231, 6);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (400, 341847252, 19329, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (402, 668765595, 33600, 76);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (403, 152424981, 5400, 52);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (404, 299736337, 11978, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (405, 654255921, 19180, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (406, 859844261, 28474, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (407, 865215275, 23512, 43);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (408, 468585183, 38996, 51);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (409, 389255349, 23160, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (411, 282936927, 24690, 61);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (413, 461373363, 11297, 56);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (414, 126838426, 30540, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (415, 429776146, 15014, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (416, 883586931, 13104, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (417, 774979773, 2407, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (418, 314184921, 15491, 60);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (419, 833614888, 6947, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (420, 165573773, 28017, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (421, 234174689, 11222, 92);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (422, 929536997, 30196, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (423, 424571573, 7205, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (424, 133439283, 23139, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (425, 953247474, 21586, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (426, 623766341, 13268, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (427, 385684821, 19064, 57);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (430, 115844894, 5100, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (431, 617594317, 26519, 35);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (432, 434731147, 17694, 15);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (434, 453515197, 37468, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (435, 283697136, 30546, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (436, 667713529, 19614, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (437, 274647728, 33424, 35);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (439, 998632432, 9811, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (440, 427824948, 34136, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (441, 571464877, 8476, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (442, 964265386, 22965, 42);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (443, 916979347, 23502, 82);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (447, 613572895, 29392, 40);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (448, 558277917, 26003, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (449, 815622957, 24064, 5);
commit;
prompt 400 records committed...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (450, 238379998, 3274, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (451, 344937744, 9270, 30);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (453, 367954333, 2002, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (454, 235594698, 30815, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (455, 585496626, 21834, 75);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (456, 746213236, 22893, 40);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (457, 178162194, 37040, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (458, 789814791, 29554, 42);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (459, 766974828, 28234, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (460, 471212296, 13826, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (461, 643287793, 21321, 11);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (462, 766193763, 16981, 45);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (463, 957911971, 39200, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (464, 114597212, 14949, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (465, 453229686, 18649, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (466, 462336371, 34372, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (467, 968531235, 15816, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (468, 712934381, 17829, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (469, 373641271, 36416, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (470, 852153334, 22623, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (471, 647526771, 25033, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (472, 862215686, 3866, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (473, 528974185, 14382, 99);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (475, 343483574, 20543, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (476, 641596763, 19583, 64);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (477, 771984452, 17267, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (478, 817481898, 12028, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (479, 371664357, 3952, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (481, 653631878, 37649, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (482, 152267454, 4669, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (483, 264929256, 15524, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (484, 843713883, 13160, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (485, 243772297, 9903, 51);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (486, 786518399, 20825, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (487, 861746247, 2208, 6);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (488, 149912164, 23931, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (489, 295854969, 7963, 62);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (490, 132993394, 10128, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (491, 797187793, 3223, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (492, 235959527, 28230, 60);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (493, 773373753, 10538, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (494, 133996424, 5763, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (496, 317219446, 27875, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (497, 262822266, 20562, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (498, 616387777, 1558, 55);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (499, 557568383, 22798, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (500, 112931753, 14261, 19);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (501, 751923255, 2076, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (502, 414365918, 16737, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (503, 968956871, 5755, 73);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (504, 271231363, 24845, 42);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (505, 458182745, 31859, 6);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (506, 471435749, 8770, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (508, 457768574, 35856, 94);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (509, 289373988, 33726, 76);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (510, 539741581, 28274, 79);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (511, 216953252, 8252, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (512, 942115967, 21937, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (513, 422615757, 35866, 76);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (514, 171629692, 33227, 82);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (515, 175695988, 39831, 6);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (516, 121115139, 25805, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (517, 161499286, 26016, 94);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (518, 392113681, 24302, 92);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (519, 885574319, 13089, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (520, 823321786, 7448, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (521, 686826545, 1283, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (522, 255424261, 8417, 63);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (523, 534424813, 21060, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (524, 983313378, 16758, 75);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (526, 232559292, 39544, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (527, 537492355, 18584, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (528, 184528366, 14102, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (529, 513667164, 23616, 75);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (531, 679782539, 17883, 32);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (532, 875681156, 8833, 85);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (534, 134242213, 29230, 35);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (536, 765196123, 35209, 45);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (538, 368268367, 26034, 85);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (539, 291131496, 1947, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (540, 779976878, 6159, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (541, 766913354, 13619, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (543, 822353233, 23013, 43);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (544, 747155447, 21601, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (545, 417615964, 2741, 52);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (546, 188544312, 36573, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (547, 582468375, 24912, 52);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (548, 362889387, 20210, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (549, 846639244, 16825, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (550, 718273723, 34992, 90);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (551, 613537334, 16256, 79);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (552, 395937995, 6958, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (553, 797136137, 30831, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (554, 921593213, 28949, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (555, 957345346, 8143, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (556, 815955518, 24486, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (557, 996147919, 28027, 7);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (558, 312852864, 31865, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (559, 877527862, 27091, 8);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (561, 552422317, 34387, 67);
commit;
prompt 500 records committed...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (563, 175975398, 40950, 51);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (564, 576296178, 34817, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (565, 896578892, 10446, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (566, 771681359, 17971, 94);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (567, 984329299, 6106, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (568, 717499215, 33304, 58);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (569, 866171255, 25418, 37);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (570, 665683165, 29129, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (571, 899128736, 10145, 75);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (572, 932525755, 4738, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (573, 972839753, 37832, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (574, 479762457, 11546, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (575, 357332685, 28693, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (576, 924353163, 30214, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (577, 138942831, 35937, 10);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (578, 416377683, 36478, 22);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (579, 788937979, 6329, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (580, 653961936, 28124, 11);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (581, 181398833, 15418, 71);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (582, 685736965, 35353, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (583, 961914549, 22734, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (584, 973318616, 20501, 55);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (585, 746578521, 28896, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (586, 973485197, 16015, 35);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (587, 695471691, 23592, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (590, 575521292, 6923, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (591, 597611656, 16035, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (592, 388612364, 18016, 38);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (593, 714961923, 21159, 61);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (594, 954521842, 26246, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (595, 739168141, 17381, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (596, 653278921, 37560, 58);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (597, 231813587, 12740, 90);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (598, 857482811, 39941, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (599, 953166229, 2353, 43);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (600, 724163332, 11631, 19);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (601, 924719437, 21489, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (602, 463766331, 35172, 61);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (604, 557627362, 37737, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (605, 769173833, 21060, 99);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (606, 312438578, 25487, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (608, 813733993, 4919, 100);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (609, 415447453, 32868, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (610, 974327234, 33767, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (612, 127894217, 25683, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (613, 186827867, 15179, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (615, 766966182, 2348, 36);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (616, 675834536, 24139, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (617, 932428287, 22927, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (619, 844156345, 4281, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (620, 198513333, 24521, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (622, 825683165, 6650, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (623, 258878562, 19971, 94);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (624, 851788191, 31024, 15);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (625, 654971165, 23281, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (626, 729651993, 9965, 90);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (627, 651672755, 30411, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (628, 944668932, 12639, 58);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (629, 765357983, 26743, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (630, 757816624, 5112, 67);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (631, 726785596, 8792, 54);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (632, 974572325, 32313, 82);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (633, 815936535, 14552, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (634, 858797589, 17683, 81);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (635, 984692656, 32138, 37);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (636, 265965726, 21768, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (637, 316595816, 27241, 61);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (638, 177422668, 17720, 90);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (639, 818523878, 15610, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (640, 698159644, 20237, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (641, 226281124, 32324, 18);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (642, 236359977, 31044, 100);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (643, 834841262, 37739, 31);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (644, 718485385, 31579, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (645, 442178193, 25605, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (646, 181641633, 35584, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (647, 333729554, 39787, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (648, 931331329, 33978, 21);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (649, 279294657, 15741, 85);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (650, 966827921, 6562, 66);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (652, 326171965, 34889, 28);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (653, 636116728, 15256, 16);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (654, 779621176, 12268, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (655, 844552296, 33187, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (656, 285234697, 38527, 34);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (657, 559791774, 22126, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (658, 548555178, 30531, 8);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (659, 912794764, 9600, 30);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (660, 324957213, 22473, 58);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (662, 237331971, 3361, 14);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (663, 524464518, 36710, 69);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (664, 266519966, 25708, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (665, 514611236, 11779, 64);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (666, 749244892, 26901, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (667, 285938333, 13590, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (668, 828264494, 29084, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (669, 845227585, 28803, 22);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (671, 482376731, 37870, 22);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (672, 986463525, 33501, 78);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (673, 857967686, 35273, 28);
commit;
prompt 600 records committed...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (674, 619175978, 34678, 37);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (675, 228941674, 18145, 76);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (676, 188144617, 33638, 96);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (677, 244759698, 12643, 41);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (678, 263686953, 26947, 18);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (679, 368811124, 1116, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (680, 664547678, 37422, 61);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (681, 439267369, 39403, 8);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (682, 117325393, 4831, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (683, 524792516, 7700, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (684, 687924946, 37195, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (685, 348859122, 5907, 68);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (686, 913541537, 34286, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (688, 758638283, 23847, 56);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (689, 589413259, 29566, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (690, 248273936, 8081, 6);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (691, 535165389, 16314, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (692, 151219573, 32842, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (693, 623679183, 35351, 7);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (695, 333852316, 20130, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (696, 221831487, 33891, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (697, 577493244, 4059, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (698, 318416239, 13251, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (699, 981382864, 35734, 46);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (701, 524369147, 36998, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (703, 246837674, 29530, 22);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (705, 289876814, 34202, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (706, 827227963, 11696, 87);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (708, 157214651, 22914, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (709, 471187831, 19166, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (710, 864911878, 4862, 95);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (712, 318594755, 34963, 15);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (713, 854232594, 9122, 52);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (714, 275691953, 10293, 36);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (715, 517286445, 8934, 16);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (716, 515447432, 4373, 89);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (717, 554954222, 24039, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (718, 916518113, 24054, 89);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (719, 722213825, 4164, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (721, 334471229, 12376, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (722, 394292128, 17363, 52);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (723, 746531625, 35641, 44);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (724, 429638557, 23058, 18);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (725, 912953244, 40898, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (726, 956625328, 1090, 93);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (727, 784564289, 26800, 37);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (728, 664962492, 28626, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (729, 571857583, 37743, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (730, 264982983, 27201, 29);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (731, 346186756, 33418, 83);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (732, 242558996, 4588, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (733, 694344286, 8666, 25);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (734, 825268475, 38180, 24);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (736, 833354728, 13778, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (737, 591168314, 29882, 39);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (738, 795726539, 29954, 80);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (739, 284816823, 1202, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (740, 532392426, 12409, 38);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (741, 677956656, 20009, 38);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (742, 624811778, 16405, 82);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (743, 616734762, 5782, 27);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (744, 759827863, 12517, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (745, 146368113, 36715, 7);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (746, 838289978, 35217, 43);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (747, 816859194, 16438, 77);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (748, 143726227, 8989, 89);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (749, 628583443, 32222, 10);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (750, 367333494, 5388, 51);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (751, 364663357, 2654, 5);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (752, 737711539, 29744, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (753, 351665182, 12812, 25);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (754, 383439378, 39774, 88);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (755, 622356228, 40196, 22);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (756, 797469156, 6170, 51);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (757, 266821511, 8899, 9);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (758, 335273164, 21991, 13);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (759, 953212211, 39624, 43);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (760, 992955373, 14571, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (761, 895628258, 19382, 1);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (762, 831862355, 5051, 40);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (763, 677924779, 22620, 15);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (764, 551652428, 5629, 4);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (765, 179468944, 12371, 2);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (766, 132121193, 14298, 89);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (767, 938929491, 30041, 47);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (768, 285349282, 8329, 38);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (769, 959649222, 36313, 73);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (771, 168695513, 9067, 100);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (773, 481786752, 20660, 10);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (774, 189814233, 11744, 85);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (775, 272978237, 6020, 75);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (776, 118478913, 23062, 65);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (777, 954321423, 10523, 17);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (778, 184313881, 32313, 57);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (779, 697512344, 6051, 91);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (780, 216947211, 36668, 74);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (781, 264521394, 16075, 60);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (782, 237569833, 16737, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (783, 363193725, 5925, 37);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (784, 384459317, 26696, 43);
commit;
prompt 700 records committed...
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (786, 565718178, 19334, 50);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (787, 824917858, 1298, 20);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (788, 917592414, 29155, 8);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (789, 989475677, 30532, 64);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (790, 835619135, 28487, 59);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (791, 557923862, 10679, 3);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (792, 458536668, 25504, 33);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (793, 469923868, 20711, 72);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (794, 696814881, 16829, 70);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (795, 636896427, 13035, 98);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (796, 757424869, 9263, 86);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (797, 224738898, 9558, 94);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (798, 582589587, 33219, 23);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (799, 897596557, 23604, 92);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (800, 211384647, 39300, 53);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (801, 823386789, 12482, 97);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (802, 143931717, 39830, 66);
insert into COFFEE_SHOP (shop_id, sphone_number, area, state)
values (803, 968721671, 40641, 17);
commit;
prompt 718 records loaded
prompt Loading LOCATIONS...
insert into LOCATIONS (lid, area_name, state)
values (444, ' jerusalem', null);
insert into LOCATIONS (lid, area_name, state)
values (555, ' rbs', null);
insert into LOCATIONS (lid, area_name, state)
values (666, ' tlv', null);
insert into LOCATIONS (lid, area_name, state)
values (123, 'jerusalem', null);
insert into LOCATIONS (lid, area_name, state)
values (234, 'Beit Shemesh', null);
insert into LOCATIONS (lid, area_name, state)
values (345, 'Haifa', null);
insert into LOCATIONS (lid, area_name, state)
values (664, 'Tampa', null);
insert into LOCATIONS (lid, area_name, state)
values (624, 'Horsham', null);
insert into LOCATIONS (lid, area_name, state)
values (368, 'Graz', null);
insert into LOCATIONS (lid, area_name, state)
values (413, 'Dalmine', null);
insert into LOCATIONS (lid, area_name, state)
values (626, 'Kevelaer', null);
insert into LOCATIONS (lid, area_name, state)
values (251, 'Enschede', null);
insert into LOCATIONS (lid, area_name, state)
values (634, 'Perth', null);
insert into LOCATIONS (lid, area_name, state)
values (884, 'Stanford', null);
insert into LOCATIONS (lid, area_name, state)
values (856, 'Traralgon', null);
insert into LOCATIONS (lid, area_name, state)
values (845, 'Redding', null);
insert into LOCATIONS (lid, area_name, state)
values (448, 'Espoo', null);
insert into LOCATIONS (lid, area_name, state)
values (191, 'Buffalo', null);
insert into LOCATIONS (lid, area_name, state)
values (858, 'Hilton', null);
insert into LOCATIONS (lid, area_name, state)
values (817, 'Mechanicsburg', null);
insert into LOCATIONS (lid, area_name, state)
values (174, 'Lakeville', null);
insert into LOCATIONS (lid, area_name, state)
values (922, 'Holts Summit', null);
insert into LOCATIONS (lid, area_name, state)
values (172, 'Novara', null);
insert into LOCATIONS (lid, area_name, state)
values (988, 'Cannock', null);
insert into LOCATIONS (lid, area_name, state)
values (165, 'Jacksonville', null);
insert into LOCATIONS (lid, area_name, state)
values (957, 'Bellevue', null);
insert into LOCATIONS (lid, area_name, state)
values (679, 'Overland park', null);
insert into LOCATIONS (lid, area_name, state)
values (691, 'East sussex', null);
insert into LOCATIONS (lid, area_name, state)
values (619, 'Oxon', null);
insert into LOCATIONS (lid, area_name, state)
values (582, 'Kansas City', null);
insert into LOCATIONS (lid, area_name, state)
values (879, 'Marburg', null);
insert into LOCATIONS (lid, area_name, state)
values (578, 'Matsuyama', null);
insert into LOCATIONS (lid, area_name, state)
values (742, 'Trieste', null);
insert into LOCATIONS (lid, area_name, state)
values (283, 'Jacksonville', null);
insert into LOCATIONS (lid, area_name, state)
values (868, 'Westport', null);
insert into LOCATIONS (lid, area_name, state)
values (495, 'Webster Groves', null);
insert into LOCATIONS (lid, area_name, state)
values (238, 'Pointe-claire', null);
insert into LOCATIONS (lid, area_name, state)
values (529, 'Jacksonville', null);
insert into LOCATIONS (lid, area_name, state)
values (744, 'Hounslow', null);
insert into LOCATIONS (lid, area_name, state)
values (334, 'Lippetal', null);
insert into LOCATIONS (lid, area_name, state)
values (284, 'Ludbreg', null);
insert into LOCATIONS (lid, area_name, state)
values (294, 'Treviso', null);
insert into LOCATIONS (lid, area_name, state)
values (531, 'Bielefeld', null);
insert into LOCATIONS (lid, area_name, state)
values (864, 'Fambach', null);
insert into LOCATIONS (lid, area_name, state)
values (837, 'Vantaa', null);
insert into LOCATIONS (lid, area_name, state)
values (617, 'Gauteng', null);
insert into LOCATIONS (lid, area_name, state)
values (281, 'Mountain View', null);
insert into LOCATIONS (lid, area_name, state)
values (748, 'Bedford', null);
insert into LOCATIONS (lid, area_name, state)
values (595, 'Okayama', null);
insert into LOCATIONS (lid, area_name, state)
values (942, 'Belgrad', null);
insert into LOCATIONS (lid, area_name, state)
values (323, 'Lucca', null);
insert into LOCATIONS (lid, area_name, state)
values (794, 'Seatle', null);
insert into LOCATIONS (lid, area_name, state)
values (594, 'Sutton', null);
insert into LOCATIONS (lid, area_name, state)
values (344, 'Ehningen', null);
insert into LOCATIONS (lid, area_name, state)
values (777, 'Burwood East', null);
insert into LOCATIONS (lid, area_name, state)
values (436, 'Mantova', null);
insert into LOCATIONS (lid, area_name, state)
values (192, 'Guadalajara', null);
insert into LOCATIONS (lid, area_name, state)
values (451, 'Pretoria', null);
insert into LOCATIONS (lid, area_name, state)
values (735, 'London', null);
insert into LOCATIONS (lid, area_name, state)
values (225, 'Mantova', null);
insert into LOCATIONS (lid, area_name, state)
values (569, 'Maidstone', null);
insert into LOCATIONS (lid, area_name, state)
values (948, 'Bollensen', null);
insert into LOCATIONS (lid, area_name, state)
values (952, 'Mainz-kastel', null);
insert into LOCATIONS (lid, area_name, state)
values (454, 'Porto alegre', null);
insert into LOCATIONS (lid, area_name, state)
values (378, 'Turku', null);
insert into LOCATIONS (lid, area_name, state)
values (813, 'Bremen', null);
insert into LOCATIONS (lid, area_name, state)
values (297, 'Gaza', null);
insert into LOCATIONS (lid, area_name, state)
values (432, 'Chapeco', null);
insert into LOCATIONS (lid, area_name, state)
values (633, 'Tartu', null);
insert into LOCATIONS (lid, area_name, state)
values (257, 'Lake worth', null);
insert into LOCATIONS (lid, area_name, state)
values (939, 'Tottori', null);
insert into LOCATIONS (lid, area_name, state)
values (866, 'Timonium', null);
insert into LOCATIONS (lid, area_name, state)
values (273, 'Dardilly', null);
insert into LOCATIONS (lid, area_name, state)
values (349, 'Agoncillo', null);
insert into LOCATIONS (lid, area_name, state)
values (519, 'Mason', null);
insert into LOCATIONS (lid, area_name, state)
values (167, 'Alexandria', null);
insert into LOCATIONS (lid, area_name, state)
values (414, 'Geneve', null);
insert into LOCATIONS (lid, area_name, state)
values (749, 'Longview', null);
insert into LOCATIONS (lid, area_name, state)
values (722, 'Netanya', null);
insert into LOCATIONS (lid, area_name, state)
values (343, 'Gaza', null);
insert into LOCATIONS (lid, area_name, state)
values (384, 'Bkk', null);
insert into LOCATIONS (lid, area_name, state)
values (795, 'New York City', null);
insert into LOCATIONS (lid, area_name, state)
values (776, 'Steyr', null);
insert into LOCATIONS (lid, area_name, state)
values (375, 'Hilversum', null);
insert into LOCATIONS (lid, area_name, state)
values (426, 'Vejle', null);
insert into LOCATIONS (lid, area_name, state)
values (163, 'Santa Cruz', null);
insert into LOCATIONS (lid, area_name, state)
values (789, 'Pa o de Arcos', null);
insert into LOCATIONS (lid, area_name, state)
values (223, 'Velizy Villacou', null);
insert into LOCATIONS (lid, area_name, state)
values (967, 'Lodi', null);
insert into LOCATIONS (lid, area_name, state)
values (387, 'Glasgow', null);
insert into LOCATIONS (lid, area_name, state)
values (271, 'Istanbul', null);
insert into LOCATIONS (lid, area_name, state)
values (743, 'Freising', null);
insert into LOCATIONS (lid, area_name, state)
values (936, 'Bellerose', null);
insert into LOCATIONS (lid, area_name, state)
values (674, 'Sorocaba', null);
insert into LOCATIONS (lid, area_name, state)
values (346, 'Paris', null);
insert into LOCATIONS (lid, area_name, state)
values (389, 'Alessandria', null);
insert into LOCATIONS (lid, area_name, state)
values (923, 'Freising', null);
insert into LOCATIONS (lid, area_name, state)
values (525, 'Delafield', null);
insert into LOCATIONS (lid, area_name, state)
values (418, 'Milton Keynes', null);
insert into LOCATIONS (lid, area_name, state)
values (226, 'Whitehouse Stat', null);
commit;
prompt 100 records committed...
insert into LOCATIONS (lid, area_name, state)
values (423, 'Ani res', null);
insert into LOCATIONS (lid, area_name, state)
values (639, 'Dublin', null);
insert into LOCATIONS (lid, area_name, state)
values (373, 'Bloemfontein', null);
insert into LOCATIONS (lid, area_name, state)
values (682, 'Grapevine', null);
insert into LOCATIONS (lid, area_name, state)
values (511, 'Uden', null);
insert into LOCATIONS (lid, area_name, state)
values (972, 'Kansas City', null);
insert into LOCATIONS (lid, area_name, state)
values (625, 'Dalmine', null);
insert into LOCATIONS (lid, area_name, state)
values (388, 'Ebersberg', null);
insert into LOCATIONS (lid, area_name, state)
values (363, 'Tokyo', null);
insert into LOCATIONS (lid, area_name, state)
values (699, 'Pandrup', null);
insert into LOCATIONS (lid, area_name, state)
values (644, 'Sao roque', null);
insert into LOCATIONS (lid, area_name, state)
values (324, 'Ravensburg', null);
insert into LOCATIONS (lid, area_name, state)
values (371, 'Royersford', null);
insert into LOCATIONS (lid, area_name, state)
values (685, 'Cuiab ', null);
insert into LOCATIONS (lid, area_name, state)
values (328, 'Abbotsford', null);
insert into LOCATIONS (lid, area_name, state)
values (656, 'Amsterdam', null);
insert into LOCATIONS (lid, area_name, state)
values (276, 'Massagno', null);
insert into LOCATIONS (lid, area_name, state)
values (322, 'Ilmenau', null);
insert into LOCATIONS (lid, area_name, state)
values (615, 'Novara', null);
insert into LOCATIONS (lid, area_name, state)
values (446, 'Des Plaines', null);
insert into LOCATIONS (lid, area_name, state)
values (458, 'Saitama', null);
insert into LOCATIONS (lid, area_name, state)
values (547, 'South Jordan', null);
insert into LOCATIONS (lid, area_name, state)
values (855, 'Saudarkrokur', null);
insert into LOCATIONS (lid, area_name, state)
values (457, 'Gummersbach', null);
insert into LOCATIONS (lid, area_name, state)
values (637, 'Lehi', null);
insert into LOCATIONS (lid, area_name, state)
values (886, 'Hanover', null);
insert into LOCATIONS (lid, area_name, state)
values (693, 'University', null);
insert into LOCATIONS (lid, area_name, state)
values (422, 'Salisbury', null);
insert into LOCATIONS (lid, area_name, state)
values (176, 'Fambach', null);
insert into LOCATIONS (lid, area_name, state)
values (393, 'Lehi', null);
insert into LOCATIONS (lid, area_name, state)
values (871, 'Key Biscayne', null);
insert into LOCATIONS (lid, area_name, state)
values (288, 'Istanbul', null);
insert into LOCATIONS (lid, area_name, state)
values (762, 'Buenos Aires', null);
insert into LOCATIONS (lid, area_name, state)
values (965, 'Pirapora bom Je', null);
insert into LOCATIONS (lid, area_name, state)
values (194, 'Loveland', null);
insert into LOCATIONS (lid, area_name, state)
values (484, 'Rockford', null);
insert into LOCATIONS (lid, area_name, state)
values (178, 'Miami', null);
insert into LOCATIONS (lid, area_name, state)
values (757, 'Friedrichshafe', null);
insert into LOCATIONS (lid, area_name, state)
values (692, 'Herne', null);
insert into LOCATIONS (lid, area_name, state)
values (488, 'Pearland', null);
insert into LOCATIONS (lid, area_name, state)
values (124, 'Malm ', null);
insert into LOCATIONS (lid, area_name, state)
values (732, 'Takamatsu', null);
insert into LOCATIONS (lid, area_name, state)
values (771, 'Pointe-claire', null);
insert into LOCATIONS (lid, area_name, state)
values (397, 'Rueil-Malmaison', null);
insert into LOCATIONS (lid, area_name, state)
values (493, 'Pearland', null);
insert into LOCATIONS (lid, area_name, state)
values (216, 'Meerbusch', null);
insert into LOCATIONS (lid, area_name, state)
values (929, 'Paramus', null);
insert into LOCATIONS (lid, area_name, state)
values (938, 'Yavne', null);
insert into LOCATIONS (lid, area_name, state)
values (236, 'Kwun Tong', null);
insert into LOCATIONS (lid, area_name, state)
values (274, 'Staten Island', null);
insert into LOCATIONS (lid, area_name, state)
values (646, 'Aurora', null);
insert into LOCATIONS (lid, area_name, state)
values (243, 'Udine', null);
insert into LOCATIONS (lid, area_name, state)
values (149, 'Oulu', null);
insert into LOCATIONS (lid, area_name, state)
values (567, 'Hjallerup', null);
insert into LOCATIONS (lid, area_name, state)
values (425, 'Mito', null);
insert into LOCATIONS (lid, area_name, state)
values (919, 'Hunt Valley', null);
insert into LOCATIONS (lid, area_name, state)
values (887, 'Pompeia', null);
insert into LOCATIONS (lid, area_name, state)
values (391, 'Redding', null);
insert into LOCATIONS (lid, area_name, state)
values (677, 'Newton-le-willo', null);
insert into LOCATIONS (lid, area_name, state)
values (468, 'Redondo beach', null);
insert into LOCATIONS (lid, area_name, state)
values (268, 'Wavre', null);
insert into LOCATIONS (lid, area_name, state)
values (247, 'Oslo', null);
insert into LOCATIONS (lid, area_name, state)
values (456, 'Shizuoka', null);
insert into LOCATIONS (lid, area_name, state)
values (125, 'Sugar Land', null);
insert into LOCATIONS (lid, area_name, state)
values (586, 'High Wycombe', null);
insert into LOCATIONS (lid, area_name, state)
values (627, 'Nagasaki', null);
insert into LOCATIONS (lid, area_name, state)
values (598, 'Protvino', null);
insert into LOCATIONS (lid, area_name, state)
values (927, 'Regensburg', null);
insert into LOCATIONS (lid, area_name, state)
values (219, 'Lakewood', null);
insert into LOCATIONS (lid, area_name, state)
values (791, 'Dreieich', null);
insert into LOCATIONS (lid, area_name, state)
values (535, 'Huntington Beac', null);
insert into LOCATIONS (lid, area_name, state)
values (764, 'Hounslow', null);
insert into LOCATIONS (lid, area_name, state)
values (755, 'Sugar Land', null);
insert into LOCATIONS (lid, area_name, state)
values (932, 'Pasadena', null);
insert into LOCATIONS (lid, area_name, state)
values (249, 'Kumamoto', null);
insert into LOCATIONS (lid, area_name, state)
values (984, 'Annandale', null);
insert into LOCATIONS (lid, area_name, state)
values (787, 'Mclean', null);
insert into LOCATIONS (lid, area_name, state)
values (212, 'Karlstad', null);
insert into LOCATIONS (lid, area_name, state)
values (482, 'Lake worth', null);
insert into LOCATIONS (lid, area_name, state)
values (992, 'Alessandria', null);
insert into LOCATIONS (lid, area_name, state)
values (647, 'Kongserbg', null);
insert into LOCATIONS (lid, area_name, state)
values (554, 'Brentwood', null);
insert into LOCATIONS (lid, area_name, state)
values (877, 'Vancouver', null);
insert into LOCATIONS (lid, area_name, state)
values (231, 'Kagoshima', null);
insert into LOCATIONS (lid, area_name, state)
values (721, 'Recife', null);
insert into LOCATIONS (lid, area_name, state)
values (477, 'Mayfield Villag', null);
insert into LOCATIONS (lid, area_name, state)
values (913, 'Nantes', null);
insert into LOCATIONS (lid, area_name, state)
values (751, 'New Hope', null);
insert into LOCATIONS (lid, area_name, state)
values (587, 'Loveland', null);
insert into LOCATIONS (lid, area_name, state)
values (358, 'The Woodlands', null);
insert into LOCATIONS (lid, area_name, state)
values (3601, '10016', 1);
insert into LOCATIONS (lid, area_name, state)
values (3602, '331393', 3);
insert into LOCATIONS (lid, area_name, state)
values (3603, '17172', 52);
insert into LOCATIONS (lid, area_name, state)
values (3604, '13168', 10);
insert into LOCATIONS (lid, area_name, state)
values (3605, '40186', 84);
insert into LOCATIONS (lid, area_name, state)
values (3606, '40170', 91);
insert into LOCATIONS (lid, area_name, state)
values (3607, '18531', 82);
insert into LOCATIONS (lid, area_name, state)
values (3608, '39701', 84);
insert into LOCATIONS (lid, area_name, state)
values (3609, '20754', 14);
insert into LOCATIONS (lid, area_name, state)
values (3610, '39461', 86);
commit;
prompt 200 records committed...
insert into LOCATIONS (lid, area_name, state)
values (3611, '39603', 17);
insert into LOCATIONS (lid, area_name, state)
values (3612, '12134', 72);
insert into LOCATIONS (lid, area_name, state)
values (3613, '40403', 41);
insert into LOCATIONS (lid, area_name, state)
values (3614, '21795', 89);
insert into LOCATIONS (lid, area_name, state)
values (3615, '17616', 35);
insert into LOCATIONS (lid, area_name, state)
values (3616, '17537', 67);
insert into LOCATIONS (lid, area_name, state)
values (3617, '18436', 58);
insert into LOCATIONS (lid, area_name, state)
values (3618, '8801', 75);
insert into LOCATIONS (lid, area_name, state)
values (3619, '15347', 18);
insert into LOCATIONS (lid, area_name, state)
values (3620, '4095', 38);
insert into LOCATIONS (lid, area_name, state)
values (3621, '31926', 46);
insert into LOCATIONS (lid, area_name, state)
values (3622, '9135', 32);
insert into LOCATIONS (lid, area_name, state)
values (3623, '3737', 79);
insert into LOCATIONS (lid, area_name, state)
values (3624, '32504', 50);
insert into LOCATIONS (lid, area_name, state)
values (3625, '27173', 11);
insert into LOCATIONS (lid, area_name, state)
values (3626, '15974', 33);
insert into LOCATIONS (lid, area_name, state)
values (3627, '31131', 95);
insert into LOCATIONS (lid, area_name, state)
values (3628, '13107', 66);
insert into LOCATIONS (lid, area_name, state)
values (3629, '22052', 83);
insert into LOCATIONS (lid, area_name, state)
values (3630, '36221', 23);
insert into LOCATIONS (lid, area_name, state)
values (3631, '6503', 30);
insert into LOCATIONS (lid, area_name, state)
values (3632, '14768', 53);
insert into LOCATIONS (lid, area_name, state)
values (3633, '17770', 93);
insert into LOCATIONS (lid, area_name, state)
values (3634, '25706', 36);
insert into LOCATIONS (lid, area_name, state)
values (3635, '11384', 28);
insert into LOCATIONS (lid, area_name, state)
values (3636, '11134', 61);
insert into LOCATIONS (lid, area_name, state)
values (3637, '2819', 48);
insert into LOCATIONS (lid, area_name, state)
values (3638, '11098', 28);
insert into LOCATIONS (lid, area_name, state)
values (3639, '34617', 74);
insert into LOCATIONS (lid, area_name, state)
values (3640, '22675', 47);
insert into LOCATIONS (lid, area_name, state)
values (3641, '10168', 78);
insert into LOCATIONS (lid, area_name, state)
values (3642, '16949', 80);
insert into LOCATIONS (lid, area_name, state)
values (3643, '7194', 24);
insert into LOCATIONS (lid, area_name, state)
values (3644, '9702', 27);
insert into LOCATIONS (lid, area_name, state)
values (3645, '3745', 96);
insert into LOCATIONS (lid, area_name, state)
values (3646, '36103', 38);
insert into LOCATIONS (lid, area_name, state)
values (3647, '1052', 74);
insert into LOCATIONS (lid, area_name, state)
values (3648, '34443', 4);
insert into LOCATIONS (lid, area_name, state)
values (3649, '31602', 75);
insert into LOCATIONS (lid, area_name, state)
values (3650, '19738', 38);
insert into LOCATIONS (lid, area_name, state)
values (3651, '29347', 1);
insert into LOCATIONS (lid, area_name, state)
values (3652, '13629', 6);
insert into LOCATIONS (lid, area_name, state)
values (3653, '4156', 63);
insert into LOCATIONS (lid, area_name, state)
values (3654, '34317', 10);
insert into LOCATIONS (lid, area_name, state)
values (3655, '39464', 21);
insert into LOCATIONS (lid, area_name, state)
values (3656, '23732', 91);
insert into LOCATIONS (lid, area_name, state)
values (3657, '11596', 90);
insert into LOCATIONS (lid, area_name, state)
values (3658, '4664', 73);
insert into LOCATIONS (lid, area_name, state)
values (3659, '18773', 23);
insert into LOCATIONS (lid, area_name, state)
values (3660, '36959', 80);
insert into LOCATIONS (lid, area_name, state)
values (3661, '27276', 61);
insert into LOCATIONS (lid, area_name, state)
values (3662, '16921', 74);
insert into LOCATIONS (lid, area_name, state)
values (3663, '5136', 53);
insert into LOCATIONS (lid, area_name, state)
values (3664, '16048', 21);
insert into LOCATIONS (lid, area_name, state)
values (3665, '9889', 46);
insert into LOCATIONS (lid, area_name, state)
values (3666, '34351', 24);
insert into LOCATIONS (lid, area_name, state)
values (3667, '19573', 18);
insert into LOCATIONS (lid, area_name, state)
values (3668, '25025', 43);
insert into LOCATIONS (lid, area_name, state)
values (3669, '32305', 34);
insert into LOCATIONS (lid, area_name, state)
values (3670, '28435', 68);
insert into LOCATIONS (lid, area_name, state)
values (3671, '15779', 31);
insert into LOCATIONS (lid, area_name, state)
values (3672, '14316', 15);
insert into LOCATIONS (lid, area_name, state)
values (3673, '15795', 88);
insert into LOCATIONS (lid, area_name, state)
values (3674, '32604', 13);
insert into LOCATIONS (lid, area_name, state)
values (3675, '39687', 13);
insert into LOCATIONS (lid, area_name, state)
values (3676, '6984', 9);
insert into LOCATIONS (lid, area_name, state)
values (3677, '11923', 50);
insert into LOCATIONS (lid, area_name, state)
values (3678, '27592', 10);
insert into LOCATIONS (lid, area_name, state)
values (3679, '15508', 83);
insert into LOCATIONS (lid, area_name, state)
values (3680, '18534', 29);
insert into LOCATIONS (lid, area_name, state)
values (3681, '26329', 94);
insert into LOCATIONS (lid, area_name, state)
values (3682, '26023', 55);
insert into LOCATIONS (lid, area_name, state)
values (3683, '24235', 8);
insert into LOCATIONS (lid, area_name, state)
values (3684, '1966', 66);
insert into LOCATIONS (lid, area_name, state)
values (3685, '9742', 39);
insert into LOCATIONS (lid, area_name, state)
values (3686, '33681', 41);
insert into LOCATIONS (lid, area_name, state)
values (3687, '38137', 41);
insert into LOCATIONS (lid, area_name, state)
values (3688, '12025', 18);
insert into LOCATIONS (lid, area_name, state)
values (3689, '17434', 99);
insert into LOCATIONS (lid, area_name, state)
values (3690, '3411', 26);
insert into LOCATIONS (lid, area_name, state)
values (3691, '32181', 50);
insert into LOCATIONS (lid, area_name, state)
values (3692, '18869', 67);
insert into LOCATIONS (lid, area_name, state)
values (3693, '23130', 81);
insert into LOCATIONS (lid, area_name, state)
values (3694, '33134', 58);
insert into LOCATIONS (lid, area_name, state)
values (3695, '32100', 58);
insert into LOCATIONS (lid, area_name, state)
values (3696, '40176', 54);
insert into LOCATIONS (lid, area_name, state)
values (3697, '31747', 61);
insert into LOCATIONS (lid, area_name, state)
values (3698, '6755', 69);
insert into LOCATIONS (lid, area_name, state)
values (3699, '25974', 12);
insert into LOCATIONS (lid, area_name, state)
values (3700, '4007', 32);
insert into LOCATIONS (lid, area_name, state)
values (3701, '25284', 41);
insert into LOCATIONS (lid, area_name, state)
values (3702, '36992', 11);
insert into LOCATIONS (lid, area_name, state)
values (3703, '9482', 85);
insert into LOCATIONS (lid, area_name, state)
values (3704, '6549', 65);
insert into LOCATIONS (lid, area_name, state)
values (3705, '27278', 41);
insert into LOCATIONS (lid, area_name, state)
values (3706, '6775', 92);
insert into LOCATIONS (lid, area_name, state)
values (3707, '3799', 58);
insert into LOCATIONS (lid, area_name, state)
values (3708, '5061', 71);
insert into LOCATIONS (lid, area_name, state)
values (3709, '17893', 64);
insert into LOCATIONS (lid, area_name, state)
values (3710, '28474', 30);
commit;
prompt 300 records committed...
insert into LOCATIONS (lid, area_name, state)
values (3711, '13404', 2);
insert into LOCATIONS (lid, area_name, state)
values (3712, '20561', 18);
insert into LOCATIONS (lid, area_name, state)
values (3713, '7061', 9);
insert into LOCATIONS (lid, area_name, state)
values (3714, '6334', 74);
insert into LOCATIONS (lid, area_name, state)
values (3715, '4619', 96);
insert into LOCATIONS (lid, area_name, state)
values (3716, '38060', 31);
insert into LOCATIONS (lid, area_name, state)
values (3717, '19405', 96);
insert into LOCATIONS (lid, area_name, state)
values (3718, '15457', 55);
insert into LOCATIONS (lid, area_name, state)
values (3719, '11509', 53);
insert into LOCATIONS (lid, area_name, state)
values (3720, '4794', 54);
insert into LOCATIONS (lid, area_name, state)
values (3721, '3119', 39);
insert into LOCATIONS (lid, area_name, state)
values (3722, '22605', 68);
insert into LOCATIONS (lid, area_name, state)
values (3723, '4720', 44);
insert into LOCATIONS (lid, area_name, state)
values (3724, '29773', 89);
insert into LOCATIONS (lid, area_name, state)
values (3725, '20157', 4);
insert into LOCATIONS (lid, area_name, state)
values (3726, '8349', 2);
insert into LOCATIONS (lid, area_name, state)
values (3727, '4928', 78);
insert into LOCATIONS (lid, area_name, state)
values (3728, '5312', 59);
insert into LOCATIONS (lid, area_name, state)
values (3729, '27105', 59);
insert into LOCATIONS (lid, area_name, state)
values (3730, '13155', 15);
insert into LOCATIONS (lid, area_name, state)
values (3731, '38272', 79);
insert into LOCATIONS (lid, area_name, state)
values (3732, '40284', 43);
insert into LOCATIONS (lid, area_name, state)
values (3733, '36400', 10);
insert into LOCATIONS (lid, area_name, state)
values (3734, '27962', 55);
insert into LOCATIONS (lid, area_name, state)
values (3735, '15508', 69);
insert into LOCATIONS (lid, area_name, state)
values (3736, '6648', 20);
insert into LOCATIONS (lid, area_name, state)
values (3737, '9761', 65);
insert into LOCATIONS (lid, area_name, state)
values (3738, '14666', 8);
insert into LOCATIONS (lid, area_name, state)
values (3739, '31104', 64);
insert into LOCATIONS (lid, area_name, state)
values (3740, '6482', 71);
insert into LOCATIONS (lid, area_name, state)
values (3741, '26689', 27);
insert into LOCATIONS (lid, area_name, state)
values (3742, '33560', 39);
insert into LOCATIONS (lid, area_name, state)
values (3743, '16949', 93);
insert into LOCATIONS (lid, area_name, state)
values (3744, '28224', 76);
insert into LOCATIONS (lid, area_name, state)
values (3745, '4511', 90);
insert into LOCATIONS (lid, area_name, state)
values (3746, '24714', 5);
insert into LOCATIONS (lid, area_name, state)
values (3747, '39953', 100);
insert into LOCATIONS (lid, area_name, state)
values (3748, '15294', 51);
insert into LOCATIONS (lid, area_name, state)
values (3749, '18878', 39);
insert into LOCATIONS (lid, area_name, state)
values (3750, '27496', 8);
insert into LOCATIONS (lid, area_name, state)
values (3751, '22541', 40);
insert into LOCATIONS (lid, area_name, state)
values (3752, '26084', 30);
insert into LOCATIONS (lid, area_name, state)
values (3753, '8696', 44);
insert into LOCATIONS (lid, area_name, state)
values (3754, '40204', 9);
insert into LOCATIONS (lid, area_name, state)
values (3755, '16407', 48);
insert into LOCATIONS (lid, area_name, state)
values (3756, '27599', 62);
insert into LOCATIONS (lid, area_name, state)
values (3757, '21249', 33);
insert into LOCATIONS (lid, area_name, state)
values (3758, '5170', 56);
insert into LOCATIONS (lid, area_name, state)
values (3759, '12921', 31);
insert into LOCATIONS (lid, area_name, state)
values (3760, '28135', 54);
insert into LOCATIONS (lid, area_name, state)
values (3761, '21908', 84);
insert into LOCATIONS (lid, area_name, state)
values (3762, '9784', 93);
insert into LOCATIONS (lid, area_name, state)
values (3763, '2479', 82);
insert into LOCATIONS (lid, area_name, state)
values (3764, '22222', 91);
insert into LOCATIONS (lid, area_name, state)
values (3765, '39089', 2);
insert into LOCATIONS (lid, area_name, state)
values (3766, '38905', 2);
insert into LOCATIONS (lid, area_name, state)
values (3767, '27788', 47);
insert into LOCATIONS (lid, area_name, state)
values (3768, '9322', 3);
insert into LOCATIONS (lid, area_name, state)
values (3769, '23989', 66);
insert into LOCATIONS (lid, area_name, state)
values (3770, '30313', 26);
insert into LOCATIONS (lid, area_name, state)
values (3771, '11670', 28);
insert into LOCATIONS (lid, area_name, state)
values (3772, '27433', 19);
insert into LOCATIONS (lid, area_name, state)
values (3773, '12721', 55);
insert into LOCATIONS (lid, area_name, state)
values (3774, '21826', 62);
insert into LOCATIONS (lid, area_name, state)
values (3775, '9337', 62);
insert into LOCATIONS (lid, area_name, state)
values (3776, '34244', 40);
insert into LOCATIONS (lid, area_name, state)
values (3777, '19315', 73);
insert into LOCATIONS (lid, area_name, state)
values (3778, '23834', 23);
insert into LOCATIONS (lid, area_name, state)
values (3779, '2615', 4);
insert into LOCATIONS (lid, area_name, state)
values (3780, '15529', 99);
insert into LOCATIONS (lid, area_name, state)
values (3781, '28926', 76);
insert into LOCATIONS (lid, area_name, state)
values (3782, '21886', 52);
insert into LOCATIONS (lid, area_name, state)
values (3783, '14014', 81);
insert into LOCATIONS (lid, area_name, state)
values (3784, '18299', 64);
insert into LOCATIONS (lid, area_name, state)
values (3785, '29446', 2);
insert into LOCATIONS (lid, area_name, state)
values (3786, '36082', 86);
insert into LOCATIONS (lid, area_name, state)
values (3787, '13837', 35);
insert into LOCATIONS (lid, area_name, state)
values (3788, '3849', 56);
insert into LOCATIONS (lid, area_name, state)
values (3789, '23905', 85);
insert into LOCATIONS (lid, area_name, state)
values (3790, '16886', 52);
insert into LOCATIONS (lid, area_name, state)
values (3791, '37169', 42);
insert into LOCATIONS (lid, area_name, state)
values (3792, '9460', 62);
insert into LOCATIONS (lid, area_name, state)
values (3793, '28317', 14);
insert into LOCATIONS (lid, area_name, state)
values (3794, '36521', 69);
insert into LOCATIONS (lid, area_name, state)
values (3795, '34105', 21);
insert into LOCATIONS (lid, area_name, state)
values (3796, '13054', 25);
insert into LOCATIONS (lid, area_name, state)
values (3797, '5769', 74);
insert into LOCATIONS (lid, area_name, state)
values (3798, '9677', 1);
insert into LOCATIONS (lid, area_name, state)
values (3799, '1931', 21);
insert into LOCATIONS (lid, area_name, state)
values (3800, '1154', 30);
insert into LOCATIONS (lid, area_name, state)
values (3801, '20881', 99);
insert into LOCATIONS (lid, area_name, state)
values (3802, '15476', 98);
insert into LOCATIONS (lid, area_name, state)
values (3803, '1037', 65);
insert into LOCATIONS (lid, area_name, state)
values (3804, '15808', 96);
insert into LOCATIONS (lid, area_name, state)
values (3805, '28608', 56);
insert into LOCATIONS (lid, area_name, state)
values (3806, '25386', 23);
insert into LOCATIONS (lid, area_name, state)
values (3807, '37666', 31);
insert into LOCATIONS (lid, area_name, state)
values (3808, '4340', 19);
insert into LOCATIONS (lid, area_name, state)
values (3809, '33878', 98);
insert into LOCATIONS (lid, area_name, state)
values (3810, '20067', 13);
commit;
prompt 400 records committed...
insert into LOCATIONS (lid, area_name, state)
values (3811, '30166', 58);
insert into LOCATIONS (lid, area_name, state)
values (3812, '31577', 18);
insert into LOCATIONS (lid, area_name, state)
values (3813, '12397', 59);
insert into LOCATIONS (lid, area_name, state)
values (3814, '20459', 100);
insert into LOCATIONS (lid, area_name, state)
values (3815, '23822', 49);
insert into LOCATIONS (lid, area_name, state)
values (3816, '27686', 9);
insert into LOCATIONS (lid, area_name, state)
values (3817, '11879', 96);
insert into LOCATIONS (lid, area_name, state)
values (3818, '23788', 94);
insert into LOCATIONS (lid, area_name, state)
values (3819, '36645', 64);
insert into LOCATIONS (lid, area_name, state)
values (3820, '14628', 46);
insert into LOCATIONS (lid, area_name, state)
values (3821, '31845', 24);
insert into LOCATIONS (lid, area_name, state)
values (3822, '3212', 98);
insert into LOCATIONS (lid, area_name, state)
values (3823, '32370', 13);
insert into LOCATIONS (lid, area_name, state)
values (3824, '36004', 49);
insert into LOCATIONS (lid, area_name, state)
values (3825, '23408', 42);
insert into LOCATIONS (lid, area_name, state)
values (3826, '1885', 70);
insert into LOCATIONS (lid, area_name, state)
values (3827, '39305', 21);
insert into LOCATIONS (lid, area_name, state)
values (3828, '2203', 38);
insert into LOCATIONS (lid, area_name, state)
values (3829, '8623', 99);
insert into LOCATIONS (lid, area_name, state)
values (3830, '14313', 13);
insert into LOCATIONS (lid, area_name, state)
values (3831, '26676', 3);
insert into LOCATIONS (lid, area_name, state)
values (3832, '19847', 65);
insert into LOCATIONS (lid, area_name, state)
values (3833, '7107', 77);
insert into LOCATIONS (lid, area_name, state)
values (3834, '19106', 80);
insert into LOCATIONS (lid, area_name, state)
values (3835, '40642', 47);
insert into LOCATIONS (lid, area_name, state)
values (3836, '12896', 11);
insert into LOCATIONS (lid, area_name, state)
values (3837, '35189', 11);
insert into LOCATIONS (lid, area_name, state)
values (3838, '24152', 100);
insert into LOCATIONS (lid, area_name, state)
values (3839, '30526', 9);
insert into LOCATIONS (lid, area_name, state)
values (3840, '4025', 7);
insert into LOCATIONS (lid, area_name, state)
values (3841, '22671', 20);
insert into LOCATIONS (lid, area_name, state)
values (3842, '2769', 30);
insert into LOCATIONS (lid, area_name, state)
values (3843, '7579', 96);
insert into LOCATIONS (lid, area_name, state)
values (3844, '29857', 78);
insert into LOCATIONS (lid, area_name, state)
values (3845, '5487', 83);
insert into LOCATIONS (lid, area_name, state)
values (3846, '31198', 62);
insert into LOCATIONS (lid, area_name, state)
values (3847, '38333', 59);
insert into LOCATIONS (lid, area_name, state)
values (3848, '37007', 30);
insert into LOCATIONS (lid, area_name, state)
values (3849, '19288', 33);
insert into LOCATIONS (lid, area_name, state)
values (3850, '3165', 97);
insert into LOCATIONS (lid, area_name, state)
values (3851, '36693', 82);
insert into LOCATIONS (lid, area_name, state)
values (3852, '5932', 11);
insert into LOCATIONS (lid, area_name, state)
values (3853, '4864', 85);
insert into LOCATIONS (lid, area_name, state)
values (3854, '9821', 44);
insert into LOCATIONS (lid, area_name, state)
values (3855, '11452', 10);
insert into LOCATIONS (lid, area_name, state)
values (3856, '25479', 73);
insert into LOCATIONS (lid, area_name, state)
values (3857, '25842', 83);
insert into LOCATIONS (lid, area_name, state)
values (3858, '18689', 65);
insert into LOCATIONS (lid, area_name, state)
values (3859, '14149', 70);
insert into LOCATIONS (lid, area_name, state)
values (3860, '23188', 22);
insert into LOCATIONS (lid, area_name, state)
values (3861, '37833', 62);
insert into LOCATIONS (lid, area_name, state)
values (3862, '32721', 51);
insert into LOCATIONS (lid, area_name, state)
values (3863, '2578', 50);
insert into LOCATIONS (lid, area_name, state)
values (3864, '27659', 40);
insert into LOCATIONS (lid, area_name, state)
values (3865, '19446', 98);
insert into LOCATIONS (lid, area_name, state)
values (3866, '22270', 40);
insert into LOCATIONS (lid, area_name, state)
values (3867, '10425', 41);
insert into LOCATIONS (lid, area_name, state)
values (3868, '5891', 16);
insert into LOCATIONS (lid, area_name, state)
values (3869, '13303', 46);
insert into LOCATIONS (lid, area_name, state)
values (3870, '33864', 47);
insert into LOCATIONS (lid, area_name, state)
values (3871, '10249', 69);
insert into LOCATIONS (lid, area_name, state)
values (3872, '13570', 2);
insert into LOCATIONS (lid, area_name, state)
values (3873, '28120', 79);
insert into LOCATIONS (lid, area_name, state)
values (3874, '26441', 89);
insert into LOCATIONS (lid, area_name, state)
values (3875, '4488', 61);
insert into LOCATIONS (lid, area_name, state)
values (3876, '5702', 77);
insert into LOCATIONS (lid, area_name, state)
values (3877, '2558', 57);
insert into LOCATIONS (lid, area_name, state)
values (3878, '8385', 98);
insert into LOCATIONS (lid, area_name, state)
values (3879, '16261', 67);
insert into LOCATIONS (lid, area_name, state)
values (3880, '2209', 9);
insert into LOCATIONS (lid, area_name, state)
values (3881, '22342', 58);
insert into LOCATIONS (lid, area_name, state)
values (3882, '4151', 53);
insert into LOCATIONS (lid, area_name, state)
values (3883, '35622', 12);
insert into LOCATIONS (lid, area_name, state)
values (3884, '34409', 68);
insert into LOCATIONS (lid, area_name, state)
values (3885, '34492', 38);
insert into LOCATIONS (lid, area_name, state)
values (3886, '11154', 50);
insert into LOCATIONS (lid, area_name, state)
values (3887, '34169', 79);
insert into LOCATIONS (lid, area_name, state)
values (3888, '24691', 55);
insert into LOCATIONS (lid, area_name, state)
values (3889, '2546', 16);
insert into LOCATIONS (lid, area_name, state)
values (3890, '20571', 60);
insert into LOCATIONS (lid, area_name, state)
values (3891, '1250', 2);
insert into LOCATIONS (lid, area_name, state)
values (3892, '28007', 54);
insert into LOCATIONS (lid, area_name, state)
values (3893, '38400', 27);
insert into LOCATIONS (lid, area_name, state)
values (3894, '12319', 37);
insert into LOCATIONS (lid, area_name, state)
values (3895, '2417', 74);
insert into LOCATIONS (lid, area_name, state)
values (3896, '4873', 3);
insert into LOCATIONS (lid, area_name, state)
values (3897, '7794', 31);
insert into LOCATIONS (lid, area_name, state)
values (3898, '29446', 43);
insert into LOCATIONS (lid, area_name, state)
values (3899, '38255', 96);
insert into LOCATIONS (lid, area_name, state)
values (3900, '5205', 79);
insert into LOCATIONS (lid, area_name, state)
values (3901, '3783', 26);
insert into LOCATIONS (lid, area_name, state)
values (3902, '3805', 60);
insert into LOCATIONS (lid, area_name, state)
values (3903, '2581', 85);
insert into LOCATIONS (lid, area_name, state)
values (3904, '19017', 37);
insert into LOCATIONS (lid, area_name, state)
values (3905, '29408', 62);
insert into LOCATIONS (lid, area_name, state)
values (3906, '36296', 57);
insert into LOCATIONS (lid, area_name, state)
values (3907, '16142', 21);
insert into LOCATIONS (lid, area_name, state)
values (3908, '29896', 34);
insert into LOCATIONS (lid, area_name, state)
values (3909, '36791', 58);
insert into LOCATIONS (lid, area_name, state)
values (3910, '22544', 5);
commit;
prompt 500 records committed...
insert into LOCATIONS (lid, area_name, state)
values (3911, '11952', 16);
insert into LOCATIONS (lid, area_name, state)
values (3912, '14834', 89);
insert into LOCATIONS (lid, area_name, state)
values (3913, '15479', 89);
insert into LOCATIONS (lid, area_name, state)
values (3914, '22274', 47);
insert into LOCATIONS (lid, area_name, state)
values (3915, '20406', 3);
insert into LOCATIONS (lid, area_name, state)
values (3916, '40896', 59);
insert into LOCATIONS (lid, area_name, state)
values (3917, '14001', 62);
insert into LOCATIONS (lid, area_name, state)
values (3918, '24330', 18);
insert into LOCATIONS (lid, area_name, state)
values (3919, '29971', 18);
insert into LOCATIONS (lid, area_name, state)
values (3920, '3361', 28);
insert into LOCATIONS (lid, area_name, state)
values (3921, '22891', 88);
insert into LOCATIONS (lid, area_name, state)
values (3922, '22546', 72);
insert into LOCATIONS (lid, area_name, state)
values (3923, '26634', 78);
insert into LOCATIONS (lid, area_name, state)
values (3924, '8000', 100);
insert into LOCATIONS (lid, area_name, state)
values (3925, '3763', 66);
insert into LOCATIONS (lid, area_name, state)
values (3926, '2515', 7);
insert into LOCATIONS (lid, area_name, state)
values (3927, '18715', 73);
insert into LOCATIONS (lid, area_name, state)
values (3928, '11622', 43);
insert into LOCATIONS (lid, area_name, state)
values (3929, '32774', 35);
insert into LOCATIONS (lid, area_name, state)
values (3930, '21954', 12);
insert into LOCATIONS (lid, area_name, state)
values (3931, '6910', 64);
insert into LOCATIONS (lid, area_name, state)
values (3932, '33061', 62);
insert into LOCATIONS (lid, area_name, state)
values (3933, '1524', 2);
insert into LOCATIONS (lid, area_name, state)
values (3934, '39786', 5);
insert into LOCATIONS (lid, area_name, state)
values (3935, '18510', 100);
insert into LOCATIONS (lid, area_name, state)
values (3936, '37660', 94);
insert into LOCATIONS (lid, area_name, state)
values (3937, '4699', 71);
insert into LOCATIONS (lid, area_name, state)
values (3938, '7627', 90);
insert into LOCATIONS (lid, area_name, state)
values (3939, '23134', 12);
insert into LOCATIONS (lid, area_name, state)
values (3940, '18714', 27);
insert into LOCATIONS (lid, area_name, state)
values (3941, '5455', 23);
insert into LOCATIONS (lid, area_name, state)
values (3942, '30195', 83);
insert into LOCATIONS (lid, area_name, state)
values (3943, '12145', 11);
insert into LOCATIONS (lid, area_name, state)
values (3944, '1952', 52);
insert into LOCATIONS (lid, area_name, state)
values (3945, '25905', 49);
insert into LOCATIONS (lid, area_name, state)
values (3946, '5068', 18);
insert into LOCATIONS (lid, area_name, state)
values (3947, '19220', 82);
insert into LOCATIONS (lid, area_name, state)
values (3948, '27746', 68);
insert into LOCATIONS (lid, area_name, state)
values (3949, '10178', 47);
insert into LOCATIONS (lid, area_name, state)
values (3950, '36196', 89);
insert into LOCATIONS (lid, area_name, state)
values (3951, '13441', 37);
insert into LOCATIONS (lid, area_name, state)
values (3952, '40332', 42);
insert into LOCATIONS (lid, area_name, state)
values (3953, '28623', 100);
insert into LOCATIONS (lid, area_name, state)
values (3954, '22175', 2);
insert into LOCATIONS (lid, area_name, state)
values (3955, '30614', 81);
insert into LOCATIONS (lid, area_name, state)
values (3956, '4457', 13);
insert into LOCATIONS (lid, area_name, state)
values (3957, '12520', 95);
insert into LOCATIONS (lid, area_name, state)
values (3958, '32335', 20);
insert into LOCATIONS (lid, area_name, state)
values (3959, '4568', 92);
insert into LOCATIONS (lid, area_name, state)
values (3960, '37044', 69);
insert into LOCATIONS (lid, area_name, state)
values (3961, '12496', 74);
insert into LOCATIONS (lid, area_name, state)
values (3962, '30888', 34);
insert into LOCATIONS (lid, area_name, state)
values (3963, '39115', 55);
insert into LOCATIONS (lid, area_name, state)
values (3964, '38970', 76);
insert into LOCATIONS (lid, area_name, state)
values (3965, '2771', 69);
insert into LOCATIONS (lid, area_name, state)
values (3966, '3072', 61);
insert into LOCATIONS (lid, area_name, state)
values (3967, '24597', 53);
insert into LOCATIONS (lid, area_name, state)
values (3968, '17549', 51);
insert into LOCATIONS (lid, area_name, state)
values (3969, '30478', 87);
insert into LOCATIONS (lid, area_name, state)
values (3970, '28271', 20);
insert into LOCATIONS (lid, area_name, state)
values (3971, '17903', 3);
insert into LOCATIONS (lid, area_name, state)
values (3972, '37343', 78);
insert into LOCATIONS (lid, area_name, state)
values (3973, '36599', 80);
insert into LOCATIONS (lid, area_name, state)
values (3974, '20009', 90);
insert into LOCATIONS (lid, area_name, state)
values (3975, '19359', 32);
insert into LOCATIONS (lid, area_name, state)
values (3976, '22618', 57);
insert into LOCATIONS (lid, area_name, state)
values (3977, '15826', 5);
insert into LOCATIONS (lid, area_name, state)
values (3978, '30326', 97);
insert into LOCATIONS (lid, area_name, state)
values (3979, '23790', 7);
insert into LOCATIONS (lid, area_name, state)
values (3980, '35436', 27);
insert into LOCATIONS (lid, area_name, state)
values (3981, '23124', 16);
insert into LOCATIONS (lid, area_name, state)
values (3982, '22243', 7);
insert into LOCATIONS (lid, area_name, state)
values (3983, '3725', 92);
insert into LOCATIONS (lid, area_name, state)
values (3984, '7773', 81);
insert into LOCATIONS (lid, area_name, state)
values (3985, '35293', 44);
insert into LOCATIONS (lid, area_name, state)
values (3986, '29846', 36);
insert into LOCATIONS (lid, area_name, state)
values (3987, '19901', 2);
insert into LOCATIONS (lid, area_name, state)
values (3988, '7623', 25);
insert into LOCATIONS (lid, area_name, state)
values (3989, '12003', 15);
insert into LOCATIONS (lid, area_name, state)
values (3990, '6000', 80);
insert into LOCATIONS (lid, area_name, state)
values (3991, '8600', 59);
insert into LOCATIONS (lid, area_name, state)
values (3992, '16847', 36);
insert into LOCATIONS (lid, area_name, state)
values (3993, '31523', 26);
insert into LOCATIONS (lid, area_name, state)
values (3994, '7292', 10);
insert into LOCATIONS (lid, area_name, state)
values (3995, '9892', 49);
insert into LOCATIONS (lid, area_name, state)
values (3996, '11329', 88);
insert into LOCATIONS (lid, area_name, state)
values (3997, '5189', 47);
insert into LOCATIONS (lid, area_name, state)
values (3998, '5400', 34);
insert into LOCATIONS (lid, area_name, state)
values (3999, '12292', 23);
insert into LOCATIONS (lid, area_name, state)
values (4000, '13021', 27);
insert into LOCATIONS (lid, area_name, state)
values (4001, '33035', 46);
insert into LOCATIONS (lid, area_name, state)
values (4002, '19239', 35);
insert into LOCATIONS (lid, area_name, state)
values (4003, '17856', 49);
insert into LOCATIONS (lid, area_name, state)
values (4004, '26488', 99);
insert into LOCATIONS (lid, area_name, state)
values (4005, '22631', 66);
insert into LOCATIONS (lid, area_name, state)
values (4006, '12796', 35);
insert into LOCATIONS (lid, area_name, state)
values (4007, '7137', 93);
insert into LOCATIONS (lid, area_name, state)
values (4008, '6375', 33);
insert into LOCATIONS (lid, area_name, state)
values (4009, '10419', 77);
insert into LOCATIONS (lid, area_name, state)
values (4010, '6961', 63);
commit;
prompt 600 records committed...
insert into LOCATIONS (lid, area_name, state)
values (4011, '39107', 12);
insert into LOCATIONS (lid, area_name, state)
values (4012, '38977', 77);
insert into LOCATIONS (lid, area_name, state)
values (4013, '39149', 17);
insert into LOCATIONS (lid, area_name, state)
values (4014, '5859', 91);
insert into LOCATIONS (lid, area_name, state)
values (4015, '38177', 42);
insert into LOCATIONS (lid, area_name, state)
values (4016, '9097', 83);
insert into LOCATIONS (lid, area_name, state)
values (4017, '25299', 39);
insert into LOCATIONS (lid, area_name, state)
values (4018, '26747', 30);
insert into LOCATIONS (lid, area_name, state)
values (4019, '9919', 95);
insert into LOCATIONS (lid, area_name, state)
values (4020, '40571', 71);
insert into LOCATIONS (lid, area_name, state)
values (4021, '33507', 93);
insert into LOCATIONS (lid, area_name, state)
values (4022, '38072', 69);
insert into LOCATIONS (lid, area_name, state)
values (4023, '12601', 62);
insert into LOCATIONS (lid, area_name, state)
values (4024, '27302', 36);
insert into LOCATIONS (lid, area_name, state)
values (4025, '25103', 76);
insert into LOCATIONS (lid, area_name, state)
values (4026, '1594', 29);
insert into LOCATIONS (lid, area_name, state)
values (4027, '2893', 69);
insert into LOCATIONS (lid, area_name, state)
values (4028, '4911', 99);
insert into LOCATIONS (lid, area_name, state)
values (4029, '10749', 74);
insert into LOCATIONS (lid, area_name, state)
values (4030, '2363', 43);
insert into LOCATIONS (lid, area_name, state)
values (4031, '38543', 26);
insert into LOCATIONS (lid, area_name, state)
values (4032, '17848', 74);
insert into LOCATIONS (lid, area_name, state)
values (4033, '13506', 43);
insert into LOCATIONS (lid, area_name, state)
values (4034, '1765', 92);
insert into LOCATIONS (lid, area_name, state)
values (4035, '7639', 91);
insert into LOCATIONS (lid, area_name, state)
values (4036, '25238', 16);
insert into LOCATIONS (lid, area_name, state)
values (4037, '34606', 91);
insert into LOCATIONS (lid, area_name, state)
values (4038, '2109', 54);
insert into LOCATIONS (lid, area_name, state)
values (4039, '12270', 79);
insert into LOCATIONS (lid, area_name, state)
values (4040, '4740', 82);
insert into LOCATIONS (lid, area_name, state)
values (4041, '37188', 100);
insert into LOCATIONS (lid, area_name, state)
values (4042, '33198', 90);
insert into LOCATIONS (lid, area_name, state)
values (4043, '38468', 69);
insert into LOCATIONS (lid, area_name, state)
values (4044, '34107', 42);
insert into LOCATIONS (lid, area_name, state)
values (4045, '40138', 27);
insert into LOCATIONS (lid, area_name, state)
values (4046, '13503', 2);
insert into LOCATIONS (lid, area_name, state)
values (4047, '3508', 52);
insert into LOCATIONS (lid, area_name, state)
values (4048, '40272', 30);
insert into LOCATIONS (lid, area_name, state)
values (4049, '23739', 82);
insert into LOCATIONS (lid, area_name, state)
values (4050, '2235', 42);
insert into LOCATIONS (lid, area_name, state)
values (4051, '24701', 77);
insert into LOCATIONS (lid, area_name, state)
values (4052, '12019', 65);
insert into LOCATIONS (lid, area_name, state)
values (4053, '34832', 73);
insert into LOCATIONS (lid, area_name, state)
values (4054, '7455', 41);
insert into LOCATIONS (lid, area_name, state)
values (4055, '17891', 13);
insert into LOCATIONS (lid, area_name, state)
values (4056, '25794', 13);
insert into LOCATIONS (lid, area_name, state)
values (4057, '33970', 17);
insert into LOCATIONS (lid, area_name, state)
values (4058, '33835', 44);
insert into LOCATIONS (lid, area_name, state)
values (4059, '10905', 38);
insert into LOCATIONS (lid, area_name, state)
values (4060, '3009', 77);
insert into LOCATIONS (lid, area_name, state)
values (4061, '40500', 30);
insert into LOCATIONS (lid, area_name, state)
values (4062, '30104', 40);
insert into LOCATIONS (lid, area_name, state)
values (4063, '37045', 11);
insert into LOCATIONS (lid, area_name, state)
values (4064, '18661', 98);
insert into LOCATIONS (lid, area_name, state)
values (4065, '21413', 96);
insert into LOCATIONS (lid, area_name, state)
values (4066, '36140', 61);
insert into LOCATIONS (lid, area_name, state)
values (4067, '23474', 52);
insert into LOCATIONS (lid, area_name, state)
values (4068, '10614', 60);
insert into LOCATIONS (lid, area_name, state)
values (4069, '15650', 56);
insert into LOCATIONS (lid, area_name, state)
values (4070, '34350', 16);
insert into LOCATIONS (lid, area_name, state)
values (4071, '32182', 51);
insert into LOCATIONS (lid, area_name, state)
values (4072, '29998', 16);
insert into LOCATIONS (lid, area_name, state)
values (4073, '33775', 19);
insert into LOCATIONS (lid, area_name, state)
values (4074, '10674', 45);
insert into LOCATIONS (lid, area_name, state)
values (4075, '12294', 40);
insert into LOCATIONS (lid, area_name, state)
values (4076, '27829', 20);
insert into LOCATIONS (lid, area_name, state)
values (4077, '12263', 91);
insert into LOCATIONS (lid, area_name, state)
values (4078, '36289', 87);
insert into LOCATIONS (lid, area_name, state)
values (4079, '3934', 5);
insert into LOCATIONS (lid, area_name, state)
values (4080, '31316', 71);
insert into LOCATIONS (lid, area_name, state)
values (4081, '7147', 49);
insert into LOCATIONS (lid, area_name, state)
values (4082, '34714', 94);
insert into LOCATIONS (lid, area_name, state)
values (4083, '26465', 34);
insert into LOCATIONS (lid, area_name, state)
values (4084, '1312', 41);
insert into LOCATIONS (lid, area_name, state)
values (4085, '39564', 97);
insert into LOCATIONS (lid, area_name, state)
values (4086, '25543', 45);
insert into LOCATIONS (lid, area_name, state)
values (4087, '1686', 76);
insert into LOCATIONS (lid, area_name, state)
values (4088, '9500', 21);
insert into LOCATIONS (lid, area_name, state)
values (4089, '6004', 25);
insert into LOCATIONS (lid, area_name, state)
values (4090, '27193', 100);
insert into LOCATIONS (lid, area_name, state)
values (4091, '23333', 20);
insert into LOCATIONS (lid, area_name, state)
values (4092, '24435', 58);
insert into LOCATIONS (lid, area_name, state)
values (4093, '28707', 60);
insert into LOCATIONS (lid, area_name, state)
values (4094, '25741', 74);
insert into LOCATIONS (lid, area_name, state)
values (4095, '19678', 51);
insert into LOCATIONS (lid, area_name, state)
values (4096, '31385', 52);
insert into LOCATIONS (lid, area_name, state)
values (4097, '33698', 28);
insert into LOCATIONS (lid, area_name, state)
values (4098, '19809', 30);
insert into LOCATIONS (lid, area_name, state)
values (4099, '34651', 9);
insert into LOCATIONS (lid, area_name, state)
values (4100, '31718', 36);
insert into LOCATIONS (lid, area_name, state)
values (4101, '7842', 89);
insert into LOCATIONS (lid, area_name, state)
values (4102, '40314', 20);
insert into LOCATIONS (lid, area_name, state)
values (4103, '2994', 22);
insert into LOCATIONS (lid, area_name, state)
values (4104, '17011', 74);
insert into LOCATIONS (lid, area_name, state)
values (4105, '14373', 32);
insert into LOCATIONS (lid, area_name, state)
values (4106, '23407', 89);
insert into LOCATIONS (lid, area_name, state)
values (4107, '20269', 36);
insert into LOCATIONS (lid, area_name, state)
values (4108, '1739', 31);
insert into LOCATIONS (lid, area_name, state)
values (4109, '17466', 64);
insert into LOCATIONS (lid, area_name, state)
values (4110, '1409', 26);
commit;
prompt 700 records committed...
insert into LOCATIONS (lid, area_name, state)
values (4111, '17602', 49);
insert into LOCATIONS (lid, area_name, state)
values (4112, '9462', 45);
insert into LOCATIONS (lid, area_name, state)
values (4113, '31115', 1);
insert into LOCATIONS (lid, area_name, state)
values (4114, '38076', 80);
insert into LOCATIONS (lid, area_name, state)
values (4115, '20909', 97);
insert into LOCATIONS (lid, area_name, state)
values (4116, '31894', 80);
insert into LOCATIONS (lid, area_name, state)
values (4117, '6832', 58);
insert into LOCATIONS (lid, area_name, state)
values (4118, '24126', 46);
insert into LOCATIONS (lid, area_name, state)
values (4119, '10201', 66);
insert into LOCATIONS (lid, area_name, state)
values (4120, '36155', 12);
insert into LOCATIONS (lid, area_name, state)
values (4121, '20115', 12);
insert into LOCATIONS (lid, area_name, state)
values (4122, '31397', 80);
insert into LOCATIONS (lid, area_name, state)
values (4123, '8553', 1);
insert into LOCATIONS (lid, area_name, state)
values (4124, '8935', 5);
insert into LOCATIONS (lid, area_name, state)
values (4125, '11954', 85);
insert into LOCATIONS (lid, area_name, state)
values (4126, '23438', 73);
insert into LOCATIONS (lid, area_name, state)
values (4127, '16035', 34);
insert into LOCATIONS (lid, area_name, state)
values (4128, '5050', 79);
insert into LOCATIONS (lid, area_name, state)
values (4129, '30872', 31);
insert into LOCATIONS (lid, area_name, state)
values (4130, '27964', 16);
insert into LOCATIONS (lid, area_name, state)
values (4131, '1128', 15);
insert into LOCATIONS (lid, area_name, state)
values (4132, '33249', 94);
insert into LOCATIONS (lid, area_name, state)
values (4133, '29394', 99);
insert into LOCATIONS (lid, area_name, state)
values (4134, '22247', 65);
insert into LOCATIONS (lid, area_name, state)
values (4135, '23005', 8);
insert into LOCATIONS (lid, area_name, state)
values (4136, '29399', 62);
insert into LOCATIONS (lid, area_name, state)
values (4137, '5676', 46);
insert into LOCATIONS (lid, area_name, state)
values (4138, '36509', 27);
insert into LOCATIONS (lid, area_name, state)
values (4139, '26396', 66);
insert into LOCATIONS (lid, area_name, state)
values (4140, '30760', 9);
insert into LOCATIONS (lid, area_name, state)
values (4141, '21529', 56);
insert into LOCATIONS (lid, area_name, state)
values (4142, '34059', 38);
insert into LOCATIONS (lid, area_name, state)
values (4143, '38723', 72);
insert into LOCATIONS (lid, area_name, state)
values (4144, '12875', 35);
insert into LOCATIONS (lid, area_name, state)
values (4145, '16637', 63);
insert into LOCATIONS (lid, area_name, state)
values (4146, '18208', 32);
insert into LOCATIONS (lid, area_name, state)
values (4147, '10180', 72);
insert into LOCATIONS (lid, area_name, state)
values (4148, '2487', 31);
insert into LOCATIONS (lid, area_name, state)
values (4149, '10495', 31);
insert into LOCATIONS (lid, area_name, state)
values (4150, '39242', 98);
insert into LOCATIONS (lid, area_name, state)
values (4151, '35980', 76);
insert into LOCATIONS (lid, area_name, state)
values (4152, '10229', 54);
insert into LOCATIONS (lid, area_name, state)
values (4153, '40517', 60);
insert into LOCATIONS (lid, area_name, state)
values (4154, '30841', 9);
insert into LOCATIONS (lid, area_name, state)
values (4155, '18610', 67);
insert into LOCATIONS (lid, area_name, state)
values (4156, '14151', 63);
insert into LOCATIONS (lid, area_name, state)
values (4157, '18130', 72);
insert into LOCATIONS (lid, area_name, state)
values (4158, '25525', 63);
insert into LOCATIONS (lid, area_name, state)
values (4159, '40186', 69);
insert into LOCATIONS (lid, area_name, state)
values (4160, '25119', 44);
insert into LOCATIONS (lid, area_name, state)
values (4161, '7142', 61);
insert into LOCATIONS (lid, area_name, state)
values (4162, '6195', 47);
insert into LOCATIONS (lid, area_name, state)
values (4163, '26808', 70);
insert into LOCATIONS (lid, area_name, state)
values (4164, '33210', 35);
insert into LOCATIONS (lid, area_name, state)
values (4165, '29138', 67);
insert into LOCATIONS (lid, area_name, state)
values (4166, '34529', 5);
insert into LOCATIONS (lid, area_name, state)
values (4167, '30841', 65);
insert into LOCATIONS (lid, area_name, state)
values (4168, '25862', 65);
insert into LOCATIONS (lid, area_name, state)
values (4169, '1805', 83);
insert into LOCATIONS (lid, area_name, state)
values (4170, '2565', 98);
insert into LOCATIONS (lid, area_name, state)
values (4171, '34907', 38);
insert into LOCATIONS (lid, area_name, state)
values (4172, '17084', 91);
insert into LOCATIONS (lid, area_name, state)
values (4173, '8767', 61);
insert into LOCATIONS (lid, area_name, state)
values (4174, '4162', 40);
insert into LOCATIONS (lid, area_name, state)
values (4175, '27395', 42);
insert into LOCATIONS (lid, area_name, state)
values (4176, '3252', 82);
insert into LOCATIONS (lid, area_name, state)
values (4177, '1626', 13);
insert into LOCATIONS (lid, area_name, state)
values (4178, '5440', 29);
insert into LOCATIONS (lid, area_name, state)
values (4179, '7385', 25);
insert into LOCATIONS (lid, area_name, state)
values (4180, '38262', 58);
insert into LOCATIONS (lid, area_name, state)
values (4181, '13214', 22);
insert into LOCATIONS (lid, area_name, state)
values (4182, '34084', 40);
insert into LOCATIONS (lid, area_name, state)
values (4183, '11403', 33);
insert into LOCATIONS (lid, area_name, state)
values (4184, '9559', 3);
insert into LOCATIONS (lid, area_name, state)
values (4185, '32131', 89);
insert into LOCATIONS (lid, area_name, state)
values (4186, '34883', 70);
insert into LOCATIONS (lid, area_name, state)
values (4187, '5104', 58);
insert into LOCATIONS (lid, area_name, state)
values (4188, '4765', 74);
insert into LOCATIONS (lid, area_name, state)
values (4189, '33362', 13);
insert into LOCATIONS (lid, area_name, state)
values (4190, '37304', 92);
insert into LOCATIONS (lid, area_name, state)
values (4191, '4471', 26);
insert into LOCATIONS (lid, area_name, state)
values (4192, '24320', 92);
insert into LOCATIONS (lid, area_name, state)
values (4193, '32455', 79);
insert into LOCATIONS (lid, area_name, state)
values (4194, '34213', 35);
insert into LOCATIONS (lid, area_name, state)
values (4195, '40119', 24);
insert into LOCATIONS (lid, area_name, state)
values (4196, '10061', 43);
insert into LOCATIONS (lid, area_name, state)
values (4197, '28573', 10);
insert into LOCATIONS (lid, area_name, state)
values (4198, '20561', 17);
insert into LOCATIONS (lid, area_name, state)
values (4199, '20503', 9);
insert into LOCATIONS (lid, area_name, state)
values (4200, '6855', 69);
insert into LOCATIONS (lid, area_name, state)
values (4201, '11990', 77);
insert into LOCATIONS (lid, area_name, state)
values (4202, '4240', 17);
insert into LOCATIONS (lid, area_name, state)
values (4203, '21943', 26);
insert into LOCATIONS (lid, area_name, state)
values (4204, '15183', 15);
insert into LOCATIONS (lid, area_name, state)
values (4205, '14478', 25);
insert into LOCATIONS (lid, area_name, state)
values (4206, '25907', 74);
insert into LOCATIONS (lid, area_name, state)
values (4207, '8848', 17);
insert into LOCATIONS (lid, area_name, state)
values (4208, '26818', 7);
insert into LOCATIONS (lid, area_name, state)
values (4209, '24603', 56);
insert into LOCATIONS (lid, area_name, state)
values (4210, '39068', 69);
commit;
prompt 800 records committed...
insert into LOCATIONS (lid, area_name, state)
values (4211, '32846', 53);
insert into LOCATIONS (lid, area_name, state)
values (4212, '4901', 74);
insert into LOCATIONS (lid, area_name, state)
values (4213, '38649', 14);
insert into LOCATIONS (lid, area_name, state)
values (4214, '2128', 3);
insert into LOCATIONS (lid, area_name, state)
values (4215, '33638', 43);
insert into LOCATIONS (lid, area_name, state)
values (4216, '37846', 86);
insert into LOCATIONS (lid, area_name, state)
values (4217, '19121', 83);
insert into LOCATIONS (lid, area_name, state)
values (4218, '26224', 8);
insert into LOCATIONS (lid, area_name, state)
values (4219, '9494', 28);
insert into LOCATIONS (lid, area_name, state)
values (4220, '7268', 6);
insert into LOCATIONS (lid, area_name, state)
values (4221, '37108', 90);
insert into LOCATIONS (lid, area_name, state)
values (4222, '5361', 4);
insert into LOCATIONS (lid, area_name, state)
values (4223, '15358', 59);
insert into LOCATIONS (lid, area_name, state)
values (4224, '1753', 73);
insert into LOCATIONS (lid, area_name, state)
values (4225, '27538', 32);
insert into LOCATIONS (lid, area_name, state)
values (4226, '11688', 62);
insert into LOCATIONS (lid, area_name, state)
values (4227, '15995', 78);
insert into LOCATIONS (lid, area_name, state)
values (4228, '10723', 71);
insert into LOCATIONS (lid, area_name, state)
values (4229, '22866', 89);
insert into LOCATIONS (lid, area_name, state)
values (4230, '2707', 100);
insert into LOCATIONS (lid, area_name, state)
values (4231, '34479', 78);
insert into LOCATIONS (lid, area_name, state)
values (4232, '8126', 65);
insert into LOCATIONS (lid, area_name, state)
values (4233, '5072', 38);
insert into LOCATIONS (lid, area_name, state)
values (4234, '32952', 82);
insert into LOCATIONS (lid, area_name, state)
values (4235, '34917', 41);
insert into LOCATIONS (lid, area_name, state)
values (4236, '21695', 49);
insert into LOCATIONS (lid, area_name, state)
values (4237, '26378', 66);
insert into LOCATIONS (lid, area_name, state)
values (4238, '26287', 87);
insert into LOCATIONS (lid, area_name, state)
values (4239, '35732', 89);
insert into LOCATIONS (lid, area_name, state)
values (4240, '30048', 46);
insert into LOCATIONS (lid, area_name, state)
values (4241, '23272', 87);
insert into LOCATIONS (lid, area_name, state)
values (4242, '33369', 31);
insert into LOCATIONS (lid, area_name, state)
values (4243, '17213', 13);
insert into LOCATIONS (lid, area_name, state)
values (4244, '13527', 94);
insert into LOCATIONS (lid, area_name, state)
values (4245, '3029', 71);
insert into LOCATIONS (lid, area_name, state)
values (4246, '11898', 43);
insert into LOCATIONS (lid, area_name, state)
values (4247, '32668', 62);
insert into LOCATIONS (lid, area_name, state)
values (4248, '10378', 41);
insert into LOCATIONS (lid, area_name, state)
values (4249, '13120', 100);
insert into LOCATIONS (lid, area_name, state)
values (4250, '18840', 27);
insert into LOCATIONS (lid, area_name, state)
values (4251, '29158', 14);
insert into LOCATIONS (lid, area_name, state)
values (4252, '12645', 82);
insert into LOCATIONS (lid, area_name, state)
values (4253, '37143', 9);
insert into LOCATIONS (lid, area_name, state)
values (4254, '35855', 6);
insert into LOCATIONS (lid, area_name, state)
values (4255, '34060', 82);
insert into LOCATIONS (lid, area_name, state)
values (4256, '25480', 8);
insert into LOCATIONS (lid, area_name, state)
values (4257, '27793', 10);
insert into LOCATIONS (lid, area_name, state)
values (4258, '29410', 95);
insert into LOCATIONS (lid, area_name, state)
values (4259, '34713', 99);
insert into LOCATIONS (lid, area_name, state)
values (4260, '34772', 43);
insert into LOCATIONS (lid, area_name, state)
values (4261, '2294', 97);
insert into LOCATIONS (lid, area_name, state)
values (4262, '20845', 72);
insert into LOCATIONS (lid, area_name, state)
values (4263, '7977', 67);
insert into LOCATIONS (lid, area_name, state)
values (4264, '26948', 82);
insert into LOCATIONS (lid, area_name, state)
values (4265, '12818', 39);
insert into LOCATIONS (lid, area_name, state)
values (4266, '35680', 44);
insert into LOCATIONS (lid, area_name, state)
values (4267, '2728', 34);
insert into LOCATIONS (lid, area_name, state)
values (4268, '33615', 65);
insert into LOCATIONS (lid, area_name, state)
values (4269, '14021', 98);
insert into LOCATIONS (lid, area_name, state)
values (4270, '3096', 37);
insert into LOCATIONS (lid, area_name, state)
values (4271, '27635', 36);
insert into LOCATIONS (lid, area_name, state)
values (4272, '6014', 13);
insert into LOCATIONS (lid, area_name, state)
values (4273, '1563', 73);
insert into LOCATIONS (lid, area_name, state)
values (4274, '10206', 29);
insert into LOCATIONS (lid, area_name, state)
values (4275, '15765', 2);
insert into LOCATIONS (lid, area_name, state)
values (4276, '22976', 18);
insert into LOCATIONS (lid, area_name, state)
values (4277, '8734', 56);
insert into LOCATIONS (lid, area_name, state)
values (4278, '6956', 14);
insert into LOCATIONS (lid, area_name, state)
values (4279, '13598', 67);
insert into LOCATIONS (lid, area_name, state)
values (4280, '28515', 49);
insert into LOCATIONS (lid, area_name, state)
values (4281, '23938', 23);
insert into LOCATIONS (lid, area_name, state)
values (4282, '40341', 25);
insert into LOCATIONS (lid, area_name, state)
values (4283, '11206', 35);
insert into LOCATIONS (lid, area_name, state)
values (4284, '22656', 98);
insert into LOCATIONS (lid, area_name, state)
values (4285, '36491', 60);
insert into LOCATIONS (lid, area_name, state)
values (4286, '11525', 17);
insert into LOCATIONS (lid, area_name, state)
values (4287, '11365', 93);
insert into LOCATIONS (lid, area_name, state)
values (4288, '40969', 98);
insert into LOCATIONS (lid, area_name, state)
values (4289, '10854', 61);
insert into LOCATIONS (lid, area_name, state)
values (4290, '11664', 12);
insert into LOCATIONS (lid, area_name, state)
values (4291, '7114', 59);
insert into LOCATIONS (lid, area_name, state)
values (4292, '26479', 21);
insert into LOCATIONS (lid, area_name, state)
values (4293, '26707', 1);
insert into LOCATIONS (lid, area_name, state)
values (4294, '6065', 14);
insert into LOCATIONS (lid, area_name, state)
values (4295, '29555', 89);
insert into LOCATIONS (lid, area_name, state)
values (4296, '5394', 87);
insert into LOCATIONS (lid, area_name, state)
values (4297, '8139', 57);
insert into LOCATIONS (lid, area_name, state)
values (4298, '33427', 12);
insert into LOCATIONS (lid, area_name, state)
values (4299, '16625', 96);
insert into LOCATIONS (lid, area_name, state)
values (4300, '27217', 41);
insert into LOCATIONS (lid, area_name, state)
values (4301, '1107', 44);
insert into LOCATIONS (lid, area_name, state)
values (4302, '1685', 60);
insert into LOCATIONS (lid, area_name, state)
values (4303, '2477', 34);
insert into LOCATIONS (lid, area_name, state)
values (4304, '40165', 38);
insert into LOCATIONS (lid, area_name, state)
values (4305, '33520', 78);
insert into LOCATIONS (lid, area_name, state)
values (4306, '17065', 73);
insert into LOCATIONS (lid, area_name, state)
values (4307, '38174', 5);
insert into LOCATIONS (lid, area_name, state)
values (4308, '20504', 62);
insert into LOCATIONS (lid, area_name, state)
values (4309, '16593', 90);
insert into LOCATIONS (lid, area_name, state)
values (4310, '3125', 57);
commit;
prompt 900 records committed...
insert into LOCATIONS (lid, area_name, state)
values (4311, '27225', 58);
insert into LOCATIONS (lid, area_name, state)
values (4312, '38408', 41);
insert into LOCATIONS (lid, area_name, state)
values (4313, '10848', 22);
insert into LOCATIONS (lid, area_name, state)
values (4314, '40778', 15);
insert into LOCATIONS (lid, area_name, state)
values (4315, '37170', 29);
insert into LOCATIONS (lid, area_name, state)
values (4316, '19525', 19);
insert into LOCATIONS (lid, area_name, state)
values (4317, '12335', 32);
insert into LOCATIONS (lid, area_name, state)
values (4318, '26108', 84);
insert into LOCATIONS (lid, area_name, state)
values (4319, '5066', 54);
insert into LOCATIONS (lid, area_name, state)
values (4320, '26837', 10);
insert into LOCATIONS (lid, area_name, state)
values (4321, '13476', 100);
insert into LOCATIONS (lid, area_name, state)
values (4322, '12050', 81);
insert into LOCATIONS (lid, area_name, state)
values (4323, '4107', 18);
insert into LOCATIONS (lid, area_name, state)
values (4324, '26996', 75);
insert into LOCATIONS (lid, area_name, state)
values (4325, '38805', 8);
insert into LOCATIONS (lid, area_name, state)
values (4326, '27318', 26);
insert into LOCATIONS (lid, area_name, state)
values (4327, '11237', 45);
insert into LOCATIONS (lid, area_name, state)
values (4328, '24714', 37);
insert into LOCATIONS (lid, area_name, state)
values (4329, '4263', 64);
insert into LOCATIONS (lid, area_name, state)
values (4330, '8784', 6);
insert into LOCATIONS (lid, area_name, state)
values (4331, '30172', 44);
insert into LOCATIONS (lid, area_name, state)
values (4332, '3536', 72);
insert into LOCATIONS (lid, area_name, state)
values (4333, '15093', 55);
insert into LOCATIONS (lid, area_name, state)
values (4334, '21288', 98);
insert into LOCATIONS (lid, area_name, state)
values (4335, '17039', 6);
insert into LOCATIONS (lid, area_name, state)
values (4336, '7198', 83);
insert into LOCATIONS (lid, area_name, state)
values (4337, '26620', 30);
insert into LOCATIONS (lid, area_name, state)
values (4338, '29697', 96);
insert into LOCATIONS (lid, area_name, state)
values (4339, '20637', 81);
insert into LOCATIONS (lid, area_name, state)
values (4340, '1576', 29);
insert into LOCATIONS (lid, area_name, state)
values (4341, '23230', 80);
insert into LOCATIONS (lid, area_name, state)
values (4342, '21460', 64);
insert into LOCATIONS (lid, area_name, state)
values (4343, '4621', 24);
insert into LOCATIONS (lid, area_name, state)
values (4344, '5103', 12);
insert into LOCATIONS (lid, area_name, state)
values (4345, '21533', 55);
insert into LOCATIONS (lid, area_name, state)
values (4346, '16590', 5);
insert into LOCATIONS (lid, area_name, state)
values (4347, '3366', 33);
insert into LOCATIONS (lid, area_name, state)
values (4348, '30326', 40);
insert into LOCATIONS (lid, area_name, state)
values (4349, '20242', 5);
insert into LOCATIONS (lid, area_name, state)
values (4350, '40549', 61);
insert into LOCATIONS (lid, area_name, state)
values (4351, '1224', 39);
insert into LOCATIONS (lid, area_name, state)
values (4352, '4809', 89);
insert into LOCATIONS (lid, area_name, state)
values (4353, '15482', 91);
insert into LOCATIONS (lid, area_name, state)
values (4354, '32357', 84);
insert into LOCATIONS (lid, area_name, state)
values (4355, '27232', 20);
insert into LOCATIONS (lid, area_name, state)
values (4356, '9266', 98);
insert into LOCATIONS (lid, area_name, state)
values (4357, '8641', 20);
insert into LOCATIONS (lid, area_name, state)
values (4358, '7712', 44);
insert into LOCATIONS (lid, area_name, state)
values (4359, '3897', 79);
insert into LOCATIONS (lid, area_name, state)
values (4360, '17784', 42);
insert into LOCATIONS (lid, area_name, state)
values (4361, '8230', 74);
insert into LOCATIONS (lid, area_name, state)
values (4362, '3146', 70);
insert into LOCATIONS (lid, area_name, state)
values (4363, '14758', 47);
insert into LOCATIONS (lid, area_name, state)
values (4364, '9647', 37);
insert into LOCATIONS (lid, area_name, state)
values (4365, '32523', 46);
insert into LOCATIONS (lid, area_name, state)
values (4366, '18938', 51);
insert into LOCATIONS (lid, area_name, state)
values (4367, '2568', 48);
insert into LOCATIONS (lid, area_name, state)
values (4368, '29508', 63);
insert into LOCATIONS (lid, area_name, state)
values (4369, '40945', 72);
insert into LOCATIONS (lid, area_name, state)
values (4370, '12757', 74);
insert into LOCATIONS (lid, area_name, state)
values (4371, '32324', 71);
insert into LOCATIONS (lid, area_name, state)
values (4372, '27070', 95);
insert into LOCATIONS (lid, area_name, state)
values (4373, '17381', 66);
insert into LOCATIONS (lid, area_name, state)
values (4374, '9836', 27);
insert into LOCATIONS (lid, area_name, state)
values (4375, '22880', 19);
insert into LOCATIONS (lid, area_name, state)
values (4376, '2031', 45);
insert into LOCATIONS (lid, area_name, state)
values (4377, '90071', 2);
insert into LOCATIONS (lid, area_name, state)
values (4378, '33139', 3);
insert into LOCATIONS (lid, area_name, state)
values (4379, '34103', 79);
insert into LOCATIONS (lid, area_name, state)
values (4380, '39125', 32);
insert into LOCATIONS (lid, area_name, state)
values (4381, '34451', 62);
insert into LOCATIONS (lid, area_name, state)
values (4382, '27753', 55);
insert into LOCATIONS (lid, area_name, state)
values (4383, '7331', 37);
insert into LOCATIONS (lid, area_name, state)
values (4384, '30168', 9);
insert into LOCATIONS (lid, area_name, state)
values (4385, '7007', 77);
insert into LOCATIONS (lid, area_name, state)
values (4386, '32892', 16);
insert into LOCATIONS (lid, area_name, state)
values (4387, '10254', 14);
insert into LOCATIONS (lid, area_name, state)
values (4388, '9584', 54);
insert into LOCATIONS (lid, area_name, state)
values (4389, '12249', 42);
insert into LOCATIONS (lid, area_name, state)
values (4390, '7638', 15);
insert into LOCATIONS (lid, area_name, state)
values (4391, '16911', 81);
insert into LOCATIONS (lid, area_name, state)
values (4392, '38458', 53);
insert into LOCATIONS (lid, area_name, state)
values (4393, '9205', 74);
insert into LOCATIONS (lid, area_name, state)
values (4394, '19840', 48);
insert into LOCATIONS (lid, area_name, state)
values (4395, '37570', 44);
insert into LOCATIONS (lid, area_name, state)
values (4396, '19523', 44);
insert into LOCATIONS (lid, area_name, state)
values (4397, '17306', 15);
insert into LOCATIONS (lid, area_name, state)
values (4398, '13453', 58);
insert into LOCATIONS (lid, area_name, state)
values (4399, '38254', 48);
insert into LOCATIONS (lid, area_name, state)
values (4400, '20684', 85);
insert into LOCATIONS (lid, area_name, state)
values (4401, '32179', 5);
insert into LOCATIONS (lid, area_name, state)
values (4402, '1125', 78);
insert into LOCATIONS (lid, area_name, state)
values (4403, '12807', 51);
insert into LOCATIONS (lid, area_name, state)
values (4404, '35570', 19);
insert into LOCATIONS (lid, area_name, state)
values (4405, '36791', 80);
insert into LOCATIONS (lid, area_name, state)
values (4406, '18201', 34);
insert into LOCATIONS (lid, area_name, state)
values (4407, '12986', 53);
insert into LOCATIONS (lid, area_name, state)
values (4408, '17993', 63);
insert into LOCATIONS (lid, area_name, state)
values (4409, '36332', 27);
insert into LOCATIONS (lid, area_name, state)
values (4410, '1013', 13);
commit;
prompt 1000 records committed...
insert into LOCATIONS (lid, area_name, state)
values (4411, '22624', 86);
insert into LOCATIONS (lid, area_name, state)
values (4412, '23348', 69);
insert into LOCATIONS (lid, area_name, state)
values (4413, '23647', 58);
insert into LOCATIONS (lid, area_name, state)
values (4414, '38415', 74);
insert into LOCATIONS (lid, area_name, state)
values (4415, '15656', 83);
insert into LOCATIONS (lid, area_name, state)
values (4416, '16170', 34);
insert into LOCATIONS (lid, area_name, state)
values (4417, '2218', 1);
insert into LOCATIONS (lid, area_name, state)
values (4418, '7618', 45);
insert into LOCATIONS (lid, area_name, state)
values (4419, '7581', 69);
insert into LOCATIONS (lid, area_name, state)
values (4420, '12019', 20);
insert into LOCATIONS (lid, area_name, state)
values (4421, '15718', 53);
insert into LOCATIONS (lid, area_name, state)
values (4422, '22420', 58);
insert into LOCATIONS (lid, area_name, state)
values (4423, '26895', 19);
insert into LOCATIONS (lid, area_name, state)
values (4424, '19210', 73);
insert into LOCATIONS (lid, area_name, state)
values (4425, '36275', 74);
insert into LOCATIONS (lid, area_name, state)
values (4426, '18706', 30);
insert into LOCATIONS (lid, area_name, state)
values (4427, '37747', 58);
insert into LOCATIONS (lid, area_name, state)
values (4428, '8777', 54);
insert into LOCATIONS (lid, area_name, state)
values (4429, '36361', 64);
insert into LOCATIONS (lid, area_name, state)
values (4430, '5408', 31);
insert into LOCATIONS (lid, area_name, state)
values (4431, '14248', 11);
insert into LOCATIONS (lid, area_name, state)
values (4432, '34361', 68);
insert into LOCATIONS (lid, area_name, state)
values (4433, '27367', 28);
insert into LOCATIONS (lid, area_name, state)
values (4434, '38162', 56);
insert into LOCATIONS (lid, area_name, state)
values (4435, '22743', 49);
insert into LOCATIONS (lid, area_name, state)
values (4436, '9862', 67);
insert into LOCATIONS (lid, area_name, state)
values (4437, '4222', 82);
insert into LOCATIONS (lid, area_name, state)
values (4438, '10082', 14);
insert into LOCATIONS (lid, area_name, state)
values (4439, '35921', 60);
insert into LOCATIONS (lid, area_name, state)
values (4440, '5372', 43);
insert into LOCATIONS (lid, area_name, state)
values (4441, '5896', 2);
insert into LOCATIONS (lid, area_name, state)
values (4442, '17447', 2);
insert into LOCATIONS (lid, area_name, state)
values (4443, '15246', 7);
insert into LOCATIONS (lid, area_name, state)
values (4444, '12413', 7);
insert into LOCATIONS (lid, area_name, state)
values (4445, '39179', 14);
insert into LOCATIONS (lid, area_name, state)
values (4446, '21576', 93);
insert into LOCATIONS (lid, area_name, state)
values (4447, '5999', 94);
insert into LOCATIONS (lid, area_name, state)
values (4448, '18181', 45);
insert into LOCATIONS (lid, area_name, state)
values (4449, '8508', 45);
insert into LOCATIONS (lid, area_name, state)
values (4450, '5548', 73);
insert into LOCATIONS (lid, area_name, state)
values (4451, '9514', 56);
insert into LOCATIONS (lid, area_name, state)
values (4452, '5615', 68);
insert into LOCATIONS (lid, area_name, state)
values (4453, '7358', 43);
insert into LOCATIONS (lid, area_name, state)
values (4454, '8622', 95);
insert into LOCATIONS (lid, area_name, state)
values (4455, '16639', 66);
insert into LOCATIONS (lid, area_name, state)
values (4456, '14674', 1);
insert into LOCATIONS (lid, area_name, state)
values (4457, '9367', 76);
insert into LOCATIONS (lid, area_name, state)
values (4458, '4125', 10);
insert into LOCATIONS (lid, area_name, state)
values (4459, '31412', 41);
insert into LOCATIONS (lid, area_name, state)
values (4460, '27815', 46);
insert into LOCATIONS (lid, area_name, state)
values (4461, '1505', 19);
insert into LOCATIONS (lid, area_name, state)
values (4462, '17374', 97);
insert into LOCATIONS (lid, area_name, state)
values (4463, '18770', 71);
insert into LOCATIONS (lid, area_name, state)
values (4464, '10890', 51);
insert into LOCATIONS (lid, area_name, state)
values (4465, '11613', 81);
insert into LOCATIONS (lid, area_name, state)
values (4466, '21913', 42);
insert into LOCATIONS (lid, area_name, state)
values (4467, '25944', 14);
insert into LOCATIONS (lid, area_name, state)
values (4468, '21779', 51);
insert into LOCATIONS (lid, area_name, state)
values (4469, '8049', 65);
insert into LOCATIONS (lid, area_name, state)
values (4470, '7768', 91);
insert into LOCATIONS (lid, area_name, state)
values (4471, '23124', 68);
insert into LOCATIONS (lid, area_name, state)
values (4472, '17565', 62);
insert into LOCATIONS (lid, area_name, state)
values (4473, '33202', 26);
insert into LOCATIONS (lid, area_name, state)
values (4474, '23806', 6);
insert into LOCATIONS (lid, area_name, state)
values (4475, '7285', 82);
insert into LOCATIONS (lid, area_name, state)
values (4476, '40111', 47);
insert into LOCATIONS (lid, area_name, state)
values (4477, '4460', 54);
insert into LOCATIONS (lid, area_name, state)
values (4478, '4448', 29);
insert into LOCATIONS (lid, area_name, state)
values (4479, '29282', 92);
insert into LOCATIONS (lid, area_name, state)
values (4480, '21119', 62);
insert into LOCATIONS (lid, area_name, state)
values (4481, '25329', 69);
insert into LOCATIONS (lid, area_name, state)
values (4482, '33924', 56);
commit;
prompt 1072 records loaded
prompt Loading CUSTOMER...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (111, ' Shifra', 524567876, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (222, ' Eliana', 586543234, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (333, ' Adina', 587654323, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (294, 'DonPrinze', 3123332459, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (834, 'BobbiMatthau', 5572125332, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (667, 'GabyPryce', 5851132883, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (547, 'TziBerry', 7128822129, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (172, 'MarcJay', 7171581657, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (622, 'PelvicRapaport', 4244582429, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (652, 'ElvisDomino', 5781984195, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (378, 'FredaColon', 4157862329, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (849, 'RosanneAtkinson', 9918341253, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (267, 'GarthBratt', 1662319119, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (128, 'LloydShelton', 4621695467, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (695, 'ElleGoldblum', 7181416737, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (715, 'NileShue', 5163642884, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (896, 'JulianneWeller', 3228476242, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (866, 'DarGriggs', 7151569418, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (885, 'CarrieBerenger', 3444737792, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (645, 'StephenTaha', 4945889439, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (881, 'ChristineVitere', 9649663397, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (754, 'HollandAlbright', 3641678993, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (538, 'Bobby-Durning', 5422256435, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (483, 'Raymond-Oszajca', 8336943168, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (184, 'Donna-Morse', 8189818913, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (872, 'Ronny-Miles', 1647343789, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (651, 'Dave-Yankovic', 7543321368, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (166, 'Joseph-Neeson', 7299688345, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (392, 'Max-Hagerty', 4644453549, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (726, 'Hugh-Head', 1611133569, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (196, 'Rutger-Quinones', 3498383627, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (315, 'Belinda-Orlando', 8634123877, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (841, 'Victor-Conley', 9266612162, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (176, 'Rip-Hamilton', 5796677553, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (529, 'Whoopi-Ward', 3882262267, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (681, 'Oro-McDormand', 3579479471, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (777, 'Ron-Leguizamo', 1715115745, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (435, 'Rascal-Clinton', 5736429535, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (719, 'Sharon-Kristoff', 5986314762, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (729, 'Mark-Sanchez', 9413321393, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (513, 'Juliana-Allison', 9169518114, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (119, 'Larnelle-Chandl', 7613922129, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (917, 'Charles-Pigott-', 3457484128, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (152, 'Mika-Chinlund', 3745792178, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (653, 'Burt-Gayle', 3124342779, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (423, 'Taye-Tucci', 1789245512, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (455, 'Julie-Serbedzij', 4589712694, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (632, 'Austin-Ojeda', 9365577143, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (548, 'Debra-Crosby', 7636141296, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (465, 'Nora-Reynolds', 8269339145, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (635, 'Belinda-Orbit', 2921618232, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (735, 'Forest-Plummer', 1149775671, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (933, 'Marley-Magnuson', 2625737346, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (362, 'Betty-Conway', 7889319165, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (641, 'Ewan-Gary', 9122442647, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (724, 'Carlene-Wayans', 7265763919, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (773, 'Giancarlo-Mitch', 4313391919, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (598, 'Gin-Whitaker', 6197768959, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (421, 'Rufus-Christie', 3167178881, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (238, 'Juliana-Everett', 5268212858, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (276, 'Moe-Sledge', 9335217416, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (925, 'Carlene-Carrey', 5582284611, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (235, 'Machine-Ponty', 4673529454, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (198, 'Mekhi-Spears', 2764637299, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (764, 'Clarence-Walker', 3268274399, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (554, 'Eddie-Watley', 8856887961, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (665, 'Rascal-Sossamon', 2796888941, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (486, 'Annie-Benet', 6755354228, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (989, 'Marisa-Swank', 2232969133, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (518, 'Sinead-Warren', 3336429567, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (516, 'Pierce-Ness', 2379841296, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (698, 'Jesus-Lynne', 2327642342, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (991, 'Art-Stevens', 7329617926, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (826, 'Debby-Hurt', 1815156371, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (443, 'Rolando-Curry', 3161961298, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (824, 'Red-Gore', 2225829278, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (954, 'Christopher-Sen', 8678587232, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (253, 'Bobbi-Santa Ros', 7199533656, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (558, 'Henry-Crow', 6556257752, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (251, 'Geena-Belushi', 2666995153, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (226, 'Franz-Winger', 6924631344, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (882, 'Kid-McAnally', 4682596846, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (211, 'Matthew-Tripple', 3749435296, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (466, 'Junior-Vincent', 4482982615, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (475, 'Salma-Tomei', 3152148242, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (179, 'Busta-Hanley', 8328587431, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (821, 'Adam-Whitwam', 6944425698, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (913, 'Garth-Graham', 7234286527, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (286, 'Bryan-Flemyng', 2841473395, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (817, 'Pam-Hiatt', 4126453714, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (523, 'Wendy-Carradine', 6687354227, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (231, 'Herbie-Wilder', 6615778286, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (969, 'Lee-Eckhart', 2338267495, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (723, 'Adam-Everett', 2761648439, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (685, 'Patrick-Popper', 3178195812, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (682, 'Ty-Chesnutt', 9478199291, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (582, 'Mitchell-LaBell', 9118372547, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (784, 'Gabrielle-Rippy', 9574867118, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (316, 'Ryan-Beckinsale', 4484397127, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (911, 'Joaquin-Slater', 6795943732, 345);
commit;
prompt 100 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (856, 'Sean-Curfman', 3159362382, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (458, 'Nicolas-Colon', 1625343456, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (412, 'Glen-Chan', 2185966285, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (324, 'Kathy-Gibbons', 2778276858, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (373, 'Tim-Dupree', 7372176877, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (335, 'Minnie-Dysart', 9863484841, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (889, 'Tamala-Holden', 5988492238, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (249, 'Avenged-Tillis', 8526561777, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (165, 'Mickey-Wen', 1867389321, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (257, 'Arturo-Cervine', 6372417165, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (189, 'Cuba-Raybon', 2262865214, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (233, 'Emerson-Steagal', 2369955151, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (758, 'Alice-Quaid', 1464232178, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (221, 'Josh-McCoy', 3385964942, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (415, 'Chuck-Benson', 4539745674, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (434, 'Miko-Lineback', 7965999833, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (769, 'Junior-Lattimor', 8481957561, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (519, 'Temuera-Heald', 8238175473, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (214, 'Emmylou-Tomlin', 9246918431, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (126, 'France-Schwarze', 9921968483, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (912, 'Molly-Evett', 3715641123, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (174, 'Micky-Farina', 8867765718, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (539, 'Parker-Weiland', 8551543139, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (874, 'Gerald-Blackwel', 5617914862, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (532, 'Julio-Kinney', 4219541881, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (355, 'Lea-Lonsdale', 6536638796, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (445, 'Roscoe-Lynne', 2852351487, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (879, 'Jaime-Zeta-Jone', 3453555819, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (491, 'Kevin-Popper', 9759987819, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (979, 'Rhett-Sepulveda', 5181947476, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (871, 'Roddy-Theron', 2111853575, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (149, 'Ernie-Campbell', 3439124211, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (197, 'Bret-Coltrane', 9814636981, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (275, 'Lou-Carradine', 8494214927, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (254, 'Debi-Hagar', 2295969251, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (279, 'Lois-Krieger', 4546782292, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (213, 'Julianna-Dunawa', 7626799828, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (781, 'Neve-Burrows', 5562651879, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (666, 'Rade-Lang', 6646562366, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (924, 'Tramaine-Winans', 3646616438, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (156, 'Todd-McFerrin', 9495514764, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (892, 'Collective-Epps', 6318174546, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (981, 'Gene-Hawke', 8177432939, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (436, 'Christopher-Spe', 4322832162, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (381, 'Albert-Parker', 5454753447, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (339, 'Connie-Cartlidg', 9693731258, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (851, 'Cornell-Greenwo', 7383213454, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (422, 'Heather-Silverm', 5684761767, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (936, 'Milla-Roth', 9163142995, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (482, 'Crystal-Monk', 4799334969, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (472, 'Thomas-Finn', 3879187428, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (765, 'Robbie-Tomei', 4699641169, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (365, 'Ice-Emmett', 7437189767, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (959, 'Goldie-Oakenfol', 8798629231, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (978, 'Connie-Stone', 9425858969, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (112, 'Miriam-Ball', 3182286986, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (479, 'Joseph-Spiner', 4378232195, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (419, 'Dick-Def', 2378388352, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (562, 'Ritchie-Wahlber', 9549272182, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (927, 'Ryan-Burmester', 5167141272, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (565, 'Kyra-Kier', 1755463862, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (468, 'Donald-Doucette', 3633718173, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (351, 'Olympia-Linney', 5173953661, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (224, 'Kid-Lapointe', 7247387429, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (481, 'Night-El-Saher', 8171748394, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (697, 'Andy-Loggins', 5715652523, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (274, 'Belinda-Rubinek', 7112491796, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (799, 'Rickie-Negbaur', 9173217965, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (776, 'Udo-Taylor', 9994716811, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (537, 'Bruce-Flanery', 6949397549, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (388, 'Emm-Murdock', 3499287995, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (845, 'Anne-Harmon', 7536312956, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (984, 'Cyndi-Douglas', 9757475953, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (654, 'Carl-Shorter', 2914713635, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (837, 'Rachid-Leoni', 2673338699, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (144, 'Vin-Paymer', 2987414258, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (595, 'Tori-McCormack', 8943539365, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (187, 'Mike-Mahoney', 4928274837, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (878, 'Gabrielle-Linne', 4484256635, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (962, 'Milla-Keeslar', 2452975568, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (749, 'Yaphet-Mars', 2454182345, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (368, 'Richie-Theron', 1657766247, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (825, 'Ice-Snider', 2544317576, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (948, 'Norm-Mars', 5411515263, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (256, 'Solomon-Hershey', 3569465855, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (797, 'Toni-Gershon', 6955385783, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (411, 'Lindsay-Houston', 4747742558, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (996, 'Vin-Sandoval', 2293127132, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (844, 'Juliet-Palmer', 1982472716, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (774, 'Buffy-DeLuise', 1544957523, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (358, 'Phoebe-Eldard', 5997255471, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (452, 'Oded-Garber', 4761599575, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (875, 'Joan-Paul', 2433261114, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (625, 'Pete-Giannini', 3293369798, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (961, 'Ahmad-Overstree', 7815498957, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (265, 'Tony-Fender', 3115853851, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (867, 'Parker-Freeman', 6771645667, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (185, 'Wally-MacDonald', 7949229679, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (836, 'Stevie-Tanon', 5866998463, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (168, 'Donal-Jordan', 5516454576, 234);
commit;
prompt 200 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (284, 'Walter-Stallone', 9635923855, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (827, 'Lindsey-Osbourn', 1681345438, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (217, 'Gaby-Gill', 3514492967, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (193, 'Johnny-Conners', 3868491986, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (438, 'James-Day', 6438718741, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (261, 'Debi-Myles', 7525561236, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (646, 'Geoffrey-Haslam', 7461579568, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (245, 'Chad-Worrell', 3868421847, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (869, 'Martha-Herrmann', 3169355464, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (811, 'Andy-Weston', 7933153388, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (524, 'Brothers-Gleeso', 2625895447, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (616, 'Davey-LaBelle', 5927323645, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (171, 'Jesus-Rucker', 6974862884, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (891, 'Udo-Flack', 3333813655, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (639, 'Ted-Fiorentino', 2366521127, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (321, 'Hugo-Sanders', 9347388587, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (956, 'Marisa-Sisto', 4113737921, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (345, 'Terri-Downey', 6515299892, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (393, 'Aaron-Mason', 6261973372, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (573, 'Tobey-Hong', 1535246223, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (935, 'Jon-Kramer', 2343243992, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (497, 'Allison-Robards', 5126323838, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (677, 'Armin-Carlton', 1489318118, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (494, 'Curt-Ingram', 5286642475, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (557, 'Miki-Ricci', 3894712648, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (782, 'Scarlett-Damon', 4915123934, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (746, 'Machine-Warwick', 6794982179, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (761, 'Cloris-Margulie', 3516576223, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (965, 'Goldie-Dorff', 3615552552, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (377, 'Chaka-Pressly', 8289286242, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (535, 'Kirsten-Teng', 4326435513, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (133, 'Julianna-Levine', 2536974551, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (688, 'Mena-Raitt', 6487846325, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (887, 'Carl-Raitt', 7259882194, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (966, 'Vivica-Tomlin', 1854593432, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (915, 'Sheena-Gooding', 7182315633, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (611, 'Emerson-Margoly', 1682338955, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (471, 'Devon-Conroy', 3458122971, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (576, 'Rachel-Marin', 4645685975, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (363, 'Gary-Randal', 7448795478, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (118, 'Devon-Parish', 3558598893, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (116, 'Natacha-McGooha', 3228275673, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (439, 'Azucar-Rhys-Dav', 4796683984, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (115, 'Luke-Savage', 7533619284, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (958, 'Gil-Boothe', 3754621131, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (999, 'Kevin-Plummer', 8523441985, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (384, 'Morgan-Levy', 7986342737, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (629, 'Aimee-Brock', 8994931546, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (273, 'Angela-Thorton', 7788471724, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (994, 'Brendan-Mann', 9888682746, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (819, 'Natascha-McLach', 8245959352, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (469, 'Junior-Keener', 9128675689, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (972, 'Vin-Hackman', 7131458937, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (437, 'Anita-Burmester', 8321293127, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (553, 'Geoffrey-Walken', 7699917244, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (631, 'Freddie-Davison', 1356719598, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (853, 'Hilton-Oldman', 7544875779, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (425, 'Hookah-Armatrad', 6483116223, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (182, 'Johnny-Biehn', 8641891336, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (543, 'Mac-Roberts', 5799345488, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (813, 'Rita-Diesel', 3838997948, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (684, 'First-Pantolian', 5391692663, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (731, 'Pamela-Evett', 5461141989, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (515, 'Avril-Mann', 1128434516, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (858, 'Angie-Payne', 9295228426, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (228, 'Saul-Kurtz', 5854596751, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (549, 'Greg-Marley', 6824618348, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (376, 'Elle-Kretschman', 4939741922, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (186, 'Crystal-Gleeson', 6717295764, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (597, 'Chant -Kahn', 1348479775, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (143, 'Lupe-Tripplehor', 7868195216, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (499, 'Eliza-McFerrin', 2491635214, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (716, 'Brendan-Perry', 6767621145, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (343, 'Chris-Wincott', 9751543213, 555);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (414, 'Jaime-Hayes', 1716842678, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (258, 'Neneh-Hawn', 6865168755, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (135, 'Jane-Bridges', 5169439423, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (868, 'King-Downey', 6999682174, 123);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (865, 'Jarvis-Spacey', 1157143639, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (295, 'Maureen-Quinn', 7645518856, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (462, 'Reese-Cumming', 7965546497, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (173, 'Devon-Loggins', 6967233574, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (816, 'Bo-Gellar', 6537215533, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (277, 'Debi-Paul', 5775478135, 666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (938, 'Lesley-Candy', 6262535196, 444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (248, 'Rueben-Mason', 7798119386, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (728, 'Ani-Holiday', 6844921188, 345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (833, 'Ann-Grier', 4967588255, 234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (1, 'Yael', 527703139, 3601);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (2, 'Adina', 527703138, 4377);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (3, 'Chani', 526673322, 4378);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (4, ' Bezalel', 524070888, 3601);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (5, ' Shimi', 527746585, 4377);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (6, ' Musya', 524158756, 3602);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (7, 'Chi', 2882887852, 3838);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (8, 'Don', 4468218199, 3603);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (9, 'Mena', 3742678779, 3719);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (10, 'Ramsey', 9356699298, 4379);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (11, 'Daryle', 2991224551, 3940);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (12, 'Marley', 1989748451, 3941);
commit;
prompt 300 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (13, 'Emm', 4522934294, 4286);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (14, 'Vertical', 4167273667, 3839);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (15, 'Ron', 4181636226, 3942);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (16, 'Marley', 4593814956, 3840);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (17, 'Natacha', 4734532526, 4380);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (18, 'Vonda', 8445868328, 3943);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (19, 'Clint', 3362754587, 3720);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (20, 'James', 8187255147, 3721);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (21, 'Hope', 2949219292, 4381);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (22, 'Hilton', 8117516369, 4382);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (23, 'Danny', 5764234926, 4287);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (24, 'Bryan', 5958594498, 3722);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (25, 'Chalee', 2864558561, 3723);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (26, 'Gordie', 3742471831, 3724);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (27, 'Lennie', 3339555574, 4383);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (28, 'Chrissie', 8631645128, 3841);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (30, 'Grace', 6236726979, 3725);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (31, 'Lauren', 6281128627, 3726);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (32, 'Suzy', 5928753774, 4384);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (33, 'Lou', 9895345573, 4288);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (34, 'Cheech', 3345559646, 3727);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (35, 'Rebecca', 2272392714, 3728);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (36, 'Frederic', 6164442865, 4058);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (37, 'Natacha', 4336816241, 4163);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (38, 'Chloe', 2453468682, 4289);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (39, 'Danni', 9844477125, 3842);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (40, 'Freddie', 2278421992, 3604);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (42, 'Fisher', 1782581752, 4059);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (44, 'Rhett', 8672423569, 4385);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (45, 'Elizabeth', 2158149215, 4386);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (46, 'Olympia', 3435945573, 4290);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (47, 'Charlize', 4826136247, 4164);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (48, 'Lesley', 5694581648, 4291);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (49, 'Elisabeth', 7468839743, 4165);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (50, 'Andy', 4441532599, 3944);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (51, 'Fats', 9324392228, 4387);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (52, 'Brian', 1731527757, 4060);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (53, 'Sara', 7369728469, 3843);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (54, 'Night', 2636582195, 3729);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (56, 'Kristin', 2553553336, 4292);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (58, 'Nile', 6721983943, 3605);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (59, 'Julianne', 8414317981, 4166);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (60, 'Jean-Claude', 3454676937, 3844);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (61, 'Campbell', 3568983971, 3606);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (62, 'Gabrielle', 2589225595, 3945);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (63, 'Dan', 9494851332, 3946);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (64, 'Joey', 2929773835, 4293);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (65, 'Tommy', 2613896293, 3947);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (66, 'Corey', 3628782194, 3730);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (67, 'Cloris', 8111249388, 3607);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (68, 'Mos', 6351942718, 4167);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (69, 'Tramaine', 2754578629, 4061);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (70, 'Kathleen', 8472441867, 3845);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (71, 'Hal', 1574712546, 3731);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (74, 'Millie', 1155775514, 3732);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (75, 'Bradley', 3269843874, 4062);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (76, 'Harris', 5491665293, 4168);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (77, 'Freddie', 7358263135, 4294);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (78, 'Rita', 1819869223, 3948);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (79, 'Martin', 7388644728, 3608);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (80, 'Garry', 1692531538, 3609);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (81, 'Ryan', 1877229569, 3949);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (82, 'Heather', 9288551356, 3846);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (83, 'Dwight', 2749874773, 3610);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (84, 'Jackie', 3472983758, 4063);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (85, 'Collin', 3465428813, 3950);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (89, 'Mary', 2125298696, 3733);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (90, 'Jesus', 2615963266, 4295);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (91, 'Tzi', 4733443292, 4064);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (92, 'Pam', 8314745989, 3611);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (94, 'Orlando', 9535694765, 3951);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (95, 'Maria', 8157257324, 3952);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (96, 'Whoopi', 5248711634, 3734);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (97, 'Scott', 2654574656, 3953);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (98, 'Christopher', 1636991728, 3612);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (99, 'Bob', 2743678578, 4065);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (100, 'Wade', 8562355667, 3735);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (101, 'Dar', 5958985176, 3954);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (102, 'Brent', 2458558611, 4066);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (103, 'Dorry', 2939588717, 3736);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (104, 'Miguel', 5512777161, 4169);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (105, 'Nigel', 3148523911, 3955);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (106, 'Omar', 2466785647, 4067);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (108, 'Frank', 3662645148, 4296);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (110, 'Julie', 7688331312, 4170);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (113, 'Stockard', 9686395219, 4171);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (114, 'Philip', 4182685172, 3614);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (120, 'Jean-Claude', 4971477839, 4388);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (121, 'Burton', 9151261233, 4172);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (122, 'Christine', 6674385951, 4069);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (123, 'Miles', 7839724532, 4297);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (124, 'Garland', 4849187431, 3616);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (125, 'Kurt', 7296669228, 4298);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (127, 'Amanda', 5928911242, 4299);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (129, 'Lorraine', 4521528518, 3957);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (130, 'Bo', 2512265353, 4390);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (131, 'Cevin', 4476637497, 4391);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (132, 'Ali', 5678649368, 4392);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (134, 'Gran', 2386677718, 4301);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (136, 'Cole', 9549797534, 4071);
commit;
prompt 400 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (137, 'Annie', 5956874417, 3617);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (138, 'Colin', 9849571497, 4072);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (139, 'Jeffery', 3727772734, 4393);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (140, 'Trace', 4162342556, 4073);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (141, 'Gin', 9973279128, 4302);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (145, 'Cheryl', 9138343993, 3618);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (146, 'Jared', 4339185814, 4174);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (147, 'Howie', 1216315554, 4175);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (148, 'Bernard', 9879777158, 3737);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (150, 'Collective', 6893763547, 3959);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (151, 'Nicholas', 4477577569, 4394);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (153, 'Elisabeth', 9647756925, 3619);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (154, 'Roy', 6727512267, 3960);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (155, 'Gord', 1167564317, 4395);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (157, 'Glen', 8133254687, 4176);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (159, 'Nikka', 7697727234, 4396);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (160, 'Trace', 6671349648, 3620);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (161, 'Talvin', 2753283668, 4397);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (162, 'Rachid', 6435375535, 3849);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (163, 'Brian', 5521427982, 4177);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (164, 'Bette', 1877978699, 3621);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (169, 'Janice', 6295275327, 4398);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (175, 'Andrew', 1669322782, 3739);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (177, 'Lee', 1713787151, 3851);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (178, 'Wendy', 1644119917, 3852);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (180, 'Seth', 4987438295, 3740);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (181, 'Selma', 3834758354, 4180);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (183, 'Xander', 4591822399, 3622);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (188, 'Stockard', 3775382598, 3626);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (191, 'Julianne', 9414522351, 4075);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (192, 'Kylie', 1631572766, 4181);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (194, 'Rutger', 4296289497, 4401);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (195, 'Latin', 8269475589, 3627);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (200, 'Patrick', 6425614769, 3743);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (201, 'Ashton', 5699915637, 3628);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (202, 'Billy', 6389784582, 3963);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (204, 'Diamond', 3128174494, 4182);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (205, 'Taye', 8593796346, 3964);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (206, 'Ernie', 6734259154, 4183);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (207, 'Neil', 6549471161, 4309);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (208, 'Tramaine', 5228259675, 3629);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (209, 'Debbie', 7257658493, 3630);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (210, 'Emerson', 9541243782, 3744);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (212, 'Illeana', 4846975382, 4184);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (215, 'Rodney', 6183378314, 3631);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (218, 'Lara', 4724579438, 4076);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (219, 'Julio', 9781653827, 4077);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (220, 'Elvis', 7965392317, 4186);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (223, 'Sissy', 5318113873, 3853);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (225, 'Max', 2462517577, 4188);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (227, 'Geggy', 8588934523, 3746);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (229, 'Beth', 5824876964, 4403);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (232, 'Debra', 5284976731, 3966);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (234, 'Dom', 1971191865, 3747);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (236, 'Roger', 5688549256, 4189);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (237, 'Jose', 7343912996, 3749);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (239, 'Matthew', 4348456463, 4081);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (240, 'Charlton', 8852415568, 4082);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (241, 'Mickey', 6917694437, 4311);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (243, 'Delbert', 6493854823, 3854);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (244, 'Angie', 2446131941, 3633);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (246, 'Rebeka', 5854325575, 3634);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (247, 'Hank', 7651197762, 3751);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (252, 'Teena', 6225938167, 4312);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (255, 'Guy', 6558347267, 3635);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (259, 'Nils', 6419617197, 3968);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (260, 'Janice', 8867267397, 4192);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (262, 'Robby', 7835192148, 3752);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (263, 'Elizabeth', 6692642288, 3753);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (264, 'Sophie', 1639826569, 4193);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (266, 'Red', 4734369321, 3969);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (268, 'Bridgette', 3293483734, 3856);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (269, 'Marisa', 1629983951, 3857);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (270, 'James', 4929688556, 4406);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (271, 'Don', 7622325222, 4194);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (272, 'Rebecca', 4712294876, 3858);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (278, 'Robert', 8795148693, 3970);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (280, 'Albertina', 1459515198, 4087);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (281, 'Deborah', 1425355316, 3859);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (282, 'Brooke', 7891674512, 4408);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (283, 'Sam', 6458454756, 3754);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (285, 'Angelina', 7388746174, 4315);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (287, 'Miki', 5334439812, 4409);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (288, 'First', 5279415238, 3638);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (289, 'Desmond', 3461154889, 4089);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (290, 'Cary', 7985784338, 3971);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (291, 'Mint', 8527211692, 4410);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (292, 'Brad', 6236469268, 3639);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (293, 'Jarvis', 2312633621, 4090);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (296, 'Jamie', 8552851669, 3973);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (297, 'Karon', 4373361519, 3756);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (298, 'Ricardo', 8545763633, 4411);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (299, 'Fiona', 8112189591, 4197);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (300, 'Domingo', 1432742775, 4412);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (301, 'Larry', 3693246439, 3860);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (302, 'Cornell', 7623324131, 3640);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (303, 'King', 9621646847, 3641);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (304, 'Richie', 4987476154, 3642);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (306, 'Andrea', 9659278939, 3974);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (307, 'Javon', 8933968441, 4198);
commit;
prompt 500 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (308, 'Ceili', 1986194487, 3643);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (309, 'Solomon', 3652146321, 4199);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (310, 'Tara', 8918128276, 4091);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (311, 'Trick', 3392368723, 4317);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (312, 'Minnie', 1867921674, 3757);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (313, 'Talvin', 6831983319, 4318);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (314, 'Alicia', 3712183813, 4200);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (317, 'Billy', 4728718232, 4201);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (319, 'Wayman', 2897426979, 3976);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (320, 'Bridgette', 2366813647, 3862);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (322, 'Gran', 8277737758, 4319);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (323, 'Alex', 4978298361, 3644);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (325, 'Jake', 6436754416, 3645);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (326, 'Mykelti', 5561627462, 4414);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (327, 'Bette', 4767575957, 4092);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (328, 'Jeffrey', 1122583421, 4093);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (329, 'Embeth', 5998833789, 3646);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (330, 'Ani', 5586846979, 3758);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (331, 'Jeff', 6735958147, 4202);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (332, 'Geggy', 1448985132, 3977);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (334, 'Earl', 1267565643, 4095);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (336, 'Jonny', 3497774225, 3760);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (337, 'Jim', 9193812744, 4096);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (338, 'Claude', 3323391228, 4415);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (340, 'Cheech', 8135659665, 4203);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (341, 'Kim', 9576199539, 3978);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (342, 'Sara', 2728916199, 4097);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (344, 'Toni', 2564378129, 3864);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (346, 'Juliette', 2533879623, 4320);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (347, 'Balthazar', 7632566977, 4204);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (348, 'Harris', 2598632726, 4416);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (349, 'Ewan', 8498295596, 4321);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (350, 'Terence', 8528329971, 4322);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (352, 'Neneh', 1177123237, 4417);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (354, 'Delbert', 8441698572, 4205);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (356, 'Nick', 4564379935, 3865);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (359, 'Billy', 4564558879, 4206);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (360, 'Allan', 3573724766, 4099);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (364, 'Tanya', 9514524846, 3867);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (366, 'Nancy', 2924795737, 4100);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (367, 'Rita', 9749483359, 3647);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (369, 'Lucy', 2573522389, 3981);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (370, 'Kyra', 3822365233, 3982);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (371, 'Dionne', 5862898897, 4325);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (372, 'Seann', 9854239928, 4101);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (374, 'Ceili', 7894968589, 3868);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (375, 'Judi', 5549714998, 3869);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (380, 'Manu', 6133725374, 3762);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (383, 'Anita', 8841619341, 3650);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (385, 'Jason', 4234569325, 4208);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (387, 'Mac', 8572283483, 4209);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (389, 'Marie', 7338691228, 3763);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (390, 'Brenda', 9146184723, 4419);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (391, 'Al', 2856778888, 4420);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (395, 'King', 1431149894, 4102);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (396, 'Art', 6142164191, 4103);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (397, 'Samantha', 7481588636, 3765);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (398, 'Jeffrey', 7396762194, 4327);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (399, 'Molly', 9841271181, 3870);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (400, 'Kazem', 7624219281, 3984);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (401, 'Sean', 8752896314, 3985);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (403, 'Brendan', 1526222318, 3871);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (404, 'Edie', 6144942178, 3872);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (406, 'Laurence', 9482828118, 3766);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (407, 'Adina', 8395339928, 3767);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (408, 'Tim', 5566694981, 3986);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (409, 'Isaac', 5851462216, 4210);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (410, 'Kristin', 9436684763, 3768);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (413, 'Pat', 5959858459, 3874);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (416, 'Woody', 7798474555, 4328);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (417, 'Rose', 5165196548, 3770);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (418, 'Trey', 3596734515, 4329);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (420, 'Vince', 5766915799, 4331);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (426, 'Debi', 7536629736, 3877);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (427, 'Patty', 9452685479, 4421);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (428, 'Sarah', 3928967863, 3773);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (429, 'Chet', 6383332817, 4104);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (430, 'Natascha', 2294454532, 3878);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (431, 'Edie', 8448812134, 3879);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (432, 'Josh', 1432152717, 3880);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (433, 'Cary', 2834392952, 3652);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (440, 'Thora', 5732738382, 3991);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (442, 'Rosanna', 2257589837, 4107);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (444, 'Hex', 3952888491, 3774);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (446, 'Taylor', 6636172437, 3776);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (447, 'Lynn', 4122251532, 4422);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (449, 'Joanna', 4138361574, 4423);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (450, 'Clarence', 8257962168, 3654);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (451, 'Max', 6232929966, 3655);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (454, 'Linda', 8661648534, 4332);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (456, 'Sander', 9112575941, 4424);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (457, 'Jim', 3495612721, 4213);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (459, 'Dermot', 9694466443, 3882);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (460, 'Lila', 2746646221, 3883);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (461, 'Kim', 5783445775, 4425);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (464, 'Sona', 2173393619, 3884);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (467, 'Morris', 7892316962, 4333);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (470, 'Jonathan', 9658565613, 3658);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (473, 'Rik', 2699931761, 3660);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (474, 'Willem', 8663178895, 4215);
commit;
prompt 600 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (476, 'Rhett', 8533379635, 3885);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (477, 'Mary', 8692999187, 4429);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (478, 'Armin', 5295615158, 3778);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (480, 'Tea', 2741994692, 4430);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (484, 'Bo', 4223761175, 4432);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (485, 'Lupe', 1561465621, 3887);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (487, 'Debra', 7484237498, 4217);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (489, 'Sophie', 8591532961, 3780);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (492, 'Forest', 3639329255, 3889);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (493, 'Walter', 2449181273, 3781);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (495, 'Andrew', 5944336165, 3890);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (498, 'Wayne', 8297287143, 4111);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (500, 'Kirsten', 3394327588, 4218);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (501, 'Angie', 2837924451, 3891);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (503, 'Lizzy', 9432874346, 3892);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (504, 'Desmond', 9434755719, 4219);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (505, 'Denis', 4295515818, 3893);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (506, 'Jose', 8695251134, 3894);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (507, 'Trey', 7548183482, 3782);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (508, 'Jonathan', 3547528364, 4220);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (509, 'Ralph', 3974196339, 3992);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (510, 'Garland', 1488623467, 3661);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (511, 'Arturo', 3217741656, 4112);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (512, 'Susan', 3517824963, 3993);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (514, 'Emm', 2878451239, 3783);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (517, 'Juliette', 9851936611, 3995);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (520, 'Laurence', 3759839936, 4221);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (521, 'April', 6493278227, 4334);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (522, 'Chrissie', 3735374661, 4435);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (525, 'Madeleine', 3433338117, 3997);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (526, 'Emily', 1777755287, 4437);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (527, 'Anjelica', 4497623786, 3896);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (528, 'Aida', 5976766749, 4335);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (530, 'Grant', 8914514142, 4222);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (531, 'Grant', 1398419221, 4223);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (533, 'Kitty', 7484635772, 3998);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (534, 'Darren', 3317378813, 3999);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (536, 'Clive', 9786419913, 4114);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (540, 'Wesley', 8146617634, 4336);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (541, 'Fred', 5274485677, 4115);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (544, 'Horace', 8784816652, 4116);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (545, 'Powers', 7815224355, 4225);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (546, 'Nicky', 9831737398, 3785);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (550, 'Drew', 3346971364, 4002);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (551, 'Jonathan', 8258645216, 3786);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (552, 'Vondie', 3946112761, 3666);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (555, 'Christine', 2894531816, 3667);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (556, 'Roscoe', 7238533275, 3898);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (559, 'Caroline', 6699551245, 3668);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (560, 'Elle', 8936953778, 4439);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (561, 'Gino', 7562674725, 4117);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (563, 'Cole', 3816577926, 4226);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (564, 'Gabrielle', 1279382239, 3669);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (566, 'Hal', 8538291594, 4440);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (567, 'Emmylou', 3838912374, 3788);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (568, 'Andy', 3121861654, 3901);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (569, 'Balthazar', 5466742819, 4227);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (571, 'Barry', 5271935952, 4228);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (572, 'Rip', 4598415279, 3789);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (574, 'Helen', 6848427877, 4230);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (575, 'Nancy', 6835396996, 3670);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (577, 'Merillee', 3362948343, 3902);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (578, 'Terri', 7949743549, 4003);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (579, 'Night', 3775183422, 4231);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (580, 'Nicolas', 6342526529, 4337);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (581, 'Vin', 1387794677, 4338);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (583, 'Chet', 1895832452, 4232);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (584, 'Kevn', 4936262736, 4339);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (585, 'Terry', 8415627736, 3671);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (587, 'Gin', 6726772268, 3791);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (588, 'Merrilee', 4753934135, 3792);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (589, 'Sonny', 3681443375, 4004);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (590, 'Bernie', 6448986339, 4118);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (591, 'Orlando', 9733735917, 4005);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (592, 'Radney', 6676987474, 3903);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (593, 'Clint', 2852986544, 4119);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (594, 'Adam', 5144121581, 4120);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (599, 'Latin', 5941185163, 3904);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (600, 'Temuera', 6594765114, 4006);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (601, 'Gena', 1762633127, 4121);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (602, 'Carrie-Anne', 1726981222, 4442);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (603, 'Wallace', 7392142814, 4340);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (605, 'Marina', 8711819454, 3672);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (606, 'Ice', 1121144143, 3793);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (607, 'Loreena', 3238546364, 4234);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (608, 'Leonardo', 9429183411, 4007);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (609, 'Woody', 4772122229, 4008);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (610, 'Ryan', 8611851117, 3794);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (613, 'Jeffery', 6716881898, 4009);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (614, 'Rosario', 4614787845, 4010);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (615, 'Martin', 1618349248, 3673);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (617, 'Elvis', 6214327898, 3796);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (618, 'Demi', 7117748542, 4341);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (619, 'Molly', 6761955984, 4011);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (620, 'Rosco', 7776548759, 4342);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (621, 'Rueben', 8755325456, 4343);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (623, 'Gene', 6144926491, 4344);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (624, 'Kasey', 2566662152, 4122);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (626, 'Bonnie', 4194921685, 4235);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (627, 'Tramaine', 8451547582, 4012);
commit;
prompt 700 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (630, 'Andie', 8481671711, 4236);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (633, 'Andie', 5771525766, 4345);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (634, 'Ike', 9224838369, 3675);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (637, 'Tobey', 1253439298, 4444);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (638, 'Bret', 7852491393, 3905);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (640, 'Tamala', 4161915766, 4125);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (642, 'Daniel', 1657791884, 4445);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (643, 'Collective', 2284665497, 3906);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (644, 'Kitty', 3858266281, 3677);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (647, 'Vickie', 5665724989, 3678);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (648, 'Wang', 6967698318, 4126);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (649, 'Grace', 5832868982, 4127);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (650, 'Mary-Louise', 7959278331, 3907);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (655, 'Selma', 7881885949, 4346);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (656, 'Dar', 4683556385, 3679);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (657, 'Garland', 6189935299, 4239);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (658, 'Carole', 7844845555, 3680);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (659, 'Carrie', 8558365862, 3909);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (660, 'Lindsay', 7428499281, 3800);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (661, 'Shelby', 1683174254, 4448);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (662, 'Jimmy', 5494923167, 3801);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (663, 'Robby', 9922365456, 4013);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (664, 'Eileen', 6929699849, 3802);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (668, 'Tal', 7945997251, 4240);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (670, 'Roddy', 9754863923, 4014);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (671, 'Forest', 9962421892, 4241);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (673, 'Pam', 2244611857, 3803);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (674, 'Powers', 1546449918, 4450);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (675, 'Kevin', 9519782938, 4129);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (676, 'Chrissie', 1731942123, 4015);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (678, 'Diane', 2992236668, 3683);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (680, 'Henry', 2686255391, 3910);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (683, 'Matt', 4798513189, 4243);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (686, 'Ty', 6372576856, 3685);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (687, 'Karon', 4558653614, 3804);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (689, 'Adrien', 9382234653, 3686);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (690, 'Goldie', 9741824346, 4132);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (691, 'Lara', 3739213437, 4016);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (692, 'Gilberto', 6939633123, 3687);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (693, 'Anthony', 6194116176, 3805);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (694, 'Albert', 4385468638, 3806);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (696, 'Sheena', 1559272537, 3807);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (699, 'Kenny', 1156834397, 3911);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (700, 'Liam', 1327286785, 3912);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (702, 'Carla', 9626921427, 3688);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (703, 'Morris', 7779742823, 4133);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (705, 'Paula', 4895259671, 4452);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (706, 'Ronny', 7995284158, 4453);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (707, 'Gil', 5761541627, 4454);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (708, 'Sammy', 2169563665, 4245);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (709, 'Meg', 8319742338, 4347);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (711, 'Millie', 6659985167, 4017);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (712, 'Boz', 3962215249, 4134);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (714, 'Loretta', 3878823637, 4135);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (717, 'Sander', 4497198388, 4247);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (720, 'Michelle', 8951832644, 4348);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (721, 'Daryl', 7726198267, 4455);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (722, 'Wayman', 9651728845, 4248);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (725, 'Rob', 8559248394, 3915);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (727, 'Austin', 1146484483, 4249);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (730, 'Joaquin', 5545332287, 4019);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (732, 'Amy', 7362615599, 3689);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (733, 'Heather', 8526997989, 3808);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (734, 'Jeremy', 9576273232, 3917);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (737, 'Junior', 8815214912, 4250);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (738, 'Liquid', 8226957888, 3690);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (739, 'Antonio', 3595375278, 3691);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (740, 'Paula', 5659625328, 4137);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (742, 'Suzanne', 7446693275, 3809);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (743, 'Ben', 2351293988, 4458);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (744, 'Fats', 8672441984, 3692);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (745, 'Gerald', 7969738864, 3810);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (747, 'Gabriel', 2521226594, 3919);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (748, 'Cheech', 4659488933, 4459);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (750, 'Ben', 2826662817, 4252);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (751, 'Chris', 1549984573, 4253);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (752, 'Patricia', 6214187943, 4138);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (755, 'Steven', 5691267843, 3693);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (756, 'Melanie', 4178576917, 4020);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (757, 'Mindy', 4594319513, 3920);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (759, 'Jay', 9117526117, 3921);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (760, 'James', 3855742534, 4350);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (762, 'Gerald', 1932833118, 3694);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (763, 'Aaron', 8783112749, 3695);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (766, 'Anita', 7111191774, 3696);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (767, 'Rosco', 5116971253, 3922);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (770, 'Christmas', 7751434622, 4021);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (771, 'Elias', 5467877986, 3812);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (772, 'Ewan', 8665177341, 3697);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (775, 'Wally', 4821573759, 4461);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (778, 'Rhea', 7957748262, 4141);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (779, 'Bobbi', 8847122758, 4255);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (780, 'Ian', 2482828182, 4256);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (785, 'Don', 8424884693, 4354);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (786, 'Sheena', 3558922219, 4022);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (787, 'Dennis', 5226592198, 3924);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (788, 'Fred', 4844255852, 4355);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (789, 'Penelope', 6464667931, 4258);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (791, 'Ahmad', 7229873858, 4259);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (792, 'Bonnie', 6428313756, 3925);
commit;
prompt 800 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (793, 'Sissy', 9114362927, 4463);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (794, 'Tilda', 3471184921, 3698);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (795, 'Edgar', 9615855882, 4356);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (796, 'Leo', 3219829316, 4260);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (798, 'Johnette', 6682435142, 3813);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (800, 'Natacha', 7699519365, 4464);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (801, 'Dean', 6582736833, 4357);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (803, 'Tommy', 6631179322, 3814);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (804, 'Latin', 1126422426, 3699);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (805, 'Dick', 2676234886, 4143);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (807, 'Rueben', 4781289395, 4261);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (808, 'Tilda', 8323689171, 4358);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (809, 'Tzi', 2524678179, 4262);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (810, 'Susan', 1441343551, 4359);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (812, 'Teena', 1532142751, 4465);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (814, 'Lance', 4845471728, 3927);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (815, 'Joaquim', 2985135512, 4024);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (818, 'Curtis', 7347368887, 4026);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (820, 'Ryan', 3845379476, 4027);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (822, 'Demi', 9367737158, 3815);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (823, 'Vondie', 8528476532, 4145);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (828, 'Marty', 1326834617, 3817);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (829, 'Joy', 7453337841, 3818);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (831, 'Chazz', 4993673895, 4028);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (832, 'Jena', 1927836823, 4360);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (835, 'Owen', 5643522118, 4029);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (838, 'Trini', 6914699776, 4030);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (839, 'Patty', 8962697269, 4468);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (840, 'Jose', 3234331651, 4266);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (842, 'Demi', 7855886351, 4361);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (843, 'Spencer', 5997241729, 4146);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (846, 'Maceo', 1618947399, 4031);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (847, 'Illeana', 1575895689, 3820);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (848, 'Denise', 4369342922, 3929);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (850, 'Praga', 6326915145, 3821);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (854, 'Gabriel', 5466496842, 4148);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (855, 'Jeff', 4273151912, 4032);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (857, 'Dabney', 7135275434, 4363);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (859, 'Mekhi', 8244277414, 3701);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (860, 'Jesus', 4158544887, 4033);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (861, 'Debi', 6979299916, 4273);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (862, 'Ricky', 4791441124, 3822);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (864, 'Doug', 3815345383, 4469);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (870, 'Jackson', 3582657549, 4150);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (873, 'Saffron', 3973163273, 4365);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (877, 'Kurt', 8855247186, 4037);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (880, 'Jody', 2736628244, 4152);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (883, 'Chubby', 2114589963, 3702);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (884, 'Jonny Lee', 9562989331, 3930);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (886, 'Max', 2317246539, 4038);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (888, 'Ellen', 3949853527, 4039);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (890, 'Radney', 6966243711, 4276);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (893, 'Jessica', 4491512561, 4367);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (894, 'Ruth', 9592576587, 3931);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (895, 'Loren', 6179646513, 4277);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (897, 'Raymond', 3875551577, 4472);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (899, 'Renee', 7844685868, 4473);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (900, 'Rhys', 9347379119, 3704);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (901, 'Sandra', 2435636667, 3826);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (902, 'Hilary', 9568112972, 3932);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (903, 'Ronny', 6348446493, 3705);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (905, 'Hazel', 5254616636, 3827);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (906, 'Mykelti', 7847454878, 4278);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (907, 'Vendetta', 9679411653, 4368);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (909, 'Judd', 4479548474, 4279);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (910, 'Jimmie', 4664914133, 4369);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (916, 'Juliette', 4648719553, 4154);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (918, 'Curt', 5123198126, 4281);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (919, 'Jeffery', 6584288749, 3706);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (920, 'Nanci', 5734152956, 4041);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (922, 'Connie', 3433318317, 3829);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (923, 'Joseph', 7427571958, 4282);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (926, 'Jonny Lee', 9842878437, 4370);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (928, 'Leo', 6423293247, 4042);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (929, 'Rik', 8714834671, 3831);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (930, 'Chely', 2164324967, 3709);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (931, 'Barbara', 4945589326, 3710);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (932, 'Yaphet', 6214652169, 3832);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (934, 'Gavin', 3229511981, 3711);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (937, 'Tia', 8144912738, 4044);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (939, 'Benjamin', 5187462732, 4156);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (940, 'Gil', 5727979677, 4157);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (941, 'Jennifer', 2458931327, 3712);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (942, 'Blair', 8592512691, 4475);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (943, 'Chazz', 3458248693, 4371);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (944, 'Marley', 6622471228, 4045);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (945, 'Michael', 3835192441, 3933);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (946, 'Taye', 8941634141, 4046);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (947, 'Lari', 9573933837, 4047);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (949, 'Amanda', 4688438169, 4372);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (950, 'Charles', 3531235978, 3934);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (951, 'Parker', 9167129296, 4158);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (952, 'Cevin', 3648671323, 4373);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (953, 'Alec', 1937354515, 4374);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (957, 'Gloria', 5583228147, 4048);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (960, 'Suzi', 4491273852, 3935);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (963, 'Kevin', 4822485975, 4052);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (964, 'Benjamin', 6966486128, 4159);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (967, 'Red', 9285888893, 3937);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (968, 'Rose', 8183514555, 3713);
commit;
prompt 900 records committed...
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (970, 'Lynette', 8567756298, 4053);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (975, 'Roger', 2194738438, 4478);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (976, 'Julianne', 3858658636, 3836);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (977, 'Ernest', 3448286261, 4054);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (980, 'Donna', 4868556871, 3938);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (982, 'Jonny', 1159296599, 4480);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (983, 'Clarence', 6411542337, 3939);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (985, 'King', 6958611744, 3714);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (986, 'Rachel', 8544561458, 4160);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (987, 'Gabrielle', 7665514259, 4161);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (988, 'Jonny Lee', 5643745437, 3715);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (990, 'Charlton', 3943438813, 4162);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (992, 'Gilbert', 2696469995, 4375);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (995, 'Andre', 5677617276, 4055);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (997, 'Vonda', 7137864142, 3717);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (1000, 'Alex', 1549417344, 3837);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (1001, 'Gerald', 1224496851, 3718);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (1002, 'Charles', 6553869149, 4056);
insert into CUSTOMER (cid, cname, cphone_number, lid)
values (1003, 'Carl', 3383528372, 4057);
commit;
prompt 919 records loaded
prompt Loading BRANCH...
insert into BRANCH (bid, bname, lid)
values (999, 'branch1', 123);
insert into BRANCH (bid, bname, lid)
values (888, 'branch2', 234);
insert into BRANCH (bid, bname, lid)
values (777, 'branch3', 345);
insert into BRANCH (bid, bname, lid)
values (815, 'Sander-Koteas', 666);
insert into BRANCH (bid, bname, lid)
values (874, 'Chalee-Garofalo', 666);
insert into BRANCH (bid, bname, lid)
values (474, 'Natalie-Hornsby', 123);
insert into BRANCH (bid, bname, lid)
values (832, 'Andrew-McNeice', 123);
insert into BRANCH (bid, bname, lid)
values (217, 'Eugene-Summer', 234);
insert into BRANCH (bid, bname, lid)
values (264, 'Jeanne-Webb', 123);
insert into BRANCH (bid, bname, lid)
values (167, 'Fisher-Gandolfi', 444);
insert into BRANCH (bid, bname, lid)
values (151, 'Naomi-Thorton', 444);
insert into BRANCH (bid, bname, lid)
values (759, 'Stanley-Carrere', 666);
insert into BRANCH (bid, bname, lid)
values (145, 'Wallace-Cozier', 666);
insert into BRANCH (bid, bname, lid)
values (178, 'Elle-Dooley', 555);
insert into BRANCH (bid, bname, lid)
values (847, 'Rhett-O''Neal', 345);
insert into BRANCH (bid, bname, lid)
values (986, 'Mae-Elwes', 345);
insert into BRANCH (bid, bname, lid)
values (313, 'Holly-Dalton', 345);
insert into BRANCH (bid, bname, lid)
values (259, 'Cliff-Zellweger', 234);
insert into BRANCH (bid, bname, lid)
values (489, 'Campbell-Rankin', 234);
insert into BRANCH (bid, bname, lid)
values (867, 'Christmas-Union', 234);
insert into BRANCH (bid, bname, lid)
values (682, 'Jeffery-Cazale', 234);
insert into BRANCH (bid, bname, lid)
values (574, 'Sarah-Lipnicki', 444);
insert into BRANCH (bid, bname, lid)
values (482, 'Cate-Patillo', 444);
insert into BRANCH (bid, bname, lid)
values (738, 'Regina-Bonham', 234);
insert into BRANCH (bid, bname, lid)
values (754, 'Annie-Giannini', 345);
insert into BRANCH (bid, bname, lid)
values (131, 'Julia-Goldberg', 123);
insert into BRANCH (bid, bname, lid)
values (829, 'Crispin-Swank', 123);
insert into BRANCH (bid, bname, lid)
values (129, 'Morris-McGill', 123);
insert into BRANCH (bid, bname, lid)
values (183, 'Denzel-Solido', 123);
insert into BRANCH (bid, bname, lid)
values (768, 'Alex-Laurie', 666);
insert into BRANCH (bid, bname, lid)
values (335, 'Lynn-Place', 123);
insert into BRANCH (bid, bname, lid)
values (818, 'Stockard-Chung', 555);
insert into BRANCH (bid, bname, lid)
values (379, 'Queen-Rodriguez', 234);
insert into BRANCH (bid, bname, lid)
values (353, 'Ronnie-Benoit', 234);
insert into BRANCH (bid, bname, lid)
values (995, 'Gran-Smith', 444);
insert into BRANCH (bid, bname, lid)
values (758, 'Meredith-Silver', 444);
insert into BRANCH (bid, bname, lid)
values (411, 'Oro-de Lancie', 234);
insert into BRANCH (bid, bname, lid)
values (415, 'Heath-Donelly', 234);
insert into BRANCH (bid, bname, lid)
values (137, 'Jude-Vai', 123);
insert into BRANCH (bid, bname, lid)
values (547, 'Helen-Wong', 666);
insert into BRANCH (bid, bname, lid)
values (392, 'Emma-Myers', 555);
insert into BRANCH (bid, bname, lid)
values (579, 'France-Chestnut', 345);
insert into BRANCH (bid, bname, lid)
values (481, 'Lily-Reno', 555);
insert into BRANCH (bid, bname, lid)
values (134, 'Scarlett-Gallag', 234);
insert into BRANCH (bid, bname, lid)
values (848, 'Halle-Parm', 234);
insert into BRANCH (bid, bname, lid)
values (969, 'Mary-Robbins', 234);
insert into BRANCH (bid, bname, lid)
values (293, 'Russell-Lizzy', 123);
insert into BRANCH (bid, bname, lid)
values (895, 'Madeline-Yankov', 234);
insert into BRANCH (bid, bname, lid)
values (189, 'Geggy-Costello', 234);
insert into BRANCH (bid, bname, lid)
values (882, 'Madeline-Pullma', 666);
insert into BRANCH (bid, bname, lid)
values (838, 'Phoebe-Snipes', 234);
insert into BRANCH (bid, bname, lid)
values (187, 'Eliza-Hong', 555);
insert into BRANCH (bid, bname, lid)
values (636, 'Katie-Midler', 666);
insert into BRANCH (bid, bname, lid)
values (785, 'Chet-urban', 123);
insert into BRANCH (bid, bname, lid)
values (687, 'Davey-Manning', 234);
insert into BRANCH (bid, bname, lid)
values (347, 'Josh-Liu', 234);
insert into BRANCH (bid, bname, lid)
values (291, 'Brittany-Oates', 345);
insert into BRANCH (bid, bname, lid)
values (383, 'Roscoe-Basinger', 234);
insert into BRANCH (bid, bname, lid)
values (199, 'Mary-Gold', 234);
insert into BRANCH (bid, bname, lid)
values (528, 'Vanessa-Whitman', 555);
insert into BRANCH (bid, bname, lid)
values (462, 'Lisa-Hawthorne', 345);
insert into BRANCH (bid, bname, lid)
values (184, 'Bebe-Marsden', 444);
insert into BRANCH (bid, bname, lid)
values (417, 'Norm-Patton', 666);
insert into BRANCH (bid, bname, lid)
values (971, 'Bernie-de Lanci', 444);
insert into BRANCH (bid, bname, lid)
values (622, 'Shirley-Brandt', 555);
insert into BRANCH (bid, bname, lid)
values (875, 'Kris-Chao', 555);
insert into BRANCH (bid, bname, lid)
values (563, 'Belinda-Jessee', 234);
insert into BRANCH (bid, bname, lid)
values (937, 'Dave-Conley', 444);
insert into BRANCH (bid, bname, lid)
values (686, 'Hal-Pitney', 234);
insert into BRANCH (bid, bname, lid)
values (544, 'Ann-Pleasure', 345);
insert into BRANCH (bid, bname, lid)
values (362, 'Molly-Levin', 555);
insert into BRANCH (bid, bname, lid)
values (552, 'Debby-Bullock', 345);
insert into BRANCH (bid, bname, lid)
values (726, 'Wallace-Gryner', 666);
insert into BRANCH (bid, bname, lid)
values (556, 'Kieran-Coltrane', 666);
insert into BRANCH (bid, bname, lid)
values (425, 'Treat-Marx', 123);
insert into BRANCH (bid, bname, lid)
values (285, 'Judi-Leary', 345);
insert into BRANCH (bid, bname, lid)
values (486, 'Olga-Blossoms', 555);
insert into BRANCH (bid, bname, lid)
values (916, 'Kimberly-Folds', 555);
insert into BRANCH (bid, bname, lid)
values (994, 'Lance-Porter', 444);
insert into BRANCH (bid, bname, lid)
values (782, 'Ozzy-Bailey', 555);
insert into BRANCH (bid, bname, lid)
values (531, 'Rebeka-McGregor', 234);
insert into BRANCH (bid, bname, lid)
values (384, 'Cameron-Saxon', 234);
insert into BRANCH (bid, bname, lid)
values (274, 'Queen-Evans', 444);
insert into BRANCH (bid, bname, lid)
values (923, 'Machine-Venora', 123);
insert into BRANCH (bid, bname, lid)
values (841, 'Mint-Jamal', 123);
insert into BRANCH (bid, bname, lid)
values (851, 'Scott-Briscoe', 123);
insert into BRANCH (bid, bname, lid)
values (223, 'Gil-Worrell', 666);
insert into BRANCH (bid, bname, lid)
values (652, 'Patrick-Gibbons', 234);
insert into BRANCH (bid, bname, lid)
values (473, 'Remy-Martin', 444);
insert into BRANCH (bid, bname, lid)
values (576, 'Christina-Schei', 234);
insert into BRANCH (bid, bname, lid)
values (739, 'Art-Dunn', 444);
insert into BRANCH (bid, bname, lid)
values (766, 'Tia-Stiers', 444);
insert into BRANCH (bid, bname, lid)
values (584, 'Lauren-Mason', 345);
insert into BRANCH (bid, bname, lid)
values (398, 'Natacha-Craven', 123);
insert into BRANCH (bid, bname, lid)
values (158, 'Vanessa-Stills', 444);
insert into BRANCH (bid, bname, lid)
values (244, 'Judge-Winslet', 444);
insert into BRANCH (bid, bname, lid)
values (581, 'Andie-Melvin', 345);
insert into BRANCH (bid, bname, lid)
values (213, 'Gina-Salonga', 555);
insert into BRANCH (bid, bname, lid)
values (232, 'Keith-Oates', 345);
insert into BRANCH (bid, bname, lid)
values (786, 'Don-Baranski', 234);
commit;
prompt 100 records committed...
insert into BRANCH (bid, bname, lid)
values (755, 'Armin-Cochran', 123);
insert into BRANCH (bid, bname, lid)
values (397, 'Sheryl-Briscoe', 666);
insert into BRANCH (bid, bname, lid)
values (944, 'Stephen-Derring', 345);
insert into BRANCH (bid, bname, lid)
values (419, 'Hikaru-Keaton', 666);
insert into BRANCH (bid, bname, lid)
values (195, 'Jimmy-Connelly', 234);
insert into BRANCH (bid, bname, lid)
values (171, 'Regina-Bailey', 666);
insert into BRANCH (bid, bname, lid)
values (713, 'Vin-Smith', 234);
insert into BRANCH (bid, bname, lid)
values (496, 'Simon-O''Donnell', 444);
insert into BRANCH (bid, bname, lid)
values (917, 'Gavin-Vannelli', 555);
insert into BRANCH (bid, bname, lid)
values (135, 'Jessica-Chappel', 555);
insert into BRANCH (bid, bname, lid)
values (533, 'Katrin-Biel', 345);
insert into BRANCH (bid, bname, lid)
values (666, 'Karen-McKennitt', 234);
insert into BRANCH (bid, bname, lid)
values (594, 'Kiefer-Latifah', 666);
insert into BRANCH (bid, bname, lid)
values (112, 'Joey-Harary', 666);
insert into BRANCH (bid, bname, lid)
values (741, 'Madeline-Imbrug', 234);
insert into BRANCH (bid, bname, lid)
values (949, 'Hugh-Duvall', 555);
insert into BRANCH (bid, bname, lid)
values (249, 'Darius-Porter', 123);
insert into BRANCH (bid, bname, lid)
values (193, 'Marc-Liotta', 555);
insert into BRANCH (bid, bname, lid)
values (647, 'Johnny-Hayek', 444);
insert into BRANCH (bid, bname, lid)
values (192, 'Randy-Checker', 555);
insert into BRANCH (bid, bname, lid)
values (414, 'Kevin-Sledge', 444);
insert into BRANCH (bid, bname, lid)
values (323, 'Ian-Hobson', 345);
insert into BRANCH (bid, bname, lid)
values (377, 'Edwin-Danes', 666);
insert into BRANCH (bid, bname, lid)
values (265, 'Rosario-McKenni', 666);
insert into BRANCH (bid, bname, lid)
values (814, 'Isabella-Arnold', 666);
insert into BRANCH (bid, bname, lid)
values (951, 'James-Huston', 123);
insert into BRANCH (bid, bname, lid)
values (281, 'Mira-Winter', 345);
insert into BRANCH (bid, bname, lid)
values (119, 'Harris-Sherman', 555);
insert into BRANCH (bid, bname, lid)
values (241, 'Loretta-Hidalgo', 666);
insert into BRANCH (bid, bname, lid)
values (914, 'Fionnula-Conner', 444);
insert into BRANCH (bid, bname, lid)
values (744, 'Bobbi-Chao', 234);
insert into BRANCH (bid, bname, lid)
values (718, 'Leslie-Winwood', 444);
insert into BRANCH (bid, bname, lid)
values (541, 'Sylvester-Stone', 123);
insert into BRANCH (bid, bname, lid)
values (845, 'Freddie-Warburt', 555);
insert into BRANCH (bid, bname, lid)
values (381, 'Leo-Dalley', 345);
insert into BRANCH (bid, bname, lid)
values (757, 'Angie-Scott', 345);
insert into BRANCH (bid, bname, lid)
values (413, 'Chaka-Kravitz', 444);
insert into BRANCH (bid, bname, lid)
values (918, 'Gilbert-Peet', 123);
insert into BRANCH (bid, bname, lid)
values (361, 'Jeanne-Mulroney', 666);
insert into BRANCH (bid, bname, lid)
values (465, 'Howard-Rollins', 444);
insert into BRANCH (bid, bname, lid)
values (312, 'Collin-Aglukark', 345);
insert into BRANCH (bid, bname, lid)
values (292, 'Kiefer-Hawke', 345);
insert into BRANCH (bid, bname, lid)
values (665, 'Isaiah-Brando', 345);
insert into BRANCH (bid, bname, lid)
values (126, 'Mia-Azaria', 555);
insert into BRANCH (bid, bname, lid)
values (854, 'Ray-Griffith', 666);
insert into BRANCH (bid, bname, lid)
values (395, 'Jeffrey-Gore', 345);
insert into BRANCH (bid, bname, lid)
values (348, 'Benjamin-Cox', 234);
insert into BRANCH (bid, bname, lid)
values (314, 'Nicky-Vaughan', 345);
insert into BRANCH (bid, bname, lid)
values (693, 'Johnny-Leguizam', 666);
insert into BRANCH (bid, bname, lid)
values (961, 'Kris-Guinness', 234);
insert into BRANCH (bid, bname, lid)
values (721, 'Curtis-Ruffalo', 444);
insert into BRANCH (bid, bname, lid)
values (479, 'Gabriel-Kinski', 444);
insert into BRANCH (bid, bname, lid)
values (237, 'Percy-Cassel', 345);
insert into BRANCH (bid, bname, lid)
values (143, 'Davis-Snipes', 234);
insert into BRANCH (bid, bname, lid)
values (855, 'Sheryl-Lewis', 666);
insert into BRANCH (bid, bname, lid)
values (418, 'Daryl-Stills', 345);
insert into BRANCH (bid, bname, lid)
values (268, 'Edie-DiCaprio', 444);
insert into BRANCH (bid, bname, lid)
values (643, 'Denise-Hagar', 666);
insert into BRANCH (bid, bname, lid)
values (198, 'Ving-Theron', 555);
insert into BRANCH (bid, bname, lid)
values (653, 'Gene-Utada', 345);
insert into BRANCH (bid, bname, lid)
values (321, 'Kimberly-LaMond', 234);
insert into BRANCH (bid, bname, lid)
values (989, 'Mark-Stiller', 444);
insert into BRANCH (bid, bname, lid)
values (242, 'Sharon-Bonnevil', 444);
insert into BRANCH (bid, bname, lid)
values (651, 'Dwight-Bentley', 123);
insert into BRANCH (bid, bname, lid)
values (825, 'Pablo-Berkeley', 444);
insert into BRANCH (bid, bname, lid)
values (842, 'Bonnie-Liu', 444);
insert into BRANCH (bid, bname, lid)
values (642, 'Claire-Arkin', 444);
insert into BRANCH (bid, bname, lid)
values (725, 'Terrence-Favrea', 345);
insert into BRANCH (bid, bname, lid)
values (619, 'Christmas-Wiest', 555);
insert into BRANCH (bid, bname, lid)
values (894, 'Gladys-Spacek', 234);
insert into BRANCH (bid, bname, lid)
values (881, 'Alessandro-Anis', 444);
insert into BRANCH (bid, bname, lid)
values (233, 'Mickey-Beck', 444);
insert into BRANCH (bid, bname, lid)
values (162, 'Lari-Spader', 666);
insert into BRANCH (bid, bname, lid)
values (696, 'Jean-Springfiel', 234);
insert into BRANCH (bid, bname, lid)
values (645, 'Julio-Spine', 234);
insert into BRANCH (bid, bname, lid)
values (615, 'Betty-MacDowell', 444);
insert into BRANCH (bid, bname, lid)
values (497, 'Freddie-Baransk', 555);
insert into BRANCH (bid, bname, lid)
values (767, 'Kathy-Blossoms', 345);
insert into BRANCH (bid, bname, lid)
values (394, 'Maureen-Raitt', 123);
insert into BRANCH (bid, bname, lid)
values (567, 'Ned-Paquin', 123);
insert into BRANCH (bid, bname, lid)
values (389, 'Maureen-Connery', 666);
insert into BRANCH (bid, bname, lid)
values (925, 'Ronnie-Harary', 555);
insert into BRANCH (bid, bname, lid)
values (444, 'William-Hayek', 234);
insert into BRANCH (bid, bname, lid)
values (378, 'Robbie-Walker', 234);
insert into BRANCH (bid, bname, lid)
values (471, 'Mark-Niven', 234);
insert into BRANCH (bid, bname, lid)
values (976, 'Lionel-Frakes', 666);
insert into BRANCH (bid, bname, lid)
values (211, 'Radney-Nicks', 234);
insert into BRANCH (bid, bname, lid)
values (892, 'Willem-Creek', 444);
insert into BRANCH (bid, bname, lid)
values (933, 'Luke-Domino', 666);
insert into BRANCH (bid, bname, lid)
values (363, 'Kathy-Evanswood', 234);
insert into BRANCH (bid, bname, lid)
values (555, 'Danni-Baranski', 345);
insert into BRANCH (bid, bname, lid)
values (388, 'Mira-Mortensen', 234);
insert into BRANCH (bid, bname, lid)
values (261, 'Terri-Meniketti', 444);
insert into BRANCH (bid, bname, lid)
values (446, 'Denzel-Blackmor', 234);
insert into BRANCH (bid, bname, lid)
values (146, 'Leo-LaSalle', 345);
insert into BRANCH (bid, bname, lid)
values (794, 'Emerson-Negbaur', 345);
insert into BRANCH (bid, bname, lid)
values (639, 'Sarah-Sevigny', 123);
insert into BRANCH (bid, bname, lid)
values (387, 'King-Favreau', 234);
insert into BRANCH (bid, bname, lid)
values (779, 'Morgan-Connick', 666);
insert into BRANCH (bid, bname, lid)
values (278, 'Petula-Willard', 444);
commit;
prompt 200 records committed...
insert into BRANCH (bid, bname, lid)
values (896, 'Diane-Allan', 444);
insert into BRANCH (bid, bname, lid)
values (527, 'Vivica-Eat Worl', 555);
insert into BRANCH (bid, bname, lid)
values (257, 'Demi-Brothers', 444);
insert into BRANCH (bid, bname, lid)
values (399, 'Roy-Franklin', 555);
insert into BRANCH (bid, bname, lid)
values (147, 'Phoebe-Ramis', 345);
insert into BRANCH (bid, bname, lid)
values (692, 'Bridget-Hagerty', 345);
insert into BRANCH (bid, bname, lid)
values (668, 'Bonnie-Wood', 666);
insert into BRANCH (bid, bname, lid)
values (822, 'Randall-Li', 234);
insert into BRANCH (bid, bname, lid)
values (441, 'Hugh-Silverman', 123);
insert into BRANCH (bid, bname, lid)
values (826, 'Denzel-Meyer', 234);
insert into BRANCH (bid, bname, lid)
values (749, 'Harriet-Norton', 345);
insert into BRANCH (bid, bname, lid)
values (186, 'Bobbi-Finn', 123);
insert into BRANCH (bid, bname, lid)
values (792, 'Loreena-Phillip', 555);
insert into BRANCH (bid, bname, lid)
values (197, 'Connie-Griggs', 345);
insert into BRANCH (bid, bname, lid)
values (177, 'Charlton-Judd', 123);
insert into BRANCH (bid, bname, lid)
values (526, 'Daryl-Perlman', 555);
insert into BRANCH (bid, bname, lid)
values (936, 'Ernie-Paltrow', 666);
insert into BRANCH (bid, bname, lid)
values (427, 'Danni-Cockburn', 555);
insert into BRANCH (bid, bname, lid)
values (255, 'Phil-Schreiber', 444);
insert into BRANCH (bid, bname, lid)
values (935, 'Orlando-Reinhol', 234);
insert into BRANCH (bid, bname, lid)
values (172, 'Corey-Ceasar', 123);
insert into BRANCH (bid, bname, lid)
values (566, 'Christina-Warwi', 345);
insert into BRANCH (bid, bname, lid)
values (366, 'Lari-Rawls', 555);
insert into BRANCH (bid, bname, lid)
values (752, 'Curtis-Madsen', 555);
insert into BRANCH (bid, bname, lid)
values (571, 'Ashton-Oates', 666);
insert into BRANCH (bid, bname, lid)
values (499, 'George-Rollins', 666);
insert into BRANCH (bid, bname, lid)
values (525, 'Pamela-Gayle', 555);
insert into BRANCH (bid, bname, lid)
values (245, 'Ali-Orlando', 234);
insert into BRANCH (bid, bname, lid)
values (722, 'Suzy-Bachman', 666);
insert into BRANCH (bid, bname, lid)
values (781, 'Tal-Clooney', 345);
insert into BRANCH (bid, bname, lid)
values (276, 'Joan-Goldberg', 444);
insert into BRANCH (bid, bname, lid)
values (532, 'Jodie-Patrick', 444);
insert into BRANCH (bid, bname, lid)
values (962, 'Daryl-Pesci', 123);
insert into BRANCH (bid, bname, lid)
values (355, 'April-Davis', 123);
insert into BRANCH (bid, bname, lid)
values (231, 'Frances-Coleman', 123);
insert into BRANCH (bid, bname, lid)
values (956, 'Katie-Curry', 234);
insert into BRANCH (bid, bname, lid)
values (959, 'Al-Cleary', 444);
insert into BRANCH (bid, bname, lid)
values (287, 'Eric-Satriani', 123);
insert into BRANCH (bid, bname, lid)
values (861, 'Garry-Mould', 123);
insert into BRANCH (bid, bname, lid)
values (328, 'Gloria-Oldman', 666);
insert into BRANCH (bid, bname, lid)
values (629, 'Fats-Balin', 234);
insert into BRANCH (bid, bname, lid)
values (176, 'Solomon-Wood', 345);
insert into BRANCH (bid, bname, lid)
values (672, 'Dave-Reed', 234);
insert into BRANCH (bid, bname, lid)
values (258, 'Buddy-Speaks', 345);
insert into BRANCH (bid, bname, lid)
values (849, 'Seth-Van Shelto', 555);
insert into BRANCH (bid, bname, lid)
values (915, 'Heath-Hirsch', 345);
insert into BRANCH (bid, bname, lid)
values (179, 'Pelvic-Sizemore', 345);
insert into BRANCH (bid, bname, lid)
values (862, 'Trey-Rickman', 666);
insert into BRANCH (bid, bname, lid)
values (616, 'Vondie-Van Held', 555);
insert into BRANCH (bid, bname, lid)
values (127, 'Martin-Curry', 444);
insert into BRANCH (bid, bname, lid)
values (132, 'Kirsten-Sobiesk', 666);
insert into BRANCH (bid, bname, lid)
values (893, 'Willie-LaSalle', 666);
insert into BRANCH (bid, bname, lid)
values (456, 'Loren-Stigers', 345);
insert into BRANCH (bid, bname, lid)
values (863, 'Hilton-Snider', 234);
insert into BRANCH (bid, bname, lid)
values (181, 'Spike-Nightinga', 234);
insert into BRANCH (bid, bname, lid)
values (871, 'Salma-Berenger', 345);
insert into BRANCH (bid, bname, lid)
values (868, 'Tony-Pantoliano', 123);
insert into BRANCH (bid, bname, lid)
values (229, 'Hank-Atkins', 234);
insert into BRANCH (bid, bname, lid)
values (297, 'Alana-Manning', 555);
insert into BRANCH (bid, bname, lid)
values (769, 'Stephanie-Vassa', 345);
insert into BRANCH (bid, bname, lid)
values (763, 'Parker-Sledge', 345);
insert into BRANCH (bid, bname, lid)
values (673, 'Chi-Young', 345);
insert into BRANCH (bid, bname, lid)
values (992, 'Sharon-Dale', 444);
insert into BRANCH (bid, bname, lid)
values (557, 'Andrae-Burns', 444);
insert into BRANCH (bid, bname, lid)
values (273, 'Lloyd-Wiest', 555);
insert into BRANCH (bid, bname, lid)
values (764, 'Jane-MacDonald', 234);
insert into BRANCH (bid, bname, lid)
values (588, 'Carlos-Crowe', 123);
insert into BRANCH (bid, bname, lid)
values (724, 'Kelli-Meyer', 345);
insert into BRANCH (bid, bname, lid)
values (191, 'Balthazar-Cross', 234);
insert into BRANCH (bid, bname, lid)
values (597, 'Stevie-Penn', 345);
insert into BRANCH (bid, bname, lid)
values (485, 'Tracy-Capshaw', 345);
insert into BRANCH (bid, bname, lid)
values (536, 'Swoosie-Griffit', 234);
insert into BRANCH (bid, bname, lid)
values (658, 'Lucinda-Feore', 234);
insert into BRANCH (bid, bname, lid)
values (139, 'Lenny-Affleck', 444);
insert into BRANCH (bid, bname, lid)
values (236, 'Lara-Shepherd', 666);
insert into BRANCH (bid, bname, lid)
values (968, 'Joe-Imbruglia', 123);
insert into BRANCH (bid, bname, lid)
values (865, 'Cheryl-Stallone', 234);
insert into BRANCH (bid, bname, lid)
values (793, 'Walter-Menikett', 666);
insert into BRANCH (bid, bname, lid)
values (798, 'David-Moreno', 666);
insert into BRANCH (bid, bname, lid)
values (559, 'Miko-O''Neal', 123);
insert into BRANCH (bid, bname, lid)
values (537, 'Alannah-Lewin', 234);
insert into BRANCH (bid, bname, lid)
values (684, 'Louise-Vai', 555);
insert into BRANCH (bid, bname, lid)
values (977, 'Nile-Speaks', 234);
insert into BRANCH (bid, bname, lid)
values (929, 'Fionnula-Ruffal', 444);
insert into BRANCH (bid, bname, lid)
values (816, 'Claire-Barrymor', 123);
insert into BRANCH (bid, bname, lid)
values (382, 'Carol-Playboys', 345);
insert into BRANCH (bid, bname, lid)
values (487, 'Kazem-Rockwell', 666);
insert into BRANCH (bid, bname, lid)
values (463, 'Sara-McNarland', 123);
insert into BRANCH (bid, bname, lid)
values (349, 'Catherine-Brisc', 234);
insert into BRANCH (bid, bname, lid)
values (998, 'Elle-Francis', 666);
insert into BRANCH (bid, bname, lid)
values (224, 'Morgan-Chinlund', 234);
insert into BRANCH (bid, bname, lid)
values (554, 'Kris-Mitra', 444);
insert into BRANCH (bid, bname, lid)
values (344, 'Eliza-Def', 444);
commit;
prompt 293 records loaded
prompt Loading EMPLOYEE...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (666, 'Jackson', 523454321, 999, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (777, 'Emily', 587654565, 999, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (555, 'Bill', 523344434, 777, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (362, 'Ronny-Chung', 2147732266, 829, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (839, 'Famke-Astin', 8361122266, 724, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (612, 'Lance-Haynes', 5461316775, 782, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (242, 'Donal-McConaugh', 9462395266, 976, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (992, 'Art-Leguizamo', 6136243522, 273, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (636, 'Naomi-Morse', 8673724245, 527, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (768, 'Christopher-Spa', 2697357182, 146, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (613, 'Adrien-Lewin', 3476766466, 781, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (533, 'Hank-Fehr', 4475384688, 158, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (327, 'Tramaine-MacIsa', 5633495286, 881, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (323, 'Mike-Carlyle', 9571811199, 231, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (652, 'Ernie-Chappelle', 6957322752, 172, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (542, 'Jay-Parsons', 8598691196, 198, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (573, 'Davis-McGill', 9998632183, 191, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (455, 'Marley-Tate', 8463286133, 818, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (915, 'Carrie-Anne-Cub', 4992519275, 622, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (326, 'Jeroen-Craddock', 8817686195, 321, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (256, 'Chely-Worrell', 7184371829, 687, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (559, 'Jena-Oates', 2657178628, 323, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (964, 'Peabo-McIntosh', 1235139677, 167, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (273, 'Joseph-Alexande', 3334511462, 181, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (232, 'Nanci-Ford', 8281332479, 236, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (118, 'Phil-McLachlan', 9671926968, 643, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (494, 'Blair-Berkley', 5139236428, 862, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (488, 'Rhys-Idle', 9456418237, 281, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (466, 'Heather-Hornsby', 7843843674, 643, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (778, 'Jesse-Chesnutt', 3213679954, 127, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (649, 'Gilberto-McGrif', 4599371481, 527, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (938, 'Suzy-Atkinson', 4996677676, 581, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (426, 'Barry-Iglesias', 8997895367, 195, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (418, 'Michelle-Wong', 6326131429, 129, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (121, 'Wade-Idol', 3432351799, 785, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (733, 'Lena-McDowall', 7125785584, 242, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (691, 'Ron-Preston', 2732881537, 242, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (267, 'Rachid-Bailey', 5123416733, 397, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (233, 'Ray-Colman', 2181775688, 528, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (135, 'Udo-Thomas', 7647462753, 482, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (681, 'Ivan-Kirshner', 9943223955, 131, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (646, 'Hikaru-D''Onofri', 4221342496, 793, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (614, 'Rosanna-Borgnin', 3699589914, 167, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (672, 'Anne-Shatner', 7169668665, 863, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (272, 'Judd-Rea', 9864252488, 313, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (912, 'Frederic-Weber', 4424147146, 399, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (153, 'Curtis-Stiller', 8563596821, 847, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (881, 'Thin-Moody', 9243469119, 629, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (991, 'Buffy-Ledger', 1548266586, 594, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (994, 'Tcheky-Hynde', 5695397522, 389, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (579, 'Mitchell-Gibbon', 9744494937, 868, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (371, 'Micky-Noseworth', 2968487273, 172, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (137, 'Nanci-Phoenix', 8399591878, 725, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (293, 'Sharon-Connelly', 3415138269, 794, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (774, 'Lili-Lucas', 4925146443, 119, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (895, 'Ruth-Lavigne', 2676754663, 645, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (873, 'Carolyn-Underwo', 3117775441, 949, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (584, 'Daniel-Sayer', 6424223485, 556, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (129, 'Joaquin-Giannin', 3227426733, 619, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (961, 'Sydney-Olin', 6574617138, 479, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (534, 'Andie-Nightinga', 6143654161, 666, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (397, 'Jonathan-McCann', 5312632937, 244, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (541, 'Morgan-Thewlis', 5914679924, 184, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (184, 'Marty-Negbaur', 4656723158, 135, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (195, 'Julianne-Tempes', 6116738845, 998, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (513, 'Grace-Davies', 9757148373, 135, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (567, 'Steve-Briscoe', 4361631793, 918, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (916, 'Aida-Gill', 1852921849, 838, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (518, 'Madeline-McDowe', 9792468548, 999, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (679, 'Debbie-Palin', 2415462868, 588, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (483, 'Norm-Byrd', 9425716229, 127, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (521, 'Willem-Lewin', 4663652851, 167, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (448, 'Mary Beth-Ball', 1685616111, 321, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (731, 'Mary-Sedgwick', 5189548247, 739, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (744, 'Ashton-Haslam', 4347897497, 692, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (933, 'Raul-Child', 3866388776, 399, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (592, 'Belinda-Sawa', 8629949825, 687, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (284, 'Hugo-Reubens', 7556677342, 651, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (678, 'Anna-McDonnell', 9687757971, 377, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (982, 'Robbie-Kretschm', 1468617722, 552, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (889, 'Nathan-Palmieri', 2727867648, 344, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (719, 'Marie-Springfie', 6975252349, 777, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (186, 'Ashton-Nicks', 3981811686, 781, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (949, 'Renee-Andrews', 9511858134, 588, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (762, 'Keanu-Portman', 3474281129, 557, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (141, 'Lydia-Red', 1765625551, 815, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (563, 'Paul-Redgrave', 4475486236, 959, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (289, 'Miki-Kinney', 9964249156, 845, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (785, 'Rebeka-Delta', 9277165389, 998, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (432, 'Terence-Emmett', 6643116675, 693, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (752, 'Wade-Foley', 4998454811, 241, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (655, 'Alana-Rivers', 6948867693, 629, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (941, 'Howard-McAnally', 7563614579, 576, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (593, 'Suzy-Arkenstone', 6544687245, 914, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (936, 'Cesar-Holland', 6798476148, 497, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (472, 'Vince-Carradine', 5832195664, 419, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (497, 'Buffy-Alda', 4594732511, 893, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (822, 'Stewart-Moriart', 2437236254, 754, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (615, 'Herbie-Cornell', 5968993796, 398, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (844, 'Luis-Sinise', 7679962939, 189, null);
commit;
prompt 100 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (291, 'Rowan-Dern', 9873656775, 894, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (935, 'Gin-Schock', 2345558522, 456, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (729, 'Rhona-Wilkinson', 4679366958, 914, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (474, 'Stockard-Magnus', 6355483572, 851, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (388, 'Cherry-Dench', 9941312496, 622, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (224, 'Lance-Wine', 3394395733, 191, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (743, 'Terry-Mould', 8446485148, 576, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (625, 'Freddie-Stanton', 4638197441, 616, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (987, 'Kyle-Buckingham', 5489157495, 231, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (851, 'Al-Mills', 7385932738, 936, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (692, 'Patricia-Adler', 8425734661, 544, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (775, 'Elijah-Hunt', 4968693146, 989, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (656, 'Victoria-Shaye', 1722549122, 236, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (171, 'Coley-DeGraw', 7375167139, 969, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (617, 'Albertina-Dalto', 2561482257, 244, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (238, 'Junior-Magnuson', 2293911721, 377, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (311, 'Angelina-Peters', 3582246226, 285, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (726, 'Gil-Strong', 8341751636, 925, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (792, 'Gil-Van Shelton', 1114589549, 759, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (389, 'Alfie-Durning', 5133976236, 567, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (248, 'Joshua-Sartain', 8816338515, 865, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (918, 'Linda-McDiarmid', 1515414414, 285, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (318, 'Eliza-Oldman', 2541922856, 792, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (125, 'Jeff-Bachman', 4634848571, 387, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (787, 'Trey-Tyler', 2751721898, 389, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (241, 'Isabella-Thomps', 5224871636, 769, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (264, 'Andy-Sandler', 8463466555, 977, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (325, 'Vienna-Peterson', 7211861571, 547, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (773, 'Brothers-Thorto', 6161219832, 754, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (635, 'Millie-Garfunke', 6498632228, 381, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (447, 'Trace-Bening', 2958219824, 137, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (441, 'Boyd-Tankard', 1735628167, 622, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (671, 'Tea-Tanon', 3837719165, 841, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (451, 'Cyndi-Dickinson', 4351597369, 895, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (372, 'Andrew-Kier', 1985746716, 441, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (217, 'Jena-Tobolowsky', 7588219431, 992, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (244, 'Boz-Bridges', 9278553685, 195, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (911, 'Crispin-Paltrow', 3675192896, 894, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (269, 'Remy-Saucedo', 9158681518, 255, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (116, 'King-Matheson', 9365548127, 537, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (225, 'Roberta-Carter', 8412523581, 258, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (766, 'Taylor-Tisdale', 9139339289, 741, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (529, 'Rachid-Patrick', 5387875845, 792, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (939, 'King-Henstridge', 1724885712, 893, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (769, 'Kyra-Collins', 1562288959, 162, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (377, 'Jeffery-Bening', 1965734653, 217, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (462, 'Humberto-Hart', 8327178823, 112, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (622, 'Anne-MacIsaac', 3128443597, 652, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (888, 'Denis-Allan', 4323898157, 191, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (899, 'Kenneth-Rifkin', 3532743563, 567, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (639, 'Shawn-Rundgren', 4895395293, 474, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (967, 'Gailard-Keitel', 7448943815, 615, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (476, 'Nicholas-Bates', 3123381645, 684, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (825, 'Clint-McCabe', 7884381627, 444, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (223, 'Dionne-Posener', 6872693914, 265, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (866, 'Gran-Brickell', 5166896522, 486, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (871, 'Leon-Dern', 1852713722, 739, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (922, 'Gordie-Larter', 6771177274, 217, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (313, 'Cuba-Gallant', 1321488821, 179, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (274, 'Jonathan-Sorvin', 9451676542, 668, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (983, 'Vince-Cotton', 5678564128, 418, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (739, 'Leo-Stevenson', 5859893267, 268, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (329, 'Anthony-Botti', 9167649412, 785, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (746, 'Fairuza-Penders', 6111357769, 531, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (163, 'Simon-Connick', 1734621751, 682, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (381, 'Malcolm-Hutton', 6912418141, 994, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (832, 'Marina-Cagle', 9435466931, 456, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (996, 'Clive-Shocked', 9755376834, 344, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (576, 'Sean-Loeb', 2449196647, 462, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (427, 'Chrissie-Weaver', 2541775256, 754, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (182, 'Donna-Bonnevill', 8934533112, 865, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (886, 'Rhett-Biel', 4543947514, 554, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (177, 'Vince-Warren', 2379815191, 556, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (651, 'Rebecca-Irving', 5442516625, 777, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (365, 'Lance-Williamso', 4122163938, 355, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (393, 'Daniel-Loring', 8212568269, 186, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (812, 'Maureen-Sherman', 7939158564, 236, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (169, 'Angie-Brandt', 8951144377, 865, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (969, 'Julianna-Wiedli', 4361885722, 636, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (337, 'Edgar-Matheson', 5477594487, 536, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (745, 'Natacha-O''Sulli', 6955772547, 158, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (928, 'Natascha-Lauper', 3955544858, 896, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (959, 'Wes-Woodard', 5171597292, 258, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (143, 'Garry-Aniston', 4538547735, 229, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (179, 'Natascha-Neuwir', 5974278272, 427, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (583, 'Samantha-Diggs', 8198667298, 718, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (675, 'Demi-Heche', 2914354746, 721, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (234, 'Cyndi-Black', 3333835564, 285, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (647, 'Tzi-Soul', 4825461387, 693, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (993, 'Buddy-Davidtz', 5714345756, 563, null);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1, ' Aliza', 527703458, null, 1);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (2, ' Meni', 527741538, null, 2);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (3, ' Eli', 548575444, null, 3);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (7, 'Daryl', 9183815244, null, 633);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (8, 'Luke', 4716652251, null, 257);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (9, 'Lupe', 1837852441, null, 724);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (10, 'Beth', 4472291587, null, 283);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (11, 'Laura', 1962719321, null, 492);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (12, 'Rascal', 1668542328, null, 605);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (13, 'Meryl', 8285935174, null, 89);
commit;
prompt 200 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (14, 'Bobby', 4244796739, null, 302);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (15, 'Louise', 1517813287, null, 56);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (16, 'Howard', 2783144856, null, 719);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (17, 'Thin', 4884661549, null, 649);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (18, 'Suzi', 1491913724, null, 725);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (19, 'Adina', 1546394796, null, 191);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (20, 'Donna', 5699988185, null, 769);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (21, 'Kenneth', 2353671645, null, 649);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (22, 'Wang', 1684613334, null, 214);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (23, 'Nanci', 4294175744, null, 690);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (24, 'Pablo', 8282758914, null, 1);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (25, 'Joy', 1666648891, null, 788);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (26, 'Albert', 8821914166, null, 491);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (27, 'Ike', 5653264716, null, 230);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (28, 'Vern', 7547944732, null, 451);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (29, 'Nils', 3395953835, null, 610);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (30, 'Chely', 2477643859, null, 230);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (31, 'Breckin', 1397713128, null, 16);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (32, 'Pat', 6964563862, null, 322);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (33, 'Coley', 2885826224, null, 166);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (34, 'Chalee', 7966368583, null, 315);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (35, 'Jonny Lee', 5117488795, null, 646);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (36, 'Gaby', 2813923531, null, 262);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (37, 'Jennifer', 6373195431, null, 505);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (38, 'Dennis', 6287991643, null, 286);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (39, 'Wang', 9445123616, null, 231);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (40, 'Wally', 9541182856, null, 14);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (41, 'Jody', 7419693478, null, 641);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (42, 'Stockard', 2691118937, null, 461);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (43, 'Al', 5618996274, null, 198);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (44, 'Harriet', 6999629579, null, 782);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (45, 'Ricky', 8252575385, null, 521);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (46, 'Harris', 1917896373, null, 96);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (47, 'Judd', 4712338131, null, 285);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (48, 'Randy', 9559279853, null, 397);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (49, 'Annie', 4777273826, null, 527);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (50, 'Armin', 8625745758, null, 392);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (51, 'Nicolas', 6259198871, null, 439);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (52, 'Anna', 7673885533, null, 595);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (53, 'Marina', 1692281716, null, 534);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (54, 'Lynn', 1966548716, null, 387);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (55, 'Lena', 2986699753, null, 739);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (56, 'Julie', 9159137497, null, 650);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (57, 'Rolando', 4685546327, null, 278);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (58, 'Trini', 5848861745, null, 40);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (59, 'Vincent', 1685925669, null, 149);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (60, 'Judge', 3477297923, null, 759);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (61, 'Dylan', 7612191293, null, 163);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (62, 'Brenda', 9495176271, null, 193);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (63, 'Praga', 2596293511, null, 593);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (64, 'Susan', 5271951914, null, 612);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (65, 'Liquid', 2467494451, null, 98);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (66, 'Nik', 5211643927, null, 212);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (67, 'Olympia', 7848192187, null, 186);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (68, 'Hal', 9953986387, null, 431);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (69, 'Jena', 4948486485, null, 413);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (70, 'Kurtwood', 5339243487, null, 435);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (71, 'Blair', 4216598972, null, 581);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (72, 'Hugo', 8745987857, null, 477);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (73, 'Sydney', 3834828221, null, 15);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (74, 'Marley', 9781788175, null, 689);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (75, 'Delroy', 6345869786, null, 342);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (76, 'Daryl', 6553995616, null, 554);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (77, 'Andre', 9594251788, null, 563);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (78, 'Harrison', 6554239767, null, 439);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (79, 'Quentin', 8159826245, null, 780);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (80, 'Jessica', 4213666235, null, 424);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (81, 'Teena', 3629137561, null, 741);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (82, 'Illeana', 3468746359, null, 638);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (83, 'Stellan', 4469743951, null, 200);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (84, 'Nanci', 9361485145, null, 260);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (85, 'Stellan', 7562876961, null, 551);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (86, 'Colm', 5824421143, null, 747);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (87, 'Barry', 8448157197, null, 672);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (88, 'Ralph', 5871285175, null, 283);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (89, 'Ceili', 3824459993, null, 478);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (90, 'Lennie', 4836249415, null, 680);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (91, 'Armand', 5139375535, null, 764);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (92, 'Thora', 6616518851, null, 558);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (93, 'Matt', 1223414365, null, 279);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (94, 'Vince', 2396589713, null, 362);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (95, 'Charlton', 6883757427, null, 799);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (96, 'Oro', 4476161779, null, 750);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (97, 'Elvis', 4589135883, null, 634);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (98, 'Max', 1616557937, null, 143);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (99, 'Shelby', 3585222865, null, 518);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (100, 'Sam', 2878541321, null, 767);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (101, 'Kasey', 5231382738, null, 441);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (102, 'Jarvis', 3692781259, null, 441);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (103, 'Rueben', 2675793945, null, 409);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (104, 'Marley', 3292881532, null, 665);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (105, 'Anne', 4499747511, null, 201);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (106, 'Lynette', 1954553297, null, 699);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (107, 'Anjelica', 9697723827, null, 291);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (108, 'Jill', 3394382612, null, 569);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (109, 'Chaka', 9587689736, null, 180);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (110, 'Gena', 9192385495, null, 703);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (111, 'Janeane', 2279918943, null, 725);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (112, 'Will', 3452749889, null, 668);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (113, 'Ving', 9361823342, null, 674);
commit;
prompt 300 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (114, 'Brenda', 5161352997, null, 419);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (115, 'Nastassja', 1484616333, null, 87);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (117, 'Janice', 4627652836, null, 318);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (119, 'Kurtwood', 7927416336, null, 136);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (120, 'Tommy', 3199253426, null, 423);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (122, 'Rickie', 6237387516, null, 644);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (123, 'Carlene', 5865272633, null, 741);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (124, 'Balthazar', 2338688751, null, 596);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (126, 'Maureen', 2355278227, null, 200);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (127, 'Suzanne', 9445574324, null, 728);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (128, 'Jean', 2728625228, null, 708);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (130, 'Natalie', 3792863425, null, 784);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (131, 'Nanci', 5415823466, null, 762);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (132, 'Glen', 5723128443, null, 455);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (133, 'Gordie', 7848299119, null, 310);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (134, 'Lorraine', 2693452221, null, 612);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (136, 'Mel', 5535298539, null, 595);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (138, 'Illeana', 2727286597, null, 418);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (139, 'Latin', 8485939622, null, 403);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (140, 'Karon', 8893737183, null, 68);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (142, 'Pamela', 3986793935, null, 425);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (144, 'Davey', 9956949199, null, 381);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (145, 'Teri', 2115942872, null, 740);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (146, 'Kieran', 1282959854, null, 539);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (147, 'Kim', 4522683796, null, 113);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (148, 'Mike', 3793628878, null, 484);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (149, 'Lucinda', 8847943219, null, 468);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (150, 'Paula', 7123884376, null, 606);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (151, 'Kelli', 4463349913, null, 566);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (152, 'Martha', 4782352293, null, 396);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (154, 'Spencer', 4458397411, null, 762);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (155, 'Suzanne', 5881787979, null, 532);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (156, 'Trace', 1895199918, null, 215);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (157, 'Randy', 1275625838, null, 316);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (158, 'Danni', 9274292228, null, 164);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (159, 'Selma', 3543823996, null, 658);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (160, 'Jet', 3922779514, null, 653);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (161, 'Chloe', 7148278214, null, 111);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (162, 'Swoosie', 4972865345, null, 622);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (164, 'Pamela', 5351967715, null, 491);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (165, 'Willem', 4942273427, null, 751);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (166, 'Treat', 7962378766, null, 648);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (167, 'Diane', 1945951188, null, 85);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (168, 'Nina', 3755176675, null, 489);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (170, 'Sonny', 2857775918, null, 793);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (172, 'Alice', 8748661675, null, 98);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (173, 'Jason', 4985925948, null, 656);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (174, 'Gabrielle', 7292418544, null, 186);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (175, 'Catherine', 2422773559, null, 713);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (176, 'Courtney', 7152115396, null, 655);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (178, 'Gary', 7325549136, null, 362);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (180, 'Natalie', 6687274215, null, 635);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (181, 'Woody', 7433217145, null, 222);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (183, 'Rodney', 6667271229, null, 395);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (185, 'Suzy', 7876424329, null, 38);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (187, 'Gene', 8429384342, null, 15);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (188, 'Ruth', 3168788525, null, 567);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (189, 'Carrie-Anne', 8957813461, null, 189);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (190, 'April', 4682197959, null, 106);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (191, 'Claire', 4721334477, null, 284);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (192, 'Jon', 1421781529, null, 159);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (193, 'Devon', 4418549252, null, 255);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (194, 'Kimberly', 7318759973, null, 733);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (196, 'Bradley', 2289166614, null, 473);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (197, 'Mary Beth', 1871495155, null, 279);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (198, 'Minnie', 8682732519, null, 459);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (199, 'Kim', 6811412357, null, 799);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (200, 'Gloria', 4452617142, null, 767);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (201, 'Stanley', 4673934749, null, 520);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (202, 'Brenda', 5336551278, null, 543);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (203, 'Delroy', 2194914136, null, 385);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (204, 'Tim', 9675584243, null, 297);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (205, 'Jeffrey', 1171534568, null, 66);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (206, 'Betty', 1528596118, null, 730);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (207, 'Javon', 1379579498, null, 132);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (208, 'Dianne', 3253952347, null, 338);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (209, 'Kurtwood', 5646127727, null, 654);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (210, 'Isaac', 5668155279, null, 282);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (211, 'Charlton', 3442544685, null, 26);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (212, 'Viggo', 9356538225, null, 598);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (213, 'Julia', 3817225915, null, 612);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (214, 'Armin', 9632448327, null, 658);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (215, 'Julio', 5947525275, null, 679);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (216, 'Gene', 6416271538, null, 509);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (218, 'Mia', 3354266227, null, 190);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (219, 'Micky', 3126587289, null, 49);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (220, 'Etta', 4922972421, null, 585);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (221, 'Juliana', 5625275844, null, 528);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (222, 'Rene', 5876669662, null, 82);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (226, 'Breckin', 7962475197, null, 801);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (227, 'Nicky', 3119768119, null, 656);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (228, 'Rebecca', 8521425645, null, 195);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (229, 'Phoebe', 3242235449, null, 28);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (230, 'Courtney', 5737419383, null, 154);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (231, 'Nancy', 7223437961, null, 346);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (235, 'Ryan', 1116992215, null, 378);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (236, 'Heath', 3847212976, null, 520);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (237, 'Adrien', 5756261332, null, 156);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (239, 'Lupe', 4482837111, null, 154);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (240, 'Timothy', 6868963811, null, 118);
commit;
prompt 400 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (243, 'Yolanda', 7315267642, null, 146);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (245, 'Clive', 7736891487, null, 456);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (246, 'Elvis', 7261152732, null, 195);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (247, 'Sigourney', 2718843417, null, 235);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (249, 'Warren', 5794553925, null, 284);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (250, 'Aida', 2243891478, null, 568);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (251, 'Gates', 7461234634, null, 95);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (252, 'Boz', 8783162832, null, 221);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (253, 'Elias', 8234875888, null, 620);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (254, 'Edwin', 1292923944, null, 350);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (255, 'Liev', 3656559231, null, 782);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (257, 'Robby', 3115494289, null, 262);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (258, 'Harvey', 5249714559, null, 716);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (259, 'Xander', 7768459744, null, 456);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (260, 'Herbie', 7515158731, null, 451);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (261, 'Brian', 2752129157, null, 522);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (262, 'Courtney', 1737919366, null, 40);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (263, 'Miles', 4763493621, null, 78);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (265, 'Ramsey', 2297829521, null, 143);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (266, 'Gordie', 5851543343, null, 500);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (268, 'Renee', 2514769373, null, 5);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (270, 'Garth', 8827719334, null, 186);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (271, 'Stanley', 3626642223, null, 172);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (275, 'Willem', 9515776231, null, 56);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (276, 'Holly', 7391314237, null, 557);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (277, 'Jason', 7189568229, null, 379);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (278, 'Kyle', 5151821897, null, 154);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (279, 'Julio', 3851335699, null, 515);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (280, 'Tramaine', 1318314157, null, 769);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (281, 'Wayne', 9236647435, null, 601);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (282, 'Kurt', 6974675251, null, 26);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (283, 'Azucar', 3531477991, null, 616);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (285, 'Celia', 6434695379, null, 728);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (286, 'Marina', 6371376681, null, 579);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (287, 'Chalee', 5654739877, null, 422);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (288, 'Derek', 2391763675, null, 327);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (290, 'Hookah', 2866832372, null, 547);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (292, 'Rade', 7827722951, null, 637);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (294, 'Lupe', 8311593833, null, 625);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (295, 'Mel', 7189815368, null, 722);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (296, 'Jann', 1226527678, null, 692);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (297, 'Benicio', 6464218898, null, 751);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (298, 'Rolando', 8399631264, null, 779);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (299, 'Armin', 9649433135, null, 590);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (300, 'Roberta', 9595498989, null, 604);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (301, 'Debbie', 4725847884, null, 89);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (302, 'Ani', 6228491713, null, 21);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (303, 'Remy', 5585688885, null, 567);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (304, 'Pablo', 5747281232, null, 407);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (305, 'Alfie', 2983392188, null, 612);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (306, 'Aimee', 2639683912, null, 212);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (307, 'Rebecca', 1915397663, null, 771);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (308, 'Diamond', 6617747434, null, 141);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (309, 'Russell', 1257768326, null, 416);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (310, 'Harrison', 7893483959, null, 335);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (312, 'Jeffrey', 1136937451, null, 679);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (314, 'Natascha', 8366894239, null, 396);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (315, 'Rufus', 6679717747, null, 675);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (316, 'Cameron', 8116284165, null, 727);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (317, 'Alec', 1817252556, null, 526);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (319, 'Art', 5368686955, null, 517);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (320, 'Curtis', 7236992782, null, 168);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (321, 'Mili', 6545892464, null, 498);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (322, 'Ivan', 9684253743, null, 584);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (324, 'Albertina', 7347115774, null, 338);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (328, 'Glenn', 2288277857, null, 295);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (330, 'Sarah', 7354338116, null, 559);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (331, 'Louise', 8626551871, null, 528);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (332, 'Grace', 5424918768, null, 347);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (333, 'Nikka', 3792591928, null, 83);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (334, 'Herbie', 3167596469, null, 68);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (335, 'Annie', 5714135987, null, 327);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (336, 'Denny', 2462159178, null, 72);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (338, 'Chantי', 4888519156, null, 321);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (339, 'Edward', 6469997894, null, 300);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (340, 'Owen', 3187995545, null, 317);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (341, 'Earl', 9474219379, null, 792);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (342, 'Mac', 7723746997, null, 755);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (343, 'Willem', 3873542111, null, 382);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (344, 'Judy', 5281884132, null, 532);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (345, 'Debra', 1888745795, null, 477);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (346, 'Colm', 8363592544, null, 522);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (347, 'Sammy', 3333632642, null, 334);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (348, 'Christian', 9325381611, null, 76);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (349, 'Belinda', 6777675636, null, 708);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (350, 'Marina', 1553219632, null, 509);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (351, 'Miranda', 7574915897, null, 149);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (352, 'Heath', 8388641158, null, 408);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (353, 'Latin', 5418497772, null, 680);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (354, 'Vanessa', 6873417559, null, 509);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (355, 'Campbell', 5461862776, null, 147);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (356, 'Jude', 9723198594, null, 166);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (357, 'Kirk', 6657324499, null, 337);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (358, 'Leonardo', 9123581378, null, 504);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (359, 'Liv', 3423146115, null, 693);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (360, 'Busta', 7997257874, null, 582);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (361, 'Salma', 6354584828, null, 500);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (363, 'Jill', 5492653273, null, 781);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (364, 'Mac', 8527996892, null, 696);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (366, 'Mac', 4986513835, null, 482);
commit;
prompt 500 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (367, 'Miranda', 4257363234, null, 248);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (368, 'Cevin', 7628484987, null, 496);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (369, 'Ritchie', 6513426913, null, 447);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (370, 'Rhea', 5295354217, null, 638);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (373, 'Robin', 6514875686, null, 321);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (374, 'Edgar', 2984185819, null, 5);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (375, 'Debra', 5515461977, null, 655);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (376, 'Johnette', 2334782528, null, 254);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (378, 'Wes', 7437749424, null, 225);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (379, 'Lindsey', 3289197797, null, 665);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (380, 'Curt', 6844629524, null, 22);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (382, 'Penelope', 6296579876, null, 529);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (383, 'Marisa', 8291623999, null, 203);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (384, 'Ving', 2535632798, null, 234);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (385, 'Jack', 8317774426, null, 171);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (386, 'Rich', 9841477433, null, 202);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (387, 'Geoffrey', 3173611821, null, 516);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (390, 'Delbert', 5964491366, null, 220);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (391, 'Chris', 2324272183, null, 107);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (392, 'Nora', 9355913377, null, 768);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (394, 'Dick', 7362647722, null, 173);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (395, 'Olympia', 4543283376, null, 103);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (396, 'Tracy', 2192716815, null, 82);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (398, 'Claude', 3237164751, null, 23);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (399, 'Tara', 4895934142, null, 511);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (400, 'Elisabeth', 4459741988, null, 160);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (401, 'Billy', 5714517823, null, 767);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (402, 'Gary', 9921685268, null, 331);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (403, 'Darren', 4552567389, null, 75);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (404, 'Rachid', 2885592398, null, 640);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (405, 'Ryan', 7326212256, null, 439);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (406, 'Millie', 8157852831, null, 113);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (407, 'Jill', 8784825315, null, 594);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (408, 'Aida', 9524273624, null, 760);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (409, 'Candice', 6236866464, null, 411);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (410, 'Emma', 7165996422, null, 337);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (411, 'Owen', 7427155249, null, 519);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (412, 'Dylan', 6222756371, null, 713);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (413, 'Maura', 8817815821, null, 278);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (414, 'Neve', 6578544263, null, 331);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (415, 'Rachael', 6676258239, null, 176);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (416, 'Isaiah', 4661819992, null, 605);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (417, 'Lucy', 7627259399, null, 269);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (419, 'Judd', 4986799431, null, 214);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (420, 'Olympia', 1376454394, null, 339);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (421, 'Derek', 5298661115, null, 184);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (422, 'Kasey', 2695192841, null, 663);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (423, 'Wayman', 8913681817, null, 583);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (424, 'Jackson', 7112563912, null, 272);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (425, 'Mili', 9115986552, null, 317);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (428, 'Anjelica', 2838479327, null, 349);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (429, 'Willem', 7577936483, null, 476);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (430, 'Samantha', 1666194193, null, 49);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (431, 'Diamond', 9431976597, null, 713);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (433, 'Rob', 8999898928, null, 220);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (434, 'Isabella', 5257322322, null, 392);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (435, 'Oliver', 6351265365, null, 541);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (436, 'Alan', 9344864955, null, 366);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (437, 'Val', 1213576922, null, 369);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (438, 'Gordon', 1944785494, null, 68);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (439, 'Jonny Lee', 1612849978, null, 245);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (440, 'Whoopi', 3879511332, null, 769);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (442, 'Laurie', 4187675445, null, 295);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (443, 'Embeth', 2272197644, null, 572);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (444, 'Matthew', 3991854681, null, 79);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (445, 'Owen', 5428923957, null, 422);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (446, 'Ryan', 9434572738, null, 571);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (449, 'Mika', 5814164578, null, 81);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (450, 'Mykelti', 7917991381, null, 226);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (452, 'Jeremy', 7736151622, null, 484);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (453, 'Eddie', 2465229182, null, 192);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (454, 'Leslie', 5998967635, null, 136);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (456, 'Nikki', 6817936221, null, 316);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (457, 'Davy', 4918738832, null, 553);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (458, 'Curt', 1536468793, null, 389);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (459, 'Caroline', 4237595511, null, 16);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (460, 'Ron', 5461516299, null, 352);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (461, 'Mili', 2562944438, null, 667);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (463, 'Javon', 8396477675, null, 629);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (464, 'Oro', 2239249754, null, 71);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (465, 'Chubby', 6627325784, null, 408);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (467, 'Annette', 3348815278, null, 277);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (468, 'Eric', 3155944138, null, 673);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (469, 'Alannah', 7417631475, null, 338);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (470, 'Chaka', 2677773388, null, 684);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (471, 'Gord', 2372948296, null, 647);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (473, 'Rachael', 5891379191, null, 21);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (475, 'Jena', 3995622752, null, 78);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (477, 'Clint', 3797796233, null, 52);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (478, 'Rebecca', 9125367831, null, 500);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (479, 'Hex', 9285775432, null, 402);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (480, 'Sheena', 1466346142, null, 660);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (481, 'Jeanne', 7769261788, null, 501);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (482, 'Kirsten', 9148691238, null, 518);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (484, 'Eliza', 8957828112, null, 321);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (485, 'Matthew', 2682461559, null, 630);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (486, 'Russell', 7358672442, null, 343);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (487, 'Garry', 7439332768, null, 695);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (489, 'Max', 5759183965, null, 604);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (490, 'Caroline', 7768473158, null, 90);
commit;
prompt 600 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (491, 'Nastassja', 1699678292, null, 741);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (492, 'Jared', 2144113534, null, 738);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (493, 'Diane', 6497768727, null, 546);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (495, 'John', 1631837976, null, 253);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (496, 'Toni', 8383589154, null, 659);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (498, 'Anita', 4812197133, null, 152);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (499, 'Geraldine', 9911979919, null, 699);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (500, 'Lindsay', 9172669529, null, 644);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (501, 'Carla', 1874518185, null, 775);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (502, 'Benjamin', 8415128523, null, 569);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (503, 'Irene', 6234973525, null, 636);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (504, 'Anita', 2257347864, null, 782);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (505, 'First', 9177889219, null, 652);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (506, 'Annie', 4272361457, null, 72);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (507, 'Miriam', 1567774594, null, 102);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (508, 'Neve', 8192431743, null, 443);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (509, 'Hugo', 1472627289, null, 26);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (510, 'Hector', 1721115951, null, 379);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (511, 'Seth', 5232777292, null, 647);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (512, 'Albertina', 4253737746, null, 84);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (514, 'Domingo', 1284328184, null, 509);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (515, 'Kevn', 1454278364, null, 198);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (516, 'Ronnie', 1282299418, null, 652);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (517, 'Bebe', 5766993194, null, 408);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (519, 'John', 5122972685, null, 398);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (520, 'Harrison', 9547798838, null, 706);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (522, 'Heath', 2612749176, null, 684);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (523, 'Kirk', 7529752612, null, 783);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (524, 'Elvis', 4237115826, null, 737);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (525, 'Raul', 1463188451, null, 285);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (526, 'Lucy', 9787135422, null, 386);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (527, 'Lydia', 8332879227, null, 577);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (528, 'CeCe', 7849242895, null, 360);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (530, 'Carrie-Anne', 4231971423, null, 404);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (531, 'Adam', 5576561855, null, 215);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (532, 'Bobby', 1846551196, null, 373);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (535, 'Colin', 7227743598, null, 49);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (536, 'Carol', 6719216928, null, 21);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (537, 'Dustin', 7932463978, null, 499);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (538, 'Jill', 1215716441, null, 552);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (539, 'Nick', 6878435216, null, 305);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (540, 'Dean', 5251183436, null, 737);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (543, 'Kim', 5545992744, null, 754);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (544, 'Emma', 4512559818, null, 330);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (545, 'Miriam', 8912475557, null, 584);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (546, 'Sheena', 9776226289, null, 278);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (547, 'Mika', 3813523255, null, 739);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (548, 'Thin', 9916422779, null, 65);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (549, 'Leonardo', 3747678776, null, 276);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (550, 'Wade', 1615155963, null, 413);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (551, 'Billy', 3552911395, null, 529);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (552, 'Adam', 3315581781, null, 482);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (553, 'Seth', 3137954223, null, 166);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (554, 'Richard', 5852355514, null, 713);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (556, 'Angelina', 8349762925, null, 595);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (557, 'Laura', 2298324225, null, 268);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (558, 'Anthony', 4197664641, null, 723);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (560, 'Hugh', 5162877792, null, 248);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (561, 'Simon', 1233749564, null, 408);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (562, 'Sam', 1459996392, null, 561);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (564, 'Franco', 9266779186, null, 168);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (565, 'Chris', 4325225631, null, 133);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (566, 'Rosanne', 6787822379, null, 768);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (568, 'Ming-Na', 9858743377, null, 442);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (569, 'Stevie', 7659283377, null, 623);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (570, 'Charles', 2444765765, null, 604);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (571, 'Judy', 4251958425, null, 559);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (572, 'Neil', 7333935396, null, 682);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (574, 'Eugene', 7242551999, null, 423);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (575, 'Juliette', 4889229188, null, 408);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (577, 'Angela', 1331141364, null, 648);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (578, 'Michael', 1669743713, null, 110);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (580, 'Nastassja', 5216472575, null, 555);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (581, 'Geoffrey', 2178662619, null, 340);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (582, 'Trey', 4224228769, null, 689);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (585, 'Courtney', 9656844467, null, 177);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (586, 'Jim', 7452339286, null, 496);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (587, 'Meryl', 7682647716, null, 500);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (588, 'Maria', 3215756571, null, 767);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (589, 'Brothers', 7736866571, null, 267);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (590, 'April', 3932898715, null, 116);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (591, 'Henry', 1245349859, null, 271);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (594, 'Bill', 4696997226, null, 189);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (595, 'Fionnula', 2423981299, null, 802);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (596, 'Vanessa', 3729932932, null, 506);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (597, 'Lenny', 3933314953, null, 111);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (598, 'Xander', 5277816245, null, 98);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (599, 'Ivan', 8289819229, null, 712);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (600, 'Rita', 6925555967, null, 172);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (601, 'Night', 3369584776, null, 660);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (602, 'Sammy', 7949952859, null, 660);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (603, 'Dianne', 2158359829, null, 122);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (604, 'Miles', 9214175684, null, 36);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (605, 'Maura', 3731364215, null, 218);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (606, 'Liv', 5854591212, null, 503);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (607, 'Charlton', 3851925458, null, 316);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (608, 'Dar', 7256424198, null, 181);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (609, 'Tea', 5969514129, null, 521);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (610, 'Caroline', 2222615351, null, 481);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (611, 'Thomas', 5418397479, null, 597);
commit;
prompt 700 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (616, 'Grant', 8558776678, null, 512);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (618, 'Mykelti', 4433425492, null, 578);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (619, 'Guy', 5745792851, null, 301);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (620, 'Christopher', 6169811877, null, 289);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (621, 'Don', 8142492877, null, 256);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (623, 'Rene', 3847445925, null, 217);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (624, 'Marty', 2362519347, null, 252);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (626, 'Wes', 6198429626, null, 677);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (627, 'Xander', 3855848129, null, 492);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (628, 'Ahmad', 7977535596, null, 494);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (629, 'Tilda', 7153683383, null, 254);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (630, 'Alfie', 9323511886, null, 727);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (631, 'Denis', 2811392413, null, 227);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (632, 'Taryn', 4565842646, null, 722);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (633, 'Joy', 8414273882, null, 470);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (634, 'Kay', 5357735624, null, 552);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (637, 'Carolyn', 8752446718, null, 759);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (638, 'Judi', 8664989322, null, 358);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (640, 'Xander', 8868199174, null, 317);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (641, 'Harris', 8141582752, null, 514);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (642, 'Ashley', 9652787746, null, 478);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (643, 'Goran', 7857886766, null, 346);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (644, 'Saffron', 8148817851, null, 153);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (645, 'Terence', 9138561365, null, 189);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (648, 'Shannon', 5332219523, null, 604);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (650, 'Bernard', 3491287355, null, 88);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (653, 'Alessandro', 6534867919, null, 408);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (654, 'Suzanne', 3889168372, null, 140);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (657, 'Liam', 4735142698, null, 668);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (658, 'Tzi', 3317741815, null, 400);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (659, 'Clarence', 3615787496, null, 536);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (660, 'Molly', 6944528776, null, 221);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (661, 'Matt', 4585678529, null, 386);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (662, 'Crystal', 1991361548, null, 652);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (663, 'Kelly', 9158891873, null, 526);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (664, 'Manu', 2744763196, null, 605);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (665, 'Davey', 2756121659, null, 108);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (667, 'Rich', 6738299652, null, 21);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (668, 'John', 4778251837, null, 144);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (669, 'Devon', 3919149173, null, 226);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (670, 'Carrie-Anne', 4988163921, null, 450);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (673, 'Pete', 3818472925, null, 323);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (674, 'Jon', 6774362322, null, 184);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (676, 'Mitchell', 7697963514, null, 249);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (677, 'Jean-Luc', 2616848824, null, 416);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (680, 'Julianne', 4386717951, null, 171);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (682, 'Jodie', 1134632868, null, 757);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (683, 'Lesley', 5779941169, null, 2);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (684, 'Brittany', 4419815717, null, 180);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (685, 'Nicky', 6913594882, null, 312);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (686, 'Vienna', 8922671582, null, 83);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (687, 'Rupert', 1314515137, null, 451);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (688, 'Chely', 3941195488, null, 421);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (689, 'Andrew', 7819941286, null, 431);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (690, 'Marty', 1927873977, null, 352);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (693, 'Elias', 9717837715, null, 548);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (694, 'Betty', 9623832944, null, 488);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (695, 'Benjamin', 9523811574, null, 47);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (696, 'Rick', 4761984333, null, 154);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (697, 'Cliff', 3283227939, null, 615);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (698, 'Rickie', 7736339347, null, 172);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (699, 'Edie', 1643573769, null, 688);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (700, 'Martha', 6564896157, null, 583);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (701, 'Steven', 6385871484, null, 706);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (702, 'Sinead', 1964582465, null, 637);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (703, 'Mitchell', 7825915896, null, 174);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (704, 'Jean-Claude', 4524269445, null, 271);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (705, 'Marc', 9941643124, null, 652);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (706, 'Matthew', 6431655164, null, 679);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (707, 'Victor', 1716553961, null, 67);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (708, 'Balthazar', 5268426477, null, 200);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (709, 'Miko', 6246557912, null, 157);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (710, 'Andrea', 7599534148, null, 724);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (711, 'Eileen', 9291435255, null, 117);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (712, 'Rachel', 5671553957, null, 426);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (713, 'Rich', 2391798433, null, 141);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (714, 'Terrence', 2493261798, null, 513);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (715, 'Vonda', 6116713159, null, 427);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (716, 'Austin', 2328794939, null, 426);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (717, 'Saul', 7221793845, null, 532);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (718, 'Andy', 7227817761, null, 123);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (720, 'Juan', 9344573691, null, 274);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (721, 'Percy', 1891998756, null, 144);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (722, 'Tamala', 1354636469, null, 115);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (723, 'Salma', 9621237446, null, 323);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (724, 'Ann', 6871128261, null, 277);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (725, 'Nicolas', 5966942424, null, 147);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (727, 'Vince', 3522768554, null, 623);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (728, 'Louise', 4947211471, null, 684);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (730, 'Louise', 5768671989, null, 563);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (732, 'Terence', 9761176449, null, 609);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (734, 'Gena', 2549948883, null, 169);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (735, 'Rebecca', 5616249468, null, 737);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (736, 'Norm', 9548541224, null, 225);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (737, 'Rhea', 6245929566, null, 795);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (738, 'Avenged', 4621597862, null, 43);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (740, 'Gordie', 6851261262, null, 606);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (741, 'Beverley', 2545193153, null, 524);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (742, 'Guy', 8635643933, null, 296);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (747, 'Famke', 7954895832, null, 327);
commit;
prompt 800 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (748, 'Celia', 4184438189, null, 617);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (749, 'Ed', 8253328448, null, 247);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (750, 'Giovanni', 9796288538, null, 409);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (751, 'Jerry', 7815888774, null, 193);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (753, 'Cherry', 4781495966, null, 797);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (754, 'Timothy', 5446678933, null, 257);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (755, 'Holly', 7936657632, null, 297);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (756, 'Jean-Luc', 3771848689, null, 193);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (757, 'Anjelica', 5996923852, null, 413);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (758, 'Jackson', 9219611756, null, 125);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (759, 'Katie', 2671132441, null, 285);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (760, 'Harrison', 9138532291, null, 511);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (761, 'Blair', 9925785477, null, 652);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (763, 'Naomi', 5555629358, null, 571);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (764, 'Casey', 1484392246, null, 164);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (765, 'Nils', 3387724582, null, 371);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (767, 'Clarence', 9759773356, null, 779);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (770, 'Kurtwood', 1924951446, null, 563);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (771, 'Miki', 2489627588, null, 215);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (772, 'Chazz', 4827328895, null, 658);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (776, 'Julia', 8438724519, null, 120);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (779, 'Marty', 6453751462, null, 56);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (780, 'Petula', 5973132514, null, 777);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (781, 'Vivica', 4688241475, null, 427);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (782, 'Holland', 5292325547, null, 516);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (783, 'Denzel', 1117852455, null, 78);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (784, 'Brendan', 2848768984, null, 448);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (786, 'Brian', 8844266568, null, 773);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (788, 'Salma', 1779853345, null, 630);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (789, 'Maxine', 6777288128, null, 379);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (790, 'Debby', 6718464484, null, 532);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (791, 'Don', 2549183997, null, 484);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (793, 'Ritchie', 7437561986, null, 83);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (794, 'Edgar', 8959973289, null, 69);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (795, 'Ron', 8123473976, null, 511);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (796, 'France', 8175216827, null, 189);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (797, 'Wayman', 2799789945, null, 727);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (798, 'Bridget', 8463231367, null, 116);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (799, 'Pablo', 8595964386, null, 595);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (800, 'Herbie', 8263377395, null, 740);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (801, 'Matt', 9343252274, null, 336);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (802, 'Barbara', 6163918751, null, 719);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (803, 'Charles', 4331298445, null, 666);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (804, 'Ewan', 5732566432, null, 549);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (805, 'Minnie', 7527166848, null, 665);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (806, 'Sheryl', 7736815797, null, 71);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (807, 'Robert', 3916695269, null, 76);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (808, 'Daniel', 1544624648, null, 584);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (809, 'Gary', 1163583797, null, 90);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (810, 'Garth', 5724529621, null, 657);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (811, 'Fats', 9582457354, null, 179);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (813, 'Elizabeth', 8846568854, null, 664);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (814, 'Talvin', 7111261642, null, 188);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (815, 'Luis', 3594561296, null, 151);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (816, 'Elisabeth', 4255774889, null, 308);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (817, 'Brittany', 6963283586, null, 333);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (818, 'Avril', 9442229463, null, 233);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (819, 'Tommy', 3855126526, null, 472);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (820, 'Pelvic', 3593436254, null, 274);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (821, 'Bradley', 4428296165, null, 71);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (823, 'Aida', 1123635117, null, 455);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (824, 'Murray', 9179619413, null, 345);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (826, 'Roddy', 2625818285, null, 246);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (827, 'Jay', 9773293248, null, 204);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (828, 'Olympia', 3484895279, null, 233);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (829, 'Vertical', 1822774499, null, 376);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (830, 'Stockard', 1362743252, null, 40);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (831, 'Lisa', 2516256467, null, 675);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (833, 'Crispin', 1178666617, null, 141);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (834, 'Tobey', 4792987472, null, 787);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (835, 'Morgan', 2423628721, null, 113);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (836, 'Steve', 9374543355, null, 676);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (837, 'Armand', 3794719577, null, 484);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (838, 'Cevin', 8594471688, null, 678);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (840, 'Bette', 5987946473, null, 627);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (841, 'Rose', 1277915518, null, 491);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (842, 'Temuera', 5358348268, null, 100);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (843, 'Taryn', 8526595928, null, 660);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (845, 'Nora', 8171624991, null, 721);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (846, 'Simon', 3519773158, null, 184);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (847, 'Edwin', 1798114217, null, 204);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (848, 'Greg', 4542544934, null, 580);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (849, 'Rick', 1328545467, null, 626);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (850, 'Nikka', 6255753983, null, 635);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (852, 'Shawn', 5991852851, null, 425);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (853, 'Elijah', 2554546357, null, 503);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (854, 'Sinead', 2735365949, null, 777);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (855, 'Rutger', 1623516988, null, 427);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (856, 'Davey', 2531825356, null, 389);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (857, 'Bobbi', 4512312374, null, 628);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (858, 'Amanda', 4492142965, null, 686);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (859, 'Peabo', 6942685645, null, 513);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (860, 'Thin', 1527346346, null, 42);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (861, 'Ron', 5557745347, null, 23);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (862, 'Glenn', 1654988819, null, 747);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (863, 'Bill', 6577442934, null, 103);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (864, 'Nikka', 4615855364, null, 447);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (865, 'Solomon', 8629621589, null, 565);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (867, 'Renee', 7981952439, null, 672);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (868, 'Ellen', 1682288965, null, 30);
commit;
prompt 900 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (869, 'Armand', 4443214646, null, 238);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (870, 'Dionne', 7756231622, null, 508);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (872, 'Shawn', 2331973381, null, 57);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (874, 'Peabo', 5119927465, null, 94);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (875, 'Etta', 5363693595, null, 63);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (876, 'Michael', 1577352195, null, 556);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (877, 'Bradley', 6146543398, null, 568);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (878, 'Lara', 9731578478, null, 662);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (879, 'Drew', 4776871883, null, 229);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (880, 'Tracy', 2756363476, null, 330);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (882, 'Colm', 4424122977, null, 146);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (883, 'Gil', 2379317126, null, 171);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (884, 'Clay', 7273747926, null, 187);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (885, 'Ellen', 3721422381, null, 510);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (887, 'Annie', 3568375189, null, 58);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (890, 'Shelby', 5533629779, null, 413);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (891, 'Deborah', 8416486467, null, 103);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (892, 'Nastassja', 6589969562, null, 352);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (893, 'Vonda', 2142353328, null, 523);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (894, 'Giovanni', 5112753899, null, 84);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (896, 'Aimee', 7382573619, null, 551);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (897, 'Pelvic', 1988293572, null, 306);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (898, 'Whoopi', 7672368929, null, 402);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (900, 'Avril', 1999999487, null, 211);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (901, 'Ian', 8462177884, null, 456);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (902, 'Shannon', 7111213752, null, 672);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (903, 'Geggy', 2388768689, null, 214);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (904, 'Lin', 4219561811, null, 500);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (905, 'Dylan', 8592189629, null, 133);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (906, 'Howard', 1592341843, null, 570);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (907, 'Larry', 7571927857, null, 346);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (908, 'Keanu', 1945466252, null, 266);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (909, 'Jesus', 4551822539, null, 386);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (910, 'Hope', 8317261153, null, 373);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (913, 'Sheena', 5453871873, null, 37);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (914, 'Suzi', 5598793421, null, 352);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (917, 'Johnette', 2195978865, null, 723);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (919, 'Dan', 3619922353, null, 768);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (920, 'Toshiro', 6195587274, null, 337);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (921, 'Rupert', 3398789542, null, 478);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (923, 'Loreena', 7277868751, null, 230);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (924, 'Art', 9921628323, null, 520);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (925, 'Brenda', 8136873258, null, 567);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (926, 'Yaphet', 8261594156, null, 117);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (927, 'Ritchie', 7767791563, null, 762);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (929, 'Carrie', 7459429725, null, 677);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (930, 'Ving', 2135526822, null, 726);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (931, 'Blair', 2793866963, null, 178);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (932, 'Brad', 8881359789, null, 613);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (934, 'Temuera', 2118347589, null, 70);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (937, 'Dean', 2238669772, null, 268);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (940, 'Nik', 9116682699, null, 776);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (942, 'Clea', 4834693266, null, 689);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (943, 'Ivan', 9697923984, null, 334);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (944, 'Barry', 1166173941, null, 346);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (945, 'Suzanne', 5541381324, null, 168);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (946, 'Jonathan', 8372576626, null, 647);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (947, 'Sal', 5845179614, null, 291);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (948, 'Kazem', 2268783244, null, 684);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (950, 'Debbie', 7236342349, null, 392);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (951, 'Buffy', 8868731482, null, 200);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (952, 'Mel', 1364959864, null, 678);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (953, 'Bebe', 3786958423, null, 198);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (954, 'Kathy', 9712689346, null, 483);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (955, 'Rich', 8467193253, null, 766);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (956, 'Fred', 1584389599, null, 84);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (957, 'Brothers', 7322231245, null, 622);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (958, 'Mika', 2735672495, null, 697);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (960, 'Blair', 9362919658, null, 503);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (962, 'Sheena', 9233287869, null, 83);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (963, 'Lois', 4421687729, null, 347);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (965, 'Gailard', 1868933988, null, 574);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (966, 'Lloyd', 1629197434, null, 212);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (968, 'Ahmad', 4417741887, null, 712);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (970, 'Philip', 3692192729, null, 499);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (971, 'Edgar', 2257915296, null, 430);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (972, 'Chi', 5773413287, null, 127);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (973, 'Keanu', 1412355441, null, 66);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (974, 'Simon', 1489852995, null, 754);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (975, 'Rosanne', 4665523551, null, 596);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (976, 'Adina', 2731718433, null, 555);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (977, 'Ramsey', 1132683278, null, 243);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (978, 'Ron', 5972596832, null, 597);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (979, 'Angie', 8643255753, null, 573);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (980, 'Pablo', 4578498957, null, 617);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (981, 'Barry', 2821721325, null, 425);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (984, 'Willem', 2285759738, null, 553);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (985, 'Chaka', 4536452466, null, 52);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (986, 'Jon', 6619511613, null, 683);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (988, 'Woody', 5173931222, null, 382);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (989, 'Claude', 3592465768, null, 558);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (990, 'Tyrone', 7877958375, null, 282);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (995, 'Edwin', 7293441717, null, 91);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (997, 'Maggie', 9274585474, null, 130);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (998, 'Emmylou', 4132961512, null, 404);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (999, 'Benicio', 5261755842, null, 673);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1000, 'Winona', 2671126896, null, 712);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1001, 'Avenged', 8237562325, null, 532);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1002, 'Sinead', 4373393355, null, 16);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1003, 'Christina', 7717898552, null, 351);
commit;
prompt 1000 records committed...
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1004, 'Alfie', 7121632128, null, 566);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1005, 'Leon', 8756586839, null, 464);
insert into EMPLOYEE (eid, ename, ephone_number, bid, shop_id)
values (1006, 'Olympia', 8295425671, null, 729);
commit;
prompt 1003 records loaded
prompt Loading ORDERS...
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (776, 1620, to_date('02-04-2023', 'dd-mm-yyyy'), 111, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (882, 1170, to_date('12-03-2023', 'dd-mm-yyyy'), 222, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (667, 720, to_date('16-01-2023', 'dd-mm-yyyy'), 333, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (511, 189, to_date('27-06-2014', 'dd-mm-yyyy'), 466, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (555, 215, to_date('01-09-2013', 'dd-mm-yyyy'), 423, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (452, 225, to_date('24-05-2021', 'dd-mm-yyyy'), 221, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (698, 355, to_date('18-09-1997', 'dd-mm-yyyy'), 494, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (679, 39, to_date('13-09-2012', 'dd-mm-yyyy'), 777, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (495, 105, to_date('11-01-1993', 'dd-mm-yyyy'), 817, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (353, 175, to_date('10-08-1971', 'dd-mm-yyyy'), 891, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (983, 123, to_date('07-10-2014', 'dd-mm-yyyy'), 174, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (221, 239, to_date('22-06-2002', 'dd-mm-yyyy'), 966, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (599, 269, to_date('21-02-2002', 'dd-mm-yyyy'), 821, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (946, 69, to_date('05-04-1984', 'dd-mm-yyyy'), 622, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (821, 119, to_date('18-11-1973', 'dd-mm-yyyy'), 938, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (141, 92, to_date('28-04-1980', 'dd-mm-yyyy'), 115, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (794, 29, to_date('06-09-1987', 'dd-mm-yyyy'), 226, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (389, 99, to_date('18-09-2017', 'dd-mm-yyyy'), 749, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (712, 29, to_date('05-07-1984', 'dd-mm-yyyy'), 494, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (185, 45, to_date('18-09-2016', 'dd-mm-yyyy'), 598, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (829, 30, to_date('31-03-1985', 'dd-mm-yyyy'), 381, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (169, 25, to_date('16-02-1971', 'dd-mm-yyyy'), 184, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (716, 1, to_date('21-04-1973', 'dd-mm-yyyy'), 479, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (476, 309, to_date('19-03-2013', 'dd-mm-yyyy'), 179, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (868, 36, to_date('13-02-1988', 'dd-mm-yyyy'), 518, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (142, 75, to_date('03-11-2009', 'dd-mm-yyyy'), 253, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (597, 85, to_date('03-02-2003', 'dd-mm-yyyy'), 116, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (561, 325, to_date('24-03-2006', 'dd-mm-yyyy'), 999, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (944, 58, to_date('07-05-1998', 'dd-mm-yyyy'), 582, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (238, 408.75, to_date('13-08-1976', 'dd-mm-yyyy'), 156, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (684, 169, to_date('04-04-1974', 'dd-mm-yyyy'), 797, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (877, 239, to_date('24-08-2021', 'dd-mm-yyyy'), 468, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (242, 45, to_date('06-07-1993', 'dd-mm-yyyy'), 538, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (429, 209, to_date('07-05-1991', 'dd-mm-yyyy'), 917, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (889, 42, to_date('29-10-2011', 'dd-mm-yyyy'), 182, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (649, 175, to_date('08-01-1992', 'dd-mm-yyyy'), 324, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (834, 69, to_date('10-01-1998', 'dd-mm-yyyy'), 554, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (349, 93, to_date('10-06-1991', 'dd-mm-yyyy'), 595, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (668, 255, to_date('04-06-2004', 'dd-mm-yyyy'), 249, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (118, 66.5, to_date('17-12-2002', 'dd-mm-yyyy'), 222, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (644, 95, to_date('12-08-2021', 'dd-mm-yyyy'), 321, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (689, 289, to_date('09-03-1996', 'dd-mm-yyyy'), 825, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (853, 72, to_date('12-07-1998', 'dd-mm-yyyy'), 781, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (993, 35, to_date('18-12-1974', 'dd-mm-yyyy'), 547, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (348, 45, to_date('30-03-1995', 'dd-mm-yyyy'), 799, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (465, 3, to_date('19-07-1983', 'dd-mm-yyyy'), 851, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (234, 20, to_date('24-09-2022', 'dd-mm-yyyy'), 684, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (423, 45, to_date('20-02-1975', 'dd-mm-yyyy'), 874, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (377, 159, to_date('18-05-1990', 'dd-mm-yyyy'), 166, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (432, 269, to_date('28-03-1970', 'dd-mm-yyyy'), 872, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (688, 5, to_date('15-01-1982', 'dd-mm-yyyy'), 979, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (925, 57.5, to_date('03-09-1985', 'dd-mm-yyyy'), 119, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (439, 118, to_date('08-03-1975', 'dd-mm-yyyy'), 629, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (282, 179, to_date('11-06-1995', 'dd-mm-yyyy'), 776, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (616, 105, to_date('06-04-1982', 'dd-mm-yyyy'), 625, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (958, 135, to_date('29-07-2012', 'dd-mm-yyyy'), 543, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (456, 149, to_date('18-07-2003', 'dd-mm-yyyy'), 959, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (861, 355, to_date('14-07-2002', 'dd-mm-yyyy'), 238, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (534, 22, to_date('07-03-1997', 'dd-mm-yyyy'), 423, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (587, 6, to_date('30-06-1979', 'dd-mm-yyyy'), 598, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (288, 169, to_date('06-03-1991', 'dd-mm-yyyy'), 174, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (977, 88, to_date('10-03-1999', 'dd-mm-yyyy'), 335, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (335, 40, to_date('16-09-2020', 'dd-mm-yyyy'), 481, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (379, 69, to_date('29-07-1996', 'dd-mm-yyyy'), 729, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (849, 115, to_date('08-05-2008', 'dd-mm-yyyy'), 765, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (928, 385, to_date('21-10-2020', 'dd-mm-yyyy'), 715, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (479, 179, to_date('27-08-1985', 'dd-mm-yyyy'), 853, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (557, 289, to_date('02-07-1992', 'dd-mm-yyyy'), 573, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (914, 78, to_date('26-06-2001', 'dd-mm-yyyy'), 277, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (939, 459, to_date('05-05-2009', 'dd-mm-yyyy'), 892, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (639, 7, to_date('07-07-1983', 'dd-mm-yyyy'), 629, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (715, 130, to_date('01-01-1977', 'dd-mm-yyyy'), 936, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (168, 118, to_date('11-09-1993', 'dd-mm-yyyy'), 248, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (116, 8, to_date('16-08-1998', 'dd-mm-yyyy'), 133, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (873, 90, to_date('07-06-1989', 'dd-mm-yyyy'), 276, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (582, 92, to_date('23-07-1995', 'dd-mm-yyyy'), 321, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (562, 369, to_date('12-09-2013', 'dd-mm-yyyy'), 688, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (325, 215, to_date('03-12-2014', 'dd-mm-yyyy'), 844, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (224, 179, to_date('16-09-2019', 'dd-mm-yyyy'), 979, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (572, 69, to_date('21-07-2013', 'dd-mm-yyyy'), 184, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (515, 179, to_date('05-06-2005', 'dd-mm-yyyy'), 472, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (485, 265, to_date('17-01-2006', 'dd-mm-yyyy'), 866, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (848, 75, to_date('04-04-1999', 'dd-mm-yyyy'), 176, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (125, 35, to_date('06-03-1995', 'dd-mm-yyyy'), 184, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (969, 125, to_date('03-10-1977', 'dd-mm-yyyy'), 384, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (591, 189, to_date('04-12-2021', 'dd-mm-yyyy'), 499, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (475, 121, to_date('10-05-1977', 'dd-mm-yyyy'), 435, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (696, 399, to_date('25-04-1986', 'dd-mm-yyyy'), 867, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (528, 3, to_date('22-10-1999', 'dd-mm-yyyy'), 184, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (135, 35, to_date('16-12-1994', 'dd-mm-yyyy'), 422, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (546, 159, to_date('25-07-2011', 'dd-mm-yyyy'), 735, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (343, 399, to_date('04-07-1998', 'dd-mm-yyyy'), 115, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (673, 249, to_date('22-11-1999', 'dd-mm-yyyy'), 233, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (277, 39, to_date('10-04-1972', 'dd-mm-yyyy'), 611, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (685, 99, to_date('05-06-2009', 'dd-mm-yyyy'), 373, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (862, 125, to_date('14-05-1995', 'dd-mm-yyyy'), 373, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (319, 229, to_date('23-06-2014', 'dd-mm-yyyy'), 984, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (191, 25, to_date('20-06-1980', 'dd-mm-yyyy'), 819, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (287, 118, to_date('07-03-2012', 'dd-mm-yyyy'), 867, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (264, 70, to_date('18-08-1998', 'dd-mm-yyyy'), 257, null, null, null);
commit;
prompt 100 records committed...
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (967, 23, to_date('01-03-1990', 'dd-mm-yyyy'), 716, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (619, 235, to_date('20-08-2002', 'dd-mm-yyyy'), 731, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (648, 99, to_date('27-12-1999', 'dd-mm-yyyy'), 866, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (961, 9, to_date('11-09-1995', 'dd-mm-yyyy'), 483, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (545, 369, to_date('11-12-1983', 'dd-mm-yyyy'), 462, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (764, 4, to_date('24-05-1976', 'dd-mm-yyyy'), 128, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (472, 99, to_date('04-09-1979', 'dd-mm-yyyy'), 245, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (678, 189, to_date('29-06-2003', 'dd-mm-yyyy'), 856, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (435, 129, to_date('19-12-2003', 'dd-mm-yyyy'), 362, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (517, 24, to_date('07-08-1971', 'dd-mm-yyyy'), 198, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (163, 29, to_date('11-09-1973', 'dd-mm-yyyy'), 419, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (373, 95, to_date('19-02-2021', 'dd-mm-yyyy'), 611, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (192, 35, to_date('15-02-2019', 'dd-mm-yyyy'), 887, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (139, 89, to_date('25-08-2018', 'dd-mm-yyyy'), 872, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (469, 78, to_date('01-12-2019', 'dd-mm-yyyy'), 889, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (997, 289, to_date('16-07-1976', 'dd-mm-yyyy'), 989, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (212, 169, to_date('11-02-2019', 'dd-mm-yyyy'), 345, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (332, 135, to_date('09-03-2018', 'dd-mm-yyyy'), 324, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (774, 28, to_date('31-08-1972', 'dd-mm-yyyy'), 925, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (638, 130, to_date('01-06-1988', 'dd-mm-yyyy'), 651, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (746, 118, to_date('08-04-2012', 'dd-mm-yyyy'), 981, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (755, 135, to_date('20-01-2010', 'dd-mm-yyyy'), 966, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (381, 135, to_date('26-11-1990', 'dd-mm-yyyy'), 965, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (782, 55, to_date('28-05-2000', 'dd-mm-yyyy'), 196, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (899, 229, to_date('08-11-1990', 'dd-mm-yyyy'), 754, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (665, 209, to_date('16-08-1991', 'dd-mm-yyyy'), 924, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (487, 134, to_date('13-04-2008', 'dd-mm-yyyy'), 115, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (519, 129, to_date('25-07-2004', 'dd-mm-yyyy'), 799, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (239, 69, to_date('16-12-1996', 'dd-mm-yyyy'), 393, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (621, 8, to_date('25-03-1998', 'dd-mm-yyyy'), 119, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (577, 58, to_date('30-05-1996', 'dd-mm-yyyy'), 171, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (796, 155, to_date('22-04-1996', 'dd-mm-yyyy'), 698, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (544, 189, to_date('30-12-2021', 'dd-mm-yyyy'), 257, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (112, 179, to_date('16-11-1999', 'dd-mm-yyyy'), 981, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (952, 681.75, to_date('14-10-1988', 'dd-mm-yyyy'), 458, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (426, 5, to_date('27-06-2004', 'dd-mm-yyyy'), 435, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (542, 69, to_date('02-03-2007', 'dd-mm-yyyy'), 411, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (369, 35, to_date('10-09-2022', 'dd-mm-yyyy'), 827, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (682, 39, to_date('26-05-2014', 'dd-mm-yyyy'), 196, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (339, 179, to_date('13-02-2011', 'dd-mm-yyyy'), 466, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (457, 441.75, to_date('09-06-1986', 'dd-mm-yyyy'), 228, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (917, 446.25, to_date('12-02-2000', 'dd-mm-yyyy'), 631, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (655, 235, to_date('19-10-2016', 'dd-mm-yyyy'), 189, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (525, 89, to_date('15-08-1991', 'dd-mm-yyyy'), 797, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (398, 239, to_date('05-12-1971', 'dd-mm-yyyy'), 651, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (976, 359, to_date('10-10-1985', 'dd-mm-yyyy'), 646, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (529, 185, to_date('01-10-2014', 'dd-mm-yyyy'), 915, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (744, 125, to_date('23-05-1984', 'dd-mm-yyyy'), 535, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (933, 78, to_date('21-03-2013', 'dd-mm-yyyy'), 112, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (175, 118, to_date('21-12-1997', 'dd-mm-yyyy'), 211, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (438, 72, to_date('05-03-1997', 'dd-mm-yyyy'), 184, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (171, 219, to_date('22-06-1978', 'dd-mm-yyyy'), 991, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (266, 140, to_date('30-05-1993', 'dd-mm-yyyy'), 253, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (446, 434.25, to_date('16-12-1988', 'dd-mm-yyyy'), 294, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (721, 445, to_date('25-10-2017', 'dd-mm-yyyy'), 938, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (196, 156, to_date('27-07-1982', 'dd-mm-yyyy'), 469, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (297, 2, to_date('04-07-2003', 'dd-mm-yyyy'), 499, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (253, 1, to_date('04-05-1970', 'dd-mm-yyyy'), 666, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (571, 3, to_date('02-11-1971', 'dd-mm-yyyy'), 419, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (473, 24, to_date('11-08-1980', 'dd-mm-yyyy'), 119, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (316, 355, to_date('25-04-1973', 'dd-mm-yyyy'), 143, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (859, 375, to_date('08-08-1999', 'dd-mm-yyyy'), 765, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (188, 24, to_date('30-10-1986', 'dd-mm-yyyy'), 841, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (237, 411.75, to_date('30-09-2004', 'dd-mm-yyyy'), 171, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (711, 129, to_date('29-04-1977', 'dd-mm-yyyy'), 652, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (131, 255, to_date('07-03-2020', 'dd-mm-yyyy'), 118, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (336, 389.25, to_date('26-07-1972', 'dd-mm-yyyy'), 913, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (732, 140, to_date('16-05-2021', 'dd-mm-yyyy'), 324, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (272, 139, to_date('01-12-1994', 'dd-mm-yyyy'), 535, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (814, 69, to_date('01-12-2020', 'dd-mm-yyyy'), 769, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (539, 145, to_date('08-03-1972', 'dd-mm-yyyy'), 524, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (536, 656.25, to_date('09-10-2016', 'dd-mm-yyyy'), 189, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (299, 149, to_date('30-07-2022', 'dd-mm-yyyy'), 821, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (968, 43, to_date('01-11-2000', 'dd-mm-yyyy'), 878, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (382, 35, to_date('11-08-1995', 'dd-mm-yyyy'), 666, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (884, 115, to_date('29-10-2019', 'dd-mm-yyyy'), 782, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (793, 330, to_date('04-11-1994', 'dd-mm-yyyy'), 984, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (651, 229, to_date('27-10-1986', 'dd-mm-yyyy'), 695, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (399, 219, to_date('10-08-1996', 'dd-mm-yyyy'), 645, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (486, 289, to_date('17-07-2011', 'dd-mm-yyyy'), 651, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (568, 149, to_date('18-06-2013', 'dd-mm-yyyy'), 539, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (662, 95, to_date('20-05-2000', 'dd-mm-yyyy'), 468, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (752, 79, to_date('29-12-1974', 'dd-mm-yyyy'), 539, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (985, 159, to_date('12-01-2016', 'dd-mm-yyyy'), 959, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (549, 69, to_date('25-10-1993', 'dd-mm-yyyy'), 168, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (552, 49, to_date('12-07-2001', 'dd-mm-yyyy'), 144, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (132, 389.25, to_date('17-12-1989', 'dd-mm-yyyy'), 471, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (366, 41, to_date('19-12-1988', 'dd-mm-yyyy'), 834, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (595, 35, to_date('28-11-1984', 'dd-mm-yyyy'), 684, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (245, 265, to_date('18-12-2019', 'dd-mm-yyyy'), 912, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (748, 189, to_date('03-06-1995', 'dd-mm-yyyy'), 434, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (249, 235, to_date('22-06-2012', 'dd-mm-yyyy'), 716, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (463, 8, to_date('11-02-2021', 'dd-mm-yyyy'), 275, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (799, 105, to_date('01-04-1980', 'dd-mm-yyyy'), 414, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (857, 179, to_date('24-02-2010', 'dd-mm-yyyy'), 415, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (895, 265, to_date('11-10-2007', 'dd-mm-yyyy'), 892, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (121, 149, to_date('07-04-1973', 'dd-mm-yyyy'), 776, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (411, 118, to_date('15-07-1996', 'dd-mm-yyyy'), 816, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (396, 275, to_date('29-12-1989', 'dd-mm-yyyy'), 439, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (957, 99, to_date('19-09-2003', 'dd-mm-yyyy'), 999, null, null, null);
commit;
prompt 200 records committed...
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (283, 129, to_date('21-10-1983', 'dd-mm-yyyy'), 173, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (521, 31, to_date('16-10-1996', 'dd-mm-yyyy'), 196, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (285, 249, to_date('10-08-2020', 'dd-mm-yyyy'), 378, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (813, 129, to_date('18-05-2021', 'dd-mm-yyyy'), 598, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (326, 24, to_date('06-08-1998', 'dd-mm-yyyy'), 969, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (275, 132, to_date('04-04-1981', 'dd-mm-yyyy'), 882, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (315, 70, to_date('27-03-2007', 'dd-mm-yyyy'), 651, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (738, 295, to_date('12-10-1978', 'dd-mm-yyyy'), 472, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (312, 89, to_date('18-05-2019', 'dd-mm-yyyy'), 258, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (585, 238, to_date('10-05-2004', 'dd-mm-yyyy'), 841, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (375, 49, to_date('05-03-2018', 'dd-mm-yyyy'), 226, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (614, 39, to_date('27-08-1988', 'dd-mm-yyyy'), 781, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (256, 88, to_date('10-03-1983', 'dd-mm-yyyy'), 991, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (166, 23, to_date('13-06-1980', 'dd-mm-yyyy'), 639, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (414, 109, to_date('19-03-2019', 'dd-mm-yyyy'), 774, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (987, 369, to_date('02-03-1983', 'dd-mm-yyyy'), 879, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (322, 179, to_date('03-12-1976', 'dd-mm-yyyy'), 519, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (431, 118, to_date('27-10-1997', 'dd-mm-yyyy'), 253, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (514, 99, to_date('08-01-2015', 'dd-mm-yyyy'), 927, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (771, 4, to_date('21-10-1985', 'dd-mm-yyyy'), 851, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (533, 12, to_date('16-02-1973', 'dd-mm-yyyy'), 777, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (374, 72, to_date('07-11-2011', 'dd-mm-yyyy'), 491, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (145, 65, to_date('30-08-1993', 'dd-mm-yyyy'), 715, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (843, 69, to_date('06-09-2007', 'dd-mm-yyyy'), 217, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (781, 125, to_date('22-03-2004', 'dd-mm-yyyy'), 335, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (615, 59, to_date('23-08-2004', 'dd-mm-yyyy'), 231, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (815, 149, to_date('28-02-2013', 'dd-mm-yyyy'), 827, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (888, 20, to_date('23-02-1995', 'dd-mm-yyyy'), 827, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (918, 435, to_date('20-10-2022', 'dd-mm-yyyy'), 222, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (713, 267, to_date('19-10-1999', 'dd-mm-yyyy'), 667, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (995, 195, to_date('02-05-1978', 'dd-mm-yyyy'), 172, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (184, 259, to_date('07-08-1971', 'dd-mm-yyyy'), 149, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (291, 108, to_date('25-06-2006', 'dd-mm-yyyy'), 651, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (656, 83, to_date('07-01-2022', 'dd-mm-yyyy'), 486, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (627, 20, to_date('19-05-1970', 'dd-mm-yyyy'), 565, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (719, 99.5, to_date('20-02-2010', 'dd-mm-yyyy'), 519, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (444, 145, to_date('10-05-2010', 'dd-mm-yyyy'), 513, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (496, 75, to_date('12-12-1972', 'dd-mm-yyyy'), 165, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (642, 255, to_date('11-06-1977', 'dd-mm-yyyy'), 221, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (937, 39, to_date('07-08-1997', 'dd-mm-yyyy'), 224, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (825, 63, to_date('26-04-1994', 'dd-mm-yyyy'), 452, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (753, 269, to_date('27-04-1982', 'dd-mm-yyyy'), 682, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (878, 77, to_date('06-06-2002', 'dd-mm-yyyy'), 535, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (932, 189, to_date('23-07-1980', 'dd-mm-yyyy'), 171, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (787, 18, to_date('24-11-1999', 'dd-mm-yyyy'), 143, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (354, 118, to_date('28-02-1971', 'dd-mm-yyyy'), 639, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (761, 65, to_date('19-06-1980', 'dd-mm-yyyy'), 452, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (244, 75, to_date('29-07-1988', 'dd-mm-yyyy'), 761, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (187, 24, to_date('02-07-1974', 'dd-mm-yyyy'), 224, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (392, 138, to_date('26-02-1978', 'dd-mm-yyyy'), 936, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (223, 155, to_date('24-03-2015', 'dd-mm-yyyy'), 875, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (467, 14, to_date('03-06-1995', 'dd-mm-yyyy'), 969, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (448, 49, to_date('03-07-1992', 'dd-mm-yyyy'), 543, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (433, 325, to_date('25-04-1994', 'dd-mm-yyyy'), 185, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (636, 22, to_date('09-01-1996', 'dd-mm-yyyy'), 611, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (148, 24, to_date('20-05-1990', 'dd-mm-yyyy'), 629, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (845, 56, to_date('03-06-2003', 'dd-mm-yyyy'), 891, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (323, 138, to_date('26-06-2016', 'dd-mm-yyyy'), 455, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (931, 129, to_date('27-08-2019', 'dd-mm-yyyy'), 915, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (126, 209, to_date('14-02-2004', 'dd-mm-yyyy'), 434, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (846, 75, to_date('06-09-1984', 'dd-mm-yyyy'), 816, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (847, 85, to_date('15-09-2004', 'dd-mm-yyyy'), 176, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (953, 48, to_date('07-09-1986', 'dd-mm-yyyy'), 911, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (819, 135, to_date('01-12-2011', 'dd-mm-yyyy'), 179, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (216, 48, to_date('24-09-2019', 'dd-mm-yyyy'), 273, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (331, 209, to_date('05-12-1996', 'dd-mm-yyyy'), 445, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (395, 259, to_date('15-02-1970', 'dd-mm-yyyy'), 935, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (364, 389, to_date('14-11-1995', 'dd-mm-yyyy'), 491, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (386, 10, to_date('06-08-2014', 'dd-mm-yyyy'), 471, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (198, 95, to_date('22-07-1986', 'dd-mm-yyyy'), 841, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (762, 105, to_date('22-07-2002', 'dd-mm-yyyy'), 443, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (128, 35, to_date('06-10-2012', 'dd-mm-yyyy'), 891, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (751, 195, to_date('17-09-1996', 'dd-mm-yyyy'), 393, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (576, 239, to_date('05-06-1974', 'dd-mm-yyyy'), 377, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (974, 85, to_date('29-07-2005', 'dd-mm-yyyy'), 345, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (856, 35, to_date('15-04-1976', 'dd-mm-yyyy'), 885, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (695, 89, to_date('03-04-1983', 'dd-mm-yyyy'), 472, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (477, 369, to_date('27-03-1995', 'dd-mm-yyyy'), 622, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (992, 50, to_date('09-03-1971', 'dd-mm-yyyy'), 874, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (973, 134, to_date('23-12-1994', 'dd-mm-yyyy'), 891, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (455, 28, to_date('08-07-2002', 'dd-mm-yyyy'), 126, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (155, 175, to_date('29-12-2012', 'dd-mm-yyyy'), 185, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (767, 35, to_date('29-06-2006', 'dd-mm-yyyy'), 547, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (988, 119, to_date('16-02-2008', 'dd-mm-yyyy'), 523, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (832, 83, to_date('06-11-2007', 'dd-mm-yyyy'), 519, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (134, 24, to_date('30-12-1976', 'dd-mm-yyyy'), 887, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (273, 18, to_date('03-07-2009', 'dd-mm-yyyy'), 538, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (547, 119, to_date('24-04-2006', 'dd-mm-yyyy'), 731, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (176, 5, to_date('26-04-2021', 'dd-mm-yyyy'), 781, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (593, 24, to_date('22-06-2007', 'dd-mm-yyyy'), 171, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (886, 16, to_date('25-08-1971', 'dd-mm-yyyy'), 954, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (632, 88, to_date('07-02-1998', 'dd-mm-yyyy'), 173, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (357, 16, to_date('03-01-1986', 'dd-mm-yyyy'), 782, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (276, 289, to_date('27-09-1997', 'dd-mm-yyyy'), 217, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (558, 255, to_date('07-02-2010', 'dd-mm-yyyy'), 972, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (548, 269, to_date('14-02-2023', 'dd-mm-yyyy'), 723, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (898, 325, to_date('21-03-1997', 'dd-mm-yyyy'), 222, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (159, 45, to_date('15-06-2000', 'dd-mm-yyyy'), 723, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (777, 90, to_date('29-10-1985', 'dd-mm-yyyy'), 554, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (566, 78, to_date('31-03-2008', 'dd-mm-yyyy'), 826, null, null, null);
commit;
prompt 300 records committed...
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (241, 29, to_date('30-11-2008', 'dd-mm-yyyy'), 538, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (174, 19, to_date('16-01-1977', 'dd-mm-yyyy'), 275, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (321, 45, to_date('25-12-1999', 'dd-mm-yyyy'), 532, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (912, 45, to_date('13-10-2000', 'dd-mm-yyyy'), 466, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (594, 99, to_date('24-04-2008', 'dd-mm-yyyy'), 821, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (975, 45, to_date('09-05-1981', 'dd-mm-yyyy'), 355, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (919, 295, to_date('01-12-2017', 'dd-mm-yyyy'), 513, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (986, 149, to_date('02-10-2000', 'dd-mm-yyyy'), 856, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (596, 5, to_date('19-09-1991', 'dd-mm-yyyy'), 193, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (372, 179, to_date('26-11-2008', 'dd-mm-yyyy'), 576, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (437, 56, to_date('13-12-1970', 'dd-mm-yyyy'), 238, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (255, 189, to_date('26-01-1995', 'dd-mm-yyyy'), 765, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (333, 149, to_date('27-05-2005', 'dd-mm-yyyy'), 373, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (654, 49, to_date('22-09-2013', 'dd-mm-yyyy'), 665, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (436, 75, to_date('18-06-1999', 'dd-mm-yyyy'), 889, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (387, 209, to_date('15-07-2005', 'dd-mm-yyyy'), 936, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (791, 159, to_date('07-12-1986', 'dd-mm-yyyy'), 598, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (293, 94, to_date('29-01-1990', 'dd-mm-yyyy'), 482, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (482, 239, to_date('19-03-1982', 'dd-mm-yyyy'), 774, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (233, 169, to_date('15-04-1979', 'dd-mm-yyyy'), 685, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (617, 129, to_date('13-07-1986', 'dd-mm-yyyy'), 958, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (345, 185, to_date('30-12-1977', 'dd-mm-yyyy'), 445, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (419, 165, to_date('03-04-2003', 'dd-mm-yyyy'), 813, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (553, 18, to_date('18-04-1979', 'dd-mm-yyyy'), 419, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (252, 329, to_date('03-04-1980', 'dd-mm-yyyy'), 984, null, null, null);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1, null, null, 1, 1, 134600, 2);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2, null, null, 2, 3, 135500, 3);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3, null, null, 3, 3, 161600, 1);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4, null, null, 4, 1, 537, 1);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5, null, null, 5, 4, 538, 2);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6, null, null, 6, 3, 539, 1);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7, null, null, 7, 2, 652, 3);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8, null, null, 8, 4, 630, 1);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5268, 145.28, to_date('18-02-2009', 'dd-mm-yyyy'), 851, 161340186, 78, 578);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5744, 4168.32, to_date('17-09-1991', 'dd-mm-yyyy'), 364, 763274959, 55, 236);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9998, 1228.16, to_date('14-03-2007', 'dd-mm-yyyy'), 867, 614682224, 46, 939);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6655, 7303, to_date('22-09-1974', 'dd-mm-yyyy'), 136, 31091210, 20, 818);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5634, 4283, to_date('04-03-2009', 'dd-mm-yyyy'), 104, 930660682, 20, 803);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7946, 4301, to_date('16-02-1983', 'dd-mm-yyyy'), 25, 116519921, 11, 478);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6268, 3352.32, to_date('22-06-1985', 'dd-mm-yyyy'), 821, 907229938, 51, 970);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5787, 6288, to_date('29-07-1987', 'dd-mm-yyyy'), 511, 121720792, 46, 710);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1216, 2540, to_date('14-10-2010', 'dd-mm-yyyy'), 360, 768121171, 10, 609);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5964, 6199.68, to_date('25-07-2005', 'dd-mm-yyyy'), 66, 518455769, 60, 373);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5852, 8955, to_date('03-05-1978', 'dd-mm-yyyy'), 572, 680017394, 5, 541);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6256, 759, to_date('19-11-1992', 'dd-mm-yyyy'), 1002, 715926124, 8, 274);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1888, 6074.88, to_date('31-12-1989', 'dd-mm-yyyy'), 756, 731008287, 40, 62);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5394, 9242, to_date('01-03-2021', 'dd-mm-yyyy'), 966, 539698895, 8, 512);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9946, 731.52, to_date('11-04-2012', 'dd-mm-yyyy'), 900, 281122314, 78, 89);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3997, 5676.16, to_date('22-11-1972', 'dd-mm-yyyy'), 378, 856150630, 73, 460);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4558, 392.32, to_date('04-06-2012', 'dd-mm-yyyy'), 873, 44273804, 63, 582);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6933, 490.24, to_date('12-11-1974', 'dd-mm-yyyy'), 916, 826831393, 78, 508);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4982, 7979, to_date('21-04-1986', 'dd-mm-yyyy'), 456, 511071005, 5, 483);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1143, 5871.36, to_date('17-07-1973', 'dd-mm-yyyy'), 696, 527026974, 51, 895);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7224, 4338.56, to_date('16-05-1997', 'dd-mm-yyyy'), 429, 571817222, 70, 680);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3159, 6245.76, to_date('21-06-2020', 'dd-mm-yyyy'), 963, 912983375, 31, 263);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5877, 2229.12, to_date('10-08-1985', 'dd-mm-yyyy'), 133, 449034388, 58, 681);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8396, 9734, to_date('01-06-2018', 'dd-mm-yyyy'), 225, 372177077, 2, 803);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2944, 1161.6, to_date('31-01-1973', 'dd-mm-yyyy'), 140, 298980065, 48, 33);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5475, 1501, to_date('08-12-1988', 'dd-mm-yyyy'), 256, 340867365, 18, 45);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8722, 9898, to_date('16-01-1971', 'dd-mm-yyyy'), 1000, 91470557, 20, 699);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2491, 4046, to_date('28-08-2012', 'dd-mm-yyyy'), 446, 723519783, 4, 746);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5472, 688, to_date('07-11-1974', 'dd-mm-yyyy'), 201, 627386697, 17, 855);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7576, 5619.2, to_date('05-09-2021', 'dd-mm-yyyy'), 303, 98309224, 33, 375);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5316, 8678, to_date('01-05-2019', 'dd-mm-yyyy'), 784, 803291638, 7, 892);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7198, 5810.56, to_date('05-10-2010', 'dd-mm-yyyy'), 157, 943075044, 53, 160);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5971, 5319.68, to_date('01-03-2013', 'dd-mm-yyyy'), 290, 482431672, 67, 566);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4326, 3338.88, to_date('07-11-2018', 'dd-mm-yyyy'), 358, 366320050, 52, 727);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7934, 2113, to_date('07-07-1992', 'dd-mm-yyyy'), 929, 581588290, 12, 540);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1445, 8917, to_date('21-08-1993', 'dd-mm-yyyy'), 562, 77253526, 3, 721);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2495, 8977, to_date('15-03-2005', 'dd-mm-yyyy'), 176, 233158055, 14, 815);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6426, 2715.52, to_date('25-07-1985', 'dd-mm-yyyy'), 804, 579642373, 57, 39);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5364, 5579, to_date('15-10-1971', 'dd-mm-yyyy'), 206, 131734070, 17, 762);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1166, 2588.16, to_date('23-07-2009', 'dd-mm-yyyy'), 500, 823609408, 35, 499);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2473, 6416, to_date('11-01-1990', 'dd-mm-yyyy'), 834, 424693380, 8, 772);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2624, 3682, to_date('24-03-1994', 'dd-mm-yyyy'), 629, 799781783, 26, 54);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9642, 397, to_date('20-09-2013', 'dd-mm-yyyy'), 888, 756080763, 29, 719);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5439, 3995.52, to_date('04-08-1984', 'dd-mm-yyyy'), 659, 810234153, 46, 963);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1739, 2870.4, to_date('11-08-1986', 'dd-mm-yyyy'), 183, 323187692, 33, 757);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4788, 3820.8, to_date('23-08-1976', 'dd-mm-yyyy'), 984, 400568403, 48, 441);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2836, 4700.8, to_date('25-07-1976', 'dd-mm-yyyy'), 510, 55178026, 37, 154);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9433, 5838.72, to_date('06-10-2003', 'dd-mm-yyyy'), 947, 187469033, 47, 754);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8513, 5421.44, to_date('13-05-1975', 'dd-mm-yyyy'), 336, 273209229, 50, 179);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7727, 2553.6, to_date('20-10-1986', 'dd-mm-yyyy'), 762, 66181566, 80, 753);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2163, 488.32, to_date('07-03-2004', 'dd-mm-yyyy'), 137, 441350662, 61, 236);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9315, 2733.44, to_date('19-08-1994', 'dd-mm-yyyy'), 826, 532214174, 46, 307);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8266, 4494.08, to_date('12-03-2003', 'dd-mm-yyyy'), 458, 867675522, 63, 781);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3186, 1626.88, to_date('28-11-1972', 'dd-mm-yyyy'), 272, 101715462, 72, 188);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3633, 2121.6, to_date('11-11-2011', 'dd-mm-yyyy'), 265, 464966875, 41, 702);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4994, 3017.6, to_date('12-10-1984', 'dd-mm-yyyy'), 128, 930297684, 33, 193);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2754, 3475.84, to_date('05-03-2020', 'dd-mm-yyyy'), 951, 56230200, 58, 176);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5674, 861.44, to_date('01-01-1990', 'dd-mm-yyyy'), 226, 953041937, 52, 330);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9428, 2505.6, to_date('01-04-1997', 'dd-mm-yyyy'), 811, 178104467, 45, 725);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6612, 3347.84, to_date('23-03-2001', 'dd-mm-yyyy'), 327, 310471234, 38, 825);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5147, 5234.56, to_date('02-01-1996', 'dd-mm-yyyy'), 175, 658277181, 48, 756);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1718, 567.68, to_date('27-12-2003', 'dd-mm-yyyy'), 184, 960455047, 48, 726);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2584, 5605, to_date('02-02-1988', 'dd-mm-yyyy'), 14, 279621431, 3, 244);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5399, 3306.24, to_date('27-06-1974', 'dd-mm-yyyy'), 957, 490691219, 33, 24);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7194, 4074.88, to_date('11-05-1986', 'dd-mm-yyyy'), 70, 63987655, 48, 777);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4897, 2735.36, to_date('22-02-1997', 'dd-mm-yyyy'), 690, 533590499, 80, 403);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8492, 3603.84, to_date('31-01-2007', 'dd-mm-yyyy'), 221, 945508301, 31, 747);
commit;
prompt 400 records committed...
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8594, 8469, to_date('03-06-1999', 'dd-mm-yyyy'), 907, 6524983, 20, 606);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4688, 6146.56, to_date('14-05-1974', 'dd-mm-yyyy'), 478, 417546705, 43, 919);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8864, 4729.6, to_date('30-03-1984', 'dd-mm-yyyy'), 805, 286514273, 55, 193);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6922, 2967.68, to_date('12-04-1973', 'dd-mm-yyyy'), 644, 387529252, 75, 159);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8485, 954.24, to_date('04-03-1998', 'dd-mm-yyyy'), 716, 678964789, 59, 633);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2745, 708.48, to_date('02-08-1989', 'dd-mm-yyyy'), 869, 724319312, 31, 514);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9169, 4827.52, to_date('27-08-1994', 'dd-mm-yyyy'), 751, 789652691, 44, 967);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5734, 4023.68, to_date('23-06-1996', 'dd-mm-yyyy'), 696, 232266479, 72, 914);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6874, 5555.84, to_date('14-10-1978', 'dd-mm-yyyy'), 776, 659426974, 48, 560);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6714, 2929, to_date('26-03-1980', 'dd-mm-yyyy'), 430, 36361829, 9, 189);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2346, 1252.48, to_date('06-10-1978', 'dd-mm-yyyy'), 185, 770984290, 51, 648);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5512, 1783.68, to_date('01-10-1990', 'dd-mm-yyyy'), 771, 612971597, 66, 220);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3427, 5684.48, to_date('12-01-1990', 'dd-mm-yyyy'), 103, 287108743, 66, 660);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9965, 6785, to_date('28-10-1995', 'dd-mm-yyyy'), 138, 950429996, 21, 314);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1975, 6896, to_date('27-02-1998', 'dd-mm-yyyy'), 976, 129678204, 8, 574);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3858, 3869.44, to_date('02-04-1972', 'dd-mm-yyyy'), 123, 573858031, 51, 203);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2369, 1455.36, to_date('07-02-1986', 'dd-mm-yyyy'), 670, 758924822, 78, 774);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2687, 336.64, to_date('17-12-1985', 'dd-mm-yyyy'), 928, 418627914, 76, 263);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2783, 4740.48, to_date('09-03-2005', 'dd-mm-yyyy'), 580, 762256863, 35, 137);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8333, 4442, to_date('06-03-1973', 'dd-mm-yyyy'), 825, 786867702, 17, 796);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7388, 5075.84, to_date('25-01-1975', 'dd-mm-yyyy'), 315, 611968415, 52, 370);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4586, 145.28, to_date('12-05-2016', 'dd-mm-yyyy'), 920, 871331335, 40, 497);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4679, 4923.52, to_date('10-02-2013', 'dd-mm-yyyy'), 983, 201338548, 49, 763);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9749, 3350.4, to_date('26-01-1999', 'dd-mm-yyyy'), 775, 581000909, 42, 482);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4245, 1277.44, to_date('09-05-1970', 'dd-mm-yyyy'), 182, 18385360, 74, 924);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2431, 5056.64, to_date('17-03-1994', 'dd-mm-yyyy'), 700, 652840806, 49, 445);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2135, 2110, to_date('23-11-2015', 'dd-mm-yyyy'), 153, 66715367, 28, 169);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9356, 2588, to_date('03-03-1976', 'dd-mm-yyyy'), 750, 284087185, 27, 848);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8924, 4163.2, to_date('04-05-2012', 'dd-mm-yyyy'), 747, 892794810, 71, 590);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7954, 4837, to_date('16-12-1970', 'dd-mm-yyyy'), 685, 769353567, 8, 213);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1326, 4344.32, to_date('21-01-1978', 'dd-mm-yyyy'), 131, 329088863, 35, 987);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3371, 782.72, to_date('28-02-2009', 'dd-mm-yyyy'), 548, 877086013, 41, 927);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7697, 8805, to_date('07-01-1993', 'dd-mm-yyyy'), 415, 812278664, 23, 215);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3428, 568, to_date('24-11-2007', 'dd-mm-yyyy'), 515, 949554196, 19, 91);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6562, 1873, to_date('03-07-2001', 'dd-mm-yyyy'), 622, 386229933, 9, 634);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3549, 3644.8, to_date('05-01-1988', 'dd-mm-yyyy'), 183, 960917403, 66, 378);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7415, 1623, to_date('30-12-1977', 'dd-mm-yyyy'), 654, 748717527, 10, 641);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8584, 4775.68, to_date('29-03-1978', 'dd-mm-yyyy'), 531, 17657341, 44, 888);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3868, 2819.84, to_date('28-11-1974', 'dd-mm-yyyy'), 196, 951629718, 41, 557);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2963, 5295, to_date('05-12-1985', 'dd-mm-yyyy'), 126, 35722332, 27, 469);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3926, 2398.08, to_date('14-02-2011', 'dd-mm-yyyy'), 711, 613762083, 34, 323);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4318, 929, to_date('29-02-2000', 'dd-mm-yyyy'), 329, 578902535, 25, 51);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4777, 1808, to_date('13-07-1987', 'dd-mm-yyyy'), 995, 755708132, 12, 746);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7849, 2931.84, to_date('31-05-2006', 'dd-mm-yyyy'), 640, 92641928, 34, 865);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6294, 1330, to_date('14-03-1989', 'dd-mm-yyyy'), 873, 616239893, 2, 277);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4282, 3374.72, to_date('22-03-2005', 'dd-mm-yyyy'), 345, 17701087, 38, 648);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2973, 3848.96, to_date('29-12-2011', 'dd-mm-yyyy'), 64, 59446697, 41, 580);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5911, 9527, to_date('22-04-1987', 'dd-mm-yyyy'), 160, 518170969, 15, 236);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2228, 9832, to_date('05-09-1980', 'dd-mm-yyyy'), 311, 432086488, 30, 321);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3449, 5253.12, to_date('17-08-1977', 'dd-mm-yyyy'), 219, 980556791, 56, 985);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5996, 5950.72, to_date('28-06-2008', 'dd-mm-yyyy'), 720, 310930126, 51, 690);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6995, 4204.16, to_date('10-07-1973', 'dd-mm-yyyy'), 478, 186756331, 42, 632);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4358, 2638, to_date('21-06-1997', 'dd-mm-yyyy'), 21, 136786145, 23, 772);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2888, 4200, to_date('14-09-2020', 'dd-mm-yyyy'), 432, 632227763, 7, 893);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6171, 3906, to_date('15-08-2013', 'dd-mm-yyyy'), 52, 250146967, 3, 626);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2796, 7, to_date('27-11-2017', 'dd-mm-yyyy'), 40, 838827628, 17, 366);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6392, 421, to_date('02-09-2003', 'dd-mm-yyyy'), 882, 74199348, 7, 27);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9441, 3837.44, to_date('15-02-1974', 'dd-mm-yyyy'), 270, 541437855, 38, 592);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3853, 3058, to_date('22-01-1986', 'dd-mm-yyyy'), 487, 844025267, 3, 138);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8817, 5119.36, to_date('25-04-2009', 'dd-mm-yyyy'), 633, 645524132, 79, 116);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9375, 348.16, to_date('23-05-2012', 'dd-mm-yyyy'), 464, 76480614, 80, 1000);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9757, 1263.36, to_date('03-05-2007', 'dd-mm-yyyy'), 254, 363192144, 69, 539);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2819, 8531, to_date('23-07-2000', 'dd-mm-yyyy'), 58, 461966851, 28, 932);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7138, 6287.36, to_date('22-08-1997', 'dd-mm-yyyy'), 626, 745016678, 52, 800);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7288, 1747.84, to_date('04-08-2015', 'dd-mm-yyyy'), 916, 695526546, 67, 696);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9214, 3809, to_date('23-02-2016', 'dd-mm-yyyy'), 583, 941252604, 6, 89);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3776, 2028.8, to_date('17-06-1992', 'dd-mm-yyyy'), 544, 101730944, 49, 486);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5139, 474.88, to_date('18-07-2013', 'dd-mm-yyyy'), 610, 655359859, 58, 565);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9614, 7499, to_date('12-08-2021', 'dd-mm-yyyy'), 506, 662916714, 26, 11);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9259, 110.08, to_date('03-02-1977', 'dd-mm-yyyy'), 201, 524309274, 33, 223);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2868, 2466.56, to_date('02-05-1981', 'dd-mm-yyyy'), 414, 310215078, 41, 146);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2249, 3282, to_date('07-01-2018', 'dd-mm-yyyy'), 963, 410044438, 7, 575);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5862, 3983.36, to_date('12-11-1984', 'dd-mm-yyyy'), 257, 586491576, 70, 878);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8227, 1100.8, to_date('03-06-1976', 'dd-mm-yyyy'), 599, 836416407, 33, 931);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2159, 7798, to_date('26-05-1972', 'dd-mm-yyyy'), 605, 40889669, 10, 542);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8896, 5169.92, to_date('22-03-1978', 'dd-mm-yyyy'), 951, 56049798, 44, 452);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2755, 163.84, to_date('26-12-1995', 'dd-mm-yyyy'), 760, 964046430, 53, 590);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4188, 1434.88, to_date('21-10-1973', 'dd-mm-yyyy'), 763, 481362634, 62, 311);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5897, 213.12, to_date('20-09-1986', 'dd-mm-yyyy'), 894, 464381809, 64, 548);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7249, 428.8, to_date('30-12-2007', 'dd-mm-yyyy'), 541, 9527436, 61, 478);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1613, 5443, to_date('30-04-1983', 'dd-mm-yyyy'), 63, 659404318, 2, 515);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1843, 5272.32, to_date('26-01-2023', 'dd-mm-yyyy'), 629, 747422727, 41, 298);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7144, 1913, to_date('31-10-1996', 'dd-mm-yyyy'), 390, 453151672, 9, 11);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2689, 8633, to_date('21-06-2006', 'dd-mm-yyyy'), 984, 291629731, 26, 868);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3452, 4698.24, to_date('04-06-1977', 'dd-mm-yyyy'), 299, 196617657, 49, 453);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3829, 4081.92, to_date('19-09-2008', 'dd-mm-yyyy'), 505, 754782282, 45, 659);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1811, 5798.4, to_date('01-04-1975', 'dd-mm-yyyy'), 599, 223084619, 37, 690);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2736, 4094.72, to_date('14-09-1982', 'dd-mm-yyyy'), 815, 185064290, 67, 353);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6429, 2748.8, to_date('01-06-1994', 'dd-mm-yyyy'), 743, 886636212, 51, 352);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5628, 5159.04, to_date('17-12-1981', 'dd-mm-yyyy'), 264, 749651525, 71, 808);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7139, 5728, to_date('21-03-1991', 'dd-mm-yyyy'), 595, 105580700, 25, 813);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7947, 5717.12, to_date('02-01-1977', 'dd-mm-yyyy'), 165, 134160207, 37, 401);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7812, 6663, to_date('01-06-2022', 'dd-mm-yyyy'), 275, 145029393, 12, 114);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9563, 5561.6, to_date('11-07-1996', 'dd-mm-yyyy'), 454, 17101188, 59, 289);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4939, 1634.56, to_date('06-04-1975', 'dd-mm-yyyy'), 782, 623260985, 70, 521);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9775, 3943.68, to_date('19-06-1978', 'dd-mm-yyyy'), 184, 729057944, 33, 245);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1766, 5166.08, to_date('09-01-1980', 'dd-mm-yyyy'), 584, 975988598, 74, 482);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5193, 3192.32, to_date('18-01-2011', 'dd-mm-yyyy'), 527, 455759393, 61, 115);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1364, 926.08, to_date('25-12-2001', 'dd-mm-yyyy'), 352, 863032516, 80, 186);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (1483, 5836, to_date('11-08-2001', 'dd-mm-yyyy'), 214, 594404663, 28, 105);
commit;
prompt 500 records committed...
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7664, 206.08, to_date('23-06-2007', 'dd-mm-yyyy'), 432, 251754314, 71, 19);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4449, 3630.08, to_date('19-02-2014', 'dd-mm-yyyy'), 556, 122805242, 59, 382);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8179, 3710.72, to_date('04-05-1975', 'dd-mm-yyyy'), 855, 161616454, 50, 553);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5562, 4499.2, to_date('18-07-2019', 'dd-mm-yyyy'), 529, 90484981, 77, 723);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3416, 3921, to_date('15-01-2000', 'dd-mm-yyyy'), 941, 304284196, 9, 918);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3514, 2766, to_date('03-12-2005', 'dd-mm-yyyy'), 509, 591308948, 23, 208);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8288, 4046.72, to_date('23-03-1998', 'dd-mm-yyyy'), 758, 103572753, 55, 683);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8994, 2728.32, to_date('05-08-2020', 'dd-mm-yyyy'), 648, 826898248, 38, 187);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7686, 4224, to_date('11-12-1985', 'dd-mm-yyyy'), 2, 829639895, 20, 585);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3885, 2263.04, to_date('14-04-1996', 'dd-mm-yyyy'), 63, 120229601, 64, 988);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3372, 1617.28, to_date('03-05-1984', 'dd-mm-yyyy'), 136, 831888029, 63, 724);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3728, 2246, to_date('27-10-1974', 'dd-mm-yyyy'), 189, 988782350, 25, 112);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (6213, 2061.44, to_date('19-08-2013', 'dd-mm-yyyy'), 717, 104770411, 57, 82);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (9475, 3044, to_date('05-10-2019', 'dd-mm-yyyy'), 36, 636759455, 25, 941);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4372, 9799, to_date('19-09-2007', 'dd-mm-yyyy'), 385, 671026624, 16, 488);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (5689, 801.92, to_date('14-06-1977', 'dd-mm-yyyy'), 294, 475428490, 64, 84);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2477, 6936, to_date('19-07-1975', 'dd-mm-yyyy'), 883, 516747533, 22, 352);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (7135, 4693.76, to_date('01-12-2006', 'dd-mm-yyyy'), 322, 531325864, 40, 998);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8461, 1354.24, to_date('18-05-2001', 'dd-mm-yyyy'), 18, 62433751, 50, 836);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8898, 1992.96, to_date('25-09-1981', 'dd-mm-yyyy'), 635, 851453608, 68, 450);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (2684, 8453, to_date('14-06-2009', 'dd-mm-yyyy'), 584, 404653361, 20, 254);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8487, 4635.52, to_date('26-11-1992', 'dd-mm-yyyy'), 403, 264950851, 56, 976);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (3477, 252.16, to_date('16-01-1980', 'dd-mm-yyyy'), 511, 812590728, 31, 878);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (4749, 5018.88, to_date('30-09-1975', 'dd-mm-yyyy'), 953, 110530432, 72, 405);
insert into ORDERS (ordrid, order_price, order_date, cid, description, time_completed, eid)
values (8916, 2828, to_date('09-03-2022', 'dd-mm-yyyy'), 458, 789190540, 1, 80);
commit;
prompt 525 records loaded
prompt Loading BILL...
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (552, 0, 168, 643, 0, 616494861, 116, 750);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (973, 0, 171, 1331, 0, 7466427830, 878, 297);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (521, 0, 32, 291, 0, 6788643596, 444, 247);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (199, 0, 45, 718, 0, 1173229227, 2, 152);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (719, 0, 128, 1451, 0, 6165106995, 616, 515);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (652, 0, 47, 1888, 0, 4336374808, 755, 443);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (161, 0, 96, 358, 0, 5124194673, 912, 40);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (823, 0, 77, 1090, 0, 2564924129, 184, 413);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (166, 0, 47, 1863, 0, 8893480060, 381, 430);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (641, 0, 33, 1680, 0, 9295098457, 166, 138);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (864, 0, 18, 597, 0, 8998771267, 322, 375);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (271, 0, 5, 1353, 0, 8204979089, 239, 548);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (272, 0, 198, 951, 0, 1818466953, 682, 76);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (473, 0, 63, 1443, 0, 5869003302, 472, 173);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (155, 0, 58, 1286, 0, 7015810096, 174, 136);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (467, 0, 121, 389, 0, 6152225193, 121, 245);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (963, 0, 91, 1385, 0, 3993093426, 961, 193);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (938, 0, 73, 1360, 0, 228208684, 435, 420);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (266, 1975, 162, 905, 1758, 1190771917, 793, 377);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (762, 1984, 83, 103, 2075, 3006747765, 886, 557);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (684, 1981, 81, 1416, 1557, 2510478315, 667, 585);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (149, 2012, 23, 672, 1907, 2886601236, 845, 201);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (519, 2021, 98, 428, 1407, 3396536268, 387, 49);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (632, 2021, 125, 1036, 834, 5735462855, 746, 55);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (753, 2017, 121, 663, 2132, 2925655171, 171, 278);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (847, 1979, 35, 1196, 1678, 4462739644, 399, 431);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (135, 2019, 36, 1915, 184, 2077206642, 614, 322);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (633, 1970, 115, 35, 2072, 6381016861, 456, 505);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (214, 1996, 10, 1683, 1218, 6392080273, 597, 639);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (628, 2006, 137, 1529, 1924, 6192691751, 668, 592);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (379, 1996, 155, 1859, 2109, 1894543834, 389, 376);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (486, 2005, 43, 94, 519, 2520240626, 614, 126);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (674, 1988, 197, 143, 1222, 6851520650, 761, 357);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (273, 1992, 28, 1412, 1284, 272941729, 561, 803);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (631, 1975, 81, 1798, 1461, 4061983557, 175, 197);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (349, 1988, 93, 1914, 657, 589383223, 234, 109);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (455, 1993, 28, 1519, 907, 7730672593, 511, 667);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (655, 1999, 152, 1081, 2281, 9700060489, 323, 286);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (382, 2012, 140, 1751, 1684, 8846820578, 272, 242);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (469, 1996, 64, 499, 2306, 2500077474, 191, 579);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (589, 2001, 117, 848, 558, 783578425, 168, 478);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (346, 1999, 179, 677, 324, 2717440503, 814, 232);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (145, 1973, 118, 726, 1864, 227547160, 668, 4);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (522, 1985, 196, 1445, 1001, 1615574777, 469, 615);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (646, 2004, 68, 1343, 1583, 3686921088, 212, 587);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (295, 2014, 189, 848, 1321, 2342619801, 456, 505);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (836, 2005, 130, 192, 816, 9414912809, 291, 470);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (581, 2013, 14, 145, 616, 9498630109, 859, 796);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (941, 2010, 169, 1882, 1010, 5453856732, 576, 584);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (437, 1989, 156, 695, 227, 9757227367, 542, 331);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (993, 2015, 3, 803, 902, 5133160713, 277, 568);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (887, 2021, 47, 480, 66, 7208047543, 898, 37);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (591, 2018, 179, 687, 2171, 2296549468, 175, 395);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (311, 1980, 158, 1649, 1763, 8400207524, 992, 442);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (734, 1970, 181, 412, 522, 2270103120, 983, 333);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (112, 2004, 48, 343, 1112, 6769824090, 597, 789);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (143, 1997, 198, 798, 604, 5496015904, 914, 41);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (499, 1999, 58, 1600, 11, 3546960990, 423, 239);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (869, 1991, 20, 496, 1009, 4075405994, 688, 456);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (395, 1994, 193, 421, 267, 6753446838, 751, 736);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (535, 2007, 103, 9, 1710, 2406796858, 264, 534);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (682, 2003, 73, 708, 2285, 4041570887, 386, 100);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (322, 1991, 14, 1349, 1584, 212272120, 321, 424);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (859, 1998, 163, 515, 905, 1265546319, 463, 658);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (793, 2019, 75, 1318, 1728, 1279861280, 825, 240);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (627, 1997, 107, 1659, 2359, 3244070265, 599, 784);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (644, 2022, 52, 722, 341, 3384576954, 791, 545);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (445, 2010, 185, 520, 291, 2224347480, 456, 318);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (333, 2007, 127, 472, 1424, 5150854093, 627, 371);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (619, 1994, 164, 631, 2194, 4564989183, 912, 165);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (348, 1977, 53, 1990, 1553, 6709809715, 799, 146);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (223, 2019, 186, 1694, 2083, 6159863696, 777, 743);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (394, 1990, 72, 719, 785, 9895284015, 977, 111);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (137, 1976, 131, 1315, 1504, 7160695678, 617, 664);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (874, 1978, 27, 1827, 897, 7581323851, 591, 531);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (451, 1998, 195, 893, 283, 3428528085, 961, 289);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (999, 2020, 127, 615, 1980, 8633078279, 744, 285);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (866, 1994, 188, 1324, 2346, 9180298484, 469, 455);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (826, 1992, 95, 916, 235, 1324391081, 141, 43);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (352, 2010, 60, 231, 2252, 4339024158, 245, 192);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (422, 1991, 189, 1403, 1198, 7433549029, 997, 297);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (466, 1975, 129, 1534, 191, 2882195859, 366, 117);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (692, 2006, 106, 1748, 682, 5085860763, 414, 725);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (179, 1985, 26, 533, 249, 1023584478, 285, 80);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (649, 1981, 153, 616, 539, 7996456025, 528, 148);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (576, 2015, 26, 1984, 1736, 6653249439, 436, 58);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (312, 1981, 86, 1469, 1723, 9499378634, 396, 691);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (366, 2004, 25, 1844, 1089, 7374558153, 332, 671);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (435, 1996, 43, 126, 1489, 9492069982, 662, 397);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (196, 2005, 108, 1466, 762, 3345472587, 987, 42);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (771, 1976, 190, 240, 71, 4933766117, 813, 712);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (746, 1985, 195, 1384, 651, 267309284, 185, 164);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (763, 1970, 167, 1487, 1096, 5494020076, 455, 257);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (549, 1980, 44, 442, 2059, 9555086839, 496, 311);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (989, 1986, 110, 211, 1440, 7351303791, 814, 755);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (778, 1987, 199, 1850, 652, 7191997696, 553, 776);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (744, 1988, 6, 1480, 2282, 5575067946, 539, 31);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (898, 1985, 127, 621, 2339, 6904752893, 561, 319);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (735, 1974, 188, 1519, 440, 9905439293, 776, 407);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (413, 2013, 24, 1926, 603, 6413326264, 888, 253);
commit;
prompt 100 records committed...
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (872, 2012, 180, 1854, 74, 5281249778, 321, 152);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (948, 2014, 38, 1025, 1064, 9957637744, 655, 274);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (215, 1994, 72, 1994, 1029, 1057974195, 312, 719);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (293, 1975, 183, 1223, 1590, 4094324146, 877, 164);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (431, 2001, 17, 1434, 2131, 4146374724, 272, 424);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (811, 2007, 67, 1224, 930, 3490023447, 648, 328);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (846, 1993, 38, 54, 162, 2521627355, 132, 469);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (687, 1987, 59, 1783, 18, 8099128630, 799, 86);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (323, 2008, 200, 1565, 1960, 9775448747, 917, 485);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (364, 1990, 80, 894, 2349, 8917804036, 321, 14);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (638, 1984, 77, 458, 274, 2766294639, 961, 398);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (623, 2012, 156, 1261, 1912, 1431329540, 944, 552);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (418, 2005, 83, 1071, 690, 9429634595, 848, 648);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (877, 1996, 115, 461, 2266, 5545999815, 673, 801);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (258, 1990, 172, 1189, 2255, 4138691835, 632, 780);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (449, 1996, 88, 160, 159, 917767274, 547, 640);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (689, 1999, 123, 40, 637, 2055104576, 946, 47);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (622, 1978, 50, 1260, 1106, 6468835172, 912, 25);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (722, 1996, 1, 956, 971, 6260549223, 655, 605);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (397, 1987, 149, 1849, 746, 331489371, 131, 757);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (819, 1988, 106, 1412, 1468, 5994100451, 549, 256);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (964, 1985, 26, 125, 1254, 7766667486, 252, 796);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (968, 2001, 153, 1042, 204, 145038908, 553, 685);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (291, 1978, 76, 997, 2202, 5405679785, 426, 747);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (324, 2017, 142, 1486, 2357, 8351304996, 272, 437);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (934, 2015, 129, 1022, 1295, 3931431422, 715, 370);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (433, 1972, 113, 595, 944, 7311921779, 566, 780);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (533, 1985, 14, 1775, 794, 8155318408, 457, 220);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (542, 1986, 112, 79, 1443, 995828011, 253, 567);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (625, 2019, 59, 1380, 1239, 8757465374, 888, 46);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (392, 1980, 69, 1256, 1480, 142688175, 249, 585);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (921, 2019, 183, 1539, 832, 1856434317, 496, 778);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (163, 1979, 198, 1029, 196, 5830450430, 521, 420);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (546, 1980, 6, 1186, 383, 6041840195, 315, 293);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (383, 2016, 168, 1273, 159, 3344404221, 282, 61);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (261, 1985, 164, 1925, 2221, 416838847, 145, 783);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (485, 1990, 114, 328, 650, 715274003, 533, 366);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (247, 2019, 148, 1813, 1524, 9960914031, 638, 368);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (653, 1986, 171, 672, 752, 6034004010, 593, 276);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (246, 1991, 145, 609, 496, 388417181, 276, 61);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (294, 2023, 103, 409, 132, 4444123705, 832, 16);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (393, 1988, 91, 624, 2277, 5744698800, 175, 527);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (457, 1995, 11, 1938, 204, 4251407946, 419, 636);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (298, 2015, 99, 1299, 1613, 1471741896, 185, 572);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (683, 1991, 191, 1173, 1188, 2113236544, 546, 399);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (944, 1982, 77, 644, 919, 1958611528, 868, 122);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (438, 1971, 7, 1466, 2213, 4954232075, 331, 598);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (688, 1972, 192, 1881, 2230, 898209702, 465, 578);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (983, 2017, 17, 872, 1860, 2186930310, 354, 529);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (876, 1976, 9, 828, 402, 4518968647, 517, 67);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (172, 2022, 192, 327, 1121, 6805813836, 519, 197);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (537, 1975, 139, 1076, 1567, 5358971522, 787, 291);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (173, 1970, 185, 1948, 885, 9550734004, 175, 564);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (832, 1970, 94, 1938, 2051, 7854993309, 148, 643);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (531, 2012, 146, 1999, 1412, 7784668055, 931, 206);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (439, 2013, 22, 1896, 285, 6302597269, 946, 274);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (249, 1980, 126, 779, 2176, 3237350265, 511, 109);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (257, 1996, 100, 33, 1257, 6327565573, 974, 358);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (827, 1973, 198, 565, 2222, 3657218587, 174, 648);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (648, 2005, 72, 1599, 1255, 2744031216, 712, 57);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (512, 2010, 154, 1553, 1615, 4259419782, 457, 549);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (115, 2003, 34, 700, 1459, 2305509546, 171, 775);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (695, 1976, 12, 1721, 660, 1678988910, 898, 656);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (489, 1994, 11, 430, 2107, 8923280773, 545, 400);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (882, 1998, 0, 372, 1317, 8009022530, 467, 188);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (545, 2011, 41, 636, 1384, 4863269149, 357, 780);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (759, 1993, 67, 396, 1358, 1521835677, 169, 793);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (427, 1994, 111, 1386, 2307, 1472270418, 738, 291);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (474, 2000, 64, 482, 499, 9343854043, 456, 325);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (538, 1984, 180, 698, 313, 8431073339, 321, 6);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (712, 2021, 50, 251, 2079, 2140310734, 682, 99);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (583, 2000, 110, 485, 1615, 2468107557, 886, 72);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (843, 1983, 189, 1048, 1123, 3186418731, 751, 505);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (774, 1979, 23, 230, 2163, 3088129261, 547, 185);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (953, 2019, 196, 1549, 1475, 7683820669, 349, 551);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (497, 1990, 101, 120, 780, 7975317003, 477, 747);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (191, 1994, 90, 1937, 2083, 5936603773, 695, 510);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (421, 2022, 78, 233, 2139, 5735252000, 719, 148);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (239, 1996, 72, 1964, 297, 4969832975, 536, 243);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (875, 1988, 112, 1315, 986, 3749635062, 627, 511);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (855, 2008, 172, 1930, 1907, 6163694355, 315, 456);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (255, 2016, 121, 1620, 1552, 4695042549, 511, 364);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (977, 2013, 12, 898, 2127, 8070114031, 242, 424);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (254, 1978, 192, 1573, 633, 9799623379, 287, 549);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (647, 2017, 116, 1384, 189, 2517911781, 639, 397);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (733, 1982, 53, 383, 742, 8733394966, 529, 776);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (551, 2006, 84, 703, 1419, 8042754938, 357, 528);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (714, 2006, 180, 452, 469, 88853755, 975, 169);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (781, 2017, 199, 1482, 1449, 6343884294, 753, 578);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (125, 1973, 179, 1532, 934, 479793404, 379, 455);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (761, 1993, 180, 909, 1954, 1755127665, 273, 736);
insert into BILL (bill_id, bill_date, tip, total, bill_time, descriptions, ordrid, shop_id)
values (236, 1971, 92, 205, 88, 9871133284, 126, 66);
commit;
prompt 192 records loaded
prompt Loading INVTYPE...
insert into INVTYPE (tid, tname)
values (111, 'Table');
insert into INVTYPE (tid, tname)
values (222, 'Chair');
insert into INVTYPE (tid, tname)
values (333, 'Sofa');
insert into INVTYPE (tid, tname)
values (963, 'bed');
insert into INVTYPE (tid, tname)
values (226, 'shelf');
insert into INVTYPE (tid, tname)
values (639, 'closet');
insert into INVTYPE (tid, tname)
values (859, 'couch');
insert into INVTYPE (tid, tname)
values (862, 'chair');
insert into INVTYPE (tid, tname)
values (278, 'bed');
insert into INVTYPE (tid, tname)
values (656, 'table');
insert into INVTYPE (tid, tname)
values (693, 'closet');
insert into INVTYPE (tid, tname)
values (566, 'drawers');
insert into INVTYPE (tid, tname)
values (777, 'couch');
insert into INVTYPE (tid, tname)
values (875, 'chair');
insert into INVTYPE (tid, tname)
values (696, 'closet');
insert into INVTYPE (tid, tname)
values (723, 'chair');
insert into INVTYPE (tid, tname)
values (943, 'desk');
insert into INVTYPE (tid, tname)
values (265, 'drawers');
insert into INVTYPE (tid, tname)
values (211, 'desk');
insert into INVTYPE (tid, tname)
values (589, 'couch');
insert into INVTYPE (tid, tname)
values (456, 'shelf');
insert into INVTYPE (tid, tname)
values (466, 'shelf');
insert into INVTYPE (tid, tname)
values (268, 'chair');
insert into INVTYPE (tid, tname)
values (978, 'couch');
insert into INVTYPE (tid, tname)
values (669, 'desk');
insert into INVTYPE (tid, tname)
values (634, 'closet');
insert into INVTYPE (tid, tname)
values (233, 'bed');
insert into INVTYPE (tid, tname)
values (273, 'shelf');
insert into INVTYPE (tid, tname)
values (865, 'desk');
insert into INVTYPE (tid, tname)
values (692, 'desk');
insert into INVTYPE (tid, tname)
values (917, 'closet');
commit;
prompt 31 records loaded
prompt Loading SUPPLIERS...
insert into SUPPLIERS (sid, sname)
values (766, ' IKEA');
insert into SUPPLIERS (sid, sname)
values (778, ' wexlers');
insert into SUPPLIERS (sid, sname)
values (228, ' z-boy');
insert into SUPPLIERS (sid, sname)
values (151, 'McFadden');
insert into SUPPLIERS (sid, sname)
values (333, 'Griggs');
insert into SUPPLIERS (sid, sname)
values (571, 'Russo');
insert into SUPPLIERS (sid, sname)
values (566, 'Voight');
insert into SUPPLIERS (sid, sname)
values (224, 'Almond');
insert into SUPPLIERS (sid, sname)
values (446, 'Gleeson');
insert into SUPPLIERS (sid, sname)
values (752, 'Fraser');
insert into SUPPLIERS (sid, sname)
values (339, 'Hauer');
insert into SUPPLIERS (sid, sname)
values (677, 'Weir');
insert into SUPPLIERS (sid, sname)
values (829, 'Thomas');
insert into SUPPLIERS (sid, sname)
values (525, 'Sevigny');
insert into SUPPLIERS (sid, sname)
values (851, 'Belles');
insert into SUPPLIERS (sid, sname)
values (329, 'Stormare');
insert into SUPPLIERS (sid, sname)
values (374, 'Noseworthy');
insert into SUPPLIERS (sid, sname)
values (268, 'Carrack');
insert into SUPPLIERS (sid, sname)
values (352, 'Carrington');
insert into SUPPLIERS (sid, sname)
values (138, 'Barry');
insert into SUPPLIERS (sid, sname)
values (554, 'Baldwin');
insert into SUPPLIERS (sid, sname)
values (472, 'Nakai');
insert into SUPPLIERS (sid, sname)
values (712, 'Hopkins');
insert into SUPPLIERS (sid, sname)
values (738, 'Tobolowsky');
insert into SUPPLIERS (sid, sname)
values (177, 'Taha');
insert into SUPPLIERS (sid, sname)
values (369, 'Sedgwick');
insert into SUPPLIERS (sid, sname)
values (568, 'Wilkinson');
insert into SUPPLIERS (sid, sname)
values (623, 'Luongo');
insert into SUPPLIERS (sid, sname)
values (776, 'Scaggs');
insert into SUPPLIERS (sid, sname)
values (585, 'Blanchett');
insert into SUPPLIERS (sid, sname)
values (644, 'Burrows');
insert into SUPPLIERS (sid, sname)
values (754, 'Bruce');
insert into SUPPLIERS (sid, sname)
values (868, 'Lauper');
insert into SUPPLIERS (sid, sname)
values (238, 'Depp');
insert into SUPPLIERS (sid, sname)
values (134, 'Buscemi');
insert into SUPPLIERS (sid, sname)
values (421, 'LaSalle');
insert into SUPPLIERS (sid, sname)
values (337, 'LaPaglia');
insert into SUPPLIERS (sid, sname)
values (648, 'Dafoe');
insert into SUPPLIERS (sid, sname)
values (338, 'Tinsley');
insert into SUPPLIERS (sid, sname)
values (616, 'Boyle');
insert into SUPPLIERS (sid, sname)
values (377, 'Sarandon');
insert into SUPPLIERS (sid, sname)
values (617, 'Polito');
insert into SUPPLIERS (sid, sname)
values (859, 'Redgrave');
insert into SUPPLIERS (sid, sname)
values (726, 'Garza');
insert into SUPPLIERS (sid, sname)
values (523, 'McCready');
insert into SUPPLIERS (sid, sname)
values (775, 'Tripplehorn');
insert into SUPPLIERS (sid, sname)
values (541, 'Tucci');
insert into SUPPLIERS (sid, sname)
values (445, 'MacDowell');
insert into SUPPLIERS (sid, sname)
values (126, 'Tobolowsky');
insert into SUPPLIERS (sid, sname)
values (817, 'Clayton');
insert into SUPPLIERS (sid, sname)
values (978, 'Heron');
insert into SUPPLIERS (sid, sname)
values (697, 'Llewelyn');
insert into SUPPLIERS (sid, sname)
values (334, 'Green');
insert into SUPPLIERS (sid, sname)
values (594, 'Mould');
insert into SUPPLIERS (sid, sname)
values (847, 'McCready');
insert into SUPPLIERS (sid, sname)
values (539, 'Eat World');
insert into SUPPLIERS (sid, sname)
values (647, 'Ruffalo');
insert into SUPPLIERS (sid, sname)
values (788, 'Bedelia');
insert into SUPPLIERS (sid, sname)
values (976, 'Vannelli');
insert into SUPPLIERS (sid, sname)
values (663, 'Nightingale');
insert into SUPPLIERS (sid, sname)
values (866, 'Wakeling');
insert into SUPPLIERS (sid, sname)
values (989, 'Harary');
insert into SUPPLIERS (sid, sname)
values (361, 'Burns');
insert into SUPPLIERS (sid, sname)
values (522, 'Davidtz');
insert into SUPPLIERS (sid, sname)
values (896, 'Katt');
insert into SUPPLIERS (sid, sname)
values (782, 'Levert');
insert into SUPPLIERS (sid, sname)
values (248, 'Giannini');
insert into SUPPLIERS (sid, sname)
values (798, 'Farrell');
insert into SUPPLIERS (sid, sname)
values (392, 'Rickman');
insert into SUPPLIERS (sid, sname)
values (796, 'Evett');
insert into SUPPLIERS (sid, sname)
values (557, 'Yorn');
insert into SUPPLIERS (sid, sname)
values (885, 'Shawn');
insert into SUPPLIERS (sid, sname)
values (448, 'Arnold');
insert into SUPPLIERS (sid, sname)
values (974, 'Garber');
insert into SUPPLIERS (sid, sname)
values (814, 'Condition');
insert into SUPPLIERS (sid, sname)
values (654, 'Weisz');
insert into SUPPLIERS (sid, sname)
values (956, 'Sirtis');
insert into SUPPLIERS (sid, sname)
values (649, 'Vincent');
insert into SUPPLIERS (sid, sname)
values (945, 'Barry');
insert into SUPPLIERS (sid, sname)
values (291, 'Wayans');
insert into SUPPLIERS (sid, sname)
values (483, 'Dalley');
insert into SUPPLIERS (sid, sname)
values (745, 'Hiatt');
insert into SUPPLIERS (sid, sname)
values (774, 'Cube');
insert into SUPPLIERS (sid, sname)
values (615, 'Botti');
insert into SUPPLIERS (sid, sname)
values (979, 'Atkinson');
insert into SUPPLIERS (sid, sname)
values (762, 'Child');
insert into SUPPLIERS (sid, sname)
values (834, 'Beatty');
insert into SUPPLIERS (sid, sname)
values (359, 'Gano');
insert into SUPPLIERS (sid, sname)
values (731, 'Kadison');
insert into SUPPLIERS (sid, sname)
values (545, 'Heslov');
insert into SUPPLIERS (sid, sname)
values (765, 'Brosnan');
insert into SUPPLIERS (sid, sname)
values (936, 'Hyde');
insert into SUPPLIERS (sid, sname)
values (467, 'Diddley');
insert into SUPPLIERS (sid, sname)
values (351, 'Payton');
insert into SUPPLIERS (sid, sname)
values (415, 'Lavigne');
insert into SUPPLIERS (sid, sname)
values (969, 'Eder');
insert into SUPPLIERS (sid, sname)
values (269, 'Thurman');
insert into SUPPLIERS (sid, sname)
values (396, 'Ferrell');
insert into SUPPLIERS (sid, sname)
values (491, 'Henstridge');
insert into SUPPLIERS (sid, sname)
values (463, 'Shand');
commit;
prompt 100 records committed...
insert into SUPPLIERS (sid, sname)
values (111, 'Mantegna');
insert into SUPPLIERS (sid, sname)
values (918, 'Harmon');
insert into SUPPLIERS (sid, sname)
values (927, 'Olyphant');
insert into SUPPLIERS (sid, sname)
values (424, 'Playboys');
insert into SUPPLIERS (sid, sname)
values (197, 'Hiatt');
insert into SUPPLIERS (sid, sname)
values (195, 'Dooley');
insert into SUPPLIERS (sid, sname)
values (145, 'Torino');
insert into SUPPLIERS (sid, sname)
values (526, 'Winans');
insert into SUPPLIERS (sid, sname)
values (241, 'Niven');
insert into SUPPLIERS (sid, sname)
values (887, 'Heald');
insert into SUPPLIERS (sid, sname)
values (273, 'Tomlin');
insert into SUPPLIERS (sid, sname)
values (271, 'Thewlis');
insert into SUPPLIERS (sid, sname)
values (725, 'Larter');
insert into SUPPLIERS (sid, sname)
values (758, 'Hatosy');
insert into SUPPLIERS (sid, sname)
values (575, 'Shearer');
insert into SUPPLIERS (sid, sname)
values (869, 'Dutton');
insert into SUPPLIERS (sid, sname)
values (764, 'Donelly');
insert into SUPPLIERS (sid, sname)
values (234, 'Pantoliano');
insert into SUPPLIERS (sid, sname)
values (794, 'Rhymes');
insert into SUPPLIERS (sid, sname)
values (683, 'Butler');
insert into SUPPLIERS (sid, sname)
values (152, 'Wen');
insert into SUPPLIERS (sid, sname)
values (734, 'Farris');
insert into SUPPLIERS (sid, sname)
values (569, 'Coburn');
insert into SUPPLIERS (sid, sname)
values (963, 'McDonald');
insert into SUPPLIERS (sid, sname)
values (559, 'Levine');
insert into SUPPLIERS (sid, sname)
values (112, 'Levine');
insert into SUPPLIERS (sid, sname)
values (325, 'Swayze');
insert into SUPPLIERS (sid, sname)
values (986, 'Martinez');
insert into SUPPLIERS (sid, sname)
values (289, 'Lithgow');
insert into SUPPLIERS (sid, sname)
values (148, 'Crosby');
insert into SUPPLIERS (sid, sname)
values (524, 'Hauer');
insert into SUPPLIERS (sid, sname)
values (696, 'Caine');
insert into SUPPLIERS (sid, sname)
values (485, 'Dafoe');
insert into SUPPLIERS (sid, sname)
values (176, 'Pearce');
insert into SUPPLIERS (sid, sname)
values (499, 'Saucedo');
insert into SUPPLIERS (sid, sname)
values (433, 'Crystal');
insert into SUPPLIERS (sid, sname)
values (399, 'Schock');
insert into SUPPLIERS (sid, sname)
values (223, 'Breslin');
insert into SUPPLIERS (sid, sname)
values (288, 'Horizon');
insert into SUPPLIERS (sid, sname)
values (831, 'Margulies');
insert into SUPPLIERS (sid, sname)
values (819, 'Newman');
insert into SUPPLIERS (sid, sname)
values (889, 'Clooney');
insert into SUPPLIERS (sid, sname)
values (657, 'Roundtree');
insert into SUPPLIERS (sid, sname)
values (582, 'Armstrong');
insert into SUPPLIERS (sid, sname)
values (717, 'Brown');
insert into SUPPLIERS (sid, sname)
values (436, 'Tankard');
insert into SUPPLIERS (sid, sname)
values (997, 'Mac');
insert into SUPPLIERS (sid, sname)
values (514, 'Winslet');
insert into SUPPLIERS (sid, sname)
values (393, 'McAnally');
insert into SUPPLIERS (sid, sname)
values (474, 'DeLuise');
insert into SUPPLIERS (sid, sname)
values (166, 'Christie');
insert into SUPPLIERS (sid, sname)
values (561, 'Rourke');
insert into SUPPLIERS (sid, sname)
values (456, 'Loveless');
insert into SUPPLIERS (sid, sname)
values (631, 'Madsen');
insert into SUPPLIERS (sid, sname)
values (171, 'Prinze');
insert into SUPPLIERS (sid, sname)
values (779, 'Kweller');
insert into SUPPLIERS (sid, sname)
values (199, 'Patton');
insert into SUPPLIERS (sid, sname)
values (192, 'Simpson');
insert into SUPPLIERS (sid, sname)
values (242, 'Chestnut');
insert into SUPPLIERS (sid, sname)
values (846, 'Madsen');
insert into SUPPLIERS (sid, sname)
values (733, 'DeVito');
insert into SUPPLIERS (sid, sname)
values (597, 'Hynde');
insert into SUPPLIERS (sid, sname)
values (358, 'Rio');
insert into SUPPLIERS (sid, sname)
values (281, 'Cromwell');
insert into SUPPLIERS (sid, sname)
values (219, 'Crosby');
insert into SUPPLIERS (sid, sname)
values (576, 'Costello');
insert into SUPPLIERS (sid, sname)
values (751, 'Hopper');
insert into SUPPLIERS (sid, sname)
values (985, 'Isaacs');
insert into SUPPLIERS (sid, sname)
values (673, 'White');
insert into SUPPLIERS (sid, sname)
values (959, 'Simpson');
insert into SUPPLIERS (sid, sname)
values (952, 'Postlethwaite');
insert into SUPPLIERS (sid, sname)
values (954, 'Reubens');
insert into SUPPLIERS (sid, sname)
values (296, 'Abraham');
insert into SUPPLIERS (sid, sname)
values (441, 'Wills');
insert into SUPPLIERS (sid, sname)
values (226, 'Tanon');
insert into SUPPLIERS (sid, sname)
values (462, 'Roberts');
insert into SUPPLIERS (sid, sname)
values (799, 'Stamp');
insert into SUPPLIERS (sid, sname)
values (286, 'Crowe');
insert into SUPPLIERS (sid, sname)
values (122, 'Atkins');
insert into SUPPLIERS (sid, sname)
values (331, 'Campbell');
insert into SUPPLIERS (sid, sname)
values (842, 'Loring');
insert into SUPPLIERS (sid, sname)
values (729, 'Hiatt');
insert into SUPPLIERS (sid, sname)
values (761, 'Carlisle');
insert into SUPPLIERS (sid, sname)
values (993, 'Crowe');
insert into SUPPLIERS (sid, sname)
values (818, 'Belle');
insert into SUPPLIERS (sid, sname)
values (857, 'Short');
insert into SUPPLIERS (sid, sname)
values (259, 'Ammons');
insert into SUPPLIERS (sid, sname)
values (578, 'Gilley');
insert into SUPPLIERS (sid, sname)
values (931, 'Wahlberg');
insert into SUPPLIERS (sid, sname)
values (252, 'Belle');
insert into SUPPLIERS (sid, sname)
values (878, 'Buckingham');
insert into SUPPLIERS (sid, sname)
values (849, 'Benet');
insert into SUPPLIERS (sid, sname)
values (832, 'Day');
insert into SUPPLIERS (sid, sname)
values (719, 'Deschanel');
insert into SUPPLIERS (sid, sname)
values (244, 'Holiday');
insert into SUPPLIERS (sid, sname)
values (416, 'Askew');
insert into SUPPLIERS (sid, sname)
values (639, 'Cronin');
insert into SUPPLIERS (sid, sname)
values (567, 'Dalton');
insert into SUPPLIERS (sid, sname)
values (875, 'Hewitt');
insert into SUPPLIERS (sid, sname)
values (785, 'Gershon');
commit;
prompt 200 records committed...
insert into SUPPLIERS (sid, sname)
values (894, 'MacNeil');
insert into SUPPLIERS (sid, sname)
values (838, 'Clarkson');
insert into SUPPLIERS (sid, sname)
values (965, 'Brando');
insert into SUPPLIERS (sid, sname)
values (821, 'Polito');
insert into SUPPLIERS (sid, sname)
values (886, 'Wiest');
insert into SUPPLIERS (sid, sname)
values (465, 'Salonga');
insert into SUPPLIERS (sid, sname)
values (816, 'Galecki');
insert into SUPPLIERS (sid, sname)
values (863, 'Martin');
insert into SUPPLIERS (sid, sname)
values (613, 'Bryson');
insert into SUPPLIERS (sid, sname)
values (964, 'Cervine');
insert into SUPPLIERS (sid, sname)
values (527, 'Dunn');
insert into SUPPLIERS (sid, sname)
values (671, 'Matheson');
insert into SUPPLIERS (sid, sname)
values (394, 'Vega');
insert into SUPPLIERS (sid, sname)
values (321, 'Nugent');
insert into SUPPLIERS (sid, sname)
values (916, 'Charles');
insert into SUPPLIERS (sid, sname)
values (634, 'Fishburne');
insert into SUPPLIERS (sid, sname)
values (637, 'Nicholson');
insert into SUPPLIERS (sid, sname)
values (858, 'Woodward');
insert into SUPPLIERS (sid, sname)
values (664, 'LaSalle');
insert into SUPPLIERS (sid, sname)
values (116, 'O''Sullivan');
insert into SUPPLIERS (sid, sname)
values (565, 'Neeson');
insert into SUPPLIERS (sid, sname)
values (854, 'Nielsen');
insert into SUPPLIERS (sid, sname)
values (128, 'Dale');
insert into SUPPLIERS (sid, sname)
values (855, 'Guzman');
insert into SUPPLIERS (sid, sname)
values (943, 'Holy');
insert into SUPPLIERS (sid, sname)
values (233, 'LaMond');
insert into SUPPLIERS (sid, sname)
values (173, 'McBride');
insert into SUPPLIERS (sid, sname)
values (534, 'Blaine');
insert into SUPPLIERS (sid, sname)
values (459, 'Hall');
insert into SUPPLIERS (sid, sname)
values (473, 'Baker');
insert into SUPPLIERS (sid, sname)
values (232, 'Stormare');
insert into SUPPLIERS (sid, sname)
values (447, 'Dayne');
insert into SUPPLIERS (sid, sname)
values (676, 'Fiennes');
insert into SUPPLIERS (sid, sname)
values (595, 'Travolta');
insert into SUPPLIERS (sid, sname)
values (879, 'Schock');
insert into SUPPLIERS (sid, sname)
values (419, 'Pitt');
insert into SUPPLIERS (sid, sname)
values (742, 'Christie');
insert into SUPPLIERS (sid, sname)
values (146, 'Sweeney');
insert into SUPPLIERS (sid, sname)
values (426, 'Neil');
insert into SUPPLIERS (sid, sname)
values (466, 'Conley');
insert into SUPPLIERS (sid, sname)
values (235, 'Macy');
insert into SUPPLIERS (sid, sname)
values (645, 'Kotto');
insert into SUPPLIERS (sid, sname)
values (924, 'McAnally');
insert into SUPPLIERS (sid, sname)
values (666, 'Carrington');
insert into SUPPLIERS (sid, sname)
values (429, 'Bachman');
insert into SUPPLIERS (sid, sname)
values (586, 'Voight');
insert into SUPPLIERS (sid, sname)
values (373, 'Paymer');
insert into SUPPLIERS (sid, sname)
values (655, 'Parish');
insert into SUPPLIERS (sid, sname)
values (874, 'Holiday');
insert into SUPPLIERS (sid, sname)
values (987, 'Nugent');
insert into SUPPLIERS (sid, sname)
values (257, 'England');
insert into SUPPLIERS (sid, sname)
values (181, 'Heslov');
insert into SUPPLIERS (sid, sname)
values (492, 'Harnes');
insert into SUPPLIERS (sid, sname)
values (437, 'Harry');
insert into SUPPLIERS (sid, sname)
values (464, 'McKean');
insert into SUPPLIERS (sid, sname)
values (661, 'Englund');
insert into SUPPLIERS (sid, sname)
values (375, 'Browne');
insert into SUPPLIERS (sid, sname)
values (398, 'Watley');
insert into SUPPLIERS (sid, sname)
values (412, 'De Almeida');
insert into SUPPLIERS (sid, sname)
values (511, 'Redgrave');
insert into SUPPLIERS (sid, sname)
values (826, 'Flanery');
insert into SUPPLIERS (sid, sname)
values (432, 'Chambers');
insert into SUPPLIERS (sid, sname)
values (355, 'English');
insert into SUPPLIERS (sid, sname)
values (949, 'Dalton');
insert into SUPPLIERS (sid, sname)
values (797, 'Luongo');
insert into SUPPLIERS (sid, sname)
values (243, 'Bello');
insert into SUPPLIERS (sid, sname)
values (162, 'Foster');
insert into SUPPLIERS (sid, sname)
values (482, 'Balk');
insert into SUPPLIERS (sid, sname)
values (357, 'Adler');
insert into SUPPLIERS (sid, sname)
values (169, 'Phoenix');
insert into SUPPLIERS (sid, sname)
values (871, 'McLean');
insert into SUPPLIERS (sid, sname)
values (227, 'Scheider');
insert into SUPPLIERS (sid, sname)
values (628, 'Unger');
insert into SUPPLIERS (sid, sname)
values (411, 'Imperioli');
insert into SUPPLIERS (sid, sname)
values (837, 'Buffalo');
insert into SUPPLIERS (sid, sname)
values (914, 'Nicks');
insert into SUPPLIERS (sid, sname)
values (633, 'Snipes');
insert into SUPPLIERS (sid, sname)
values (715, 'Mathis');
insert into SUPPLIERS (sid, sname)
values (656, 'Pantoliano');
insert into SUPPLIERS (sid, sname)
values (299, 'Bacharach');
insert into SUPPLIERS (sid, sname)
values (225, 'Kinnear');
insert into SUPPLIERS (sid, sname)
values (515, 'Prowse');
insert into SUPPLIERS (sid, sname)
values (521, 'Holiday');
insert into SUPPLIERS (sid, sname)
values (315, 'Seagal');
insert into SUPPLIERS (sid, sname)
values (298, 'Suchet');
insert into SUPPLIERS (sid, sname)
values (589, 'Sizemore');
insert into SUPPLIERS (sid, sname)
values (727, 'Shandling');
insert into SUPPLIERS (sid, sname)
values (453, 'LaSalle');
insert into SUPPLIERS (sid, sname)
values (562, 'Prowse');
insert into SUPPLIERS (sid, sname)
values (256, 'McCann');
insert into SUPPLIERS (sid, sname)
values (626, 'Gore');
insert into SUPPLIERS (sid, sname)
values (741, 'Carnes');
insert into SUPPLIERS (sid, sname)
values (326, 'Young');
insert into SUPPLIERS (sid, sname)
values (366, 'Westerberg');
insert into SUPPLIERS (sid, sname)
values (793, 'Affleck');
insert into SUPPLIERS (sid, sname)
values (781, 'Leigh');
commit;
prompt 296 records loaded
prompt Loading INVENTORY...
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (121, 'office chair', 'black', 500, 111, 766, 776, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (884, 'Conquest System', 'pink', 250, 222, 223, 585, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (627, 'Capital Bank', 'orange', 267, 333, 731, 349, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (799, 'May Department ', 'yellow', 289, 222, 269, 857, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (682, 'Mission West Pr', 'purple', 199, 222, 869, 546, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (914, 'Schering-Plough', 'yellow', 19, 111, 794, 698, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (475, 'Advanced Intern', 'orange', 20, 333, 358, 642, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (131, 'Conquest System', 'blue', 135, 111, 896, 843, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (238, 'Capital Automot', 'yellow', 8, 222, 817, 316, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (617, 'Strategic Manag', 'green', 73, 111, 859, 732, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (175, 'Pfizer', 'yellow', 129, 333, 725, 131, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (873, 'Extreme Pizza', 'green', 24, 222, 814, 477, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (673, 'WestNet Learnin', 'purple', 175, 111, 683, 191, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (325, 'Employer Servic', 'yellow', 39.5, 111, 985, 878, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (928, 'Third Millenniu', 'yellow', 85, 222, 393, 617, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (386, 'SEI/Aaron''s', 'pink', 319, 333, 569, 252, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (639, 'MQ Software', 'pink', 135, 111, 525, 438, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (649, 'Network Display', 'black', 23, 333, 578, 849, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (752, 'Maverick Techno', 'yellow', 29, 333, 752, 476, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (651, 'Cascade Bancorp', 'brown', 105, 333, 766, 142, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (917, 'Federated Depar', 'pink', 1, 111, 545, 487, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (953, 'Microsoft Corp.', 'red', 115, 333, 645, 767, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (848, '3t Systems', 'orange', 139, 222, 515, 856, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (463, 'Heartland Payme', 'red', 175, 333, 754, 364, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (937, 'Wyeth', 'black', 59, 333, 576, 336, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (432, 'Arrow Financial', 'brown', 279, 333, 515, 562, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (561, 'AT&T Corp.', 'grey', 65, 333, 441, 469, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (312, 'GDA Technologie', 'grey', 179, 111, 847, 187, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (667, 'FFLC Bancorp', 'grey', 895, 333, 441, 815, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (614, 'Capella Educati', 'grey', 69, 222, 566, 469, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (553, 'Blue Angel Tech', 'black', 229, 111, 774, 993, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (515, 'Joseph Sheairs ', 'pink', 199, 111, 878, 912, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (435, 'CARBO Ceramics', 'yellow', 159, 222, 868, 558, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (753, 'Blue Ocean Soft', 'green', 109, 333, 244, 392, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (825, 'MQ Software', 'purple', 48, 222, 569, 335, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (456, 'Signal Perfecti', 'purple', 65, 222, 683, 975, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (684, 'Timberlane Wood', 'pink', 189, 111, 585, 898, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (487, 'Cold Stone Crea', 'brown', 175, 333, 491, 224, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (715, 'USA Environment', 'orange', 159, 222, 473, 134, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (819, 'Midwest Media G', 'grey', 245, 333, 741, 662, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (721, 'TALX', 'green', 239, 333, 223, 856, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (517, 'U.S Physical Th', 'yellow', 149, 111, 325, 316, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (642, 'Fiber Network S', 'pink', 68, 333, 874, 438, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (888, 'AC Technologies', 'brown', 249, 333, 145, 291, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (685, '3t Systems', 'pink', 175, 222, 575, 843, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (969, 'Imports By Four', 'green', 159, 222, 411, 366, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (291, 'First Place Fin', 'grey', 45, 222, 969, 169, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (169, 'Bristol-Myers S', 'blue', 125, 333, 128, 928, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (656, 'EagleOne', 'red', 399, 222, 729, 713, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (919, 'Staff Force', 'brown', 149, 333, 256, 853, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (977, 'Toyota Motor Co', 'purple', 205, 333, 472, 552, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (587, 'Gillette Co.', 'pink', 48, 111, 373, 475, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (533, 'Signal Perfecti', 'orange', 135, 111, 993, 862, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (221, 'WCI', 'pink', 28, 333, 339, 287, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (191, 'U.S. Energy Ser', 'orange', 105, 222, 432, 118, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (946, 'Virbac', 'blue', 209, 333, 473, 283, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (665, 'ScripNet', 'black', 241, 222, 545, 562, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (249, 'E Group', 'yellow', 175, 222, 696, 656, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (414, 'EPIQ Systems', 'pink', 159, 222, 987, 132, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (748, 'Tilia', 'yellow', 39, 333, 798, 882, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (377, 'Sea Fox Boat', 'yellow', 135, 222, 952, 373, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (771, 'Gold Crest Dist', 'brown', 20, 111, 511, 752, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (542, 'Heritage Microf', 'grey', 121, 333, 298, 619, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (297, 'Staff Force', 'black', 10, 111, 128, 155, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (282, 'York Enterprise', 'grey', 49, 222, 522, 372, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (695, 'TechRX', 'pink', 549, 111, 797, 861, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (732, 'Aventis', 'black', 14, 222, 195, 685, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (546, 'U.S. dairy prod', 'blue', 129, 222, 128, 118, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (237, 'Vesta', 'pink', 145, 111, 855, 519, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (514, 'Swiss Watch Int', 'grey', 9, 222, 875, 249, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (636, 'Greenwich Techn', 'blue', 63, 111, 631, 112, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (859, 'Market First', 'red', 35, 111, 244, 283, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (135, 'Execuscribe', 'blue', 57.5, 111, 924, 253, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (288, 'Advanced Neurom', 'black', 245, 333, 357, 234, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (323, 'Multimedia Live', 'brown', 56, 222, 637, 587, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (452, 'ConAgra', 'red', 189, 111, 291, 414, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (239, 'Consultants'' Ch', 'brown', 75, 111, 766, 562, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (326, 'Joseph Sheairs ', 'pink', 215, 222, 875, 528, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (594, 'Infinity Softwa', 'purple', 41, 111, 842, 325, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (112, 'GCI', 'orange', 95, 111, 338, 771, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (931, 'PSC Info Group', 'grey', 179, 111, 562, 419, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (198, 'ACS Internation', 'brown', 69, 222, 817, 399, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (961, 'Staff Force', 'brown', 75, 111, 228, 514, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (776, 'Cura Group', 'green', 38, 333, 814, 952, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (845, 'Adea Solutions', 'purple', 1, 111, 851, 781, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (918, 'Lloyd Group', 'yellow', 15, 333, 152, 689, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (174, 'Bowman Consulti', 'red', 129, 111, 377, 767, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (992, 'I.T.S.', 'green', 889, 111, 719, 614, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (898, 'Bedford Bancsha', 'yellow', 59, 111, 567, 128, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (995, 'Nestle', 'blue', 219, 111, 576, 325, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (862, 'Operational Tec', 'pink', 109, 333, 677, 191, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (168, 'Gentra Systems', 'yellow', 45, 222, 441, 249, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (944, 'American Health', 'blue', 6, 333, 754, 234, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (264, 'American Health', 'red', 23, 111, 879, 439, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (469, 'Atlantic.Net', 'black', 35, 222, 997, 373, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (813, 'Travizon', 'purple', 249, 222, 219, 968, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (558, 'Kitba Consultin', 'black', 175, 222, 697, 997, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (787, 'Sprint Corp.', 'pink', 329, 333, 858, 771, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (933, 'Flake-Wilkerson', 'red', 12, 333, 373, 429, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (912, 'Canterbury Park', 'red', 69, 111, 842, 282, null);
commit;
prompt 100 records committed...
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (426, 'J.C. Malone Ass', 'brown', 75, 333, 986, 132, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (253, 'Scott Pipitone ', 'pink', 85, 222, 666, 366, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (595, 'North Coast Ene', 'green', 69, 111, 412, 712, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (392, 'KeyMark', 'brown', 179, 111, 628, 322, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (319, 'Pioneer Mortgag', 'purple', 105, 333, 927, 139, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (925, 'Navigator Syste', 'black', 117, 333, 462, 293, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (952, 'Calence', 'red', 16, 222, 628, 825, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (644, 'Amerisource Fun', 'yellow', 289, 111, 673, 196, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (568, 'School Technolo', 'green', 235, 222, 963, 862, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (662, 'Synhrgy HR Tech', 'black', 329, 222, 677, 487, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (398, 'SmartDraw.com', 'purple', 43, 333, 889, 849, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (224, 'TALX', 'grey', 45, 222, 565, 732, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (899, 'Woronoco Bancor', 'orange', 29, 333, 199, 185, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (655, 'Texas Residenti', 'black', 75, 111, 416, 319, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (744, 'glass', 'black', 238, 634, 575, 594, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (689, 'glass', 'black', 85, 865, 733, 392, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (983, 'abc', 'brown', 24, 723, 252, 139, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (958, 'glass', 'brown', 56, 466, 232, 131, null);
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (1, 'Iced Coffee', null, 6, null, null, null, 'crashed ices');
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (2, 'Cold Brew', null, 8, null, null, null, 'oat meal');
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (3, 'Iced Matcha Tea Latte', null, 7, null, null, null, 'ice in the side');
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (4, 'iced chai latte', null, 7, null, null, null, 'add cinammon');
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (5, ' hot mocha', null, 5, null, null, null, 'sugar free');
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (6, 'tea', null, 3, null, null, null, 'cup of water ');
insert into INVENTORY (iid, iname, color, price, tid, sid, ordrid, notes)
values (339, 'chair', 'Brown', 250, 111, 766, 776, 'fast_delivary');
commit;
prompt 125 records loaded
prompt Loading SHOPS...
insert into SHOPS (cid, bid)
values (111, 999);
insert into SHOPS (cid, bid)
values (135, 213);
insert into SHOPS (cid, bid)
values (174, 925);
insert into SHOPS (cid, bid)
values (189, 682);
insert into SHOPS (cid, bid)
values (193, 258);
insert into SHOPS (cid, bid)
values (222, 888);
insert into SHOPS (cid, bid)
values (254, 171);
insert into SHOPS (cid, bid)
values (324, 882);
insert into SHOPS (cid, bid)
values (333, 777);
insert into SHOPS (cid, bid)
values (412, 137);
insert into SHOPS (cid, bid)
values (435, 348);
insert into SHOPS (cid, bid)
values (438, 487);
insert into SHOPS (cid, bid)
values (573, 951);
insert into SHOPS (cid, bid)
values (582, 782);
insert into SHOPS (cid, bid)
values (622, 666);
insert into SHOPS (cid, bid)
values (645, 532);
insert into SHOPS (cid, bid)
values (765, 292);
insert into SHOPS (cid, bid)
values (865, 552);
insert into SHOPS (cid, bid)
values (882, 181);
insert into SHOPS (cid, bid)
values (891, 532);
insert into SHOPS (cid, bid)
values (936, 588);
insert into SHOPS (cid, bid)
values (956, 782);
insert into SHOPS (cid, bid)
values (989, 937);
commit;
prompt 23 records loaded
prompt Enabling foreign key constraints for CUSTOMER...
alter table CUSTOMER enable constraint SYS_C007736;
prompt Enabling foreign key constraints for BRANCH...
alter table BRANCH enable constraint SYS_C007740;
prompt Enabling foreign key constraints for EMPLOYEE...
alter table EMPLOYEE enable constraint FK_EMPLOYEE_COFFEE_SHOP;
alter table EMPLOYEE enable constraint SYS_C007746;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint FK_ORDERS_EMPLOYEE;
alter table ORDERS enable constraint SYS_C007750;
prompt Enabling foreign key constraints for BILL...
alter table BILL enable constraint SYS_C007759;
alter table BILL enable constraint SYS_C007760;
prompt Enabling foreign key constraints for INVENTORY...
alter table INVENTORY enable constraint SYS_C007772;
alter table INVENTORY enable constraint SYS_C007773;
alter table INVENTORY enable constraint SYS_C007774;
prompt Enabling foreign key constraints for SHOPS...
alter table SHOPS enable constraint SYS_C007778;
alter table SHOPS enable constraint SYS_C007779;
prompt Enabling triggers for COFFEE_SHOP...
alter table COFFEE_SHOP enable all triggers;
prompt Enabling triggers for LOCATIONS...
alter table LOCATIONS enable all triggers;
prompt Enabling triggers for CUSTOMER...
alter table CUSTOMER enable all triggers;
prompt Enabling triggers for BRANCH...
alter table BRANCH enable all triggers;
prompt Enabling triggers for EMPLOYEE...
alter table EMPLOYEE enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for BILL...
alter table BILL enable all triggers;
prompt Enabling triggers for INVTYPE...
alter table INVTYPE enable all triggers;
prompt Enabling triggers for SUPPLIERS...
alter table SUPPLIERS enable all triggers;
prompt Enabling triggers for INVENTORY...
alter table INVENTORY enable all triggers;
prompt Enabling triggers for SHOPS...
alter table SHOPS enable all triggers;
set feedback on
set define on
prompt Done.
