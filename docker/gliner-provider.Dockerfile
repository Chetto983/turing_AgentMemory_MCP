# syntax=docker/dockerfile:1.7
FROM python:3.14-slim@sha256:a2b82f3c48559aa0a8446d9af49826b6e2b2016f4cd2afabfe6013ec53729170

ENV HOME=/models \
    HF_HOME=/models/huggingface \
    XDG_CACHE_HOME=/models/.cache \
    PYTHONPATH=/app/src \
    PYTHONPYCACHEPREFIX=/tmp/pycache

RUN groupadd --system --gid 10001 app \
    && useradd --system --uid 10001 --gid app --home-dir /models --shell /usr/sbin/nologin app \
    && mkdir -p /app/src /models /tmp /run \
    && chown -R app:app /app /models /tmp /run

RUN --mount=type=cache,target=/root/.cache/pip \
    HOME=/root XDG_CACHE_HOME=/root/.cache \
    pip install --root-user-action=ignore "fast_gliner==0.2.1"

COPY src/ /app/src/
RUN chown -R app:app /app/src

USER app

EXPOSE 8080
ENTRYPOINT ["python", "-m", "turing_agentmemory_mcp.gliner_provider"]
