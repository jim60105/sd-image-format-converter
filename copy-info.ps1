<#
.SYNOPSIS
This PowerShell script is designed to copy Stable Diffusion generation data from a source image file to a target image file.

.DESCRIPTION
The script takes two file paths as command-line arguments: the source file path and the destination file path. It reads the generation data from the source file based on its file extension (.jpg, .webp, or .png) and writes this data to the target file. This ensures that the generation data is maintained during the conversion process, making it a convenient tool for users working with Stable Diffusion generation data.

.PARAMETER SOURCE
The path to the source image file.

.PARAMETER DESTINATION
The path to the target image file.

.EXAMPLE
.\copy-info.ps1 source.webp target.png

This command copies the generation data from 'source.webp' to 'target.png'.

.NOTES
This script requires ExifTool to be installed on the system. It is used to read and write the generation data to the image files.

.LINK
https://github.com/jim60105/sd-image-format-converter
#>

# Check if the -h parameter is passed or not exactly two arguments are passed
if ($args.Count -ne 2 -or $args -contains "-h") {
    Write-Output "Usage: copy-info.ps1 <SOURCE> <DESTINATION>"
    Write-Output "Example: copy-info.ps1 source.webp target.png"
    Write-Output "This will copy Stable Diffusion generation data from a source image file to a target image file."
    Write-Output "Current supported file types: .jpg, .webp, .png, .avif"
    exit
}

# Get two file path from command line argument
$source = $args[0]
$destination = $args[1]

# Get the source and destination file extension
$sourceExtension = [System.IO.Path]::GetExtension($source)
$destinationExtension = [System.IO.Path]::GetExtension($destination)

if ($sourceExtension -ne ".png" -and $destinationExtension -ne ".png") {
    exiftool -b -tagsFromFile $source "-UserComment>UserComment" -overwrite_original $destination
    exit 0
}

if ($sourceExtension -eq ".png") {
    exiftool -b -tagsFromFile $source "-PNG:Parameters>UserComment" -overwrite_original $destination
}
else {
    exiftool -b -tagsFromFile $source "-UserComment>PNG:Parameters" -overwrite_original $destination
}
