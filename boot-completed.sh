#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - boot-completed.sh (KernelSU / KSU Next)
# Executado quando o boot é completado
# ============================================================================

MODDIR=${0%/*}
AA_PKG="com.google.android.projection.gearhead"

# Aguardar sistema estabilizar
sleep 5

# ─── Conceder permissões runtime ────────────────────────────────────────────
if pm list packages -s 2>/dev/null | grep -q "$AA_PKG"; then
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
    
    # Definir como handler de projeção automotiva
    if command -v cmd >/dev/null 2>&1; then
        cmd role add-role-holder android.app.role.SYSTEM_AUTOMOTIVE_PROJECTION "$AA_PKG" 0 2>/dev/null
    fi
    
    log -t "AndroidAutoSystemizer" "[boot-completed] Permissões runtime e role configurados."
fi
