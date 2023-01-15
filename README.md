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
![Spotify new app overview](./Images/app_overview.png)

In Settings, you will also need to provide a `website` and `callback_uri`. You don't need anything running at these locations, but the values set here will be used for validation during the initial authentication process.
![Spotify app settings](./Images/app_settings.png)

### 2. Generate a `refresh_token`

Next you will need to generate a `refresh_token` for your personal Spotify Premium account via [Authorization Code Flow](https://developer.spotify.com/documentation/general/guides/authorization/code-flow/). This requires a couple of steps which can be executed via Postman, curl or GET requests directly in the browser. Some of this is a little bit fiddly (I'll add more details later), but you should only need to do this once.

The Spotify Player API requires a premium account.

Once the token has been set up successfully, you will see the app permission listed against your personal profile.
![Spotify user permissions](./Images/permission_granted.png)

### 3. Pass the id, secret and token generated above into the `.ps1` script file
```
powershell -File Z:\Git\scripts\spotify_player.ps1 --cookie "redacted" --id "redacted" --secret "redacted" --token "redacted" --player "redacted"
```

Trigger the script file however you want. I set it up on Windows Task Scheduler to run at 6pm every weekday, as a nice distraction to help transition me out of work headspace.

---

Preconditions for the script to work:
* Spotify must be running on your machine and you must be logged in (either via the browser or the desktop app). I currently have the desktop app set to launch minimised on startup, but a step could easily be added into the script to launch the app if it isn't already running.
* Speakers must be switched on and enabled on your PC.


