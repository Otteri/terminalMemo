#!/bin/bash

# This script lists all the notes inside directory and then
# outputs the user chosen note file to the terminal view

# Get the path to the directory where this file lies in
getPath() {
  path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
}

getPath
contents=()

# List all memo files
echo ""
echo "Select number:"
for file in $path/*
do
    filename=`basename "$file"`
    extension="${filename##*.}"
    if [ "$extension" == "txt" ]; then
      contents+=("$filename")
      name="${filename%.*}"
      echo "$name"
    fi
done

# Let user select
read page
section="${contents[$page-1]}"
clear

# Output file contents
path+=/"$section"
cat "$path"
echo