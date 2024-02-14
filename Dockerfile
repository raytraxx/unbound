FROM alpine:latest

RUN apk update && \
	apk add --no-cache unbound drill && \
	rm -vrf /var/cache/apk/*

WORKDIR /opt/unbound

RUN unbound-anchor -a "/opt/root.key" || true
RUN chown -R unbound:unbound /opt

EXPOSE 53/tcp 53/udp

#HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3  CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["unbound", "-c", "/opt/unbound/unbound.conf"]