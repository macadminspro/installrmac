#!/bin/sh

# Construye una imagen de disco que contiene la autoinstalación y paquetes.
clear
echo
THISDIR=$(/usr/bin/dirname ${0})
VERSION=$(/usr/libexec/plistbuddy -c Print:CFBundleShortVersionString: $THISDIR/install/*macOS*/Contents/info.plist)
DMGNAME="${THISDIR}/autoinstall.10.$VERSION.dmg"
if [[ -e "${DMGNAME}" ]] ; then
    /bin/rm "${DMGNAME}"
fi
echo
echo "Espere..., la imagen tendra el nombre autoinstall.10.$VERSION.dmg!"
echo
/usr/bin/hdiutil create -fs HFS+ -srcfolder "${THISDIR}/install" "${DMGNAME}"
echo
echo
echo "Cuelgue la imagen creada autoinstall.10.$VERSION.dmg en un servidor Apache o NFS"
echo 
echo "by Mac Admin 2020"
echo