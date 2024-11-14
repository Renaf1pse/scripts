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
  is 'Es el tipo de identificación del cliente de la institución financiera informante: RUC, Cédula de identidad o Pasaporte';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.identificacion_cliente
  is 'Corresponde al número de identificación del cliente de la institución financiera informante: RUC, Cédula de identidad o Pasaporte';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.razon_social
  is 'Corresponde al registro de los apellidos y nombres del cliente de la institución financiera informante en el caso de personas naturales; o la denominación o razón social en caso de personas jurídicas. Es opcional, Sólo se debe llenar en el caso de Tipo de identificación “Pasaporte”.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.pais_nacionalidad
  is 'Corresponde a la nacionalidad del cliente de la institución financiera informante. Para el efecto, utilizar la Tabla No. 3 País.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.provincia
  is 'El código de la provincia en donde se ubica la dirección del cliente informada a la institución financiera, de acuerdo a la Tabla No. 4 Provincia';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.canton
  is 'La ciudad en donde se ubica la dirección del cliente informada a la institución financiera, de acuerdo a la Tabla No. 5 Cantón';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.tipo_producto
  is 'Corresponde al código del producto informado en la institución financiera, de acuerdo a la Tabla No. 6.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.numero_cuenta_operacion
  is 'Corresponde al número de cuenta de ahorros, corriente, tarjeta de crédito, operación de crédito u operación de inversiones. No se debe consignar ningún código interno que la institución utilice para identificar al cliente con sus productos; tampoco se debe consignar los números de cuenta contables de la institución, no informar espacios ni caracteres especiales es alfanumérico.
Cuando existan más de dos propietarios de una misma cuenta se deberá registrar el propietario principal.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.saldo_inicial
  is 'l (al 1er día del mes que se informa): Este campo se llenará con el saldo disponible de la cuenta al inicio del mes a reportar. Valor mínimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.total_creditos
  is ': Este campo se llenará con la sumatoria del total de créditos recibidos a la cuenta, por cualquier concepto. Valor mínimo: 0.00';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.num_ope_cred
  is 'Este campo debe contar el número de operaciones que generaron el valor total de créditos. Valor mínimo: 0.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.total_debitos
  is ': Este campo se llenará con la sumatoria del total de débitos efectuados desde la cuenta, por cualquier concepto. Valor mínimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.num_ope_deb
  is 'Este campo debe contar el número de operaciones que generaron el valor total de débitos. Valor mínimo: 0.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.saldo_final
  is '(al último día del mes que se informa): En este campo se consignará el saldo disponible de la cuenta al final del mes a reportar. Valor mínimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.dias_mora
  is 'Indica el número real de días que la operación se encuentra en mora
(número de días impagos a partir de la última cuota pagada). Información será verificada
por el organismo de control. Cuando se reporten en un solo registro varios préstamos de un mismo cliente, en este
campo se registrará la sumatoria de los días de morosidad de todos los préstamos
informados.
';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.tipo_credito
  is 'Código que identifica al tipo de crédito otorgado por la entidad financiera,
de acuerdo con la Tabla 9 Tipo de Crédito.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.estado_credito
  is 'Código que describe el estado en el que se encuentra la
operación del crédito otorgado por la entidad financiera, de acuerdo con la Tabla 10 Tipo
de Crédito.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.capital_x_vencer
  is 'Sumatoria del valor total por vencer de 1 a 360 días, la fecha
fin será diciembre del año reportado. Valor mínimo: 0.00. Cuando el préstamo sea superior
a los 360 días, se reportará el valor acumulado, es decir, el saldo inicial más el valor
generado al último día del mes a reportar';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.capital_no_devenga
  is 'Sumatoria del saldo de la operación que no
devenga intereses de 1 a 360 días al final del mes a reportar. Valor mínimo: 0.00. Cuando
el préstamo sea superior a los 360 días, se reportará el valor acumulado, es decir, el saldo
inicial más el valor generado al último día del mes a reportar';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.total_vencido
  is 'Sumatoria del saldo de la operación que se encuentra vencido al
final del mes a reportar. Valor mínimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.recup_cartera_vencida_casti
  is 'Valor de los gastos generados
por recuperación de cartera vencida o castigada que sean objetivamente determinables,
como llamadas de call center, gastos extrajudiciales, judiciales u otros que intervengan en
la gestión de recuperación. Valor mínimo: 0.00';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.interes_ordinario
  is 'Valor del interés normal que se ha generado sobre el saldo de la
operación al final del mes a reportar. Valor mínimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.interes_mora
  is 'Valor del interés sobre mora que se ha acumulado desde que la
operación esta vencida al final del mes a reportar. Valor mínimo: 0.00.
';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.demanda_judicial
  is 'Monto por el que el deudor ha sido demandado judicialmente
en la operación. Valor mínimo: 0.00.';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.cartera_castigada
  is 'Indica el monto por el cual consta el deudor como sujeto de crédito
castigado. Se reportarán los clientes con créditos castigados incluso cuando no tengan
créditos vigentes. Valor mínimo: 0.00.
';
comment on column MKS_ESTRUCTURAS.ROTEF_DETALLE_2024.moneda
  is 'Corresponde al código de la moneda en la que se realiza la transacción. Para el efecto, utilizar la Tabla No. 8 Monedas.';
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
