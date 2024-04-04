Get-ChildItem "./" -Filter *.webp | 
Foreach-Object {
    $output = "$([System.IO.Path]::GetFileNameWithoutExtension($_)).png"
    magick "$($_.FullName)" $output
    exiftool -TagsFromFile "$($_.FullName)" "-PNG:Parameters<UserComment" -overwrite_original $output
}