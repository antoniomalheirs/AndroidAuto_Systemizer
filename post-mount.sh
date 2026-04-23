#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - post-mount.sh
# Executado após o OverlayFS ser montado (KernelSU / KSU Next)
# ============================================================================

MODDIR=${0%/*}

# Verificar se os arquivos do módulo foram montados corretamente
if [ -d "$MODDIR/system/product/priv-app/AndroidAuto" ]; then
    log -t "AndroidAutoSystemizer" "[post-mount] Overlay montado com sucesso."
else
    log -t "AndroidAutoSystemizer" "[post-mount] AVISO: Diretório do Android Auto não encontrado no overlay."
fi
