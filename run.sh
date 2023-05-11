#!/bin/bash

# Check if a path was provided as an argument
if [ -z "$1" ]; then
  echo -e "\033[1;41m Please provide a path to the folder containing images \033[0m"
  exit 1
fi

# Define the directory to search for images
dir="$1"

# Find all .jpg, .jpeg and .png files in the directory and its subdirectories
find "$dir" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) -print0 | while read -d $'\0' file
do
  # Create the new file name with .webp extension
  new_file="${file%.*}.webp"

  # Convert the file to .webp format using cwebp command
  cwebp -quiet -q 80 "$file" -o "$new_file"
    
  # Check if the conversion was successful
  if [ $? -eq 0 ]; then
    # Print a colorful message indicating successful conversion
    echo -e "\033[32mConverted\033[0m $file \033[32mto\033[0m $new_file"
      
    # Uncomment the following line to remove the original file after conversion
    # rm "$file"
  else
    # Print a colorful error message indicating conversion failure
    echo -e "\033[31mError\033[0m converting $file to $new_file"
  fi
done

# Print a colorful message indicating completion of the conversion process
echo -e "\033[1;35mConversion complete! \033[1;33mTAZER\033[1;35m rules! \033[0m"
