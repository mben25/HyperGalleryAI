MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug.log
set -x

# var
API=`getprop ro.build.version.sdk`

# property
resetprop -n ro.gallery.device cepheus
resetprop -n ro.gallery.manufacturer Xiaomi

# wait
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 10
done

# list
PKGS="`cat $MODPATH/package.txt`
       com.miui.gallery:photo_editor
       com.miui.gallery:widgetProvider
       com.miui.gallery:remote
       com.miui.gallery:appcustom"
for PKG in $PKGS; do
  magisk --denylist rm $PKG 2>/dev/null
  magisk --sulist add $PKG 2>/dev/null
done
if magisk magiskhide sulist; then
  for PKG in $PKGS; do
    magisk magiskhide add $PKG
  done
else
  for PKG in $PKGS; do
    magisk magiskhide rm $PKG
  done
fi

# function
appops_set() {
appops set $PKG LEGACY_STORAGE allow
appops set $PKG READ_EXTERNAL_STORAGE allow
appops set $PKG WRITE_EXTERNAL_STORAGE allow
appops set $PKG READ_MEDIA_AUDIO allow
appops set $PKG READ_MEDIA_VIDEO allow
appops set $PKG READ_MEDIA_IMAGES allow
appops set $PKG WRITE_MEDIA_AUDIO allow
appops set $PKG WRITE_MEDIA_VIDEO allow
appops set $PKG WRITE_MEDIA_IMAGES allow
if [ "$API" -ge 29 ]; then
  appops set $PKG ACCESS_MEDIA_LOCATION allow
fi
if [ "$API" -ge 30 ]; then
  appops set $PKG MANAGE_EXTERNAL_STORAGE allow
  appops set $PKG NO_ISOLATED_STORAGE allow
  appops set $PKG AUTO_REVOKE_PERMISSIONS_IF_UNUSED ignore
fi
if [ "$API" -ge 31 ]; then
  appops set $PKG MANAGE_MEDIA allow
fi
if [ "$API" -ge 33 ]; then
  appops set $PKG ACCESS_RESTRICTED_SETTINGS allow
fi
if [ "$API" -ge 34 ]; then
  appops set $PKG READ_MEDIA_VISUAL_USER_SELECTED allow
fi
PKGOPS=`appops get $PKG`
UID=`grep "^$PKG " /data/system/packages.list | awk '{print $2}'`
if [ "$UID" ] && [ "$UID" -gt 9999 ]; then
  appops set --uid "$UID" LEGACY_STORAGE allow
  appops set --uid "$UID" READ_EXTERNAL_STORAGE allow
  appops set --uid "$UID" WRITE_EXTERNAL_STORAGE allow
  if [ "$API" -ge 29 ]; then
    appops set --uid "$UID" ACCESS_MEDIA_LOCATION allow
  fi
  if [ "$API" -ge 34 ]; then
    appops set --uid "$UID" READ_MEDIA_VISUAL_USER_SELECTED allow
  fi
  UIDOPS=`appops get --uid "$UID"`
fi
}

# grant
PKG=com.miui.gallery
if appops get $PKG >/dev/null 2>&1; then
  pm grant --all-permissions $PKG
  appops set $PKG SYSTEM_ALERT_WINDOW allow
  appops_set
fi

# scanner fix: CN build runs as international here, but its Google
# clean-data step is stubbed, so GLOBAL_FIRST_CLEAN_TAG stays true and
# ScannerEngine never starts (empty gallery). Mark clean as done.
PKG=com.miui.gallery
DIR=/data/data/$PKG/shared_prefs
PREF=$DIR/com.miui.gallery_preferences_new.xml
KEY=GLOBAL_FIRST_CLEAN_TAG
UID=`grep "^$PKG " /data/system/packages.list | awk '{print $2}'`
if [ "$UID" ] && ! grep -q "\"$KEY\" value=\"false\"" $PREF 2>/dev/null; then
  am force-stop $PKG
  if [ -f $PREF ]; then
    sed -i "/\"$KEY\"/d" $PREF
    sed -i "s|</map>|    <boolean name=\"$KEY\" value=\"false\" />\n</map>|" $PREF
  else
    mkdir -p $DIR
    printf '%s\n' "<?xml version='1.0' encoding='utf-8' standalone='yes' ?>" \
      "<map>" "    <boolean name=\"$KEY\" value=\"false\" />" "</map>" > $PREF
    chmod 771 $DIR
    chmod 660 $PREF
  fi
  chown -R $UID:$UID $DIR
  chcon -R `ls -dZ /data/data/$PKG | awk '{print $1}'` $DIR
fi

# grant
PKG=cn.wps.moffice_eng.xiaomi.lite
if appops get $PKG >/dev/null 2>&1; then
  pm grant --all-permissions $PKG
  appops_set
fi


