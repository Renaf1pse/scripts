create or replace package body mks_estructuras.pkm_estructura_rotef is

  -- Realizado por: Santiago Araujo --
  -- Fecha: 11/08/2016 --
  -- FUNCION PARA OBTENER EL ORDENANTE/BENEFICIARIO/GARANTE --
  --FUNCTION f_obtiene_ord_ben_gar( pt_codigo_rotef_tipo_operacion IN mks_estructuras.rotef_tipo_operacion%TYPE,

  -- Realizado por: Santiago Araujo --
  -- Fecha: 15/08/2016 --
  -- FUNCION PARA DEVOLVER EL DATOS DEL BENEFINCIARIO PARA LE ROTEF --
  FUNCTION f_obtiene_ord_ben_gar( pt_codigo_rotef_tipo_operacion IN mks_estructuras.rotef_tipo_operacion.codigo%TYPE,
                                  pt_numero_movimiento IN MKS_CREDITOS.SOLICITUD_DETALLE.NUMERO_CREDITO%TYPE)
                                  RETURN VARCHAR2 IS
  BEGIN
    RETURN CASE WHEN pt_codigo_rotef_tipo_operacion = 1 THEN
                  '1'
                WHEN pt_codigo_rotef_tipo_operacion = 2 THEN
                  '2'
                WHEN pt_codigo_rotef_tipo_operacion = 3 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 4 THEN
                 mks_estructuras.pkm_estructura_rotef.f_obtiene_beneficiario(pt_numero_movimiento)
                WHEN pt_codigo_rotef_tipo_operacion = 5 THEN
                  'NOMBRE DEL ORDENANTE'
                WHEN pt_codigo_rotef_tipo_operacion = 6 THEN
                  mks_estructuras.pkm_estructura_rotef.f_obtiene_beneficiario(pt_numero_movimiento)
                WHEN pt_codigo_rotef_tipo_operacion = 8 THEN
                  'NOMBRE DE LA TARJETA DE CREDITO'
                WHEN pt_codigo_rotef_tipo_operacion = 11 THEN
                  NVL((mks_estructuras.pkm_estructura_rotef.f_obtiene_garante(pt_numero_movimiento)),'NO EXISTE GARANTE')
                WHEN pt_codigo_rotef_tipo_operacion = 12 THEN
                  mks_estructuras.pkm_estructura_rotef.f_obtiene_beneficiario(pt_numero_movimiento)
                WHEN pt_codigo_rotef_tipo_operacion = 13 THEN
                  NVL((mks_estructuras.pkm_estructura_rotef.f_obtiene_garante(pt_numero_movimiento)),'NO EXISTE GARANTE')
                WHEN pt_codigo_rotef_tipo_operacion = 23 THEN
                  NVL((mks_estructuras.pkm_estructura_rotef.f_obtiene_garante(pt_numero_movimiento)),'NO EXISTE GARANTE')
                WHEN pt_codigo_rotef_tipo_operacion = 24 THEN
                  '24'
                WHEN pt_codigo_rotef_tipo_operacion = 25 THEN
                  '25'
                WHEN pt_codigo_rotef_tipo_operacion = 26 THEN
                  'NOMBRE DEL BENEFICIARIO'
                WHEN pt_codigo_rotef_tipo_operacion = 27 THEN
                  'NOMBRE DEL ORDENANTE'
                ELSE NULL END;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error.';
  END f_obtiene_ord_ben_gar;
  -- FIN DE LA FUNCION PARA DEVOLVER EL DATOS DEL BENEFINCIARIO PARA LE ROTEF --

  -- Realizdo por: Wilman Rojas --
  -- Fecha: 15/12/2016 --
  -- FUNCION PARA DEVOLVER EL DATOS DEL PRIMER GARANTE --
  FUNCTION f_obtiene_garante( pt_numero_movimiento IN MKS_CREDITOS.SOLICITUD_DETALLE.CODIGO_MOVIMIENTO%TYPE)
                                  RETURN VARCHAR2 IS
           pt_nombre_garante mks_socios.persona.nombre_completo%TYPE;
  BEGIN
           SELECT n.nombre_completo INTO pt_nombre_garante
           FROM
                  (SELECT mc.codigo,pe.nombre_completo, sd.numero_credito, mc.fecha_movimiento FROM   mks_creditos.garante_credito gc,
                                 mks_socios.persona pe,
                                 MKS_CREDITOS.SOLICITUD_DETALLE sd,
                                 mks_ahorros.movimiento_cuenta mc
                  WHERE  gc.numero_credito = sd.numero_credito
                   AND    mc.codigo = sd.codigo_movimiento
                   AND    gc.codigo_persona = pe.codigo) n
           WHERE
                   n.codigo = pt_numero_movimiento
                   AND    ROWNUM <= 1;

     RETURN pt_nombre_garante;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'NO EXISTE GARANTE';

    WHEN OTHERS THEN
      RETURN 'Error.';
  END f_obtiene_garante;
  -- FIN DE LA FUNCION PARA DEVOLVER EL DATOS DEL PRIMER GARANTE --

  -- Realizdo por: Wilman Rojas --
  -- Fecha: 15/12/2016 --
  -- FUNCION PARA DEVOLVER EL DATOS DEL BENEFICIARIO --
  FUNCTION f_obtiene_beneficiario( pt_numero_movimiento IN MKS_CREDITOS.SOLICITUD_DETALLE.CODIGO_MOVIMIENTO%TYPE)
                                  RETURN VARCHAR2 IS
           pt_nombre_beneficiario mks_socios.persona.nombre_completo%TYPE;
  BEGIN
           SELECT n.nombre_completo
           INTO pt_nombre_beneficiario
           FROM (SELECT p.nombre_completo, mc.*
                 FROM mks_ahorros.cuenta c,
                      mks_socios.socio s,
                      mks_socios.persona p,
                      mks_ahorros.movimiento_cuenta mc
                 WHERE c.codigo_socio = s.codigo
                 AND s.codigo_persona = p.codigo
                 AND mc.codigo_cuenta = c.codigo) n
            WHERE n.codigo  = pt_numero_movimiento
            AND ROWNUM <=1;

     RETURN pt_nombre_beneficiario;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error.';
  END f_obtiene_beneficiario;
  -- FIN DE LA FUNCION PARA DEVOLVER EL DATOS DEL BENEFICIARIO --

  -- Realizado por: Santiago Araujo --
  -- Fecha: 15/08/2016 --
  -- FUNCION PARA OBTENER LA ENTIDNAD FINANCIERA DEL ORDENANTE O BENEFICIARIO --
  FUNCTION f_obtiene_entidad_fin_ord_ben( pt_codigo_rotef_tipo_operacion IN mks_estructuras.rotef_tipo_operacion.codigo%TYPE )
                                          RETURN VARCHAR2 IS
  BEGIN
    RETURN CASE WHEN pt_codigo_rotef_tipo_operacion = 1 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 2 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 3 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 4 THEN
                  'NOMBRE DE LA INST FIN DEL BENEFICIARIO'
                WHEN pt_codigo_rotef_tipo_operacion = 5 THEN
                  'NOMBRE DE LA INST FIN ORDENANTE'
                WHEN pt_codigo_rotef_tipo_operacion = 6 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 8 THEN
                  'NOMBRE DE LA INST FIN EMISORA DE LA TARJETA DE CREDITO'
                WHEN pt_codigo_rotef_tipo_operacion = 11 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 12 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 13 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 23 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 24 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 25 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 26 THEN
                  'NOMBRE DE LA INST FIN DEL BENEFICIARIO'
                WHEN pt_codigo_rotef_tipo_operacion = 27 THEN
                  'NOMBRE DE LA INST FIN ORDENANTE'
                ELSE NULL END;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error.';
  END f_obtiene_entidad_fin_ord_ben;
  -- FIN DE LA FUNCION PARA OBTENER LA ENTIDNAD FINANCIERA DEL ORDENANTE O BENEFICIARIO --

  -- Realizado por: Santiago Araujo --
  -- Fecha: 15/08/2016 --
  -- FUNCION PARA OBTENER LA CUENTA DEL ORDENANTE O EL BENEFICIARIO --
  FUNCTION f_obtiene_cuenta_ben_ord( pt_codigo_rotef_tipo_operacion IN mks_estructuras.rotef_tipo_operacion.codigo%TYPE )
                                     RETURN VARCHAR2 IS
  BEGIN
    RETURN CASE WHEN pt_codigo_rotef_tipo_operacion = 1 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 2 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 3 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 4 THEN
                  'NCUENTAINSTFINBENEF'
                WHEN pt_codigo_rotef_tipo_operacion = 5 THEN
                  'NCUENTAINSTFINORD'
                WHEN pt_codigo_rotef_tipo_operacion = 6 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 8 THEN
                  'NTARJETACREDITO'
                WHEN pt_codigo_rotef_tipo_operacion = 11 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 12 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 13 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 23 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 24 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 25 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 26 THEN
                  'NA'
                WHEN pt_codigo_rotef_tipo_operacion = 27 THEN
                  'NA'
                ELSE NULL END;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error.';
  END f_obtiene_cuenta_ben_ord;
  -- FIN DE LA FUNCION PARA OBTENER LA CUENTA DEL ORDENANTE O EL BENEFICIARIO --

  -- Realizdo por: Santiago Araujo --
  -- Fecha: 09/08/2016 --
  -- PROCEDIMINEOT PARA GENERAR LA ESTRUCTURA ROTEF --
  PROCEDURE p_genera( pt_codigo_ifip    IN  mks_ifips.ifip.codigo%TYPE,
                      pt_fecha_inicio   IN  mks_estructuras.rotef_cabecera.fecha_inicio%TYPE,
                      pt_fecha_fin      IN  mks_estructuras.rotef_cabecera.fecha_fin%TYPE,
                      pt_usuario_genera IN  mks_seguridades.usuario.codigo%TYPE,
                      pv_error_sql      OUT VARCHAR2,
                      pv_error_code     OUT VARCHAR2,
                      pv_error          OUT VARCHAR2 ) IS
    lt_codigo_institucion_fin  mks_estructuras.rotef_cabecera.codigo_institucion_financiera%TYPE;
    lt_tipo_identificacion_inf mks_estructuras.rotef_cabecera.tipo_identificacion_informante%TYPE;
    lt_ruc_informante          mks_estructuras.rotef_cabecera.ruc_informante%TYPE;
    lt_anio_periodo_informado  mks_estructuras.rotef_cabecera.anio_periodo_informado%TYPE;
    lt_mes_periodo_informado   mks_estructuras.rotef_cabecera.mes_periodo_informado%TYPE;
    lt_codigo_operativo        mks_estructuras.rotef_cabecera.codigo_operativo%TYPE;
    lt_codigo_rotef_cabecera   mks_estructuras.rotef_cabecera.codigo%TYPE;
    lt_estructura_xml          mks_estructuras.rotef_cabecera.estructura_xml%TYPE;
    lt_nombre_archivo_xml      mks_estructuras.rotef_cabecera.nombre_archivo_xml%TYPE;
  BEGIN

   --ELIMINA REGISTROS EXISTENTES DE LA ESTRUCTURA ROTEF
    mks_estructuras.pkm_estructura_rotef.p_eliminar_registros(pt_codigo_ifip, pt_fecha_inicio, pt_fecha_fin);
    -- OBTENER LA INFORMACION PARA LA CABECERA --
    mks_estructuras.pkm_estructura_rotef.p_obtiene_datos_cabecera( pt_codigo_ifip,
                                                                   pt_fecha_fin,
                                                                   lt_codigo_institucion_fin,
                                                                   lt_tipo_identificacion_inf,
                                                                   lt_ruc_informante,
                                                                   lt_anio_periodo_informado,
                                                                   lt_mes_periodo_informado,
                                                                   lt_codigo_operativo,
                                                                   pv_error_sql,
                                                                   pv_error_code,
                                                                   pv_error );
    IF pv_error IS NOT NULL THEN
      RETURN;
    END IF;
    -- INSERTAR LA CABECERA DE LA ESTRUCTURA --
    mks_estructuras.pkg_rotef_cabecera.p_inserta( pt_codigo_ifip,
                                                  lt_codigo_institucion_fin,
                                                  lt_tipo_identificacion_inf,
                                                  lt_ruc_informante,
                                                  lt_anio_periodo_informado,
                                                  lt_mes_periodo_informado,
                                                  lt_codigo_operativo,
                                                  pt_fecha_inicio,
                                                  pt_fecha_fin,
                                                  pt_usuario_genera,
                                                  NULL, -- estructura_xml --
                                                  NULL, -- nombre_archivo_xml --
                                                  'N',  -- eliminado --
                                                  lt_codigo_rotef_cabecera,
                                                  pv_error_sql,
                                                  pv_error_code,
                                                  pv_error );
    IF pv_error IS NOT NULL THEN
      RETURN;
    END IF;
    -- INSERTAR EL DETALLE DE LA ESTRCUTURA --
    mks_estructuras.pkm_estructura_rotef.p_inserta_detalle_rotef( lt_codigo_rotef_cabecera,
                                                                  pt_fecha_inicio,
                                                                  pt_fecha_fin,
                                                                  5000,--pn_monto,
                                                                  pv_error_sql,
                                                                  pv_error_code,
                                                                  pv_error );
    IF pv_error IS NOT NULL THEN
      RETURN;
    END IF;

    --ELIMINA CARACTERES ESPECIALES
    mks_estructuras.pkm_estructura_rotef.p_eliminar_caracteres;


    -- GENERAR EL ARCHIVO XML --
    mks_estructuras.pkm_estructura_rotef.p_genera_xml( lt_codigo_rotef_cabecera,
                                                       lt_estructura_xml,
                                                       pv_error_sql,
                                                       pv_error_code,
                                                       pv_error );
    IF pv_error IS NOT NULL THEN
      RETURN;
    END IF;
    -- GENEAR EL NOMBRE DEL ARCHIVO XML --
    lt_nombre_archivo_xml := 'nombre_archivo_'||TO_CHAR(pt_fecha_fin,'DDMMYYYY')||'.xml';
    -- ACTUALIAR LA ESTRUCTURA --
    mks_estructuras.pkg_rotef_cabecera.p_actualiza_xml_nom_arc( lt_codigo_rotef_cabecera,
                                                                lt_estructura_xml,
                                                                lt_nombre_archivo_xml,
                                                                pv_error_sql,
                                                                pv_error_code,
                                                                pv_error );
    IF pv_error IS NOT NULL THEN
      RETURN;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      pv_error := 'Error al generar la estructura Rotef.';
      pv_error_sql := SQLERRM;
      pv_error_code := SQLCODE;
  END p_genera;
  -- FIN DEL PROCEDIMINEOT PARA GENERAR LA ESTRUCTURA ROTEF --

   -- Realizdo por: Wilman Rojas --
  -- Fecha: 14/12/2016 --
  -- Actualizado por: Miguel Vélez 
  -- Fecha: 20/03/2024 --
  -- PROCEDIMIENTO PARA ELIMINAR ESTRUCTURA ROTEF --
  PROCEDURE p_eliminar_registros( pt_codigo_ifip    IN  mks_ifips.ifip.codigo%TYPE,
                                  pt_fecha_inicio IN  DATE,
                                  pt_fecha_fin IN DATE) IS

  BEGIN


  DELETE mks_estructuras.rotef_detalle_2024 detalle where detalle.codigo_rotef_cabecera in (select cabecera.codigo FROM mks_estructuras.rotef_cabecera cabecera where cabecera.fecha_inicio = pt_fecha_inicio and cabecera.fecha_fin = pt_fecha_fin) ;
  DELETE mks_estructuras.tmp_rotef_creditos;
  DELETE (select * FROM mks_estructuras.rotef_cabecera cabecera where cabecera.fecha_inicio = pt_fecha_inicio and cabecera.fecha_fin = pt_fecha_fin AND cabecera.eliminado = 'N');
  COMMIT;
  
  END;
  -- FIN DEL PROCEDIMIENTO PARA ELIMINAR ESTRUCTURA ROTEF --

     -- Realizdo por: Wilman Rojas --
  -- Fecha: 24/04/2017 --
    -- Actualizado por: Miguel Vélez por actualización de la ROTEF 2024
    -- Fecha: 20/03/2024 --
  -- PROCEDIMIENTO PARA ELIMINAR CARACTERES ESPECIALES (?) ROTEF --
        
  PROCEDURE p_eliminar_caracteres IS
  BEGIN
            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'Ñ','N')                
            where t.razon_social like '%Ñ%';

            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'Á','A')
            where t.razon_social like '%Á%';

            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'É','E')
            where t.razon_social like '%É%';

            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'Í','I')
            where t.razon_social like '%Í%';

            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'Ó','O')
            where t.razon_social like '%Ó%';

            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'Ú','U')
            where t.razon_social like '%Ú%';

            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'Ú','U')
            where t.razon_social like '%Ú%';

            update mks_estructuras.rotef_detalle_2024 t
            set t.razon_social=replace(t.razon_social,'/','')
            where t.razon_social like '%/%';
  END;
  -- FIN DEL PROCEDIMIENTO PARA ELIMINAR CARACTERES ESPECIALES (?) ROTEF --

  -- Realizado por: Santiago Araujo --
  -- Fecha: 09/08/2016 --
  -- PROCDIMIENTO PARA OBTENER LOS DATOS DE LA CABECERA DE LA ESTRUCTURA --
  PROCEDURE p_obtiene_datos_cabecera( pt_codigo_ifip             IN  mks_estructuras.rotef_cabecera.codigo_ifip%TYPE,
                                      pt_fecha_fin               IN  mks_estructuras.rotef_cabecera.fecha_fin%TYPE,
                                      pt_codigo_institucion_fin  OUT mks_estructuras.rotef_cabecera.codigo_institucion_financiera%TYPE,
                                      pt_tipo_identificacion_inf OUT mks_estructuras.rotef_cabecera.tipo_identificacion_informante%TYPE,
                                      pt_ruc_informante          OUT mks_estructuras.rotef_cabecera.ruc_informante%TYPE,
                                      pt_anio_periodo_informado  OUT mks_estructuras.rotef_cabecera.anio_periodo_informado%TYPE,
                                      pt_mes_periodo_informado   OUT mks_estructuras.rotef_cabecera.mes_periodo_informado%TYPE,
                                      pt_codigo_operativo        OUT mks_estructuras.rotef_cabecera.codigo_operativo%TYPE,
                                      pv_error_sql               OUT VARCHAR2,
                                      pv_error_code              OUT VARCHAR2,
                                      pv_error                   OUT VARCHAR2 ) IS
  BEGIN
    -- OBTENER EL CODIGO DE LA INSTITUCION FINANCIERA --
    pt_codigo_institucion_fin := '4385';
    -- OBTENER EL CODIGO DEL TIPO DE IDENTIFICACION DEL INFORMANTE --
    pt_tipo_identificacion_inf := 'R';
    -- OBTENER EL RUC DEL INFORMANTE --
    mks_ifips.pkg_ifips.p_obtiene_ruc( pt_codigo_ifip,
                                       pt_ruc_informante,
                                       pv_error_sql,
                                       pv_error_code,
                                       pv_error );
    IF pv_error IS NOT NULL THEN
      RETURN;
    END IF;
    -- OBTENER EL ANIO DEL PERIODO INFORMADO --
    pt_anio_periodo_informado := TO_CHAR(pt_fecha_fin,'YYYY');
    -- OBTENER EL MES DEL PERIODO INFORMADO --
    BEGIN
      SELECT TO_NUMBER(TO_CHAR(pt_fecha_fin,'MM'))
      INTO   pt_mes_periodo_informado
      FROM   dual;
    EXCEPTION
      WHEN OTHERS THEN
        pv_error := 'Error al obtener el mes del periodo informado.';
        pv_error_sql := SQLERRM;
        pv_error_code := SQLCODE;
    END;
    -- OBTENER EL CODIGO OPERATIVO --
    pt_codigo_operativo := 'RTF';
  EXCEPTION
    WHEN OTHERS THEN
      pv_error := 'Error al obtener los datos para la cabecera de la estructura rotef.';
      pv_error_sql := SQLERRM;
      pv_error_code := SQLCODE;
  END p_obtiene_datos_cabecera;
  -- FIN DEL PROCDIMIENTO PARA OBTENER LOS DATOS DE LA CABECERA DE LA ESTRUCTURA --

  -- Realizado por: Santiago Araujo --
  -- Fecha: 09/08/2016 --
  -- PROCEDIMIENTO PARA INSERTAR EL DETALLE DE LA ESTRUCTURA DEL ROTEF --
  PROCEDURE p_inserta_detalle_rotef( pt_codigo_rotef_cabecera IN  mks_estructuras.rotef_cabecera.codigo%TYPE,
                                     pt_fecha_inicio          IN  mks_estructuras.rotef_cabecera.fecha_inicio%TYPE,
                                     pt_fecha_fin             IN  mks_estructuras.rotef_cabecera.fecha_fin%TYPE,
                                     pn_monto                 IN  NUMBER,
                                     pv_error_sql             OUT VARCHAR2,
                                     pv_error_code            OUT VARCHAR2,
                                     pv_error                 OUT VARCHAR2 ) IS
  BEGIN

      -- Creado por: Miguel Vélez --
      -- Fecha: 20/03/2024 --
