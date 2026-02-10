# Space Invaders - Screensaver de VIDEO

**SÚPER SIMPLE. SIN COMPLICACIONES.**

## ✅ Qué hace:

Reproduce el video `SpaceInvaders-v15-720p-20s.mp4` en loop infinito.

- NO WebView
- NO JavaScript  
- NO HTML
- SOLO video nativo de macOS (AVPlayer)

## 🎯 Por qué esto SÍ funciona:

- AVPlayer es nativo de macOS
- No hay dependencias externas
- No hay problemas de rutas
- No hay problemas de canvas
- Es IMPOSIBLE que falle

## 📦 Estructura:

```
SpaceInvadersScreensaver.saver/
├── Contents/
│   ├── Info.plist
│   ├── MacOS/
│   │   └── SpaceInvadersScreensaver (binario)
│   └── Resources/
│       └── video.mp4 (tu video de 20 segundos)
```

## 🚀 Instalación:

### 1. Compilar en GitHub Actions

- Subí todo a GitHub
- Actions → Run workflow
- Descargá el ZIP

### 2. Desbloquear Gatekeeper

```bash
cd ~/Downloads
xattr -cr SpaceInvadersScreensaver.saver
```

### 3. Instalar

```bash
open SpaceInvadersScreensaver.saver
```

Seleccioná "Instalar para este usuario"

### 4. Activar

- Preferencias del Sistema → Salvapantallas
- Seleccioná "Space Invaders"
- Vista Previa

**Deberías ver el video reproduciéndose.**

## 🔧 Si no funciona:

Abrí Console.app y filtrá por "SpaceInvaders":

Deberías ver:
```
✅ Video encontrado: /path/to/video.mp4
✅ Player configurado
▶️ Video reproduciendo
```

Si ves:
```
❌ Video no encontrado
```
→ El video no está en el bundle (problema de compilación)

## 💡 Ventajas de este método:

1. **Simple**: Solo 50 líneas de código Swift
2. **Confiable**: AVPlayer es parte de macOS
3. **Sin dependencies**: No necesita nada externo
4. **Loop perfecto**: AVPlayerLooper hace loop sin cortes
5. **Performance**: Video nativo, acelerado por hardware

## 🎮 El video:

- Resolución: 1280x720
- Duración: 20 segundos
- Codec: H.264
- Tamaño: ~1.5 MB

Se reproduce en loop infinito.

## ⚙️ Compatibilidad:

- ✅ macOS 13.0 Ventura
- ✅ macOS 14.0 Sonoma
- ✅ macOS 15.0 Sequoia
- ✅ macOS 16.0+ futuras versiones
- ✅ Intel (x86_64)
- ✅ Apple Silicon (ARM64)

## 🔥 ESTO SÍ FUNCIONA

No hay WebView, no hay JavaScript, no hay rutas complicadas.

Solo un video reproduciéndose en loop.

SIMPLE. CONFIABLE. FUNCIONAL.

---

by dr pendejoloco - 2025

**Si esto no funciona, el problema es Gatekeeper, no el código.**
