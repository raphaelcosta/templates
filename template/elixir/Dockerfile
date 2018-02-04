FROM elixir:1.6.1-alpine

# Alternatively use ADD https:// (which will not be cached by Docker builder)
RUN apk --no-cache add curl \
    && echo "Pulling watchdog binary from Github." \
    && curl -sSL https://github.com/openfaas/faas/releases/download/0.6.9/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog \
    && apk del curl --no-cache

WORKDIR /root/

COPY mix.exs            .
COPY lib                .
COPY config             .
COPY function           lib/function
RUN mix deps.get
RUN MIX_ENV=prod mix compile

WORKDIR /root/function/

WORKDIR /root/
ENV fprocess="mix run -e \"Faas.run\""
HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
