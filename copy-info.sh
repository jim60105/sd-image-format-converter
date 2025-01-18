#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: copy-info.sh <SOURCE> <DESTINATION>"
    echo "Example: copy-info.sh source.webp target.png"
    echo "This will copy Stable Diffusion generation data from a source image file to a target image file."
    echo "Current supported file types: .jpg, .webp, .png, .avif"
    exit 1
}

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ] || [[ "$1" == "-h" ]]; then
    usage
fi

# Get two file path from command line argument
source=$1
destination=$2

# Get the source and destination file extension
sourceExtension="${source##*.}"
destinationExtension="${destination##*.}"

echo "Copying Stable Diffusion generation data from $source to $destination..."

if [[ "$sourceExtension" != "png" && "$destinationExtension" != "png" ]]; then
    exiftool -b -tagsFromFile "$source" "-UserComment>UserComment" -overwrite_original "$destination"
    exit 0
fi

if [[ "$sourceExtension" == "png" ]]; then
    exiftool -b -tagsFromFile "$source" "-PNG:Parameters>UserComment" -overwrite_original "$destination"
    exit 0
fi

exiftool -b -tagsFromFile "$source" "-UserComment>PNG:Parameters" -overwrite_original "$destination"
