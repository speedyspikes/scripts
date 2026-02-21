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
      type="dir"
    elif [[ "$f" == *.zip ]]; then
      printf "%3d) ${COL_ZIP}%s${COL_RST}\n" "$i" "$name"
      type="zip"
    elif [[ "$f" == *.iso || "$f" == *.wbfs ]]; then
      printf "%3d) ${COL_FILE}%s${COL_RST}\n" "$i" "$name"
      type="file"
    else
      printf "%3d) %s\n" "$i" "$name"
      type="file"
    fi
    entries+=("$f$'\t'$type")
  done
  shopt -u nullglob

  if [ ${#entries[@]} -eq 0 ]; then
    echo "No items found in $CURRENT_DIR. Exiting."
    exit 0
  fi

  echo
  read -rp $'Select a number, or type a path (blank to exit): ' sel
  if [ -z "$sel" ]; then
    echo "No selection made. Exiting."
    exit 0
  fi

  selected=""
  if [[ "$sel" =~ ^[0-9]+$ ]]; then
    num=$((sel-1))
    if [ "$num" -lt 0 ] || [ "$num" -ge "${#items[@]}" ]; then
      echo "Invalid selection number. Try again."
      continue
    fi
    selected="${items[$num]}"
    sel_type="${types[$num]}"
  else
    # treat input as filepath
    if [ -e "$sel" ]; then
      selected="$sel"
      if [ -d "$sel" ]; then
        sel_type="dir"
      else
        sel_type="file"
      fi
    else
      echo "Provided path does not exist: $sel"
      continue
    fi
  fi

  if [ "$sel_type" = "dir" ]; then
    read -rp $'Selected a folder. Type "m" to move, "g" to go into it, or blank to cancel: ' op
    if [ -z "$op" ]; then
      echo "Canceled."
      continue
    fi
    if [[ "$op" =~ ^[Gg]$ ]]; then
      CURRENT_DIR="$selected"
      continue
    elif [[ "$op" =~ ^[Mm]$ ]]; then
      to_move="$selected"
    else
      echo "Unknown option. Returning to list."
      continue
    fi
  else
    to_move="$selected"
  fi

  echo
  echo "Choose destination:"
  echo " 1) gamecube"
  echo " 2) wii"
  echo " 3) wiiu"
  read -rp $'Enter number or provide a custom path: ' destsel

  if [[ "$destsel" =~ ^[0-9]+$ ]]; then
    case "$destsel" in
      1) dest="$DEST_ROOT/gamecube" ;;
      2) dest="$DEST_ROOT/wii" ;;
      3) dest="$DEST_ROOT/wiiu" ;;
      *) echo "Invalid number. Move canceled."; continue ;;
    esac
  else
    if [ -z "$destsel" ]; then
      echo "No destination provided. Move canceled."
      continue
    fi
    dest="$destsel"
  fi

  mkdir -p "$dest"
  mv -v "$to_move" "$dest/"
  echo "Moved '$(basename "$to_move")' to '$dest'"

  # continue the loop (repeat)
done