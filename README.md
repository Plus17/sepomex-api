# SepomexAPI

Simple API for Sepomex zip codes using [Sepomets](https://github.com/poncho/sepomets) under the hood.

## Try in local

1. Clone this repository
2. Go to the new dir `cd sepomex-api`
3. Install dependencies: `mix deps.get && mix deps.compile`
4. Run: `mix run --no-halt`

Now server is running at: `http://localhost:4001/`

## Build docker image

1. Build image: `docker build . --tag sepomex_api`
2. Run `docker images` to get the id of the new image.
3. Run: `docker run -p 8081:80 <image-id>`

Now docker image is running at: `http://localhost:8081/`

## Usage

Make a get request to service with the zip code:
`GET: http://localhost:8081/zip_code?zip_code=03100`

```shell
❯ curl "http://localhost:8081/zip_code?zip_code=03100" | jq --indent 2
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   630  100   630    0     0   205k      0 --:--:-- --:--:-- --:--:--  205k
[
  {
    "city": {
      "code": "03",
      "name": "Ciudad de México"
    },
    "municipality": {
      "code": "014",
      "name": "Benito Juárez"
    },
    "office": "03001",
    "postal_code": "03100",
    "settlement": {
      "code": "0496",
      "name": "Del Valle Centro"
    },
    "settlement_type": {
      "code": "09",
      "name": "Colonia"
    },
    "state": {
      "code": "09",
      "name": "Ciudad de México"
    },
    "zone": "Urbano"
  },
  {
    "city": {
      "code": "03",
      "name": "Ciudad de México"
    },
    "municipality": {
      "code": "014",
      "name": "Benito Juárez"
    },
    "office": "03001",
    "postal_code": "03100",
    "settlement": {
      "code": "2624",
      "name": "Insurgentes San Borja"
    },
    "settlement_type": {
      "code": "09",
      "name": "Colonia"
    },
    "state": {
      "code": "09",
      "name": "Ciudad de México"
    },
    "zone": "Urbano"
  }
]
```

![image](https://user-images.githubusercontent.com/8551125/153260672-cc7e7b7a-e6cc-4cd4-897f-3cf0a300effa.png)
