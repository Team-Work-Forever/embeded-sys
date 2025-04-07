ARG GO_VERSION=1.24.1
FROM --platform=$BUILDPLATFORM golang:${GO_VERSION} AS build

WORKDIR /src

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,source=go.mod,target=go.mod \
    --mount=type=bind,source=go.sum,target=go.sum \
    go mod download

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

COPY . .

RUN go generate ./...

RUN --mount=type=cache,target=/go/pkg/mod \
    CGO_ENABLED=1 GOOS=$TARGETOS GOARCH=$TARGETARCH GOARM=$TARGETVARIANT \
    go build -o /bin/server ./cmd/server/

FROM debian:bookworm-slim AS final

ARG UID=10001

RUN useradd \
  --uid "${UID}" \
  --system \
  --no-create-home \
  --shell /usr/sbin/nologin \
  appuser

RUN mkdir -p /app/www && chown -R appuser:appuser /app && chmod -R 755 /app

USER appuser

COPY --from=build /bin/server /app/

WORKDIR /app

ENTRYPOINT ["./server"]
