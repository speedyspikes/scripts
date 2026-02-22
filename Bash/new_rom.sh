#!/bin/bash
dir=$1

# if no argument provided, default to ~/Downloads
if [[ $dir = "" ]]; then
  dir="$HOME/Downloads"
fi

COL_DIR="\e[34m"    # blue for directories
COL_ZIP="\e[33m"   # yellow for .zip/.iso
COL_FILE="\e[32m"   # green for other files
COL_RST="\e[0m"

CURRENT_DIR="$dir"

while true; do
  echo
  echo "Working directory: $CURRENT_DIR"

  # gather items and sort alphabetically by basename (no grouping)
  entries=()
  shopt -s nullglob
  i=0
  for f in "$CURRENT_DIR"/*; do
    ((i++))
    [ -e "$f" ] || continue
    name=$(basename "$f")
    if [ -d "$f" ]; then
      printf "%3d) ${COL_DIR}%s${COL_RST}\n" "$i" "$name"
    elif [[ "$f" == *.zip ]]; then
      printf "%3d) ${COL_ZIP}%s${COL_RST}\n" "$i" "$name"
    elif [[ "$f" == *.iso || "$f" == *.wbfs ]]; then
      printf "%3d) ${COL_FILE}%s${COL_RST}\n" "$i" "$name"
    else
      printf "%3d) %s\n" "$i" "$name"
    fi
    entries+=("$f")
  done
  shopt -u nullglob

  if [ ${#entries[@]} -eq 0 ]; then
    echo "No items found in $CURRENT_DIR. Exiting."
    exit 0
  fi

  # Prompt user for selection
  echo
  while true; do
    read -rp $'Select a number (blank to exit): ' sel
    if [ -z "$sel" ]; then
      echo "No selection made. Exiting."
      exit 0
    fi
    if (( sel >= 1 && sel <= i )); then
      break
    else
      echo "Invalid selection. Please try again."
    fi
  done
  echo ${entries[$sel-1]}
  # continue the loop (repeat)
done