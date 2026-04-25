#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - customize.sh v4.0
# Módulo Root Universal para Magisk / KernelSU / KernelSU Next / APatch
# ============================================================================
# Usa AndroidAutoStubPrebuilt (mesmo APK stub do NikGapps/Google)
# O stub é instalado como system app e a Play Store atualiza para a versão completa.
# ============================================================================

SKIPUNZIP=0

# ─── Identificação do Gerenciador de Root ────────────────────────────────────
if [ "$KSU" = "true" ]; then
    ui_print "╔══════════════════════════════════════════════╗"
    ui_print "║     Android Auto Systemizer v4.0             ║"
    ui_print "║     Detectado: KernelSU / KSU Next           ║"
    ui_print "╚══════════════════════════════════════════════╝"
    ui_print "- KSU Version: $KSU_VER ($KSU_VER_CODE)"
    ROOT_MANAGER="ksu"
elif [ "$APATCH" = "true" ]; then
    ui_print "╔══════════════════════════════════════════════╗"
    ui_print "║     Android Auto Systemizer v4.0             ║"
    ui_print "║     Detectado: APatch                        ║"
    ui_print "╚══════════════════════════════════════════════╝"
    ROOT_MANAGER="apatch"
else
    ui_print "╔══════════════════════════════════════════════╗"
    ui_print "║     Android Auto Systemizer v4.0             ║"
    ui_print "║     Detectado: Magisk                        ║"
    ui_print "╚══════════════════════════════════════════════╝"
    ui_print "- Magisk Version: $MAGISK_VER ($MAGISK_VER_CODE)"
    ROOT_MANAGER="magisk"
fi

# ─── Verificação de API / Android ────────────────────────────────────────────
ui_print ""
ui_print "- Arquitetura: $ARCH"
ui_print "- API Level: $API"

if [ "$API" -lt 28 ]; then
    abort "! ERRO: Android 9 (API 28) ou superior é necessário. Seu dispositivo está na API $API."
fi

# ─── Validar que o Stub APK existe no módulo ─────────────────────────────────
ui_print ""
STUB_APK="$MODPATH/system/product/priv-app/AndroidAutoStubPrebuilt/AndroidAutoStubPrebuilt.apk"
OVERLAY_APK="$MODPATH/system/product/overlay/AndroidAutoOverlay.apk"
PERM_FILE="$MODPATH/system/product/etc/permissions/com.google.android.projection.gearhead.xml"

if [ ! -f "$STUB_APK" ]; then
    abort "! ERRO: AndroidAutoStubPrebuilt.apk não encontrado no módulo!"
fi

ui_print "- AndroidAutoStubPrebuilt.apk encontrado ✓"

if [ -f "$OVERLAY_APK" ]; then
    ui_print "- AndroidAutoOverlay.apk encontrado ✓"
fi

if [ -f "$PERM_FILE" ]; then
    ui_print "- Permissões privilegiadas encontradas ✓"
fi

# ─── Limpar XML duplicado da partição errada ─────────────────────────────────
# CRÍTICO: O XML de permissões DEVE estar APENAS na mesma partição do APK.
rm -rf "$MODPATH/system/etc/permissions" 2>/dev/null
rm -rf "$MODPATH/system/etc" 2>/dev/null

# ─── Definir permissões corretas ─────────────────────────────────────────────
ui_print ""
ui_print "- Configurando permissões de arquivos..."

# Permissões padrão do módulo (diretórios 755, arquivos 644)
set_perm_recursive "$MODPATH" 0 0 0755 0644

# Garantir que os scripts tenham permissão de execução
for script in "$MODPATH"/*.sh; do
    [ -f "$script" ] && chmod 0755 "$script"
done

# ─── Informações finais ──────────────────────────────────────────────────────
ui_print ""
ui_print "╔══════════════════════════════════════════════════════════╗"
ui_print "║  Instalação concluída com sucesso!                      ║"
ui_print "║                                                         ║"
ui_print "║  Componentes instalados:                                ║"
ui_print "║  • AndroidAutoStubPrebuilt (priv-app)                   ║"
ui_print "║  • AndroidAutoOverlay (overlay RRO)                     ║"
ui_print "║  • Permissões privilegiadas (73 permissões)             ║"
ui_print "║                                                         ║"
ui_print "║  PRÓXIMOS PASSOS:                                       ║"
ui_print "║  1. Reinicie o dispositivo.                             ║"
ui_print "║  2. Abra a Play Store e atualize o Android Auto.        ║"
ui_print "║  3. Conecte ao carro para testar!                       ║"
ui_print "╚══════════════════════════════════════════════════════════╝"
