# SepomexAPI

Simple API for Sepomex zip codes using [Sepomets](https://github.com/poncho/sepomets) under the hood.

You can see this at: https://sepomex-api.gigalixirapp.com/

Only for reference.

## Requirements

1. [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)
    - [asdf-erlang plugin](https://github.com/asdf-vm/asdf-erlang)
    - [asdf-elixir plugin](https://github.com/asdf-vm/asdf-elixir)
2. [Docker](https://www.docker.com/products/docker-desktop) (optional)

You can run `asdf install` in the root folder of the project to install the required versions of Erlang and Elixir defined in the `.tool-versions` file.
## Run in local

1. Clone this repository `git clone git@github.com:Plus17/sepomex-api.git`
2. Go to the project dir `cd sepomex-api`
3. Install dependencies: `mix deps.get && mix deps.compile`
4. Run: `mix run --no-halt`

Now server is running at: `http://localhost:4001/`

## Build docker image

1. Build image: `docker build . --tag sepomex_api`
2. Run `docker images` to get the id of the new image.
3. Run: `docker run --env PORT=80 -p 8081:80 <image-id>`

Now docker image is running at: `http://localhost:8081/`

## Usage

Make a get request to service with the zip code:
`GET: http://localhost:8081/03100`

```shell
❯ curl "http://localhost:8081/03100" | jq --indent 2
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

![image](https://user-images.githubusercontent.com/8551125/181606708-1c077806-4ae3-46da-bb93-f4f566c77929.png)

## How to update the zip codes database

1. Download the last database in **TXT** format from [correosdemexico.gob.mx](https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/CodigoPostal_Exportar.aspx)
2. Rename the file to `sepomex.zip`
3. Replace the file in `priv/sepomex.zip`
3. Deploy
