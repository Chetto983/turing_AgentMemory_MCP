# syntax=docker/dockerfile:1.7
FROM ghcr.io/ggml-org/llama.cpp:server-cuda@sha256:31b39eacce2bab5fde9286ec3980ed5548a3987644e94da0d0c2092f93313538

ENV HOME=/models \
    XDG_CACHE_HOME=/models/.cache \
    HF_HOME=/models/huggingface \
    LLAMA_CACHE=/models/llama.cpp \
    PYTHONPYCACHEPREFIX=/tmp/pycache

RUN groupadd --system --gid 10001 app \
    && useradd --system --uid 10001 --gid app --home-dir /models --shell /usr/sbin/nologin app \
    && mkdir -p /models /tmp /run \
    && chown -R app:app /models /tmp /run

USER app
