# Spotify for Developers: https://developer.spotify.com/console/player/

echo "------- SPOTIFY PLAYER -------`nStop work, it's music time!`n"


# 0. ENABLE LOGGING -------------------------------------------------------------------------------------------------
echo "`nEnabling logging..."
Start-Transcript


# 1. AUTHENTICATE -------------------------------------------------------------------------------------------------
echo "`nAuthenticating..."
$authheaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$authheaders.Add("Content-Type", "application/x-www-form-urlencoded")
$authheaders.Add("Cookie", <INSERT-SPOTIFY-COOKIE>)

$body = "grant_type=refresh_token&refresh_token=<INSERT-SPOTIFY-REFRESH-TOKEN>&client_id=<INSERT-SPOTIFY-CLIENTID>&client_secret=<INSERT-SPOTIFY-CLIENTSECRET>"

$authresponse = Invoke-RestMethod 'https://accounts.spotify.com/api/token' -Method 'POST' -Headers $authheaders -Body $body
# $authresponse | ConvertTo-Json

echo "Access token: " $authresponse.access_token

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Authorization", "Bearer " + $authresponse.access_token)


# 2. GET DEVICES -------------------------------------------------------------------------------------------------
# Will set <INSERT-DEFAULT-PLAYER-NAME> as the default device, and if not available will use any other device
echo "`nFetching available devices..."
$deviceresponse = Invoke-RestMethod 'https://api.spotify.com/v1/me/player/devices' -Method 'GET' -Headers $headers

$playbackdevice = $deviceresponse.devices.Where({$_.name -eq "<INSERT-DEFAULT-PLAYER-NAME>"}).id
if ([string]::IsNullOrEmpty($playbackdevice))
{
    $playbackdevice = $deviceresponse.devices[0].id
}

echo "Playback device id: " $playbackdevice


# 3. TRANSFER PLAYBACK -------------------------------------------------------------------------------------------------
# Set device for active playback
echo "`nSetting active playback device..."
$body = "{
`n  `"device_ids`": [
`n    `""+ $playbackdevice +"`"
`n  ]
`n}"
$setdeviceresponse = Invoke-RestMethod 'https://api.spotify.com/v1/me/player' -Method 'PUT' -Headers $headers -Body $body

echo "Playback device has been set"


# 4. SET POSITION -------------------------------------------------------------------------------------------------
# Begin playback from the beginning of the queued/recent track
$setpositionurl = "https://api.spotify.com/v1/me/player/seek?position_ms=0&device_id="+$playbackdevice
$response = Invoke-RestMethod $setpositionurl -Method 'PUT' -Headers $headers


# 5. SET VOLUME -------------------------------------------------------------------------------------------------
$setvolumeurl = "https://api.spotify.com/v1/me/player/volume?volume_percent=50&device_id="+$playbackdevice
$response = Invoke-RestMethod $setvolumeurl -Method 'PUT' -Headers $headers


# 6. PLAY -------------------------------------------------------------------------------------------------
# Will play whatever is currently queued
echo "`nPlaying music..."
$response = Invoke-RestMethod 'https://api.spotify.com/v1/me/player/play' -Method 'PUT' -Headers $headers
echo "[There ought to be some nice music playing now]"


# 7. END LOGGING -------------------------------------------------------------------------------------------------
echo "`nEnd logging..."
Stop-Transcript


echo "`nPress Enter to pause"
pause


# 8. PAUSE -------------------------------------------------------------------------------------------------
# Will pause playback
echo "`nPausing music..."
$response = Invoke-RestMethod 'https://api.spotify.com/v1/me/player/pause' -Method 'PUT' -Headers $headers

pause
