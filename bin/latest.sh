#!/bin/bash

dependencies=(
 intl
)

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub remove ${dependencies[i]}
done

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub add ${dependencies[i]}
done

flutter pub get