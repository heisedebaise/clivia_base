#!/bin/bash

dependencies=(
 provider
 path_provider
 shared_preferences
 dio
 url_launcher
 image_picker
 file_picker
 image
 extended_image
 mime
 webview_flutter
 webview_flutter_web
 pdfx
 flutter_easyloading
 gesture_password_widget
 qr_code_scanner
 badges
 flutter_datetime_picker
 package_info_plus
)

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub remove ${dependencies[i]}
done

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub add ${dependencies[i]}
done

flutter pub get