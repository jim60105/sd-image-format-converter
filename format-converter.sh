#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: format-converter.sh <Filter> <TargetImageFileType>"
    echo "Example: format-converter.sh '*.jpg' .png"
    echo "This will convert all .jpg files in the current directory to .png format, preserving Stable Diffusion generation data."
    echo "Current supported file types: .jpg, .webp, .png, .avif"
    exit 1
}

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ] || [[ "$1" == "-h" ]]; then
    usage
fi

# Define inputs from command-line arguments
filter=$1
destinationExtension=$2

# Check if the destination extension starts with a dot
if [[ $destinationExtension != .* ]]; then
    destinationExtension=".$destinationExtension"
fi

# Get where the script is located
scriptPath=$(dirname "$(realpath "$0")")

files=$(find . -type f -name "$filter")
for file in $files; do
    echo "Converting $file to $destinationExtension format..."
    filename=$(basename "$file")
    output="${filename%.*}$destinationExtension"

    # Use magick command from ImageMagick to convert the image to the target format
    case $destinationExtension in
        .avif)
            magick -quality 80 -define "heic:speed=2" "$file" "$output"
            ;;
        .webp)
            magick -quality 100 -define webp:lossless=true "$file" "$output"
            ;;
        *)
            magick "$file" "$output"
            ;;
    esac

    echo "Conversion complete. $filename has been converted to $output."

    # Call the copy-info script
    ("$scriptPath"/copy-info.sh "$file" "$output")
done
