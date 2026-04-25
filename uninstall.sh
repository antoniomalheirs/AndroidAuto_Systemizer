#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - uninstall.sh v3.0
# Executado quando o módulo é removido pelo Magisk/KernelSU/APatch
# ============================================================================

AA_PKG="com.google.android.projection.gearhead"
TAG="AndroidAutoSystemizer"

# Limpar cache do Android Auto para evitar conflitos pós-desinstalação
# O pm clear pode falhar se o pacote não estiver instalado — isso é seguro
if pm list packages 2>/dev/null | grep -q "$AA_PKG"; then
    pm clear "$AA_PKG" 2>/dev/null
    log -t "$TAG" "Cache do Android Auto limpo."
fi

log -t "$TAG" "Módulo removido. Android Auto voltará a ser app de usuário após reiniciar."
