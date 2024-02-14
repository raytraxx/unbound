FROM alpine:latest

RUN apk update && \
	apk add --no-cache unbound drill bash && \
	rm -vrf /var/cache/apk/*

COPY unbound.conf /opt/unbound.conf
RUN unbound-anchor -a "/opt/root.key" || true

RUN chown -R unbound:unbound /opt

EXPOSE 53/tcp 53/udp

#HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]