BEGIN
  --INSERTAR DATOS DE CREDITO EN TABLA TEMPORAL--
INSERT INTO mks_estructuras.tmp_rotef_creditos
    select tc.numero_credito,
              SUM(DECODE(tc.codigo_tipo_maduracion,'V',tc.capital,0)) total_x_vencer,
              SUM(DECODE(tc.codigo_tipo_maduracion,'D',tc.capital,0)) total_no_devenga,
              SUM(DECODE(tc.codigo_tipo_maduracion,'N',tc.capital,0)) total_vencida,
              SUM(tc.interes)                                         interes_ordinario,
              SUM(tc.mora)                                            interes_mora,
              MAX(tc.dias_mora)                                       dias_mora,
              SUM(DECODE(tc.codigo_tipo_maduracion,'S',tc.capital,0)) total_castigada
         from mks_historicos.tablas_creditos tc,
              (SELECT tc.numero_credito,       
               max(tc.fecha) fecha
               FROM mks_historicos.tablas_creditos tc
               where trunc(tc.fecha) = pt_fecha_fin--BETWEEN pt_fecha_inicio AND pt_fecha_fin
               group by tc.numero_credito)t1
         where t1.numero_credito = tc.numero_credito
         and trunc(t1.fecha) = trunc(tc.fecha)
         group by tc.numero_credito
         order by tc.numero_credito;
         EXCEPTION
      WHEN OTHERS THEN
        pv_error := 'Error al insertar las concesiones de credito.';
        pv_error_sql := SQLERRM;
        pv_error_code := SQLCODE;
        RETURN;
        END; 
            -- INSERTAR EL DETALLE DE LA PARTE TRANSACCIONAL --       
    BEGIN
      INSERT INTO mks_estructuras.rotef_detalle_2024
      SELECT mks_estructuras.seq_rotef_detalle.nextval,
             pt_codigo_rotef_cabecera,
             x.*
      FROM  
        (select (select ti.siglas 
        from mks_socios.tipo_identificacion ti
        where ti.codigo = p.codigo_tipo_identificacion) "TIPO IDENTIFICACION",
       p.identificacion                                 "IDENTIFICACION",
       p.nombre_completo                                "NOMBRE / RAZON SOCIAL",
       CASE
        WHEN p.codigo_tipo_persona = 1 THEN
        (SELECT rp.codigo
           FROM mks_socios.persona_natural pn,
                mks_estructuras.rotef_pais rp
          WHERE pn.codigo_persona = p.codigo
            AND rp.codigo_ubicacion_geografica =
                mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1))
        WHEN p.codigo_tipo_persona = 2 THEN
        (SELECT rp.codigo
           FROM mks_socios.persona_residencia pn,
                mks_estructuras.rotef_pais rp
          WHERE pn.codigo_persona = p.codigo
            AND rp.codigo_ubicacion_geografica =
                mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pn.codigo_ubi_geo_res,1 /*PAIS*/))
     END pais_nacionalidad,
   CASE 
     when p.codigo_tipo_persona = 2 then
       (SELECT rp.codigo
           FROM mks_socios.persona_residencia pn,
                mks_estructuras.rotef_provincia rp
          WHERE pn.codigo_persona = p.codigo
            AND rp.codigo_ubicacion_geografica =
                mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pn.codigo_ubi_geo_res,2 ))
      WHEN p.codigo_tipo_persona = 1
        and (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1)) = '593'
        THEN
    NVL(( SELECT rp.codigo
      FROM   mks_estructuras.rotef_provincia rp
      WHERE  rp.codigo_ubicacion_geografica = mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel( pr.codigo_ubi_geo_res,
                                                                                                                  2 ) ),'NA')
       ELSE '000' 
        END provincia,
   CASE when p.codigo_tipo_persona = 2 then
       (SELECT rp.codigo
           FROM mks_socios.persona_residencia pn,
                mks_estructuras.rotef_canton rp
          WHERE pn.codigo_persona = p.codigo
            AND rp.codigo_ubicacion_geografica =
                mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pn.codigo_ubi_geo_res,3 ))
      WHEN p.codigo_tipo_persona = 1
        and (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci,pn.codigo_ubi_geo_nac),1)) = '593'
        THEN
    NVL(( SELECT rp.codigo
      FROM   mks_estructuras.rotef_canton rp
      WHERE  rp.codigo_ubicacion_geografica = mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel( pr.codigo_ubi_geo_res,
                                                                                                                  3 /*CANTON*/ ) ),'NA')
       ELSE '00000' 
        END canton,
       'AHO'                                                              "TIPO PRODUCTO",
       c.numero                                         "NUMERO CUENTA",
       NVL((SELECT sc.saldo_total 
        FROM mks_historicos.saldos_cuenta sc
        WHERE sc.codigo_cuenta = c.codigo
        AND TRUNC(sc.fecha_saldo) = TRUNC(pt_fecha_inicio -1)), 0) "SALDO INICIAL",
        x.total_credito,
        x.numero_credito "NUM. OPE. CRED",
        x.total_debito,
        x.numero_debito "NUM. OPE. DEB",
       NVL((SELECT sc.saldo_total 
        FROM mks_historicos.saldos_cuenta sc
        WHERE sc.codigo_cuenta = c.codigo
        AND TRUNC(sc.fecha_saldo) = TRUNC(pt_fecha_fin)), 0) "SALDO FINAL",  
        0                                                           "DIAS_MORA",
        'N/A'                                                       "TIPO_CREDITO",
        'X'                                                       "ESTADO_CREDITO",
        0                                                           "TOTAL_X_VENCER",
        0                                                           "TOTAL_NO_DEVENGA",
        0                                                           "TOTAL_VENCIDA",
        0                                                           "RECUP_CARTERA_VENCIDA_CASTI",
        0                                                           "INTERES_ORDINARIO",
        0                                                           "INTERES_MORA",
        0                                                           "JUDICIAL",
        0                                                           "CARTERA_CASTIGADA",
       (SELECT rm.codigo
        FROM   mks_estructuras.rotef_moneda rm
        WHERE  rm.codigo_moneda = x.codigo_moneda )                 "MONEDA"       
