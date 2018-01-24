## Geocaching Problem
Implemented a geocaching service with an exposed API in Ruby on Rails

Application is hosted at http://anyongeocaching.herokuapp.com/
## Actions
There are 3 end points.

1. Set Secret Message
````
POST http://anyongeocaching.herokuapp.com/geosecrets
params {
  lattitude: 52.5200,
  longitude: 13.4050,
  message: "Hello Berlin"
}
````
2. Get All messages within specified locations

````
GET http://anyongeocaching.herokuapp.com/geo_secrets/get_secrets?lattitude=51.9060&longitude=10.429&distance=100
````

2. Get Nearest message from specified locations

````
GET http://anyongeocaching.herokuapp.com/geo_secrets/get_nearest_secret?lattitude=51.9060&longitude=10.429
````
