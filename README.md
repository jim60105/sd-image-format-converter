# Image Format Converter (for Stable Diffusion generation data)

![00095-1675057571](https://github.com/jim60105/sd-image-format-converter/assets/16995691/399769e2-6904-44f9-bfcb-f09bdfe42a50)
<sup>↑ An image <a href="https://civitai.com/images/9372163" target="_blank">from the stable diffusion</a> that doesn't explain anything about this project.</sup>

[![CodeFactor](https://www.codefactor.io/repository/github/jim60105/sd-image-format-converter/badge)](https://www.codefactor.io/repository/github/jim60105/sd-image-format-converter)

This PowerShell script / Bash script is designed to efficiently convert image files from one format to another, ensuring that the generation data for Stable Diffusion conventional usage is preserved. It serves as a convenient tool for users who require image format conversions while maintaining the integrity of Stable Diffusion generation data.

The converted images are compatible with [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) and [Civitai](https://civitai.com/).

## Features

- Converts image files from one format to another (e.g., jpg to png).
- Supports various image formats including jpg, png, webp, and avif.
- Ensures the preservation of generation data throughout the entire conversion process.

> [!NOTE]
> Why avif😉  
> ![2024-07-11-044623](https://github.com/jim60105/sd-image-format-converter/assets/16995691/ffaeac03-af05-4063-b94d-d9b756611da3)  
> Avif is supported by [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui/pull/15582).

## Prerequisites

- PowerShell 7.
- [ImageMagick](https://imagemagick.org/index.php) installed on your system.
- [ExifTool](https://exiftool.org/) _**v12.81 or later**_ installed on your system.

> [!IMPORTANT]  
> Your ExifTool version must be **v12.81 or later** to ensure the preservation of generation data during the conversion process. If you are using an older version of ExifTool, please update to the latest version before running the script.

## Installation

1. Clone the repository or download the script.
2. Verify that ImageMagick and ExifTool are properly installed on your system.
3. Execute the script by running it from the command line.

> [!CAUTION]
> Ensure that you have the necessary permissions to execute the script on your system. If you encounter any issues, please check this [Microsoft documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies) first.

> [!NOTE]
> It is necessary to have both [`copy-info.ps1`](copy-info.ps1) and [`format-converter.ps1`](format-converter.ps1) placed in the same directory for `format-converter.ps1` to work.  
> Similarly, for the bash script, ensure [`copy-info.sh`](copy-info.sh) and [`format-converter.sh`](format-converter.sh) are in the same directory.

## Usage

### Bash

```bash
./format-converter.sh <Filter> <TargetImageFileType>
```

### PowerShell

```powershell
.\format-converter.ps1 <Filter> <TargetImageFileType>
```

For example, to convert all `.jpg` files in the current directory to `.png` format, you would run:

```powershell
.\format-converter.ps1 *.jpg .png
```

Check the [Microsoft documents](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-filter) for more information about the Filter.

If you want to convert exactly one file, you can specify the file name directly:

```powershell
.\format-converter.ps1 example.jpg .png
```

## License

<img src="https://github.com/jim60105/sd-image-format-converter/assets/16995691/c528df1f-ac1b-4f8c-810e-73c83409608d" alt="gplv3" width="300" />

[GNU GENERAL PUBLIC LICENSE Version 3](LICENSE)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).
