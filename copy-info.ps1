# Get two file path from command line argument
$source = $args[0]
$destination = $args[1]

# Get the source and destination file extension
$sourceExtension = [System.IO.Path]::GetExtension($source)
$destinationExtension = [System.IO.Path]::GetExtension($destination)

# extract info from source file
if ($sourceExtension -eq ".jpg" -or $sourceExtension -eq ".webp") {
    $info = exiftool -b -UserComment $source
}
elseif ($sourceExtension -eq ".png") {
    $info = exiftool -b -Parameters $source
}

exiftool -all= -overwrite_original $output

Write-Host "Generation data for $($source): $info"

# write info to destination file
if ($destinationExtension -eq ".jpg" -or $destinationExtension -eq ".webp") {
    exiftool -all= "-UserComment=$($info -join "`r`n" | Out-String)" -overwrite_original $destination
}
elseif ($destinationExtension -eq ".png") {
    exiftool -all= "-PNG:Parameters=$($info -join "`r`n" | Out-String)" -overwrite_original $destination
}
