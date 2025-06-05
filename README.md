# alpine-ssh-deploy

Imagen Docker ligera basada en Alpine 3.22 con `openssh-client`, `openssh-keygen`, `curl` y `bash` preinstalados, diseñada para pipelines de despliegue CI/CD.

## Características

- Base Alpine Linux 3.22  
- Cliente SSH y herramientas de generación de claves  
- `curl` para descargas  
- `bash` como shell  
- Disponible en Docker Hub con compilación automática desde GitHub

## Ejemplo completo de despliegue

```yaml
deploy:
  stage: deploy
  image: amaristany/alpine-ssh:latest
  needs:
    - build
  variables:
    GIT_STRATEGY: none
  script:
    - echo "Probando conexión SSH..."
    - ssh $SSH_CONNECTION "echo 'SSH connection successful'"

    - echo "Desplegando en $SSH_CONNECTION..."
    - scp -o StrictHostKeyChecking=no -v code.zip $SSH_CONNECTION:/tmp/
    - |
      ssh $SSH_CONNECTION "
        set -e &&
        echo 'Iniciando despliegue...' &&
        cd /tmp &&
        sudo unzip -o code.zip -d /ruta/de/despliegue &&
        # ...resto del script de despliegue...
      "
```

## Ventajas

- No se instalan paquetes en cada ejecución del pipeline  
- Tiempos de CI/CD más rápidos  
- Entorno preconfigurado para despliegues SSH
- Compilación automática desde GitHub Actions
- Disponible en múltiples arquitecturas (amd64, arm64)

## GitHub Actions

Este repositorio usa GitHub Actions para:
- Compilar la imagen Docker automáticamente
- Publicar en Docker Hub con cada push a main
- Crear tags con el SHA del commit para versionado
## Benefits

- No more package installation on every deployment
- Faster CI/CD pipeline execution
- Pre-configured environment for SSH deployments
