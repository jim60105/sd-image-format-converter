<#
.SYNOPSIS
This PowerShell script is designed to efficiently convert image files from one format to another, ensuring that the generation data for Stable Diffusion conventional usage is preserved.

.DESCRIPTION
This PowerShell script is designed to efficiently convert image files from one format to another, ensuring that the generation data for Stable Diffusion conventional usage is preserved. It serves as a convenient tool for users who require image format conversions while maintaining the integrity of Stable Diffusion generation data.

.PARAMETER Filter
The filter of the source image files to be converted. For example, "*.jpg". Check the Microsoft documents for more information. https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-filter. 

.PARAMETER TargetFileType
The file extension of the target image files. For example, ".png".

.EXAMPLE
.\format-converter.ps1 *.jpg .png
This command converts all .jpg files in the current directory to .png format, preserving generation data.

.NOTES
The script uses exiftool to extract generation data from the source images and ImageMagick's magick command to perform the conversion.
This script is licensed under the GNU General Public License version 3 (GPLv3).
For the full license text, see the LICENSE or COPYING file in the root of this project.
#>

# Check if the -h parameter is passed or not exactly two arguments are passed
if ($args.Count -ne 2 -or $args -contains "-h") {
    Write-Host "Usage:"
    Write-Host "format-converter.ps1 <SourceImageFileType> <TargetImageFileType>"
    Write-Host "Example: format-converter.ps1 .jpg .png"
    Write-Host "This will convert all .jpg files in the current directory to .png format, preserving Stable Diffusion generation data."
    exit
}

# Define inputs from command-line arguments
$filter = $args[0] # Source image file filter
$destinationExtension = $args[1] # Target image file type

# Check if the destination extension starts with a dot
if ($destinationExtension[0] -ne ".") {
    $destinationExtension = ".$destinationExtension"
}

Get-ChildItem "./" -Filter $filter | 
Foreach-Object {
    Write-Host "Converting $($_) to $destinationExtension format..."
    $info = ""
    $sourceExtension = [System.IO.Path]::GetExtension($_)
    $output = "$([System.IO.Path]::GetFileNameWithoutExtension($_))$destinationExtension"

    # Use ImageMagick's magick command to convert the image to the target format
    magick "$($_.FullName)" $output

    Write-Host "Conversion complete. $($_) has been converted to $output."

    # Use exiftool to get generation data based on the source image file type
    if ($sourceExtension -eq ".jpg" -or $sourceExtension -eq ".webp") {
        $info = exiftool -s3 -UserComment $_
    }
    elseif ($sourceExtension -eq ".png") {
        $info = exiftool -s3 -Parameters $_
    }

    Write-Host "generation data for $($_): $info"

    # Write the obtained generation data to the target image file
    if ($destinationExtension -eq ".jpg" -or $destinationExtension -eq ".webp") {
        exiftool -UserComment=$info -overwrite_original $output
    }
    elseif ($destinationExtension -eq ".png") {
        exiftool -PNG:Parameters=$info -overwrite_original $output
    }

    Write-Host "generation data has been copied to $output."
}
