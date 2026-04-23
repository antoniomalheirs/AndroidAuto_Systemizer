## Magisk, KernelSU, KernelSU Next & APatch — Android Auto Systemizer

*  Systemlessly converts Android Auto into a system app (priv-app) with full privileged permissions. Compatible with Magisk, KernelSU, KernelSU Next, and APatch.

# Changelogs

#### V2.0 — Universal Root Manager Support
- **NOVO:** Módulo completo para transformar o Android Auto em app de sistema (priv-app).
- **NOVO:** Extração automática do APK instalado do Android Auto via `pm path`.
- **NOVO:** Permissões privilegiadas completas via XML allowlisting (`privapp-permissions-androidauto.xml`).
- **NOVO:** Políticas SELinux customizadas para garantir acesso total ao app systemizado.
- **NOVO:** Scripts de boot (`post-mount.sh`, `boot-completed.sh`, `service.sh`) para montagem e persistência.
- **NOVO:** Detecção automática do root manager (Magisk, KernelSU, KernelSU Next, APatch).
- **NOVO:** `system.prop` com propriedades para compatibilidade com projeção automotiva.
- **NOVO:** Script de desinstalação limpa (`uninstall.sh`).
- **COMPATÍVEL:** Android 9+ com Magisk, KernelSU, KernelSU Next & APatch.

## Credits:

### [topjohnwu](https://github.com/topjohnwu) - For creating Magisk
### [tiann](https://github.com/tiann) - For expanding on KernelSU
### [SentinelData](https://github.com/antoniomalheirs) - Module development
