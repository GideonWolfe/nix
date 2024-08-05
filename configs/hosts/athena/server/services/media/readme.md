# Services

## NZBGet

Connects directly to Usenet provider to grab blocks that the indexers find and download them

### Configuring

You must add the **Usenet Providers** to the downloader, so NZBGet knows where to download the files froṁ

Settings > News-Servers

Use the login details from Newshosting, Eweka, or whatever your provider is.

## Prowlarr

Keeps track of all indexers/trackers and pushes the indexers to all the *arr apps

## Configuring

You must add the **Indexers**, or the programs that search through the Usenet providers to find files

Indexers > Add

Then choose one or more of the preset indexers and log into it

### Radarr, Sonarr, Lidarr

* Radarr: Tracks movies
* Sonarr: Tracks tv shows
* Lidarr: Tracks music

### Configuring

For each app, go to `Settings > Media Management` and select the root path. Will be either `/movies`, `/tv`, or `/music`

For each app, go to `Settings > Download Clients` and select NZBGet. Enter in the username/pass key from NZBGet. Since all containers are on the same `docker` network, the hostname is simply `nzbget`

### Jellyfin

Media Server

### Jellyseer

Requests for Jellyfin
