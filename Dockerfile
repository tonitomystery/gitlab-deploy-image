FROM alpine:3.22

LABEL org.opencontainers.image.title="Alpine SSH"
LABEL org.opencontainers.image.description="Imagen Docker basada en Alpine Linux con soporte para SSH. Ideal para tareas de automatización, CI/CD y despliegue seguro."

RUN apk add --no-cache \
    openssh-client \
    openssh-keygen \
    curl \
    bash

RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]

