# scripts
Some handy scripts. Just one for now, but I might include some others later.

---
## spotify_player.ps1
PowerShell script for playing Spotify via the [Player API](https://developer.spotify.com/console/player/).

When executed, the script will authenticate against Spotify and will begin playback at 50% volume from the beginning of your queued or current track.

Initial authentication is a bit fiddly but after that's done it works like a charm. I might add more details later but the gist of it is:
### 1. Set up a new "App".

First, set up a new App on the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/applications). 

Only basic configuration is required here, enough to generate a `client_id` and `client_secret`. Don't worry, you don't actually need to "build an app".
![Spotify new app overview](https://user-images.githubusercontent.com/2852629/212524329-c008ae92-5e79-4313-940a-817c24dc91f8.PNG)

In Settings, you will also need to provide a `website` and `callback_uri`. You don't need anything running at these locations, but the values set here will be used for validation during the initial authentication process.
![Spotify app settings](https://user-images.githubusercontent.com/2852629/212524341-fdc21173-1820-4ad6-b8e4-b708c4c2ee28.PNG)

### 2. Generate a `refresh_token`

Next you will need to generate a `refresh_token` for your personal Spotify Premium account via [Authorization Code Flow](https://developer.spotify.com/documentation/general/guides/authorization/code-flow/). This requires a couple of steps which can be executed via Postman, curl or GET requests directly in the browser. Some of this is a little bit fiddly (I'll add more details later), but you should only need to do this once.

The Spotify Player API requires a premium account.

Once the token has been set up successfully, you will see the app permission listed against your personal profile.
![Spotify user permissions](https://user-images.githubusercontent.com/2852629/212524352-042c0520-32c5-43a4-832b-8f46de123fbf.PNG)

### 3. Pass the id, secret and token generated above into the `.ps1` script file
```
powershell -File Z:\Git\scripts\spotify_player.ps1 --cookie "redacted" --id "redacted" --secret "redacted" --token "redacted" --player "redacted"
```

Trigger the script file however you want. I set it up on Windows Task Scheduler to run at 6pm every weekday, as a nice distraction to help transition me out of work headspace.


