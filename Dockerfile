FROM debian:bookworm-slim

WORKDIR /app
ENV PATH="/usr/games:${PATH}"

RUN useradd -m -u 1001 appuser

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fortune-mod \
        fortunes \
        cowsay \
        netcat-openbsd \
        && rm -rf /var/lib/apt/lists/*

COPY wisecow.sh ./wisecow.sh
RUN chmod +x wisecow.sh && chown -R appuser:appuser /app

USER appuser

CMD ["./wisecow.sh"]
