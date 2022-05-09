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
 webview_flutter
 pdfx
 flutter_easyloading
 gesture_password_widget
 qr_code_scanner
)

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub remove ${dependencies[i]}
done

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub add ${dependencies[i]}
done

flutter pub get