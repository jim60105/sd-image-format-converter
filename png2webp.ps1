Get-ChildItem "./" -Filter *.png | 
Foreach-Object {
    $output = "$([System.IO.Path]::GetFileNameWithoutExtension($_)).webp"
    magick "$($_.FullName)" $output
    exiftool -TagsFromFile "$($_.FullName)" "-UserComment<Parameters" -comment= -overwrite_original $output
}