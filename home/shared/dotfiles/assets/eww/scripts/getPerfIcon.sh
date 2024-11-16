#!/bin/sh


MODE=$(asusctl profile --profile-get | awk '{print $4}')

case "$MODE" in
  "Quiet") echo "󱑭"
  ;;
  "Balanced") echo "󱜝"
  ;;
  "Performance") echo "󱑮" 
  ;;
esac
