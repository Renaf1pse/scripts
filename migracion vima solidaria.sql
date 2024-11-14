---------------------- DATOS GENERALES -------------------------
select s.codigo                                           "SING_NUMSOLI",
       s.codigo                                           "CODIGO_SOCIO",
       p.codigo_tipo_persona                                "SING_TIPOPERSONA",
       (select ti.siglas
        from mks_socios.tipo_identificacion ti
        where p.codigo_tipo_identificacion = ti.codigo)     "SING_TIPO_ID",
       p.identificacion                                     "SING_NUMERO_ID",
       NVL((select tv.codigo_oc 
        from mks_socios.persona_residencia pr,
             mks_socios.tipo_vivienda tv
       where pr.codigo_persona = p.codigo
       and tv.codigo = pr.codigo_tipo_vivienda
       and rownum = 1), 'O')                                "SING_TIPO_RESID",
       NVL((select ub.codigo_oc
        from mks_socios.persona_residencia pr,
             mks_comunes.ubicacion_geografica ub
       where pr.codigo_persona = p.codigo
       and pr.codigo_ubi_geo_res = ub.codigo
       and rownum = 1), '01110150')                         "SING_LUGDIR",
       NVL((select pr.direccion
        from mks_socios.persona_residencia pr 
        where pr.codigo_persona = p.codigo
        and rownum = 1),'S/D')                      "SING_CALLE_PRIN",
       'NINGUNA'                                    "SING_CALLE_SECU",
       NVL((select UPPER(s.nombre)
        from mks_socios.persona_residencia pr,
             mks_socios.sector s
        where pr.codigo_persona = p.codigo
        and s.codigo = pr.codigo_sector
        and rownum = 1), 'URBANO')                          "SING_SECTOR",
        'S/N'                                               "SING_NUMEROCASA",
        (select pt.numero
         from mks_socios.persona_telefono pt
         where pt.codigo_persona = p.codigo
         and pt.codigo_tipo_telefono = 1
         and pt.eliminado = 'N'
         and rownum = 1)                                    "SING_TELEFONOS",
        (select ub.codigo_oc
         from mks_ifips.ifip_agencia ai,
              mks_comunes.ubicacion_geografica ub
         where ai.codigo = s.codigo_ifip_agencia
         and ai.codigo_ubi_geo_parroquia = ub.codigo
         and rownum = 1)                                    "SING_LUGSOLI",
         s.fecha_creacion                                   "SING_FECSOLI",
         s.codigo_ifip_agencia                              "CODIGO_AGENCIA",
         s.codigo_estado_socio                              "SING_ESTADO_SOLI",
         s.observaciones                                    "SING_OBSERVAC",
         sysdate                                            "SING_FECHA_HORA_SIS",
         s.codigo_usuario_creacion                          "CODIGO_USUARIO",
         1                                                  "CODIGO_EMPRESA",
         s.codigo_ifip_agencia                              "CODIGO_SUCURSAL",
         s.codigo_archivo                                   "SECUENCIA_ARCH_SOLICITUD_ING",
         1                                                  "CODIGO_CLASE_PERSONA",
        (select pt.numero
         from mks_socios.persona_telefono pt
         where pt.codigo_persona = p.codigo
         and pt.codigo_tipo_telefono = 2
         and pt.eliminado = 'N'
         and rownum = 1)                                    "SING_TELEFONO_CELULAR",
        NVL((select DECODE(s.codigo, 1, 'U', 2, 'R')
        from mks_socios.persona_residencia pr,
             mks_socios.sector s
        where pr.codigo_persona = p.codigo
        and s.codigo = pr.codigo_sector), 'U')              "TIPO_SECTOR",
        0                                                   "CODIGO_ANTERIOR_MIGRA",
        'N'                                                 "MARGINAL",
        0                                                   "CODIGO_GRUPORG",
        1                                                   "CODIGO_TIP_SEG",
        (CASE WHEN (select r.numero_cuenta 
         from mks_socios.referencia_entidad_financiera r
         where r.codigo_persona = p.codigo
         and rownum = 1) IS NOT NULL THEN 'S'
        ELSE 'N' END )                                      "TIENE_CUEN_OTR_INS_FINAN",
        'N'                                                 "TIENE_FINALIDAD_LUCRO"
from 
     mks_socios.socio s,
     mks_socios.persona p
where s.codigo_persona = p.codigo
order by s.codigo asc;

