#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - service.sh v4.0
# Executado em late_start service mode (NON-BLOCKING)
# Compatível com Magisk / KernelSU / KernelSU Next / APatch
# ============================================================================
# PRINCÍPIO: Todo comando é defensivo. Nenhum erro aqui pode afetar o boot.
# Todos os comandos usam 2>/dev/null para suprimir erros silenciosamente.
# ============================================================================

MODDIR=${0%/*}
AA_PKG="com.google.android.projection.gearhead"
TAG="AndroidAutoSystemizer"

# Aguardar o boot completar (loop seguro com timeout)
BOOT_WAIT=0
while [ "$(getprop sys.boot_completed 2>/dev/null)" != "1" ] && [ "$BOOT_WAIT" -lt 120 ]; do
    sleep 1
    BOOT_WAIT=$((BOOT_WAIT + 1))
done

# Aguardar mais 10 segundos para o sistema estabilizar
sleep 10

# ─── Verificar se o Android Auto está instalado como sistema ─────────────────
if pm list packages -s 2>/dev/null | grep -q "$AA_PKG"; then
    log -t "$TAG" "Android Auto detectado como app de sistema."

    # ─── Conceder permissões runtime essenciais ──────────────────────────
    # Permissões do tipo "dangerous" que precisam ser concedidas em runtime.
    # Cada pm grant é individual e ignora erros (permissão pode não existir
    # na versão do Android ou já estar concedida).

    pm grant "$AA_PKG" android.permission.ACCESS_FINE_LOCATION 2>/dev/null
    pm grant "$AA_PKG" android.permission.ACCESS_COARSE_LOCATION 2>/dev/null
    pm grant "$AA_PKG" android.permission.ACCESS_BACKGROUND_LOCATION 2>/dev/null
    pm grant "$AA_PKG" android.permission.READ_PHONE_STATE 2>/dev/null
    pm grant "$AA_PKG" android.permission.CALL_PHONE 2>/dev/null
    pm grant "$AA_PKG" android.permission.READ_CONTACTS 2>/dev/null
    pm grant "$AA_PKG" android.permission.RECORD_AUDIO 2>/dev/null
    pm grant "$AA_PKG" android.permission.POST_NOTIFICATIONS 2>/dev/null
    pm grant "$AA_PKG" android.permission.BLUETOOTH_CONNECT 2>/dev/null
    pm grant "$AA_PKG" android.permission.BLUETOOTH_SCAN 2>/dev/null
    pm grant "$AA_PKG" android.permission.NEARBY_WIFI_DEVICES 2>/dev/null
    pm grant "$AA_PKG" android.permission.READ_CALENDAR 2>/dev/null
    pm grant "$AA_PKG" android.permission.READ_CALL_LOG 2>/dev/null
    pm grant "$AA_PKG" android.permission.SEND_SMS 2>/dev/null
    pm grant "$AA_PKG" android.permission.RECEIVE_SMS 2>/dev/null

    log -t "$TAG" "Permissões runtime concedidas."

    # ─── Garantir que o Android Auto seja o handler de projeção ──────────
    if command -v cmd >/dev/null 2>&1; then
        cmd role add-role-holder android.app.role.SYSTEM_AUTOMOTIVE_PROJECTION "$AA_PKG" 0 2>/dev/null
    fi

    log -t "$TAG" "Configuração pós-boot concluída com sucesso."
else
    log -t "$TAG" "AVISO: Android Auto NÃO detectado como app de sistema."
fi
