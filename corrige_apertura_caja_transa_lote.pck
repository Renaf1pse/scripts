CREATE OR REPLACE PACKAGE MKS_AHORROS.pkm_ejecucion_tra_lot_det IS
  -- ------------------------------------------------------------------
  --  PAQUETE DE EJECUCION DE DETALLE DE TRANSACCIONES EN LOTE
  ---------------------------------------------------------------------
  -- Creado por: Victor Astudillo
  -- Fecha de Creacion: 13 de diciembre de 2014

  -----------------------------------------------------------------------------------
  -- GUARDA EL DETALLE DE LAS TRANSACCIONES Y REALIZA EL MOVIMIENTO EN LA CUENTA
  PROCEDURE p_guarda(p_codigo_ejecucion         IN MKS_AHORROS.EJECUCION_TRANSACCION_LOTE.CODIGO%TYPE,
                     p_codigo_cuenta            IN MKS_AHORROS.CUENTA.CODIGO%TYPE,
                     p_codigo_tipo_producto     IN MKS_AHORROS.TIPO_PRODUCTO.CODIGO%TYPE,
                     p_codigo_moneda            IN MKS_COMUNES.MONEDA.CODIGO%TYPE,
                     p_codigo_concepto          IN MKS_AHORROS.CONCEPTO_TRANSACCION.CODIGO%TYPE,
                     p_fecha_movimiento         IN MKS_AHORROS.MOVIMIENTO_CUENTA.FECHA_MOVIMIENTO%TYPE,
                     p_valor_transaccion        IN MKS_AHORROS.EJECUCION_TRANSACCION_LOT_DET.VALOR_TRANSACCION%TYPE,
                     p_codigo_usuario           IN MKS_SEGURIDADES.USUARIO.CODIGO%TYPE,
                     p_codigo_ifip              IN MKS_IFIPS.IFIP.CODIGO%TYPE,
                     p_codigo_ifip_agencia      IN MKS_IFIPS.IFIP_AGENCIA.CODIGO%TYPE,
                     p_codigo_computador        IN MKS_IFIPS.COMPUTADOR.CODIGO%TYPE,
                     p_direccion_ip             IN MKS_AHORROS.MOVIMIENTO_CUENTA_ADICIONAL.DIRECCION_IP%TYPE,
                     p_observaciones            IN MKS_AHORROS.MOVIMIENTO_CUENTA_ADICIONAL.OBSERVACIONES%TYPE,
                     p_codigo_persona           IN MKS_SOCIOS.PERSONA.CODIGO%TYPE,
                     p_codigo_modulo            IN MKS_AHORROS.LICITUD_FONDOS_MODULO.CODIGO%TYPE,
                     p_codigo_apertura          IN MKS_CAJAS.APERTURA.CODIGO%TYPE,
                     pv_mensaje_formulario      OUT VARCHAR2,
                     p_codigo_formulario        OUT MKS_AHORROS.LICITUD_FONDOS_CONTROL.CODIGO%TYPE,
                     pn_genera_formulario       OUT NUMBER,
                     pv_error_sql               OUT VARCHAR2,
                     pv_error_code              OUT VARCHAR2,
                     pv_error                   OUT VARCHAR2);
