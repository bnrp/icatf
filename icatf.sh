#!/bin/bash

# Display all images in a directory (must be JPEG or PNG for now)
# Usage: icatf <subdirectory> <prefix> or icatf -d <subdirectory> -p <prefix>

dir="$(pwd)/"
verbose=true

# Check for input flags -d for directory -p for prefixes
while getopts 'sd:p:' OPTION; do
  case "$OPTION" in
    s)
      verbose=false
      ;;
    d)
      input_dir=$OPTARG
      [[ $input_dir == /* ]] && input_dir="${input_dir:1}"
      dir=$dir$input_dir
      ;;
    p)
      prefix=$OPTARG
      ;;
    ?)
      echo "icatf usage w/ flags: icatf [-d subdirectory] [-p file prefix] [-s]" >&2
      echo "icatf usage w/o flags: icatf <subdirectory or . for current directory> <file prefix>" >&2
      exit 1
      ;;
  esac
done

# If no input flags, use positional arguments
if [[ $1 != -* ]]; then
  input_dir=$1
  # Allow . to mean current directory
  [[ $input_dir == . ]] && input_dir=""
  [[ $input_dir == /* ]] && input_dir="${input_dir:1}"
  dir=$dir$input_dir 
  prefix=$2
fi

# Check to ensure images exist in directory
files=$(ls $dir | grep ${prefix:-""} | grep -E '\.jpg|\.jpeg|\.png')

# Exit if no images to be found
[[ $files == "" ]] && echo "No image files found..." && exit 1

# If verbose, print directory and prefix if prefix is not none
$verbose && echo -en "\033[1mDisplaying images in ${dir}\033[0m" && [[ $prefix != "" ]] && echo -e "\033[1m starting with \"${prefix}\"\033[0m\n" || echo -e "\n" 

# Echo filename and display image
echo "$files" | while read line
do
  echo "${line}" &&
  kitty + kitten icat --stdin=no $dir$line < /dev/null
done

lines=$(echo "$files" | wc -l)
$verbose && echo -e "\033[1mDisplayed $lines images!\033[0m"
