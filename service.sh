#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - service.sh
# Executado em late_start service mode (NON-BLOCKING)
# Compatível com Magisk / KernelSU / KernelSU Next / APatch
# ============================================================================

MODDIR=${0%/*}
AA_PKG="com.google.android.projection.gearhead"

# Aguardar o boot completar
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

# Aguardar mais 10 segundos para o sistema estabilizar
sleep 10

# ─── Verificar se o Android Auto está instalado como sistema ─────────────────
if pm list packages -s 2>/dev/null | grep -q "$AA_PKG"; then
    # Log de sucesso
    log -t "AndroidAutoSystemizer" "Android Auto detectado como app de sistema."
    
    # ─── Conceder permissões runtime essenciais ──────────────────────────
    # Essas permissões são do tipo "dangerous" e precisam ser concedidas
    # em runtime, além das permissões privilegiadas do XML.
    
    RUNTIME_PERMS="
        android.permission.ACCESS_FINE_LOCATION
        android.permission.ACCESS_COARSE_LOCATION
        android.permission.ACCESS_BACKGROUND_LOCATION
        android.permission.READ_PHONE_STATE
        android.permission.CALL_PHONE
        android.permission.READ_CONTACTS
        android.permission.RECORD_AUDIO
        android.permission.POST_NOTIFICATIONS
        android.permission.READ_PHONE_NUMBERS
        android.permission.BLUETOOTH_CONNECT
        android.permission.BLUETOOTH_SCAN
        android.permission.NEARBY_WIFI_DEVICES
    "
    
    for perm in $RUNTIME_PERMS; do
        pm grant "$AA_PKG" "$perm" 2>/dev/null
    done
    
    log -t "AndroidAutoSystemizer" "Permissões runtime concedidas."
    
    # ─── Garantir que o Android Auto seja o handler de projeção ──────────
    # Define o Android Auto como o app de projeção automotiva padrão
    if command -v cmd >/dev/null 2>&1; then
        cmd role add-role-holder android.app.role.SYSTEM_AUTOMOTIVE_PROJECTION "$AA_PKG" 0 2>/dev/null
    fi
    
    log -t "AndroidAutoSystemizer" "Configuração pós-boot concluída."
else
    log -t "AndroidAutoSystemizer" "AVISO: Android Auto NÃO detectado como app de sistema."
fi
