# Sweater Weather API

![ruby](https://img.shields.io/badge/Ruby-2.7.4-red)
![rails](https://img.shields.io/badge/Rails-5.2.8-red)

## Table of Contents
- [Background](#background)
- [Schema](#schema)
- [Endpoints](#endpoints)
- [Requirements](#requirements)
- [Setup](#setup)

## Background

**Tea Subscription API** exposes endpoints for a Tea Subscription application frontend. 

This Rails Api is a solo challenge during MOD 4 at [Turing School of Software and Design](https://www.turing.edu)

Features:
 - Endpoint to get all of a customer's subscriptions
 - Endpoint to subscribe a customer to a tea subscription
 - Endpoint to cancel a customer's tea subscription
 
## Database Schema
![tea_subscriptions](https://user-images.githubusercontent.com/93014155/182994624-180a412f-45bb-4774-9485-5764785449f3.png)


## Endpoints

- Get all of a customer's subscriptions
```shell
GET /api/v1/customers/{customer_id}/teas
```
---
```json
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Rooibus Subscription",
                "price": 1234,
                "status": "active",
                "frequency": "monthly"
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "Irish Breakfast Subscription",
                "price": 2000,
                "status": "cancelled",
                "frequency": "monthly"
            }
        },
        {
            "id": "4",
            "type": "subscription",
            "attributes": {
                "title": "Peppermint Subscription",
                "price": 2000,
                "status": "active",
                "frequency": "monthly"
            }
        }
    ]
}
```

- Register User
```shell
POST api/v1/users
Content-Type: application/json
Accept: application/json
body: {
  "email": "hello@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
---
```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "hello@example.com",
            "api_key": "SOME API KEY"
        }
    }
}
```

- Login User
```shell
POST api/v1/sessions
Content-Type: application/json
Accept: application/json
body: {
  "email": "hello@example.com",
  "password": "password"
}
```
---
```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "hello@example.com",
            "api_key": "SOME API KEY"
        }
    }
}
```

- Road Trip
```shell
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json
body: {
  "origin": "Atlanta, GA",
  "destination": "Cincinnati, OH",
  "api_key": "SOME API KEY"
}
```
---
```
{
    "data": {
        "id": "null",
        "type": "roadtrip",
        "attributes": {
            "start_city": "Atlanta, GA",
            "end_city": "Cincinnati, OH",
            "travel_time": "7 hours, 4 minutes",
            "weather_at_eta": {
                "temperature": 74.3,
                "conditions": "clear sky"
            }
        }
    }
}
```

## Requirements

### API
[OpenWeather One Call API](https://openweathermap.org/api/one-call-api) follow instructions to get API key for v2.5.

[MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api) follow instructions to get API key.

[MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api) you only need the one key for MapQuest.

[Microsoft Bing Image Search](portal.azure.com) You need to set up a API key for Bing through Azure.


## Setup
1. Clone this repository on your local machine.

2. Install required Gems utilizing Bundler: <br>
- In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.
```shell
$ gem install bundler
```

- If Bundler is already installed or after it has been installed, run the following command.
```shell
$ bundle install
```

3. Database Migration<br>
- Before using the web application you will need to setup your databases locally by running the following command
```shell
$ rails db:{drop,create,migrate}
```
4. Setup Figaro
```shell
$ bundle exec figaro install
```
- That will create an `config/application.yml` file.

- Add your api keys to new this new file.
```shell
#config/application.yml
mapquest_key: <your mapquest key here>
open_weather_key: <your open weather key here>
bing_images_key: <your azure key here>
```

5. Startup and Access<br>
- Start the server locally.

- Start server
```shell
$ rails s
```

- Open Postman and [import this collection](https://github.com/wmedders21/sweater_weather/blob/main/Sweater%20Weather.postman_collection.json) to get started.
