# Menu App

## Running in development with docker

```
docker compose build
docker compose run --rm web rails db:create db:migrate

docker compose up
```

Running specs

```
docker compose run --rm web rspec .
```

### API Routes

```
GET /menus
GET /menu_items
GET /restaurants
GET /restaurants/:id
POST /import
```

### Importing data

Create a JSON file with the scheme above:

```json
{
  "restaurants": [
    {
      "name": "Restaurant's name",
      "menus": [
        {
          "name": "Menu's name",
          "menu_items": [
            {
              "name": "Item's name",
              "price": 1.0
            }
          ]
        }
      ]
    }
  ]
}
```

Import file using CURL

```
curl -X POST http://localhost:3000/import \
  -F "file=@data.json"
```
