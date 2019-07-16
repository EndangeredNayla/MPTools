. .\settings.ps1

if ($ENABLE_MANIFEST_BUILDER_MODULE) {
    .\twitch-export-builder.exe -n "$CLIENT_FILENAME" -p "$MODPACK_VERSION"
}

if ($ENABLE_CHANGELOG_GENERATOR_MODULE -and $ENABLE_MODPACK_UPLOADER_MODULE) {
    Remove-Item oldmanifest.json, manifest.json, shortchangelog.txt, MOD_CHANGELOGS.txt -ErrorAction SilentlyContinue
    if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed to generate changelogs"} 
    Set-Alias sz "$env:ProgramFiles\7-Zip\7z.exe"

    sz e "$CLIENT_FILENAME $LAST_MODPACK_VERSION.zip" manifest.json
    Rename-Item -Path manifest.json -NewName oldmanifest.json
    sz e "$CLIENT_FILENAME $MODPACK_VERSION.zip" manifest.json

    java -jar ChangelogGenerator.jar oldmanifest.json manifest.json
    Rename-Item Path changelog.txt -NewName MOD_CHANGELOGS.txt
}

if ($ENABLE_MODPACK_UPLOADER_MODULE) {
    $CLIENT_METADATA = "{
    'changelog': '$CLIENT_CHANGELOG',
    'changelogType': '$CLIENT_CHANGELOG_TYPE',
    'displayName': '$CLIENT_FILE_DISPLAY_NAME',
    'gameVersions': $GAME_VERSIONS,
    'releaseType': '$CLIENT_RELEASE_TYPE'
    }"
    
    Write-Host "Client Metadata: $CLIENT_METADATA"

    $Response = curl.exe --user "$CURSEFORGE_USER`:$CURSEFORGE_TOKEN" -H "Accept: application/json" -H X-Api-Token:$CURSEFORGE_TOKEN -F metadata=$CLIENT_METADATA -F file=@$CLIENT_FILENAME-$MODPACK_VERSION.zip https://minecraft.curseforge.com/api/projects/$CURSEFORGE_PROJECT_ID/upload-file | ConvertFrom-Json
    $RESPONSE_ID = $Response.id
    Write-Host $RESPONSE_ID
}

if ($ENABLE_SERVER_FILE_MODULE -and $ENABLE_MODPACK_UPLOADER_MODULE) {
    $SERVER_FILENAME = "$SERVER_FILENAME.zip"
    Compress-Archive -Path $CONTENTS_TO_ZIP -DestinationPath "$PSScriptRoot\$SERVER_FILENAME"

    $SERVER_METADATA = "{
        'changelog': '$SERVER_CHANGELOG',
        'changelogType': '$SERVER_CHANGELOG_TYPE',
        'displayName': '$SERVER_FILE_DISPLAY_NAME',
        'parentFileId': $RESPONSE_ID,
        'releaseType': '$SERVER_RELEASE_TYPE'
    }"

    Write-Host "Server Metadata: $SERVER_METADATA"

    curl.exe --user "$CURSEFORGE_USER`:$CURSEFORGE_TOKEN" -H "Accept: application/json" -H X-Api-Token:$CURSEFORGE_TOKEN -F metadata=$SERVER_METADATA -F file=@$SERVER_FILENAME https://minecraft.curseforge.com/api/projects/$CURSEFORGE_PROJECT_ID/upload-file

}

Write-Host "The Modpack Uploader has finished." -ForegroundColor Green
pause