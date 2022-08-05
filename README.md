# Tea Subscription API

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

- Subscribe a customer to a tea subscription
```shell
POST api/v1/customers/{customer_id}/teas
Content-Type: application/json
Accept: application/json
body: {
  "tea_id": 3
}
```
---
```json
{
    "data": {
        "id": "5",
        "type": "subscription",
        "attributes": {
            "title": "Peppermint Subscription",
            "price": 2000,
            "status": "active",
            "frequency": "monthly"
        }
    }
}
```
- Cancel a subscription
```shell
PATCH /api/v1/customers/{customer_id}/teas/{tea_id}
Content-Type: application/json
Accept: application/json
body: {
  "status": 1
}
```
---
```json
{
    "data": {
        "id": "3",
        "type": "subscription",
        "attributes": {
            "title": "Irish Breakfast Subscription",
            "price": 2000,
            "status": "cancelled",
            "frequency": "monthly"
        }
    }
}
```

## Requirements

- Ruby 2.7.4
- Rails 5.2.8
- PostgreSQL 14.4
- 
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
$ rails db:{drop,create,migrate,seed}
```

5. Startup and Access<br>
- Start the server locally.

- Start server
```shell
$ rails s
```

- Open Postman and [import this collection](https://github.com/wmedders21/tea_subscription/blob/main/Requests.postman_collection.json) to make sample requests.
