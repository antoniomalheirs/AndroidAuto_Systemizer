#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - customize.sh
# Módulo Root Universal para Magisk / KernelSU / KernelSU Next / APatch
# ============================================================================
# Este script é SOURCE'd (não executado) pelo instalador do módulo.
# NÃO use 'exit' — use 'abort' para erros fatais.
# ============================================================================

SKIPUNZIP=0

# ─── Identificação do Gerenciador de Root ────────────────────────────────────
if [ "$KSU" = "true" ]; then
    ui_print "╔══════════════════════════════════════════════╗"
    ui_print "║     Android Auto Systemizer v2.0             ║"
    ui_print "║     Detectado: KernelSU / KSU Next           ║"
    ui_print "╚══════════════════════════════════════════════╝"
    ui_print "- KSU Version: $KSU_VER ($KSU_VER_CODE)"
    ROOT_MANAGER="ksu"
elif [ "$APATCH" = "true" ]; then
    ui_print "╔══════════════════════════════════════════════╗"
    ui_print "║     Android Auto Systemizer v2.0             ║"
    ui_print "║     Detectado: APatch                        ║"
    ui_print "╚══════════════════════════════════════════════╝"
    ROOT_MANAGER="apatch"
else
    ui_print "╔══════════════════════════════════════════════╗"
    ui_print "║     Android Auto Systemizer v2.0             ║"
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

# ─── Pacote do Android Auto ──────────────────────────────────────────────────
AA_PKG="com.google.android.projection.gearhead"

# ─── Tentar extrair o APK do Android Auto já instalado ───────────────────────
ui_print ""
ui_print "- Procurando Android Auto instalado no dispositivo..."

# Diretório de destino no módulo
AA_DEST="$MODPATH/system/product/priv-app/AndroidAuto"
mkdir -p "$AA_DEST"

# Obter caminhos dos APKs instalados (suporte a split APKs)
APK_PATHS=$(pm path "$AA_PKG" 2>/dev/null | sed 's/^package://')

if [ -n "$APK_PATHS" ]; then
    ui_print "- Android Auto encontrado! Extraindo APKs..."
    
    APK_COUNT=0
    for apk_path in $APK_PATHS; do
        if [ -f "$apk_path" ]; then
            apk_name=$(basename "$apk_path")
            ui_print "  -> Copiando: $apk_name"
            cp -f "$apk_path" "$AA_DEST/$apk_name"
            if [ $? -ne 0 ]; then
                abort "! ERRO: Falha ao copiar $apk_name"
            fi
            APK_COUNT=$((APK_COUNT + 1))
        fi
    done
    
    if [ "$APK_COUNT" -eq 0 ]; then
        abort "! ERRO: Nenhum APK válido encontrado para o Android Auto."
    fi
    
    ui_print "- Total de $APK_COUNT APK(s) extraído(s) com sucesso!"
    
else
    # Fallback: verificar se o usuário colocou o APK manualmente no ZIP
    ui_print "! Android Auto NÃO está instalado no dispositivo."
    ui_print "- Verificando se o APK foi incluído no ZIP..."
    
    # Verificar se há APKs pré-colocados pelo usuário
    PRELOADED=$(find "$AA_DEST" -name "*.apk" 2>/dev/null | head -1)
    
    if [ -z "$PRELOADED" ]; then
        ui_print ""
        ui_print "╔══════════════════════════════════════════════════════════╗"
        ui_print "║  ERRO: Android Auto não encontrado!                     ║"
        ui_print "║                                                         ║"
        ui_print "║  Opção 1: Instale o Android Auto pela Play Store        ║"
        ui_print "║           e tente novamente.                            ║"
        ui_print "║                                                         ║"
        ui_print "║  Opção 2: Coloque o APK manualmente na pasta:           ║"
        ui_print "║  system/product/priv-app/AndroidAuto/base.apk           ║"
        ui_print "║  dentro do ZIP, e instale novamente.                    ║"
        ui_print "╚══════════════════════════════════════════════════════════╝"
        abort "! Instalação abortada: APK não encontrado."
    else
        ui_print "- APK pré-incluído encontrado no ZIP!"
    fi
fi

# ─── Remover arquivo de instrução (se existir) ──────────────────────────────
rm -f "$AA_DEST/COLOQUE_O_APK_AQUI.txt" 2>/dev/null

# ─── Criar diretório de permissões ───────────────────────────────────────────
PERM_DIR="$MODPATH/system/product/etc/permissions"
mkdir -p "$PERM_DIR"

# Copiar o XML de permissões para a partição product (onde o APK reside)
if [ -f "$MODPATH/system/etc/permissions/privapp-permissions-com.google.android.projection.gearhead.xml" ]; then
    cp -f "$MODPATH/system/etc/permissions/privapp-permissions-com.google.android.projection.gearhead.xml" \
          "$PERM_DIR/privapp-permissions-com.google.android.projection.gearhead.xml"
    ui_print "- Permissões privilegiadas configuradas em /product/etc/permissions/"
fi

# ─── Definir permissões corretas ─────────────────────────────────────────────
ui_print ""
ui_print "- Configurando permissões de arquivos..."

# Permissões padrão do módulo
set_perm_recursive "$MODPATH" 0 0 0755 0644

# Permissões específicas para o diretório do priv-app
set_perm_recursive "$AA_DEST" 0 0 0755 0644

# Permissões para o diretório de permissões
set_perm_recursive "$PERM_DIR" 0 0 0755 0644

# ─── Informações finais ──────────────────────────────────────────────────────
ui_print ""
ui_print "╔══════════════════════════════════════════════════════════╗"
ui_print "║  ✅ Instalação concluída com sucesso!                    ║"
ui_print "║                                                         ║"
ui_print "║  O Android Auto foi instalado como app de sistema       ║"
ui_print "║  em /product/priv-app/ com permissões privilegiadas.    ║"
ui_print "║                                                         ║"
ui_print "║  ⚠️  IMPORTANTE:                                        ║"
ui_print "║  1. Reinicie o dispositivo.                             ║"
ui_print "║  2. Após reiniciar, desinstale o Android Auto da        ║"
ui_print "║     Play Store (se instalado) para usar a versão        ║"
ui_print "║     de sistema.                                         ║"
ui_print "║  3. Conecte ao carro para testar!                       ║"
ui_print "╚══════════════════════════════════════════════════════════╝"
