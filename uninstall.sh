#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - uninstall.sh
# Executado quando o módulo é removido pelo Magisk/KernelSU/APatch
# ============================================================================

AA_PKG="com.google.android.projection.gearhead"

# Limpar cache do Android Auto para evitar conflitos
pm clear "$AA_PKG" 2>/dev/null

log -t "AndroidAutoSystemizer" "Módulo removido. Android Auto voltará a ser app de usuário."
