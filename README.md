# 🔨 MPTools

# ❓ What is MPTools
MPTools is a Suite of Tools for Modpack Developers.

These tools can automate the process of uploading modpacks to CurseForge.
It creates a modpack manifest, which is then posted along with metadata to Curseforge for upload.
When the upload has completed, server files are attached which are generated from the tool.

Additionally this tool can fill the mods folder with mods from an exported instance, to make working through Git easier.

Almost everything can be toggled on/off in the settings.

## ⚡️ Usage
1. Clone the project into your Modded Minecraft Instance.
2. Fill in the client.json and the settings.ps1.
4. Double-click the ModpackUploader script or start ModpackUploader.ps1 using the command line.

## 💡 Dependencies
* ❌ [7-Zip](https://www.7-zip.org/download.html) by IgorPavlov
* ✔️ [CFExporter](https://github.com/Gaz492/CFExporter) by [Gaz492](https://github.com/Gaz492/)
* ❌ [cURL](https://curl.haxx.se/download.html) by RafaelSagula
* ✔️ [Curse Changelog Generator](https://github.com/TheRandomLabs/ChangelogGenerator) by [TheRandomLabs](https://github.com/TheRandomLabs) -  Automatically Downloaded
* ✔️ [ModpackDownloader-Next](https://github.com/EndangeredNayla/ModpackDownloader-Next) originally authored by [Chon33](https://github.com/Chon33/) and forked by [me](https://github.com/EndangeredNayla)

❌ means not Automatically Downloaded | ✔️ means Automatically Downlaoded

## 🌐 Credits
A big thanks goes out to:

* [Curse.tools](https://curse.tools/) for unauthenticated access to the CurseForge API.

* [NielsPilgaard](https://github.com/NielsPilgaard) for the original [Modpack Uploader](https://github.com/EnigmaticaModpacks/ModpackUploader) that I originally contributed too before the rewrite.
