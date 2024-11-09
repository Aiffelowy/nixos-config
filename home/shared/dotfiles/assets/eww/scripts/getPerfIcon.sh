#!/bin/sh


MODE=$(asusctl profile --profile-get | awk '{print $4}')

case "$MODE" in
  "Quiet") echo $'\uefd8'
  ;;
  "Balanced") echo $'\ueaf6'
  ;;
  "Performance") echo $'\ue9e4'
  ;;
esac
