# docker-deploy-base

Imagen Docker ligera basada en Alpine 3.22 con `openssh-client` y `curl` preinstalados, diseñada para pipelines de despliegue CI/CD.

## Uso

En tu archivo de CI/CD (ejemplo GitLab):

```yaml
deploy:
  stage: deploy
  image: TU_USUARIO/docker-deploy-base:latest
  script:
    - # comandos de despliegue aquí