from ( WITH movimientos AS ( SELECT mc.codigo_cuenta,                                                     
                                    ct.codigo_transaccion,
                                    mc.codigo_moneda,
                                   sum(mc.total_movimiento) total_movimiento,    
                                   CASE
                                     WHEN mc.tipo = 'C' THEN SUM(mc.total_movimiento)
                                       ELSE 0
                                   END total_credito,
                                   CASE
                                     WHEN mc.tipo = 'D' THEN SUM(mc.total_movimiento)  
                                       ELSE 0
                                   END total_debito,
                                   CASE
                                     WHEN mc.tipo = 'C' THEN COUNT(mc.total_movimiento)
                                       ELSE 0
                                   END numero_credito,
                                   CASE
                                     WHEN mc.tipo = 'D' THEN COUNT(mc.total_movimiento)  
                                       ELSE 0
                                   END numero_debito                                   
                             FROM mks_ahorros.movimiento_cuenta mc,
                                  mks_ahorros.concepto_transaccion ct
                            WHERE mc.codigo_concepto=ct.codigo
                            AND  mc.fecha_movimiento BETWEEN pt_fecha_inicio AND pt_fecha_fin
                            GROUP BY mc.codigo_cuenta,                                                     
                            ct.codigo_transaccion,
                            mc.tipo,
                            mc.codigo_moneda)
                        SELECT c.codigo codigo_cuenta,
                               rp.codigo codigo_producto,
                               m.codigo_moneda,
                               SUM(m.total_credito) total_credito,
                               SUM(m.numero_credito) numero_credito,
                               SUM(m.total_debito) total_debito,
                               SUM(m.numero_debito) numero_debito
                        FROM   mks_estructuras.rotef_producto rp,
                               mks_ahorros.cuenta c,                               
                               movimientos m
                        WHERE  rp.codigo_tipo_prouducto = c.codigo_tipo_producto
                        AND    m.codigo_cuenta = c.codigo                   
                        GROUP BY c.codigo,
                                 rp.codigo,                                 
                                 m.codigo_moneda                                 
                        HAVING (SUM(m.total_credito) >= pn_monto 
                                OR SUM(m.total_debito) >= pn_monto )  )x,
                     mks_ahorros.cuenta c,
                     mks_socios.socio s,
                     mks_socios.persona p,
                     mks_socios.persona_residencia pr
                where c.codigo_socio = s.codigo
                and s.codigo_persona = p.codigo
                and p.codigo = pr.codigo_persona
                and x.codigo_cuenta = c.codigo
                order by 2)x;
    EXCEPTION
      WHEN OTHERS THEN
        pv_error := 'Error al insertar de la parte transaccional.';
        pv_error_sql := SQLERRM;
        pv_error_code := SQLCODE;
        RETURN;
    END;
    -- INSERTAR LAS CONCESIONES DE CREDITO --
    BEGIN
      INSERT INTO mks_estructuras.rotef_detalle_2024
      SELECT mks_estructuras.seq_rotef_detalle.nextval,
             pt_codigo_rotef_cabecera,
             x.*
      FROM   (select (select ti.siglas 
        from mks_socios.tipo_identificacion ti
        where ti.codigo = p.codigo_tipo_identificacion) "TIPO_IDENTIFICACION_CLIENTE",
        p.identificacion                                "IDENTIFICACION_CLIENTE",
        p.nombre_completo                               "RAZON_SOCIAL/NOMBRE_CLIENTE",
         CASE
           WHEN p.codigo_tipo_persona = 1 THEN
        (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1))
             WHEN p.codigo_tipo_persona = 2 THEN
              (SELECT rp.codigo 
                 FROM mks_socios.persona_residencia pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pn.codigo_ubi_geo_res,1 ))
           END                                                                                                   "PAIS_NACIONALIDAD",
           CASE 
      WHEN (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1)) = '593'
        THEN
    NVL(( SELECT rp.codigo
      FROM   mks_estructuras.rotef_provincia rp
      WHERE  rp.codigo_ubicacion_geografica = mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel( pr.codigo_ubi_geo_res,
                                                                                                                  2  ) ),'NA')
       ELSE '000' 
        END "PROVINCIA",
            CASE 
      WHEN (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1)) = '593'
        THEN
    NVL(( SELECT rp.codigo
      FROM   mks_estructuras.rotef_canton rp
      WHERE  rp.codigo_ubicacion_geografica = mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel( pr.codigo_ubi_geo_res,
                                                                                                                  3 /*CANTON*/ ) ),'NA')
       ELSE '00000' 
        END "CANTON",
            'PRE'                                                                                                                   "TIPO_PRODUCTO",
            'N/A'                                                                                                                   "NUM_CUENTA",
            0                                                                                                                       "SALDO_INICIAL",
            0                                                                                                                       "TOTAL_CREDITO",
            0                                                                                                                       "NUM. OPE. CRED",
            0                                                                                                                       "TOTAL_DEBITO",
            0                                                                                                                       "NUM. OPE. DEB",
            0                                                                                                                       "SALDO_FINAL",
          sum(rec.dias_mora)                                                                                                        "DIAS_MORA",
          CASE WHEN pt_fecha_fin < to_date('01/04/2024','dd/mm/yyyy')
            THEN (CASE WHEN tic.codigo = 9 
              THEN (CASE WHEN ((SELECT sfc.total_ingresos_socio
                            FROM mks_socios.socio_flujo_caja sfc
                            WHERE sfc.codigo_socio = s.codigo)*12) <= 1000 THEN 'MM'
                      WHEN ((SELECT sfc.total_ingresos_socio
                            FROM mks_socios.socio_flujo_caja sfc
                            WHERE sfc.codigo_socio = s.codigo )*12) BETWEEN 1000.01 AND 10000 THEN 'MS'
                      WHEN ((SELECT sfc.total_ingresos_socio
                            FROM mks_socios.socio_flujo_caja sfc
                            WHERE sfc.codigo_socio = s.codigo)*12) BETWEEN 10000.01 AND 100000 THEN 'MA' ELSE 'XX'
                      END) ELSE tic.codigo_oc END) 
           ELSE 
             (CASE WHEN tic.codigo = 9 THEN
               (CASE WHEN ((SELECT sfc.total_ingresos_socio
                            FROM mks_socios.socio_flujo_caja sfc
                            WHERE sfc.codigo_socio = s.codigo)*12) <= 20000 THEN 'MM'
                     WHEN ((SELECT sfc.total_ingresos_socio
                            FROM mks_socios.socio_flujo_caja sfc
                            WHERE sfc.codigo_socio = s.codigo )*12) BETWEEN 20000.01 AND 120000 THEN 'MS'
                     WHEN ((SELECT sfc.total_ingresos_socio
                            FROM mks_socios.socio_flujo_caja sfc
                            WHERE sfc.codigo_socio = s.codigo)*12) BETWEEN 120000.01 AND 320000 THEN 'MA' ELSE 'XX'
                  END) ELSE tic.codigo_oc END) 
                   END                                                                                                                  "TIPO_CREDITO",
          'N'                                                                                                                       "ESTADO_CREDITO",
          SUM(rec.total_x_vencer)                                                                                                   "TOTAL_X_VENCER",
          SUM(rec.total_no_devenga)                                                                                                 "TOTAL_NO_DEVENGA",
          SUM(rec.total_vencida)                                                                                                    "TOTAL_VENCIDA",
          SUM(rec.recuperacion)   "GAST_RECU_CARTERA",
          SUM(rec.interes_ordinario)                                                                                                "INTERES_ORDINARIO",
          SUM(rec.interes_mora)                                                                                                     "INTERES_MORA",
          SUM(rec.judicial)                                                                                "JUDICIAL",
          SUM(rec.total_castigada)                                                                                                  "CARTERA_CASTIGADA",
         (SELECT rm.codigo
           FROM  mks_estructuras.rotef_moneda rm
           WHERE rm.codigo_moneda = so.codigo_moneda)                                                                               "MONEDA"    
