## Magisk, KernelSU, KernelSU Next & APatch — Android Auto Systemizer

*  Systemlessly converts Android Auto into a system app (priv-app) with full privileged permissions. Compatible with Magisk, KernelSU, KernelSU Next, and APatch.

# Changelogs

#### V4.0 — StubPrebuilt + RRO Overlay (NikGapps Approach)
- **NOVO:** Utiliza `AndroidAutoStubPrebuilt.apk` (stub oficial Google) em vez de extrair APKs split.
- **NOVO:** Inclui `AndroidAutoOverlay.apk` (Runtime Resource Overlay) para configuração nativa do sistema.
- **NOVO:** Allowlist completa com **73 permissões privilegiadas** (baseada no NikGapps Addon).
- **NOVO:** 16 permissões runtime concedidas automaticamente no boot.
- **NOVO:** Arquivos idênticos byte-a-byte ao NikGapps Addon (SHA256 verificado).
- **MELHORIA:** Script de instalação simplificado — sem extração de APK em runtime.
- **MELHORIA:** Nome do XML de permissões alinhado com padrão NikGapps.

#### V3.0 — Rewrite de Segurança
- **FIX:** Remoção de XMLs duplicados entre partições (causa de bootloop).
- **NOVO:** Proteção anti-bootloop via `ro.control_privapp_permissions=log`.
- **MELHORIA:** Scripts 100% defensivos com supressão total de erros.
- **FIX:** Remoção de regras SELinux redundantes que conflitavam com ROMs custom.
- **FIX:** Lista de permissões reduzida para 22 universais (Android 9-16).

#### V2.0 — Universal Root Manager Support
- **NOVO:** Módulo completo para transformar o Android Auto em app de sistema (priv-app).
- **NOVO:** Extração automática do APK instalado do Android Auto via `pm path`.
- **NOVO:** Permissões privilegiadas completas via XML allowlisting.
- **NOVO:** Políticas SELinux customizadas para acesso USB e binder IPC.
- **NOVO:** Scripts de boot (`post-mount.sh`, `boot-completed.sh`, `service.sh`).
- **NOVO:** Detecção automática do root manager (Magisk, KernelSU, KernelSU Next, APatch).
- **NOVO:** Script de desinstalação limpa (`uninstall.sh`).

#### V1.0 — Release Inicial
- Instalação básica do Android Auto como priv-app.
- Suporte apenas para Magisk.

## Credits:

### [topjohnwu](https://github.com/topjohnwu) - For creating Magisk
### [tiann](https://github.com/tiann) - For expanding on KernelSU
### [NikGapps](https://nikgapps.com/) - Reference for StubPrebuilt + Overlay approach
### [SentinelData](https://github.com/antoniomalheirs) - Module development
