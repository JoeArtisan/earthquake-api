# Earthquake API

Desarrollar un aplicación en Ruby o framework basado en Ruby que contemple una Task para obtener y persistir datos y una API que exponga dos endpoints que serán consultados desde un cliente externo.

## Installation

- Clone the repo:
```
git clone https://github.com/JoeArtisan/earthquake-api.git
```

- Run setup script
```
./bin/setup
```

## Request features using Rake Task

```
# List all earthquakes in the past month
rake usgs_gov:get

```

## View results in browser

Start your local rails server
```
rails server
```