from mks_creditos.solicitud so,
     mks_socios.persona p,
     mks_socios.persona_residencia pr,
     mks_socios.socio s,
     mks_creditos.tipo_cartera tic,
     mks_creditos.producto_credito pcr,
    (SELECT re.*,
            NVL((select sd.total_costo_judicial 
            from mks_creditos.solicitud_detalle sd 
            where sd.numero_credito = re.numero_credito),0) recuperacion,
            (case when re.Total_Castigada > 0 then mks_creditos.f_saldo_demandado_credito(re.numero_credito,
                                                                   1,--so.codigo_ifip,
                                                                   pt_fecha_fin) 
                      when mks_creditos.f_valor_judicial_credito(re.numero_credito,
                                                                   1,--so.codigo_ifip,
                                                                   pt_fecha_fin) > 0 then mks_creditos.f_saldo_demandado_credito(re.numero_credito,
                                                                   1,--so.codigo_ifip,
                                                                   pt_fecha_fin) else 0
                    end ) judicial 
     FROM mks_estructuras.tmp_rotef_creditos re) rec
where so.codigo_socio = s.codigo
and s.codigo_persona = p.codigo
and p.codigo = pr.codigo_persona
and so.numero = rec.numero_credito
and so.codigo_producto = pcr.codigo
and pcr.codigo_tipo_cartera = tic.codigo
GROUP BY p.codigo_tipo_identificacion, 
         p.identificacion, 
         p.nombre_completo, 
         p.codigo_tipo_persona, 
         p.codigo, 
         pr.codigo_ubi_geo_res,          
         so.codigo_moneda,
         so.codigo_ifip,
         s.codigo,
         tic.codigo_oc,
         tic.codigo) x;
    EXCEPTION
      WHEN OTHERS THEN
        pv_error := 'Error al insertar las concesiones de credito.';
        pv_error_sql := SQLERRM;
        pv_error_code := SQLCODE;
        RETURN;
    END;
    -- INSERTAR DE CONTRATACION Y CANCELACION DE INVERSIONES --
    BEGIN
      INSERT INTO mks_estructuras.rotef_detalle_2024 
      SELECT mks_estructuras.seq_rotef_detalle.nextval,
             pt_codigo_rotef_cabecera,
             x.*
      FROM   (select (select ti.siglas 
        from mks_socios.tipo_identificacion ti
        where ti.codigo = p.codigo_tipo_identificacion) "TIPO_IDENTIFICACION_CLIENTE",
        p.identificacion                                "IDENTIFICACION_CLIENTE",
        p.nombre_completo                               "RAZON_SOCIAL/NOMBRE_CLIENTE",
         CASE
           WHEN p.codigo_tipo_persona = 1 THEN
        (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1))
             WHEN p.codigo_tipo_persona = 2 THEN
              (SELECT rp.codigo
                 FROM mks_socios.persona_residencia pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pn.codigo_ubi_geo_res, 1 /*PAIS*/))
           END                                                                                                   "PAIS_NACIONALIDAD",
           CASE when p.codigo_tipo_persona = 2 then
       (SELECT rp.codigo
           FROM mks_socios.persona_residencia pn,
                mks_estructuras.rotef_provincia rp
          WHERE pn.codigo_persona = p.codigo
            AND rp.codigo_ubicacion_geografica =
                mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pn.codigo_ubi_geo_res,2 ))
      WHEN p.codigo_tipo_persona = 1
        and (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1)) = '593'
        THEN
    NVL(( SELECT rp.codigo
      FROM   mks_estructuras.rotef_provincia rp
      WHERE  rp.codigo_ubicacion_geografica = mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel( pr.codigo_ubi_geo_res,
                                                                                                                  2  ) ),'NA')
       ELSE '000' 
        END "PROVINCIA",
           CASE when p.codigo_tipo_persona = 2 then
       (SELECT rp.codigo
           FROM mks_socios.persona_residencia pn,
                mks_estructuras.Rotef_Canton rp
          WHERE pn.codigo_persona = p.codigo
            AND rp.codigo_ubicacion_geografica =
                mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pn.codigo_ubi_geo_res,3 ))
      WHEN p.codigo_tipo_persona = 1
        and (SELECT rp.codigo
                 FROM mks_socios.persona_natural pn,
                      mks_estructuras.rotef_pais rp
                WHERE pn.codigo_persona = p.codigo
                  AND rp.codigo_ubicacion_geografica =
                      mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(NVL(pn.codigo_ubi_geo_naci, pn.codigo_ubi_geo_nac),1)) = '593'
        THEN 
            NVL(( SELECT rp.codigo
              FROM   mks_estructuras.rotef_canton rp
              WHERE  rp.codigo_ubicacion_geografica = mks_comunes.pkg_ubicacion_geografica.f_obtiene_ubicacion_por_nivel(pr.codigo_ubi_geo_res,
                                                                                                                                    3  ) ),'NA') 
              ELSE '00000' END                                                                                                      "CANTON",
             'INV'                                                                                                                   "TIPO_PRODUCTO",
             'N/A'                                                                                                                   "NUM_CUENTA",
             0                                                                                                                       "SALDO_INICIAL",
             0                                                                                                                       "TOTAL_CREDITO",
             0                                                                                                                       "NUM. OPE. CRED",
             0                                                                                                                       "TOTAL_DEBITO",
             0                                                                                                                       "NUM. OPE. DEB",                                                                                                                                                 
            SUM(cd.capital)                                                                                                          "CAPITAL INVERSION",
              0                                                           "DIAS_MORA",
              'N/A'                                                       "TIPO_CREDITO",
              'X'                                                       "ESTADO_CREDITO",
              0                                                           "TOTAL_X_VENCER",
              0                                                           "TOTAL_NO_DEVENGA",
              0                                                           "TOTAL_VENCIDA",
              0                                                           "RECUP_CARTERA_VENCIDA_CASTI",
              0                                                           "INTERES_ORDINARIO",
              0                                                           "INTERES_MORA",
              0                                                           "JUDICIAL",
              0                                                           "CARTERA_CASTIGADA",
           (SELECT rm.codigo
             FROM   mks_estructuras.rotef_moneda rm
             WHERE  rm.codigo_moneda = cd.codigo_moneda)                                                                          "MONEDA" 
                      
