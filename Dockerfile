FROM golang:1.24.5-alpine3.22 AS builder

RUN apk add --no-cache git

WORKDIR /build
RUN git clone --branch v1.70.3 --depth 1 https://github.com/rclone/rclone.git && \
  cd rclone && \
  go build -trimpath -ldflags="-s -w" -o /rclone 

FROM gcr.io/distroless/static-debian12

COPY --from=builder /rclone /rclone

ENV RCLONE_CONFIG=/config/rclone/rclone.conf

USER nonroot
ENTRYPOINT ["/rclone"]
CMD ["--version"]

