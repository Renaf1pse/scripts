-- Create table
create table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
(
  codigo                      NUMBER(10) not null,
  codigo_rotef_cabecera       NUMBER(10) not null,
  tipo_identificacion_cliente VARCHAR2(1) not null,
  identificacion_cliente      VARCHAR2(13) not null,
  razon_social                VARCHAR2(500) not null,
  pais_nacionalidad           VARCHAR2(3) not null,
  provincia                   VARCHAR2(3) not null,
  canton                      VARCHAR2(5) not null,
  tipo_producto               VARCHAR2(3) not null,
  numero_cuenta_operacion     VARCHAR2(30) not null,
  saldo_inicial               NUMBER(20,2) not null,
  total_creditos              NUMBER(20,2) not null,
  num_ope_cred                NUMBER(10) not null,
  total_debitos               NUMBER(20,2) not null,
  num_ope_deb                 NUMBER(10) not null,
  saldo_final                 NUMBER(20,2) not null,
  dias_mora                   NUMBER(10) not null,
  tipo_credito                VARCHAR2(3) not null,
  estado_credito              VARCHAR2(1) not null,
  capital_x_vencer            NUMBER(20,2) not null,
  capital_no_devenga          NUMBER(20,2) not null,
  total_vencido               NUMBER(20,2) not null,
  recup_cartera_vencida_casti NUMBER(20,2) not null,
  interes_ordinario           NUMBER(20,2) not null,
  interes_mora                NUMBER(20,2) not null,
  demanda_judicial            NUMBER(20,2) not null,
  cartera_castigada           NUMBER(20,2) not null,
  moneda                      VARCHAR2(3) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  is 'Tabla que contiene el detalle de la estructura de la ROTEF';
-- Add comments to the columns 
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.codigo
  is 'Codigo de la tabla';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.codigo_rotef_cabecera
  is 'Codigo de la estructura';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.tipo_identificacion_cliente
  is 'Es el tipo de identificaci�n del cliente de la instituci�n financiera informante: RUC, C�dula de identidad o Pasaporte';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.identificacion_cliente
  is 'Corresponde al n�mero de identificaci�n del cliente de la instituci�n financiera informante: RUC, C�dula de identidad o Pasaporte';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.razon_social
  is 'Corresponde al registro de los apellidos y nombres del cliente de la instituci�n financiera informante en el caso de personas naturales; o la denominaci�n o raz�n social en caso de personas jur�dicas. Es opcional, S�lo se debe llenar en el caso de Tipo de identificaci�n �Pasaporte�.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.pais_nacionalidad
  is 'Corresponde a la nacionalidad del cliente de la instituci�n financiera informante. Para el efecto, utilizar la Tabla No. 3 Pa�s.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.provincia
  is 'El c�digo de la provincia en donde se ubica la direcci�n del cliente informada a la instituci�n financiera, de acuerdo a la Tabla No. 4 Provincia';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.canton
  is 'La ciudad en donde se ubica la direcci�n del cliente informada a la instituci�n financiera, de acuerdo a la Tabla No. 5 Cant�n';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.tipo_producto
  is 'Corresponde al c�digo del producto informado en la instituci�n financiera, de acuerdo a la Tabla No. 6.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.numero_cuenta_operacion
  is 'Corresponde al n�mero de cuenta de ahorros, corriente, tarjeta de cr�dito, operaci�n de cr�dito u operaci�n de inversiones. No se debe consignar ning�n c�digo interno que la instituci�n utilice para identificar al cliente con sus productos; tampoco se debe consignar los n�meros de cuenta contables de la instituci�n, no informar espacios ni caracteres especiales es alfanum�rico.
Cuando existan m�s de dos propietarios de una misma cuenta se deber� registrar el propietario principal.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.saldo_inicial
  is 'l (al 1er d�a del mes que se informa): Este campo se llenar� con el saldo disponible de la cuenta al inicio del mes a reportar. Valor m�nimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.total_creditos
  is ': Este campo se llenar� con la sumatoria del total de cr�ditos recibidos a la cuenta, por cualquier concepto. Valor m�nimo: 0.00';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.num_ope_cred
  is 'Este campo debe contar el n�mero de operaciones que generaron el valor total de cr�ditos. Valor m�nimo: 0.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.total_debitos
  is ': Este campo se llenar� con la sumatoria del total de d�bitos efectuados desde la cuenta, por cualquier concepto. Valor m�nimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.num_ope_deb
  is 'Este campo debe contar el n�mero de operaciones que generaron el valor total de d�bitos. Valor m�nimo: 0.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.saldo_final
  is '(al �ltimo d�a del mes que se informa): En este campo se consignar� el saldo disponible de la cuenta al final del mes a reportar. Valor m�nimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.dias_mora
  is 'Indica el n�mero real de d�as que la operaci�n se encuentra en mora
(n�mero de d�as impagos a partir de la �ltima cuota pagada). Informaci�n ser� verificada
por el organismo de control. Cuando se reporten en un solo registro varios pr�stamos de un mismo cliente, en este
campo se registrar� la sumatoria de los d�as de morosidad de todos los pr�stamos
informados.
';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.tipo_credito
  is 'C�digo que identifica al tipo de cr�dito otorgado por la entidad financiera,
de acuerdo con la Tabla 9 Tipo de Cr�dito.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.estado_credito
  is 'C�digo que describe el estado en el que se encuentra la
operaci�n del cr�dito otorgado por la entidad financiera, de acuerdo con la Tabla 10 Tipo
de Cr�dito.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.capital_x_vencer
  is 'Sumatoria del valor total por vencer de 1 a 360 d�as, la fecha
fin ser� diciembre del a�o reportado. Valor m�nimo: 0.00. Cuando el pr�stamo sea superior
a los 360 d�as, se reportar� el valor acumulado, es decir, el saldo inicial m�s el valor
generado al �ltimo d�a del mes a reportar';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.capital_no_devenga
  is 'Sumatoria del saldo de la operaci�n que no
devenga intereses de 1 a 360 d�as al final del mes a reportar. Valor m�nimo: 0.00. Cuando
el pr�stamo sea superior a los 360 d�as, se reportar� el valor acumulado, es decir, el saldo
inicial m�s el valor generado al �ltimo d�a del mes a reportar';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.total_vencido
  is 'Sumatoria del saldo de la operaci�n que se encuentra vencido al
final del mes a reportar. Valor m�nimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.recup_cartera_vencida_casti
  is 'Valor de los gastos generados
por recuperaci�n de cartera vencida o castigada que sean objetivamente determinables,
como llamadas de call center, gastos extrajudiciales, judiciales u otros que intervengan en
la gesti�n de recuperaci�n. Valor m�nimo: 0.00';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.interes_ordinario
  is 'Valor del inter�s normal que se ha generado sobre el saldo de la
operaci�n al final del mes a reportar. Valor m�nimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.interes_mora
  is 'Valor del inter�s sobre mora que se ha acumulado desde que la
operaci�n esta vencida al final del mes a reportar. Valor m�nimo: 0.00.
';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.demanda_judicial
  is 'Monto por el que el deudor ha sido demandado judicialmente
en la operaci�n. Valor m�nimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.cartera_castigada
  is 'Indica el monto por el cual consta el deudor como sujeto de cr�dito
castigado. Se reportar�n los clientes con cr�ditos castigados incluso cuando no tengan
cr�ditos vigentes. Valor m�nimo: 0.00.
';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.moneda
  is 'Corresponde al c�digo de la moneda en la que se realiza la transacci�n. Para el efecto, utilizar la Tabla No. 8 Monedas.';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  add constraint PK_ROTEF_DETALLE_2024 primary key (CODIGO)
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
alter table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  add constraint FK1_ROTEF_DETALLE_2024 foreign key (CODIGO_ROTEF_CABECERA)
  references MKS_ESTRUCTURAS.ROTEF_CABECERA (CODIGO);
alter table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  add constraint FK2_ROTEF_DETALLE_2024 foreign key (TIPO_IDENTIFICACION_CLIENTE)
  references MKS_ESTRUCTURAS.ROTEF_TIPO_IDENTIFICACION (CODIGO);
alter table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  add constraint FK3_ROTEF_DETALLE_2024 foreign key (PAIS_NACIONALIDAD)
  references MKS_ESTRUCTURAS.ROTEF_PAIS (CODIGO)
  disable
  novalidate;
alter table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  add constraint FK4_ROTEF_DETALLE_2024 foreign key (PROVINCIA)
  references MKS_ESTRUCTURAS.ROTEF_PROVINCIA (CODIGO)
  disable
  novalidate;
alter table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  add constraint FK5_ROTEF_DETALLE_2024 foreign key (CANTON)
  references MKS_ESTRUCTURAS.ROTEF_CANTON (CODIGO)
  disable
  novalidate;
alter table MKS_ESTRUCTURAS.ROTEF_DETALLE_2024
  add constraint FK7_ROTEF_DETALLE_2024 foreign key (MONEDA)
  references MKS_ESTRUCTURAS.ROTEF_MONEDA (CODIGO);
