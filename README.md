# ModpackUploadTool

This tool can automate the process of uploading modpacks to Curseforge.
It creates a modpack manifest, which is then posted along with metadata to Curseforge for upload.
When the upload has completed, server files are attached. 
The server files are automatically generated from the files you specify.

## Usage
* Unzip the file into your modded Minecraft Instance.
* Fill in the .build.json file with appropriate information - This specifies the manifest information. The mods folder is automatically included.
* Fill in the modpack_upload_settings.cfg - Each variable is explained in the document. It is best viewed in Visual Studio Code.

## Dependencies
* 7-Zip - https://www.7-zip.org/download.html
* cURL - https://curl.haxx.se/download.html
 
## Known issues
* Currently only works on Windows

### Credits
A huge thanks goes out to Gaz492 for his Twitch Export Builder project, which made this tool possible.

https://github.com/Gaz492/twitch-export-builder/
