# README

Getting started:

- Make sure you are using Rails 5, this is a must. We are all currently using Ruby 2.2.3p173  or Ruby 2.3.1p112. Its not essential but have the same exact version, but something to keep in mind.

- In your terminal, cd into the folder you want to create the app. Then create the app:
git clone https://github.com/the-difference-engine/trisomy-families.git

- Create database: rake db:create

- Migrate database: rake db:migrate

- Troubleshooting postgres problems:
https://www.digitalocean.com/community/tutorials/how-to-use-roles-and-manage-grant-permissions-in-postgresql-on-a-vps--2
http://stackoverflow.com/questions/13573204/psql-could-not-connect-to-server-no-such-file-or-directory-mac-os-x

- Set up environment variables

- Install Image Magick: install Image Magic: brew install imagemagick
If you need extra help, refer to this page: https://github.com/thoughtbot/paperclip#requirements

- Run local server and verify application is running.

- Set up heroku servers:
https://docs.google.com/document/d/1Mlzv_yHtl_F1ph_-vf6VZhWs3B9-9kUDH46VBY3Fo7w/edit

- Trisomy Family heroku servers:
https://qa-svp-chicago.herokuapp.com/
https://demo-svp-chicago.herokuapp.com/
https://prod-svp-chicago.herokuapp.com/

- Run rspec test in terminal: rspec

# API Endpoint Reference V1.0

## Search

Search for physicians or trisomy families.

### Request
`GET /v1/search`

| Query Parameter | Value |
|---|---|
|  type | *Required.* Valid types are: **_physician_** and **_family_**. Accepts max. one type value|
| state | *Optional.* Only accepts abbr. state names. Example: IL |
| city | *Optional.* Example: Chicago |
| last_name | *Optional.* |
| speciality | *Optional.* Only valid for physician search types. Accepts max. one speciality value.|
| limit | *Optional.* The number of results to return. |

### Response

On success, response body contains an array of objects. If no matches are found, an empty array is returned.

On error, the header status code is an error code and the response body contains an error object.

Example:

```json
{
    "data": [
        {
            "attributes": {
                "address": "1 S. Cactus St.",
                "city": "Avon Lake",
                "first-name": "Lauryn",
                "last-name": "Ankunding",
                "latitude": -82.0282001,
                "link": "http://emard.co/josephine.adams",
                "longitude": 41.5053178,
                "phone-number": "14-236-5824",
                "speciality": "nesciunt",
                "state": "OH",
                "zip-code": "44012"
            },
            "id": "253",
            "type": "physician"
        }
    ]
}
```
