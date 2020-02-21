#!/bin/bash

# installr.sh
# Script para instalar macOS en forma desatendida desde Internet Recovery
# Adicionalmente puede instalar paquete hecho con productbuild app Packages

if [[ $EUID != 0 ]] ; then
    echo "installr: Por favor corra este script como root o bien como sudo."
    exit -1
fi

# dirname y basename no están disponibles en el Recovery
# asi que tenemos que usar la coincidencia de patron Bash
BASENAME=${0##*/}
THISDIR=${0%$BASENAME}
PACKAGESDIR="${THISDIR}packages"
INSTALLMACOSAPP=$(echo "${THISDIR}Install macOS"*.app)
STARTOSINSTALL=$(echo "${THISDIR}Install macOS"*.app/Contents/Resources/startosinstall)

if [ ! -e "$STARTOSINSTALL" ]; then
    echo "No se encuentra el ejecutable instalador en este directorio!"
    exit -1
fi

echo "****** Instalador desatendido de macOS! ******"
echo "macOS sera instalado desde:"
echo "    ${INSTALLMACOSAPP}"
echo "Estos paquete adicionales seran instalados:"
for PKG in $(/bin/ls -1 "${PACKAGESDIR}"/*.pkg); do
    echo "    ${PKG}"
done

echo
echo "Instalando macOS en el volumen /Volumes/macOS..."

# construyendo nuestra autoinstalación
CMD="\"${STARTOSINSTALL}\" --agreetolicense --volume \"/Volumes/macOS\"" 

for ITEM in "${PACKAGESDIR}"/* ; do
    FILENAME="${ITEM##*/}"
    EXTENSION="${FILENAME##*.}"
    if [[ -e ${ITEM} ]]; then
        case ${EXTENSION} in
            pkg ) CMD="${CMD} --installpackage \"${ITEM}\"" ;;
            * ) echo "    ignoring non-package ${ITEM}..." ;;
        esac
    fi
done

# inicia la instalación del sistema operativo macOS
eval $CMD

