Get-ChildItem "./" -Filter *.jpg | 
Foreach-Object {
    $output = "$([System.IO.Path]::GetFileNameWithoutExtension($_)).webp"
    magick "$($_.FullName)" $output
    exiftool -TagsFromFile "$($_.FullName)" "-UserComment<UserComment" -comment= -overwrite_original $output
}