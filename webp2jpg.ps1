Get-ChildItem "./" -Filter *.webp | 
Foreach-Object {
    $output = "$([System.IO.Path]::GetFileNameWithoutExtension($_)).jpg"
    magick "$($_.FullName)" $output
    exiftool -TagsFromFile "$($_.FullName)" "-UserComment<UserComment" -overwrite_original $output
}