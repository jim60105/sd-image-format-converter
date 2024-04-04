# Get two file path from command line argument
$source = $args[0]
$destination = $args[1]

# Get the source and destination file extension
$sourceExtension = [System.IO.Path]::GetExtension($source)
$destinationExtension = [System.IO.Path]::GetExtension($destination)

# extract info from source file
if ($sourceExtension -eq ".jpg" -or $sourceExtension -eq ".webp") {
    $info = exiftool -s3 -UserComment $source
}
elseif ($sourceExtension -eq ".png") {
    $info = exiftool -s3 -Parameters $source
}

# write info to destination file
if ($destinationExtension -eq ".jpg" -or $destinationExtension -eq ".webp") {
    exiftool -UserComment=$info -overwrite_original $destination
}
elseif ($destinationExtension -eq ".png") {
    exiftool -PNG:Parameters=$info -overwrite_original $destination
}
