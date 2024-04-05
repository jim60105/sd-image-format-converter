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

# Get two file path from command line argument
$source = $args[0]
$destination = $args[1]
$filename = $source.Name

# Get the source and destination file extension
$sourceExtension = [System.IO.Path]::GetExtension($source)
$destinationExtension = [System.IO.Path]::GetExtension($destination)

Write-Host "Reading generation data for $($filename):`n---"

# Use exiftool to get generation data based on the source image file type
if ($sourceExtension -eq ".jpg" -or $sourceExtension -eq ".webp") {
    $info = exiftool -b -UserComment $source
}
elseif ($sourceExtension -eq ".png") {
    $info = exiftool -b -Parameters $source
}

Write-Host $($info -join "`r`n" | Out-String)
Write-Host "---"

# Write the obtained generation data to the target image file
if ($destinationExtension -eq ".jpg" -or $destinationExtension -eq ".webp") {
    exiftool -all= "-UserComment=$($info -join "`r`n" | Out-String)" -overwrite_original $destination
}
elseif ($destinationExtension -eq ".png") {
    exiftool -all= "-PNG:Parameters=$($info -join "`r`n" | Out-String)" -overwrite_original $destination
}

Write-Host "Generation data written to $($destination)."