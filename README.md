# Image Format Converter (for Stable Diffusion conventional usage)

This PowerShell script converts image files from one format to another while preserving generation data for Stable Diffusion conventional usage. It's designed to be a handy tool for developers and users who need to convert image formats while retaining Stable Diffusion generation data.

## Features

- Converts image files from one format to another (e.g., JPG to PNG).
- Supports various image formats including JPG, PNG, and WEBP.
- Preserves generation data during the conversion process.

## Prerequisites

- PowerShell 7 or later.
- [ImageMagick](https://imagemagick.org/index.php) installed on your system.
- [ExifTool](https://exiftool.org/) installed on your system.

## Installation

1. Clone the repository or download the script.
2. Ensure ImageMagick and ExifTool are installed on your system.
3. Run the script from the command line.

## Usage

```powershell
.\format-converter.ps1 <Filter> <TargetImageFileType>
```

For example, to convert all `.jpg` files in the current directory to `.png` format, you would run:

```powershell
.\format-converter.ps1 *.jpg .png
```

Check the [Microsoft documents](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-filter) for more information about the Filter.

## License

<img src="https://github.com/jim60105/sd-image-format-converter/assets/16995691/c528df1f-ac1b-4f8c-810e-73c83409608d" alt="gplv3" width="300" />

[GNU GENERAL PUBLIC LICENSE Version 3](LICENSE)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).
