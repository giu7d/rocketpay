FROM elixir:1.12.2


RUN apt-get update && \
    apt-get install -y postgresql-client

WORKDIR /usr/app
COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

CMD ["mix", "phx.server"]