<#
.SYNOPSIS
This PowerShell script converts image files from one format to another while preserving generation data for Stable Diffusion conventional usage.

.DESCRIPTION
The script takes two arguments: the source image file filter and the target image file type. It converts all image files in the current directory that match the filter to the target file type, retaining the generation data of the original images.

.PARAMETER Filter
The filter of the source image files to be converted. For example, "*.jpg". Check the Microsoft documents for more information. https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-filter. 

.PARAMETER TargetFileType
The file extension of the target image files. For example, ".png".

.EXAMPLE
.\format-converter.ps1 *.jpg .png
This command converts all .jpg files in the current directory to .png format, preserving generation data.

.NOTES
The script uses exiftool to extract EXIF information from the source images and ImageMagick's magick command to perform the conversion.
This script is licensed under the GNU General Public License version 3 (GPLv3).
For the full license text, see the LICENSE or COPYING file in the root of this project.
#>

# Check if the -h parameter is passed
if ($args -contains "-h") {
    Write-Host "Usage:"
    Write-Host "format-converter.ps1 <SourceImageFileType> <TargetImageFileType>"
    Write-Host "Example: format-converter.ps1 .jpg .png"
    Write-Host "This will convert all .jpg files in the current directory to .png format, preserving EXIF information."
    exit
}

# Define inputs from command-line arguments
$filter = $args[0] # Source image file type
$destinationExtension = $args[1] # Target image file type

if ($destinationExtension[0] -ne ".") {
    $destinationExtension = ".$destinationExtension"
}

Get-ChildItem "./" -Filter $filter | 
Foreach-Object {
    $info = "" # Used to store the EXIF information of the image
    $sourceExtension = [System.IO.Path]::GetExtension($_) # Get the file type of the source image

    # Use exiftool to get EXIF information based on the source image file type
    if ($sourceExtension -eq ".jpg" -or $sourceExtension -eq ".webp") {
        $info = exiftool -s3 -UserComment $source
    }
    elseif ($sourceExtension -eq ".png") {
        $info = exiftool -s3 -Parameters $source
    }

    # Generate the filename for the target image
    $output = "$([System.IO.Path]::GetFileNameWithoutExtension($_)).$destinationExtension"

    # Use ImageMagick's magick command to convert the image to the target format
    magick "$($_.FullName)" $output

    # Write the obtained EXIF information to the target image file
    if ($destinationExtension -eq ".jpg" -or $destinationExtension -eq ".webp") {
        exiftool -UserComment=$info -overwrite_original $output
    }
    elseif ($destinationExtension -eq ".png") {
        exiftool -PNG:Parameters=$info -overwrite_original $output
    }
}
