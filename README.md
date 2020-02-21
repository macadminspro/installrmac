## installr

Una herramienta básica para instalar macOS y un conjunto de paquetes en un volumen destino "macOS".
Por lo general, estos serían paquetes que "inscriben" la máquina en su sistema de gestión; Al finalizar la instalación de macOS, estas herramientas tomarían el control y continuarían con la instalación y configuración de la máquina.

el instalador está diseñado para ejecutarse en el arranque de Internet Recovery lo que le permite reinstalar una máquina para su reubicación.

Si está preparando una máquina recién desempacada, considere NO reinstalar macOS y simplemente instalar sus paquetes adicionales. [bootstrappr] (https://github.com/munki/bootstrappr) puede ayudarlo con esa tarea.

### macOS Instalador

Copie una aplicación instalador Install macOS en el directorio install/. Debe ser un instalador "completo", que contenga la herramienta Contenido/Recursos/startosinstall.

Los instaladores más antiguos pueden o no funcionar.

### Paquetes

Agregue los paquetes deseados al directorio `install/packages`. Asegúrese de que todos los paquetes que agregue puedan instalarse correctamente en volúmenes que no sean el volumen de arranque actual.

** Importante: ** `startosinstall` requiere que todos los paquetes adicionales sean paquetes de estilo de Distribución (típicamente construidos con` productbuild`) y no paquetes de estilo de componentes (típicamente construidos con `pkgbuild`). Esto significa que los paquetes que usa con éxito con `bootstrappr` o Imagr o Munki no necesariamente funcionarán con` installr`; esas otras herramientas pueden instalar paquetes de estilo componente. `startosinstall` fallará con un error si se dan paquetes de estilo componente para instalar.

Si sus paquetes solo tienen cargas útiles, deberían funcionar bien. Los scripts previos y posteriores a la instalación deben verificarse para no utilizar rutas absolutas al volumen de inicio actual. El sistema instalador pasa el volumen de destino en el tercer argumento `$ 3` a los scripts de instalación.

`startosinstall` en High Sierra ignora las acciones de reinicio del paquete adicional. Esto significa que si el software instalado por uno o más de sus paquetes requiere un reinicio para una funcionalidad completa, no será completamente funcional cuando el instalador de High Sierra complete su trabajo.

### Orden

La herramienta `startosinstall` funcionará a través de los paquetes en orden alfanumérico. Para controlar el orden, puede anteponer nombres de archivo con números.

#### Macs con chip T2

installr es particularmente útil con Macs con chips T2, que no son compatibles con NetBoot, y son difíciles de arrancar desde medios externos. Para usar el instalador para instalar macOS y paquetes adicionales en una Mac T2, debe iniciar en Recuperación (Command-R al inicio), montar el disco del instalador y ejecutar el instalador.

### Escenarios

#### Escenario #1: Desde un disco USB

* Preparación:
  * Copie el contenido del directorio de instalación en una unidad USB.
* Ejecutando installr:
  * Inicie en modo Recovery o Internet Recovery.
  * Conecte la unidad USB.
  * Abra la Terminal (desde el menú Utilidades).
  * `/Volumes/VOLUME_NAME/run` (use `sudo` si no está en Recovery)

#### Escenario #2: Imagen de disco desde servidores Apache o NFS

* Preparación:
  * Cree una imagen de disco usando el script `make_dmg.sh`.
  * Copie la imagen del disco a un servidor.
  * (Las URL https pueden ser problemáticas en el modo de recuperación. Se recomienda usar URL http.)
* Ejecuntando installr:
  * Inicie en modo Internet Recovery o Recovery.
  * Abra la Terminal (desde el menú Utilidades)
  * `hdiutil mount <url_de_tu_imagen_dmg>`
  * `/Volumes/install/run` (use `sudo` si no está en Recovery)

## Licencia

## Adaptación de la obra original de Greg Neagle https://github.com/munki/installr


