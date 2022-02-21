FROM nexus.in.ft.com:5000/membership/elixir-build:2.2.0 AS build

WORKDIR /build

COPY mix.exs .
COPY mix.lock .

ENV MIX_ENV=prod

RUN mix deps.get

COPY lib lib
COPY test test
COPY config config
COPY priv priv
COPY assets assets

RUN cd assets && npm install && npm run deploy
RUN mix phx.digest

RUN mix release

FROM alpine:latest

RUN apk --no-cache update && apk --no-cache upgrade && apk --no-cache add ncurses-libs openssl bash ca-certificates

RUN adduser -D app

ENV MIX_ENV=prod

WORKDIR /opt/app

COPY --from=build /build/_build/prod/rel/* ./

USER app

RUN mkdir /tmp/app
ENV RELEASE_MUTABLE_DIR /tmp/app
ENV START_ERL_DATA /tmp/app/start_erl.data

CMD ["/opt/app/bin/myapp", "foreground"]