----------------- PERSONA NATURAL ---------------------
select 
        s.codigo                                            "CODIGO_SOCIO",
        pn.primer_apellido                                  "SING_APELLIDO_PAT",
        pn.segundo_apellido                                 "SING_APELLIDO_MAT",
        pn.nombres                                          "SING_NOMBRES",
        DECODE (pn.codigo_estado_civil, 2, '1', 1, '2', pn.codigo_estado_civil) "SING_ESTADO_CIVIL",
        (select ub.codigo_oc
         from mks_comunes.ubicacion_geografica ub
         where ub.codigo = pn.codigo_ubi_geo_nac)           "SING_LUGNACI",
        to_char(pn.fecha_nacimiento, 'dd/mm/yyyy')          "SING_FECNACI",
        decode(pn.codigo_instruccion, 1,7, 2,2, 3,3, 4,4, 5,5, 6,6, 7,1) "CODIGO_INSTRUCCION",
        NVL((select ae.codigo_oc
          from mks_socios.persona_trabajo_act_eco pta,
               mks_socios.persona_actividad_economica pae,
               mks_socios.actividad_economica ae
          where pta.codigo_persona = p.codigo
          and pae.codigo_persona = p.codigo
          and pae.codigo_actividad_economica = ae.codigo
          and pae.es_principal = 'S'
          and pae.eliminado = 'N'
          and rownum = 1), 'G471900')                       "CODIGO_OCUPACION",
         pn.sexo                                            "SING_SEXO",
         s.codigo_estado_socio                              "SING_ESTADO",
         NVL((select pta.direccion
          from mks_socios.persona_trabajo_act_eco pta,
               mks_socios.persona_actividad_economica pae,
               mks_socios.actividad_economica ae
          where pta.codigo_persona = p.codigo
          and pae.codigo_persona = p.codigo
          and pae.codigo_actividad_economica = ae.codigo
          and pae.es_principal = 'S'
          and pae.eliminado = 'N'
          and rownum = 1), 'S/D')                   "SING_DIRECCION_COMERCIAL",
          NVL((select UPPER(fi.nombre)
           from 
           mks_socios.fuente_ingresos fi
           where fi.codigo = pn.codigo_fuente_ingresos), 'S/D')    "SING_FUENTE_INGRESOS",
           ''                                               "SING_CEDULA_REPRESENTANTE",
           ''                                               "SING_NOMBRES_REPRESENTANTE",
           ''                                               "SING_APELLIDO_PATERNO_REPRES",
           ''                                               "SING_APELLIDO_MATERNO_REPRES",
           (select p1.identificacion 
            from mks_socios.persona p1,
                 (select pc.codigo_persona cod, max(pc.fecha_registro) fecha
                 from mks_socios.persona_conyuge pc
                 where pc.eliminado = 'N'
                 group by pc.codigo_persona)con
            where p1.codigo = con.cod
             and p1.codigo = p.codigo)                       "SING_CEDULA_CONYUGE",
           (select pn1.nombres
            from mks_socios.persona_natural pn1,
                 (select pc.codigo_persona cod, max(pc.fecha_registro) fecha
                 from mks_socios.persona_conyuge pc
                 where pc.eliminado = 'N'
                 group by pc.codigo_persona)con
            where pn1.codigo_persona = p.codigo
            and pn1.codigo_persona = con.cod)                        "SING_NOMBRES_CONYUGE",
           (select pn1.primer_apellido
            from mks_socios.persona_natural pn1,
                 (select pc.codigo_persona cod, max(pc.fecha_registro) fecha
                  from mks_socios.persona_conyuge pc
                  where pc.eliminado = 'N'
                  group by pc.codigo_persona)con
            where pn1.codigo_persona = p.codigo
            and pn1.codigo_persona = con.cod)                        "SING_APELLIDO_PATERNO_CONYUGE",
           (select pn1.segundo_apellido
            from mks_socios.persona_natural pn1,
                 (select pc.codigo_persona cod, max(pc.fecha_registro) fecha
                  from mks_socios.persona_conyuge pc
                  where pc.eliminado = 'N'
                  group by pc.codigo_persona)con
            where pn1.codigo_persona = p.codigo
            and pn1.codigo_persona = con.cod)                        "SING_APELLIDO_MATERNO_CONYUGE",
            (case 
              when mks_socios.f_calcula_edad_anios_entero(pn.fecha_nacimiento) >= 18 
               then 1 else 2 end )                                                       "SING_TIPO_EDAD_SOCIO",
            NVL(pn.codigo_profesion, 99)                    "CODIGO_PROFESION",
            1                                               "CODIGO_EMPRESA",
          NVL((select ae.codigo_oc
          from mks_socios.persona_trabajo_act_eco pta,
               mks_socios.persona_actividad_economica pae,
               mks_socios.actividad_economica ae
          where pta.codigo_persona = p.codigo
          and pae.codigo_persona = p.codigo
          and pae.codigo_actividad_economica = ae.codigo
          and pae.es_principal = 'S'
          and pae.eliminado = 'N'
          and rownum = 1), 'G4719')                         "CODIGO_OCUPACION_PRINCIPAL",
          (select  UPPER(pr.nombre)
           from mks_socios.profesion pr
           where pn.codigo_profesion = pr.codigo)           "SING_OBSERVACION_PROFESION",
           ''                                               "CODIGO_DESTINO_DET",
           ''                                               "SING_FECNACI_REPRES_O_CONY",
           ''                                               "SING_IDENF_REPRES",
           ''                                               "SING_GENERO_REPRES"
