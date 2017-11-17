# Personal website

Currently built using [Middleman](http://middlemanapp.com/).

## Development

```bash
$ bundle install
$ cp lib/.env{.sample,}
```

Edit `lib/.env` to add your RubyGems and WordPress developer username and [Personal access token from GitHub](https://github.com/settings/tokens).

## Running the app

```bash
$ middleman
== The Middleman is loading
== Locales: en, es (Default en)
== LiveReload is waiting for a browser to connect
== The Middleman is standing watch at http://0.0.0.0:4567
== Inspect your site configuration at http://0.0.0.0:4567/__middleman/
```

Published to [fernandobriano.com](http://fernandobriano.com) with [middleman-deploy](https://github.com/middleman-contrib/middleman-deploy).
