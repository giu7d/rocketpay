# Rocketpay

To use this software with `docker-compose` use:

First we need to build our Docker image:

```bash
$ docker-compose build
```

**If you don't have the database setup yet**, run this before starting the application. The command will create the database and update the migrations only if needed.

```
$ docker-compose run app mix ecto.setup
```

To start the application:

```
$ docker-compose up
```