from (select sd.codigo_contrato_dpf contrato, max(sd.fecha) fecha
      from mks_historicos.saldo_dpf sd
      where sd.estado = 'V'
      and trunc(sd.fecha) = pt_fecha_fin--BETWEEN pt_fecha_inicio AND pt_fecha_fin
      group by sd.codigo_contrato_dpf) pv,
     mks_dpfs.contrato_dpf cd,
     mks_socios.persona p,
     mks_socios.persona_residencia pr
where cd.codigo_persona = p.codigo
AND p.codigo = pr.codigo_persona
AND cd.codigo = pv.contrato 
GROUP BY p.codigo_tipo_identificacion,
         p.identificacion,
         p.nombre_completo,
         p.codigo_tipo_persona,
         p.codigo,
         pr.codigo_ubi_geo_res,
         cd.codigo_moneda
HAVING (SUM(cd.capital) >= pn_monto)
ORDER BY 2) x;
    EXCEPTION
      WHEN OTHERS THEN
        pv_error := 'Error al insertar la contratacion y cancelacion de inversiones.';
        pv_error_sql := SQLERRM;
        pv_error_code := SQLCODE;
        RETURN;
    END;
        
  EXCEPTION
    WHEN OTHERS THEN
      pv_error := 'Errro al insertar el detalle de la estructura Rotef.';
      pv_error_sql := SQLERRM;
      pv_error_code := SQLCODE;
  END p_inserta_detalle_rotef;
  -- FIN DEL PROCEDIMIENTO PARA INSERTAR EL DETALLE DE LA ESTRUCTURA DEL ROTEF --

  -- Realizado por: Santiago Araujo --
  -- Fecha: 15/08/2016 --
  -- Actualizad por: Miguel Vélez
  -- Fecha: 20/03/2024
  -- PROCEDIMIENTO PARA GENERA EL ARCHIVO XML DE LA ESTRUCTURA --
  PROCEDURE p_genera_xml( pt_codigo_rotef_cabecera IN  mks_estructuras.rotef_cabecera.codigo%TYPE,
                          pt_estructura_xml        OUT mks_estructuras.rotef_cabecera.estructura_xml%TYPE,
                          pv_error_sql             OUT VARCHAR2,
                          pv_error_code            OUT VARCHAR2,
                          pv_error                 OUT VARCHAR2 ) IS
    lt_codigo_rotef_detalle mks_estructuras.rotef_detalle.codigo%TYPE;
  BEGIN
    FOR cabecera IN ( SELECT *
                      FROM   mks_estructuras.rotef_cabecera rc
                      WHERE  rc.codigo = pt_codigo_rotef_cabecera ) LOOP
      pt_estructura_xml := '<rotef>';
      dbms_lob.append(pt_estructura_xml,CHR(10));
      dbms_lob.append(pt_estructura_xml,'<CodigoFinanciera>'||cabecera.codigo_institucion_financiera||'</CodigoFinanciera>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      dbms_lob.append(pt_estructura_xml,'<IdInformante>'||cabecera.ruc_informante||'</IdInformante>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      dbms_lob.append(pt_estructura_xml,'<Anio>'||cabecera.anio_periodo_informado||'</Anio>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      dbms_lob.append(pt_estructura_xml,'<Mes>'||LPAD(cabecera.mes_periodo_informado,2,'0')||'</Mes>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      dbms_lob.append(pt_estructura_xml,'<codigoOperativo>'||cabecera.codigo_operativo||'</codigoOperativo>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      dbms_lob.append(pt_estructura_xml,'<cuentas>');                                          
      dbms_lob.append(pt_estructura_xml,CHR(10));

      -- AGREGAR EL DETALLE AHORROS--
      FOR detalle IN ( SELECT *
                       FROM   mks_estructuras.rotef_detalle_2024 rd--rotef_detalle rd
                       WHERE  rd.codigo_rotef_cabecera = cabecera.codigo
                       AND rd.tipo_producto = 'AHO' ) LOOP
        lt_codigo_rotef_detalle := detalle.codigo;        
        dbms_lob.append(pt_estructura_xml,'<cuenta>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<TipoIDCliente>'||detalle.tipo_identificacion_cliente||'</TipoIDCliente>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<IDCliente>'||detalle.identificacion_cliente||'</IDCliente>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<RazonSocial>'||TRANSLATE(detalle.razon_social,'????????????.','aeiounAEIOUN')||'</RazonSocial>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<PaisNacionalidad>'||detalle.pais_nacionalidad||'</PaisNacionalidad>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DirProv>'||detalle.provincia||'</DirProv>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DirCanton>'||detalle.canton||'</DirCanton>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<TipoProducto>'||detalle.tipo_producto||'</TipoProducto>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<NumProducto>'||LPAD(detalle.numero_cuenta_operacion,10,'0')||'</NumProducto>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<SaldoInic>'||CASE WHEN detalle.saldo_inicial = 0 THEN '0.00'
                                                               ELSE TO_CHAR(detalle.saldo_inicial,'FM999999999999999990.009') END||'</SaldoInic>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<ValCredito>'||CASE WHEN detalle.total_creditos = 0 THEN '0.00'
                                                               ELSE TO_CHAR(detalle.total_creditos,'FM999999999999999990.009') END||'</ValCredito>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<NumOperCred>'||detalle.num_ope_cred ||'</NumOperCred>');                                                               
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<ValDebito>'||CASE WHEN detalle.total_debitos = 0 THEN '0.00'
                                                              ELSE TO_CHAR(detalle.total_debitos,'FM999999999999999990.009') END||'</ValDebito>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<NumOperDeb>'||detalle.num_ope_deb||'</NumOperDeb>');
        dbms_lob.append(pt_estructura_xml,CHR(10)); 
        dbms_lob.append(pt_estructura_xml,'<SaldoFinal>'||CASE WHEN detalle.saldo_final = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.saldo_final,'FM999999999999999990.009') END||'</SaldoFinal>');
        dbms_lob.append(pt_estructura_xml,'<CodMoneda>'||detalle.moneda||'</CodMoneda>');
        dbms_lob.append(pt_estructura_xml,CHR(10));        
        dbms_lob.append(pt_estructura_xml,'</cuenta>');
        dbms_lob.append(pt_estructura_xml,CHR(10));  
      END LOOP; -- FIN DE DETALLE -- 
      dbms_lob.append(pt_estructura_xml,'</cuentas>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      
      dbms_lob.append(pt_estructura_xml,'<inversiones>');                                          
      dbms_lob.append(pt_estructura_xml,CHR(10));

      -- AGREGAR EL DETALLE INVERSIONES--
      FOR detalle IN ( SELECT *
                       FROM   mks_estructuras.rotef_detalle_2024 rd
                       WHERE  rd.codigo_rotef_cabecera = cabecera.codigo
                       AND rd.tipo_producto = 'INV' ) LOOP
        lt_codigo_rotef_detalle := detalle.codigo;        
        dbms_lob.append(pt_estructura_xml,'<inversion>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<TipoIDCliente>'||detalle.tipo_identificacion_cliente||'</TipoIDCliente>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<IDCliente>'||detalle.identificacion_cliente||'</IDCliente>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<RazonSocial>'||TRANSLATE(detalle.razon_social,'????????????.','aeiounAEIOUN')||'</RazonSocial>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<PaisNacionalidad>'||detalle.pais_nacionalidad||'</PaisNacionalidad>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DirProv>'||detalle.provincia||'</DirProv>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DirCanton>'||detalle.canton||'</DirCanton>');
        dbms_lob.append(pt_estructura_xml,CHR(10));       
        dbms_lob.append(pt_estructura_xml,'<CapitalInvers>'||CASE WHEN detalle.saldo_final = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.saldo_final,'FM999999999999999990.009') END||'</CapitalInvers>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<CodMoneda>'||detalle.moneda||'</CodMoneda>');
        dbms_lob.append(pt_estructura_xml,CHR(10));        
        dbms_lob.append(pt_estructura_xml,'</inversion>');
        dbms_lob.append(pt_estructura_xml,CHR(10));  
      END LOOP; -- FIN DE DETALLE -- 
      dbms_lob.append(pt_estructura_xml,'</inversiones>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      
      dbms_lob.append(pt_estructura_xml,'<prestamos>');                                          
      dbms_lob.append(pt_estructura_xml,CHR(10));

      -- AGREGAR EL DETALLE CARTERA--
      FOR detalle IN ( SELECT *
                       FROM   mks_estructuras.rotef_detalle_2024 rd
                       WHERE  rd.codigo_rotef_cabecera = cabecera.codigo
                       AND rd.tipo_producto = 'PRE' ) LOOP
        lt_codigo_rotef_detalle := detalle.codigo;        
        dbms_lob.append(pt_estructura_xml,'<prestamo>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<TipoIDCliente>'||detalle.tipo_identificacion_cliente||'</TipoIDCliente>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<IDCliente>'||detalle.identificacion_cliente||'</IDCliente>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<RazonSocial>'||TRANSLATE(detalle.razon_social,'????????????.','aeiounAEIOUN')||'</RazonSocial>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<PaisNacionalidad>'||detalle.pais_nacionalidad||'</PaisNacionalidad>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DirProv>'||detalle.provincia||'</DirProv>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DirCanton>'||detalle.canton||'</DirCanton>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DiasMorosidad>'||detalle.dias_mora||'</DiasMorosidad>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<TipoCredito>'||detalle.tipo_credito||'</TipoCredito>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<EstadoOperacion>'||detalle.estado_credito||'</EstadoOperacion>');
        dbms_lob.append(pt_estructura_xml,CHR(10));        
        dbms_lob.append(pt_estructura_xml,'<TotalValorVencer>'||CASE WHEN detalle.capital_x_vencer = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.capital_x_vencer,'FM999999999999999990.009') END||'</TotalValorVencer>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<TotalValorVencerNoInteres>'||CASE WHEN detalle.capital_no_devenga = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.capital_no_devenga,'FM999999999999999990.009') END||'</TotalValorVencerNoInteres>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<TotvalorVencido>'||CASE WHEN detalle.total_vencido = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.total_vencido,'FM999999999999999990.009') END||'</TotvalorVencido>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<GastosCarteraVencida>'||CASE WHEN detalle.recup_cartera_vencida_casti = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.recup_cartera_vencida_casti,'FM999999999999999990.009') END||'</GastosCarteraVencida>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<InteresOrdinario>'||CASE WHEN detalle.interes_ordinario = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.interes_ordinario,'FM999999999999999990.009') END||'</InteresOrdinario>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<InteresMora>'||CASE WHEN detalle.interes_mora = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.interes_mora,'FM999999999999999990.009') END||'</InteresMora>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<DemandaJudicial>'||CASE WHEN detalle.demanda_judicial = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.demanda_judicial,'FM999999999999999990.009') END||'</DemandaJudicial>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<CarteraCastigada>'||CASE WHEN detalle.cartera_castigada = 0 THEN '0.00'
                                                                ELSE TO_CHAR(detalle.cartera_castigada,'FM999999999999999990.009') END||'</CarteraCastigada>');
        dbms_lob.append(pt_estructura_xml,CHR(10));
        dbms_lob.append(pt_estructura_xml,'<CodMoneda>'||detalle.moneda||'</CodMoneda>');
        dbms_lob.append(pt_estructura_xml,CHR(10));        
        dbms_lob.append(pt_estructura_xml,'</prestamo>');
        dbms_lob.append(pt_estructura_xml,CHR(10));  
      END LOOP; -- FIN DE DETALLE -- 
      dbms_lob.append(pt_estructura_xml,'</prestamos>');
      dbms_lob.append(pt_estructura_xml,CHR(10));
      
      
      dbms_lob.append(pt_estructura_xml,'</rotef>');
    END LOOP; -- FIN DE CABECERA --
  EXCEPTION
    WHEN OTHERS THEN
      pv_error := 'Error al genera el archivo xml, detelle '||lt_codigo_rotef_detalle||'.';
      pv_error_Sql := SQLERRM;
      pv_error_code := SQLCODE;
  END p_genera_xml;
  -- FIN DEL PROCEDIMIENTO PARA GENERA EL ARCHIVO XML DE LA ESTRUCTURA --


END pkm_estructura_rotef;