END pkm_ejecucion_tra_lot_det;
/
CREATE OR REPLACE PACKAGE BODY MKS_AHORROS.pkm_ejecucion_tra_lot_det IS
  -- ------------------------------------------------------------------
  --  PAQUETE DE EJECUCION DE DETALLE DE TRANSACCIONES EN LOTE
  ---------------------------------------------------------------------
  -- Creado por: Victor Astudillo
  -- Fecha de Creacion: 13 de diciembre de 2014

  -----------------------------------------------------------------------------------
  -- GUARDA EL DETALLE DE LAS TRANSACCIONES Y REALIZA EL MOVIMIENTO EN LA CUENTA
  PROCEDURE p_guarda(p_codigo_ejecucion         IN MKS_AHORROS.EJECUCION_TRANSACCION_LOTE.CODIGO%TYPE,
                     p_codigo_cuenta            IN MKS_AHORROS.CUENTA.CODIGO%TYPE,
                     p_codigo_tipo_producto     IN MKS_AHORROS.TIPO_PRODUCTO.CODIGO%TYPE,
                     p_codigo_moneda            IN MKS_COMUNES.MONEDA.CODIGO%TYPE,
                     p_codigo_concepto          IN MKS_AHORROS.CONCEPTO_TRANSACCION.CODIGO%TYPE,
                     p_fecha_movimiento         IN MKS_AHORROS.MOVIMIENTO_CUENTA.FECHA_MOVIMIENTO%TYPE,
                     p_valor_transaccion        IN MKS_AHORROS.EJECUCION_TRANSACCION_LOT_DET.VALOR_TRANSACCION%TYPE,
                     p_codigo_usuario           IN MKS_SEGURIDADES.USUARIO.CODIGO%TYPE,
                     p_codigo_ifip              IN MKS_IFIPS.IFIP.CODIGO%TYPE,
                     p_codigo_ifip_agencia      IN MKS_IFIPS.IFIP_AGENCIA.CODIGO%TYPE,
                     p_codigo_computador        IN MKS_IFIPS.COMPUTADOR.CODIGO%TYPE,
                     p_direccion_ip             IN MKS_AHORROS.MOVIMIENTO_CUENTA_ADICIONAL.DIRECCION_IP%TYPE,
                     p_observaciones            IN MKS_AHORROS.MOVIMIENTO_CUENTA_ADICIONAL.OBSERVACIONES%TYPE,
                     p_codigo_persona           IN MKS_SOCIOS.PERSONA.CODIGO%TYPE,
                     p_codigo_modulo            IN MKS_AHORROS.LICITUD_FONDOS_MODULO.CODIGO%TYPE,
                     p_codigo_apertura          IN MKS_CAJAS.APERTURA.CODIGO%TYPE,
                     pv_mensaje_formulario      OUT VARCHAR2,
                     p_codigo_formulario        OUT MKS_AHORROS.LICITUD_FONDOS_CONTROL.CODIGO%TYPE,
                     pn_genera_formulario       OUT NUMBER,
                     pv_error_sql               OUT VARCHAR2,
                     pv_error_code              OUT VARCHAR2,
                     pv_error                   OUT VARCHAR2)
                     IS
   l_codigo_movimiento       MKS_AHORROS.MOVIMIENTO_CUENTA.CODIGO%TYPE;
   l_codigo_ejecucion_det    MKS_AHORROS.EJECUCION_TRANSACCION_LOT_DET.CODIGO%TYPE;
 BEGIN
     -------------------------------------------------
     -- Creado por: Victor Astudillo
     -- Fecha de Creacion: 13 de diciembre de 2014
     -- Guarda el detalle de la transaccion y realiza el movimiento en la cuenta


     -- Realiza el movimiento de la cuenta
     mks_ahorros.pkm_movimiento_cuenta.p_guarda_movimiento_cuenta (p_codigo_cuenta,
                                                                   p_codigo_tipo_producto,
                                                                   p_codigo_moneda,
                                                                   p_codigo_concepto,
                                                                   p_fecha_movimiento,
                                                                   p_valor_transaccion,
                                                                   0,
                                                                   p_valor_transaccion,
                                                                   p_codigo_usuario,
                                                                   p_codigo_ifip,
                                                                   p_codigo_ifip_agencia,
                                                                   p_codigo_computador,
                                                                   'TRXLOT'||p_codigo_ejecucion||p_codigo_cuenta||'-'||mks_ahorros.seq_ejecucion_tra_lot_det.nextval,
                                                                   p_direccion_ip,
                                                                   p_observaciones,
                                                                   p_codigo_apertura,
                                                                   p_codigo_persona,
                                                                   p_codigo_modulo,
                                                                   pv_mensaje_formulario,
                                                                   p_codigo_formulario,
                                                                   pn_genera_formulario,
                                                                   l_codigo_movimiento,
                                                                   pv_error_sql,
                                                                   pv_error_code,
                                                                   pv_error);


     -- Verificando si existio un error
     IF pv_error IS NOT NULL THEN
        ROLLBACK;
        RETURN;
     END IF;

     -- Inserta el detalle de la ejecucion en lote
     mks_ahorros.pkg_ejecucion_tra_lot_det.p_inserta (p_codigo_ejecucion,
                                                      p_codigo_cuenta,
                                                      p_valor_transaccion,
                                                      l_codigo_movimiento,
                                                      l_codigo_ejecucion_det,
                                                      pv_error_sql,
                                                      pv_error_code,
                                                      pv_error);
     -- Verificando si existio un error
     IF pv_error IS NOT NULL THEN
        ROLLBACK;
        RETURN;
     END IF;
 EXCEPTION
   WHEN OTHERS THEN
    pv_error_sql    := SQLERRM;
    pv_error_code   := SQLCODE;
    pv_error        := 'Error al Guardar  la Cabecera de la Ejecucion en Transaccion en Lote.';
    RETURN;
  END p_guarda;
  -- FIN DE GUARDAR EL DETALLE DE LAS TRANSACCIONES Y REALIZA EL MOVIMIENTO EN LA CUENTA
  -----------------------------------------------------------------------------------


END pkm_ejecucion_tra_lot_det;
/
