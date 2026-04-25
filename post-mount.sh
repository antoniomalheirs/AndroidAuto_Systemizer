#!/system/bin/sh
# ============================================================================
# Android Auto Systemizer - post-mount.sh v3.0
# Executado após o OverlayFS ser montado (KernelSU / KSU Next)
# ============================================================================

MODDIR=${0%/*}
TAG="AndroidAutoSystemizer"

# Verificar se os arquivos do módulo foram montados corretamente
if [ -d "$MODDIR/system/product/priv-app/AndroidAuto" ]; then
    log -t "$TAG" "[post-mount] Overlay montado com sucesso."
else
    log -t "$TAG" "[post-mount] AVISO: Diretório do Android Auto não encontrado no overlay."
fi
