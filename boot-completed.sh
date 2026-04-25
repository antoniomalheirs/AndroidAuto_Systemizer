#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - boot-completed.sh v4.0 (KernelSU / KSU Next)
# Executado quando o boot é completado
# ============================================================================
# PRINCÍPIO: Todo comando é defensivo. Nenhum erro aqui pode afetar o boot.
# ============================================================================

MODDIR=${0%/*}
AA_PKG="com.google.android.projection.gearhead"
TAG="AndroidAutoSystemizer"

# Aguardar sistema estabilizar
sleep 5

# ─── Conceder permissões runtime ────────────────────────────────────────────
if pm list packages -s 2>/dev/null | grep -q "$AA_PKG"; then

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

    # Definir como handler de projeção automotiva
    if command -v cmd >/dev/null 2>&1; then
        cmd role add-role-holder android.app.role.SYSTEM_AUTOMOTIVE_PROJECTION "$AA_PKG" 0 2>/dev/null
    fi

    log -t "$TAG" "[boot-completed] Permissões runtime e role configurados."
fi
