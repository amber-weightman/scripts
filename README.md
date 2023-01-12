# scripts
Some handy scripts.


## spotify_player.ps1
PowerShell script for playing Spotify via the [Player API](https://developer.spotify.com/console/player/).

When executed, the script will authenticate against Spotify and will begin playback at 50% volume from the beginning of your queued or current track.

Initial authentication is a bit fiddly but after that's done it works like a charm. I might add more details later but the gist of it is:
1. Set up a new "App" on the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/applications). Only basic configuration is required here, enough to generate a `client_id` and `client_secret`. You don't actually need to _build an app_, and the Spotify `callback_uri` you set will not actually be _called_.

2. Generate a `refresh_token` for your personal Spotify Premium account via [Authorization Code Flow](https://developer.spotify.com/documentation/general/guides/authorization/code-flow/). This requires a couple of steps which can be executed via Postman, curl or GET requests directly in the browser. Some of this is a little bit fiddly (I'll add more details later), but you should only need to do this once.

3. Add the id, secret and token generated above into the `.ps1` script file. I should parameterise this, but I'll do that later.

4. Trigger the script file however you want. I set it up on Windows Task Scheduler to run at 6pm every weekday, as a nice distraction to help transition me out of work headspace.


Preconditions for the script to work:
* Spotify must be running on your machine and you must be logged in (either via the browser or the desktop app). I currently have the desktop app set to launch minimised on startup, but a step could easily be added into the script to launch the app if it isn't already running.
* Speakers must be switched on and enabled on your PC.