from 
       mks_socios.persona_natural pn,
       mks_socios.persona p,
       mks_socios.socio s
where p.codigo = pn.codigo_persona
and s.codigo_persona = p.codigo
and p.codigo not in (select pi.codigo_persona from mks_socios.persona_institucion pi)
order by s.codigo asc 

------------------------- PERSONA JURIDICA -------------------
select pi.razon_social                                      "SING_RAZON_SOCIAL",
       (select pn.primer_apellido ||' '||pn.segundo_apellido
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (select min(pir.codigo_persona_rep) 
                                   from mks_socios.persona_institucion_rep pir
                                   where pir.codigo_persona = pi.codigo_persona
                                   and pir.eliminado = 'N'))                           "SING_APELLIDO_REPRES1",
       (select pn.nombres
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (select min(pir.codigo_persona_rep) 
                                   from mks_socios.persona_institucion_rep pir
                                   where pir.codigo_persona = pi.codigo_persona
                                   and pir.eliminado = 'N'))                           "SING_NOMBRE_REPRES1",
       (select pe.identificacion
        from mks_socios.persona pe 
        where pe.codigo = (select min(pir.codigo_persona_rep) 
                           from mks_socios.persona_institucion_rep pir
                           where pir.codigo_persona = pi.codigo_persona
                           and pir.eliminado = 'N'))                           "SING_CEDULA_REP1",
       (select pn.primer_apellido ||' '||pn.segundo_apellido
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (case when (select count(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') > 1 then (select max(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') else null end ))           "SING_APELLIDO_REPRES2",        
       (select pn.nombres
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (case when (select count(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') > 1 then (select max(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') else null end))            "SING_NOMBRE_REPRES2",        
       (select p1.identificacion
        from mks_socios.persona p1 
        where p1.codigo = (case when (select count(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') > 1 then (select max(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') else null end))           "SING_CEDULA_REP2",
        s.codigo_estado_socio                              "SING_ESTADO",
        ''                                                 "CODIGO_EMPRESA",
        s.codigo                                           "CODIGO_SOCIO",
        NVL((select ae.codigo_oc
         from mks_socios.persona_actividad_economica pae,
              mks_socios.actividad_economica ae
         where ae.codigo = pae.codigo_actividad_economica
         and pae.codigo_persona = pi.codigo_persona
         and pae.es_principal = 'S'
         and pae.eliminado = 'N'
         and rownum = 1 ),'G4719')                         "CODIGO_OCUPACION_PRINCIPAL",
        'G47190'                                           "CODIGO_DESTINO_DE",
        'G471900'                                          "CODIGO_OCUPACION",
       (select to_char(pn.fecha_nacimiento,'dd/mm/yyyy')
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (select min(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N'))                          "SING_FECNACI_REP1",        
       (select to_char(pn.fecha_nacimiento, 'dd/mm/yyyy')
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (case when (select count(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') > 1 then (select max(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') else null end))           "SING_FECNACI_REP2",
        NVL((select pr.direccion 
         from mks_socios.persona_residencia pr
        where pr.codigo_persona = pi.codigo_persona), 'S/D')   "SING_DIRECCION_COMERCIAL",
        NVL(pi.objeto_social, 'S/D')              "SING_FUENTE_INGRESOS",
       (select pn.sexo
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (select min(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N'))                          "GENERO_REPRES1",
       (select pn.sexo
        from mks_socios.persona_natural pn 
        where pn.codigo_persona = (case when (select count(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') > 1 then (select max(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') else null end))           "GENERO_REPRES2",
       (select ti.siglas
        from mks_socios.persona pe,
             mks_socios.tipo_identificacion ti
        where pe.codigo_tipo_identificacion = ti.codigo
        and pe.codigo = (select min(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N'))                         "SING_IDENF_REP1",        
       (select ti.siglas
        from mks_socios.persona pe,
             mks_socios.tipo_identificacion ti
        where pe.codigo_tipo_identificacion = ti.codigo
        and pe.codigo = (case when (select count(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') > 1 then (select max(pir.codigo_persona_rep) 
                  from mks_socios.persona_institucion_rep pir
                  where pir.codigo_persona = pi.codigo_persona
                  and pir.eliminado = 'N') else null end))          "SING_IDENF_REP2",
        p.correo_electronico                              "SING_EMAIL",
        to_char(pi.fecha_constitucion, 'dd/mm/yyyy')      "SING_FECHA_CONSTITUCION",
        NVL(pi.objeto_social, 'S/D')             "SING_OBJETO_SOCIAL"
from mks_socios.persona p,
     mks_socios.persona_institucion pi,
     mks_socios.socio s
where pi.codigo_persona = p.codigo
and s.codigo_persona = pi.codigo_persona
order by s.codigo asc;

---------------------CUENTAS---------------------
select c.codigo_socio         "CODIGO_SOCIO",
       c.codigo_tipo_producto "CODIGO_PRODUCTO",
       c.codigo_moneda        "CODIGO_MONEDA",
       c.numero               "CUEN_NUMERO_CUENTA",
       c.saldo_total          "CUEN_SALDO_TOTAL",
       c.saldo_disponible     "CUEN_SALDO_DISP",
       c.saldo_bloqueado      "CUEN_SALDO_BLOQUEADO",
       0                        "CUEN_SALDO_INICIODIA",
       tp.nombre                "CUEN_NOMBRE",
       p.identificacion         "CUEN_CEDULA_BENE",
       p.nombre_completo        "CUEN_NOMBRE_BENE",
       c.numero_libreta       "CUEN_NUMERO_LIBRETA",
       to_char(c.fecha_creacion, 'dd/mm/yyyy')  "CUEN_FECHA_APERTURA",
       to_char(c.fecha_creacion, 'dd/mm/yyyy')    "CUEN_FECHA_SISTEMA",
       c.codigo_estado                           "CODIGO_ESTADO",
       1                                           "CODIGO_ACT_FINANCIERA",
       1                                           "CODIGO_EMPRESA",
       1                                           "CODIGO_TIPO_CLI",
       c.codigo_tipo_firma                       "TIPO_FIRM_CODIGO",
       c.creada_por                              "CODIGO_USUARIO",
       'SERVER'                                    "CODIGO_MAQUINA",
       (select to_char(lc.fecha_liquidacion,'dd/mm/yyyy')
        from mks_ahorros.liquidacion_cuenta lc,
             mks_ahorros.liquidacion_cuenta_desgloce lcd
        where lcd.codigo_liquidacion = lc.codigo
        and lcd.codigo_cuenta = c.codigo) "CUEN_FECHA_CIERRE",
        c.provision_acumulada "PROVISION",
        'MIGRACION'             "OBSERVACIONES"
from mks_ahorros.cuenta c,
     mks_ahorros.tipo_producto tp,
     mks_socios.socio s,
     mks_socios.persona p 
where c.codigo_socio = s.codigo
and s.codigo_persona = p.codigo
and tp.codigo = c.codigo_tipo_producto
order by c.codigo_socio asc ;


---------------------DPFS---------------------
select  con.codigo              "CODIGO_PLAZO",
        con.codigo_ifip_agencia "CODIGO_SUCURSAL",
        con.codigo_ifip_agencia "CODIGO_AGENCIA",
        1                       "CODIGO_EMPRESA",
        3                       "CODIGO_ACT_FINANCIERA",
        2                       "CODIGO_PRODUCTO",
        con.codigo_moneda       "CODIGO_MONEDA",
        3                       "CODIGO_USUARIO",
        'SERVIDOR'              "CODIGO_MAQUINA",
        s.codigo                "CODIGO_SOCIO",
        1                       "CODIGO_TIPO_CLI",
        to_char(con.fecha_contrato, 'dd/mm/yyyy')      "FECHA_SIS_LIQUIDA",
        con.capital             "CAPITAL",
        con.tasa_interes        "TASA_INTERES",
        con.plazo_dias          "DIASPLAZO",
        con.interes             "INTERES",
        con.total               "TOTAL",
        to_char(con.fecha_contrato, 'dd/mm/yyyyy')     "FECHA_CAPTACION",
        to_char(con.fecha_vencimiento, 'dd/mm/yyyy')   "FECHA_VENCIMIENTO",
        to_char(con.fecha_contrato, 'dd/mm/yyyyy')     "FECHA_SISTEMA",
        ''                          "FORMA_LIQUIDACION",
        ''                          "CODIGO_TRANSA_ACRED",
        ''                          "CONCEPTO_TRANSA_ACRED",
        'P'                         "ESTADO",
        con.retencion               "RETENCION_IMP_RENTA",
        0                            "INTERES_MENSUAL",
        DECODE(con.acredita_mensual, 'S', 'ME', 'N', 'VE') "FORMA_PAGO_INTERES",
        'N'                          "BLOQUEADO",
        td.numero                    "NUMERO_CERTIFICADO",
        con.retencion_impresa        "TIENE_RETENCION",
        con.renovacion_automatica    "RENOVACION",
        3                            "CODIGO_USUARIO_ASESOR",
        con.porcentaje_retencion     "PORCENTAJE_IMPUESTO_RENTA",
        ''                           "CODIGO_MOVIMIENTO",
        360                          "BASE_CALCULO"
from 
mks_socios.persona p, 
mks_dpfs.contrato_dpf con,
mks_socios.socio s,
mks_dpfs.documento_contrato_dpf doc,
mks_dpfs.talonario_documento_dpf_det td
where p.codigo = con.codigo_persona
and s.codigo_persona = p.codigo
and doc.codigo_contrato = con.codigo
and td.codigo = doc.codigo_documento
and doc.estado = 'A'
and td.estado <> 'N'
order by con.codigo asc;

---------------------pagos dpfs

select pag.numero_pago "NRO_PAGO",
       1               "CODIGO_EMPRESA",
       pag.codigo_contrato "CODIGO_PLAZO",
       to_char(pag.fecha_pago, 'dd/mm/yyyy hh24:mi:ss') "FECHA_PAGO",
       pag.interes_pagado  "INTERES_ACREDITADO",
       pag.retencion       "RETENCION_IMP_RENTA",
       (pag.interes_pagado - pag.retencion) "TOTAL"
from 
     mks_dpfs.contrato_dpf con,
     mks_dpfs.pago_dpf pag
where pag.codigo_contrato = con.codigo
order by pag.numero_pago, pag.codigo_contrato asc;

---------------------CREDITOS---------------------
select sol.numero                            "NUMERO_CREDITO",
       1                                     "CODIGO_EMPRESA",
       2                                     "CODIGO_ACT_FINANCIERA",
       1                                     "CODIGO_TIPO_CLI",
       sol.codigo_moneda                     "CODIGO_MONEDA",
       sol.codigo_producto                   "CODIGO_PRODUCTO",
       sol.codigo_socio                      "CODIGO_SOCIO",
       to_char((select min(ta.fecha_inicio)
        from mks_creditos.tabla_amortizacion ta 
        where ta.numero_credito = sol.numero), 'dd/mm/yyyy') "FECHA_CREDITO",
       pe.siglas                             "CODIGO_PERIOC",
       ori.codigo_oc                         "CODIGO_ORIREC",
       'S'                                   "DEB_AUT",
       sol.monto_credito                     "CANT_SOLI",
       sol.monto_credito                     "TOT_INNVERSION",
       0                                     "BASE_CREDITO",
       sol.numero_cuotas                     "NUM_CUOTAS",
       sol.tasa                              "TASA_INTERES",
       sd.total_mora                         "MORA",
       sol.tipo_tabla                        "TAB_AMORTIZA",
       sd.dias_mora                          "TOT_DIAS_MORA",
       0                                     "TOT_NUM_MORAS",
       nvl(decode(sol.codigo_estado, 6, 'L', 7, 'C', 8, 'E'), 'E') "ESTADO_CRED",
       'N'                                   "ESTADO",
       0                                     "PER_GRACIA",
       sd.saldo_capital                      "CAPITAL_PORPAG",
       sol.dia_fijo                          "MISMODIA",
       0                                     "NUMDIAS",
       sol.estado_colocado_por               "OFICRE",
       sol.observaciones                     "OBS",
       sol.codigo_ifip_agencia               "CODIGO_SUCURSAL",
       sol.codigo_ifip_agencia               "CODIGO_AGENCIA",
       'N'                                   "PIGPER",
       'S'                                   "INTERES_FIJO",
       0                                     "PORC_PIG",
       to_char((select min(ta.fecha_inicio) 
        from mks_creditos.tabla_amortizacion ta
        where ta.numero_credito = sol.numero),'dd/mm/yyyy') "FECINI",
       to_char((select max(ta.fecha_pago) 
        from mks_creditos.tabla_amortizacion ta
        where ta.numero_credito = sol.numero), 'dd/mm/yyyy') "FECFIN",
        'N'                                   "JUDICIAL",
        decode(tc.codigo, 7, 2, 9, 4) "CODIGO_GRUPO",       
        (select de.codigo_oc from 
             mks_creditos.destino_financiero de,
             mks_creditos.destino_financiero_cartera deca 
         where de.codigo = deca.codigo_destino
         and deca.codigo = sol.codigo_destino_financiero ) "CODIGO_DESTINO_FINANCIERO",
         'N0'            "CODIGO_SECTOR",
         'N00'           "CODIGO_SUBSECTOR",
         sd.total_costo_judicial         "COSTO_JUDICIAL",
         sd.total_notificaciones         "NOTIFICACIONES",
         0                               "GESTION_COBRO",
         ''                              "FECHA_GESTION_COBRO",
         'N'                             "DESEM_PARC",
         sol.monto_credito               "MONTO_REAL",
         sd.saldo_capital                "SALDO_CAPITAL",
         3                               "CODIGO_USUARIO",
         sd.monto_acreditado             "MONTO_ACREDITADO",
         sol.observaciones               "OBS_DESCRE",
         'N00'                           "CODIGO_INDUSTRIA_NIVEL1",
         ''                              "NUMERO_CREDITO_ANTERIOR",
         ''                              "DOCUMENTO_ANTERIOR_CREDITO",
         'N'                             "CREDITO_REESTRUCTURADO",
         'N0000000'                      "CODIGO_INDUSTRIA_NIVEL2",
         NVL((select ac.codigo_oc 
          from mks_socios.actividad_economica ac
          where ac.codigo = sol.codigo_act_eco
          and ac.catalogo = 'C'), 'N0000000') "CODIGO_CLASIFICACION_CREDITO",
          SOL.MONTO_CREDITO       "CANT_SOLI_SOCIO",
          7                       "CODIGO_SECTOR_ECONOMICO",
          sol.monto_credito       "CANTIDAD_APROBADA",
          1                       "NUM_DESEMBOLSOS",
          0                       "CODIGO_SUBGRUPO",
          (select ubi.codigo_oc 
           from mks_comunes.ubicacion_geografica ubi 
           where ubi.codigo = sol.codigo_ubi_geo)"DESTINO_GEOGRAFICO",
           7                      "NIVEL_ESTUDIOS_ESPERADO",
           'NV'                   "CAUSAL_VINCULACION",
           (CASE WHEN (select cc.numero_credito 
            from mks_creditos.cartera_castigada cc 
            where cc.numero_credito = sol.numero) IS NOT NULL THEN 'S' ELSE 'N' END) "CASTIGADO"
from 
    mks_creditos.solicitud sol,
    mks_creditos.solicitud_detalle sd,
    mks_comunes.periodicidad pe,
    mks_creditos.origen_recursos ori,
    mks_creditos.producto_credito pc,
    mks_creditos.tipo_cartera tc,
    mks_ifips.ifip ifi,
    mks_ifips.ifip_agencia ifia
where sol.codigo_periodicidad = pe.codigo
and ori.codigo = sol.codigo_origen_recursos
and sd.numero_credito = sol.numero
and ifi.codigo = sol.codigo_ifip
and ifia.codigo_ifip = ifi.codigo
and ifia.codigo = sol.codigo_ifip_agencia
and pc.codigo = sol.codigo_producto
and tc.codigo = pc.codigo_tipo_cartera
order by sol.numero asc;

-----------tabla amortizacion varialbe (calculada ccp)
select ta.numero_credito                          "NUMERO_CREDITO",
       1                                          "CODIGO_EMPRESA",        
       ta.cuota                                   "ORDENCAL",
       to_char(ta.fecha_inicio, 'dd/mm/yyyy')     "FECINICAL",
       to_char(ta.fecha_pago, 'dd/mm/yyyy')       "FECFINCAL",
       ccp.saldo_capital                          "SALDOCAL",
       ccp.capital                                "CAPITALCAL",           
       ccp.interes_causado                        "INTERESCAL",
       ccp.dias_interes                           "DIASINTCAL",
       to_char(ccp.fecha_calculo_interes, 'dd/mm/yyyy')  "FECHAINTCAL",
       ccp.mora_causada                                  "MORACAL",
       ccp.dias_mora                                     "DIASMORACAL",
       to_char(ccp.fecha_calculo_mora, 'dd/mm/yyyy')     "FECHAMORACAL",
       ccp.rubro_actual                                  "SEGURO_DESG",
       0                                                 "RUBRO_ADIC1",
       0                                                 "RUBRO_ADIC2",
       ccp.total_pago                                    "TOTALCAL",
       ta.estado                                         "ESTADOCAL",
       'I'                                               "ESTADO",
       ccp.saldo_capital                                 "CAPITAL_PENDIENTE"       
from 
     mks_creditos.tabla_amortizacion ta, 
     mks_creditos.calculo_cuota_pagar ccp,
     mks_creditos.solicitud_detalle sd
where ta.numero_credito = ccp.numero_credito
and ta.cuota = ccp.cuota
and sd.numero_credito = ta.numero_credito
order by ta.numero_credito, ta.cuota asc;

------------------tabla amortizacion contratada
select ta.numero_credito                         "NUMERO_CREDITO",
       ta.cuota                                  "ORDEN",
       to_char(ta.fecha_pago, 'dd/mm/yyyy')      "FECHA",
       ta.saldo_capital                          "SALDOCAL",
       ta.capital                                "CAPITAL",
       ta.interes                                "INTERES",
       (ta.capital + ta.interes)                 "PAGO",       
       ta.rubros                                 "SEGURO_DESG",
       0                                         "RUBRO_ADIC1",
       0                                         "RUBRO_ADIC2"
from mks_creditos.tabla_amortizacion ta
order by ta.numero_credito, ta.cuota asc;

--pagos 
select pc.numero_credito "NUMERO_CREDITO",
       pcd.cuota         "nro cuota",
       to_char(pc.fecha_cobro, 'dd/mm/yyyy')    "FECHA",
       pc.total          "VALOR",
       pcd.capital       "CAPITAL",
       pcd.interes       "INTERES",
       pcd.mora          "MORA",
       pcd.rubros        "SEGURO DESG",
       pc.costos_judiciales      "GASTOS JUDICIALES",
       0                         "GASTOS COBRANZA",
       pcd.notificaciones        "NOTIFICACIONES",
       pc.codigo_ifip_agencia    "CODIGO_SUCURSAL",
       pc.codigo_ifip_agencia    "CODIGO_AGENCIA",
       pc.codigo                 "PAGO_NUMERO",
       ''                        "OBSERVACIONES",
       0                         "INTERES COVID",
       0                         "RUBRO_ADIC1",
       0                         "RUBRO_ADIC2"
from mks_creditos.pago_credito pc,
     mks_creditos.pago_credito_detalle_cuota pcd
where pcd.codigo_pago_credito = pc.codigo
order by pc.codigo, pcd.numero_credito, pcd.cuota asc;

---------------------GARANTES
select 1                                                "CODIGO_EMPRESA",
       nvl((select s.codigo
        from mks_socios.socio s
        where s.codigo_persona = gc.codigo_persona), 0) "CODIGO_SOCIO_GARANTE",
        gc.numero_credito                               "NUM_FORMALIZA",
        'A'                                             "ESTADO",
        gc.numero_credito                               "NUMERO_CREDITO",
        p.identificacion                                "NUMERO_ID",
        0                                               "CODIGO_GRUPO",
        1                                               "NUM_REGISTRO",
        3                                               "TIGA_CODIGO",
        (CASE WHEN (select pc.codigo_persona_conyuge 
                   from mks_socios.persona_conyuge pc
                   where pc.codigo_persona = p.codigo
                   and pc.firma = 'S'
                   and pc.eliminado = 'N') IS NOT NULL THEN 'S' ELSE 'N' END)               "FIRMA_CONY_GARANTE",
        (select pn.primer_apellido ||' '|| pn.segundo_apellido 
         from mks_socios.persona_natural pn
         where pn.codigo_persona = (select pc.codigo_persona_conyuge 
                                   from mks_socios.persona_conyuge pc
                                   where pc.codigo_persona = p.codigo
                                   and pc.firma = 'S'
                                   and pc.eliminado = 'N'))                                 "APELLIDOS_CONY_GARANTE",
        (select pn.nombres 
         from mks_socios.persona_natural pn
         where pn.codigo_persona = (select pc.codigo_persona_conyuge 
                                   from mks_socios.persona_conyuge pc
                                   where pc.codigo_persona = p.codigo
                                   and pc.firma = 'S'
                                   and pc.eliminado = 'N'))                                 "NOMBRES_CONY_GARANTE",
        (select p.identificacion 
         from mks_socios.persona p1
         where p1.codigo = (select pc.codigo_persona_conyuge 
                                   from mks_socios.persona_conyuge pc
                                   where pc.codigo_persona = p.codigo
                                   and pc.firma = 'S'
                                   and pc.eliminado = 'N'))                                 "CEDULA_CONY_GARANTE",
         (select DECODE (pn.codigo_estado_civil, 2, '1', 1, '2', pn.codigo_estado_civil)
          from mks_socios.persona_natural pn 
          where pn.codigo_persona = p.codigo)                                                "ESTADO_CIVIL_GARANTE",
          3                                                                                  "CODIGO_USUARIO",
          gc.fecha_registro                                                                  "FECHA_HORA_SISTEMA",
          'SERVER'                                                                           "TERMINAL"
from 
    mks_socios.persona p,
    mks_creditos.garante_credito gc
where gc.codigo_persona = p.codigo
order by gc.numero_credito asc;

-- garentes 2
select gc.numero_credito "NRO CREDITO",
       sol.codigo_socio "COD. SOCIO",
       p.identificacion "IDENTIFICACION GARANTE",
       p.nombre_completo "NOMBRES GARANTES",
       decode(p.identificacion, '0104320841', 'F', '0101314154', 'M',(select pn.sexo from mks_socios.persona_natural pn 
       where pn.codigo_persona = gc.codigo_persona)) "GENERO GARANTE",
       (select pn.codigo_estado_civil 
        from mks_socios.persona_natural pn
        where pn.codigo_persona = gc.codigo_persona) "ESTADO CIVIL",
       nvl((select /*SUBSTRB(ub.codigo_oc, 2, length(ub.codigo_oc))*/ ub.codigo_oc
       from mks_socios.persona_natural pn,
            mks_comunes.ubicacion_geografica ub
       where pn.codigo_persona = gc.codigo_persona
       and ub.codigo = pn.codigo_ubi_geo_nac),'01010150') "LUGAR NACIMIENTO",
       NVL((select ub.codigo_oc
        from mks_socios.persona_residencia pr,
             mks_comunes.ubicacion_geografica ub
        where pr.codigo_persona = gc.codigo_persona
        and ub.codigo = pr.codigo_ubi_geo_res), '01010150') "LUGAR RESIDENCIA",
       nvl((select pt.numero 
        from mks_socios.persona_telefono pt 
        where pt.codigo_persona = gc.codigo_persona
        and pt.codigo_tipo_telefono = 1
        and pt.eliminado = 'N'
        and rownum = 1), 'N/D') "TELF. CONVENCIONAL",
       nvl((select pt.numero 
        from mks_socios.persona_telefono pt 
        where pt.codigo_persona = gc.codigo_persona
        and pt.codigo_tipo_telefono = 2
        and pt.eliminado = 'N'
        and rownum = 1), 'N/D') "TELF. CELULAR",
        (select p.identificacion
         from mks_socios.persona p,
             mks_socios.persona_conyuge py
        where p.codigo = py.codigo_persona_conyuge 
        and py.codigo_persona = gc.codigo_persona
        and py.eliminado = 'N') "CEDULA CONY GARANTE",
        (select p.nombre_completo
         from mks_socios.persona p,
             mks_socios.persona_conyuge py
        where p.codigo = py.codigo_persona_conyuge 
        and py.codigo_persona = gc.codigo_persona
        and py.eliminado = 'N') "NOMB. CONY GARANTE",
        (select pn.sexo 
         from mks_socios.persona_natural pn,
              mks_socios.persona_conyuge py
              where py.codigo_persona_conyuge = pn.codigo_persona
              and py.codigo_persona = gc.codigo_persona 
              and py.eliminado = 'N') "GENERO GARANTE"
from 
     mks_socios.persona p,
     mks_creditos.garante_credito gc,
     mks_creditos.solicitud sol
where gc.codigo_persona = p.codigo
and gc.numero_credito = sol.numero
order by gc.numero_credito asc

-- garantes direcciones
select 1                                      "CODIGO_EMPRESA",
       (select sol.codigo_socio 
        from mks_creditos.solicitud sol 
        where sol.numero = gc.numero_credito) "CODIGO_SOCIO",
        (select ub.codigo_oc
        from mks_socios.persona_residencia pr,
             mks_comunes.ubicacion_geografica ub
        where pr.codigo_persona = gc.codigo_persona
        and ub.codigo = pr.codigo_ubi_geo_res) "GARA_LUGAR_DIR",
        NVL((select pr.direccion
        from mks_socios.persona_residencia pr
        where pr.codigo_persona = gc.codigo_persona), 'S/D') "GARA_CALLE_PRIN",
        'S/D'                                         "GARA_CALLE_SECU",
        'S/N'                                         "GARA_NUMEROCASA",
        (select UPPER(sec.nombre)
        from mks_socios.persona_residencia pr,
             mks_socios.sector sec
        where pr.codigo_persona = gc.codigo_persona
        and sec.codigo = pr.codigo_sector)            "GARA_SECTOR",
        (select pt.numero 
         from mks_socios.persona_telefono pt 
         where pt.codigo_persona = gc.codigo_persona
         and pt.eliminado = 'N'
         and rownum = 1)                              "GARA_TELEFONOS",
         (select tv.codigo_oc 
          from mks_socios.persona_residencia pr,
               mks_socios.tipo_vivienda tv
          where pr.codigo_persona = gc.codigo_persona
          and pr.codigo_tipo_vivienda = tv.codigo)"CODIGO_RESIDENCIA",
          sysdate                                     "FECHA_INGRESO",
          (select pr.tiempo
           from mks_socios.persona_residencia pr
           where pr.codigo_persona = gc.codigo_persona) "TIEMPO_RESIDENCIA",
          (select substr(pe.siglas, 1,1)
           from mks_socios.persona_residencia pr,
                mks_comunes.periodicidad pe
           where pr.codigo_persona = gc.codigo_persona
           and pe.codigo = pr.codigo_periodicidad) "TIPO_TIEMPO",
           p.identificacion                        "NUMERO_ID_GARANTE",
           gc.codigo                               "NUM_REGISTRO",
       nvl((select s.codigo
        from mks_socios.socio s
        where s.codigo_persona = gc.codigo_persona), 0) "CODIGO_SOCIO_GARANTE"
from mks_socios.persona p, 
     mks_creditos.garante_credito gc
where gc.codigo_persona = p.codigo
order by gc.numero_credito asc;

----garantes actividad principal trabajos
select 1                                             "CODIGO_EMPRESA",
       (select ae.codigo_oc
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                              "ACTIVIDAD",
       (select pta.direccion
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                              "DIRECCION",
       (select pta.numero_telefonico
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                              "TELEFONO",
       (select c.nombre
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae,
             mks_socios.cargo c
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and c.codigo = pta.codigo_cargo
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                              "CARGO",
       (select TO_CHAR(pta.fecha_ingreso, 'dd/mm/yyyy')
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                              "FECHA_INGRESO",
       (select e.nombre
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae,
             mks_comunes.empresa e
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and e.codigo = pta.codigo_empresa
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                                 "RAZON_SOCIAL",
       (select pta.tiempo
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                                 "TIEMPO_ACT_PRINCIPAL",
       (select substr(pe.siglas,1, 1)
        from mks_socios.persona_trabajo_act_eco pta,
             mks_socios.actividad_economica ae,
             mks_comunes.periodicidad pe
        where pta.codigo_actividad_economica = ae.codigo
        and pta.codigo_persona = gc.codigo_persona
        and pe.codigo = pta.codigo_periodicidad
        and ae.catalogo = 'S'
        and pta.eliminado = 'N'
        and rownum = 1)                                 "TIPO_TIEMPO",
        ''                                              "OBSERVACIONES",
        p.identificacion                                "NUMERO_ID_GARANTE",
        1                                               "NUM_REGISTRO"
from mks_socios.persona p, 
     mks_creditos.garante_credito gc
where gc.codigo_persona =  p.codigo
order by gc.numero_credito asc;


