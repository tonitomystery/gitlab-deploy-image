# gitlab-deploy

Imagen Docker ligera basada en Alpine 3.22 con `openssh-client`, `openssh-keygen`, `curl` y `bash` preinstalados, diseñada para pipelines de despliegue CI/CD en **GitLab**.

## Uso en GitLab CI

```yaml
deploy:
  stage: deploy
  image: yourusername/gitlab-deploy:latest
  script:
    - echo "Probando conexión SSH..."
    - ssh $EC2_USER@$EC2_HOST "echo 'SSH connection successful'"
    - echo "Desplegando en $EC2_USER@$EC2_HOST..."
    # ...resto de comandos de despliegue...
```

## Características

- Base Alpine Linux 3.22  
- Cliente SSH y herramientas de generación de claves  
- `curl` para descargas  
- `bash` como shell  

## Ejemplo completo de despliegue

```yaml
deploy:
  stage: deploy
  image: amaristany/gitlab-deploy:latest
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
        sudo unzip -o code.zip -d \$DEPLOY_PATH && 
        # ...resto del script de despliegue...
      "
```

## Ventajas

- No se instalan paquetes en cada ejecución del pipeline  
- Tiempos de CI/CD más rápidos  
- Entorno preconfigurado para despliegues SSH
deploy:
  stage: deploy
  image: yourusername/gitlab-deploy:latest
  needs:
    - build
  variables:
    GIT_STRATEGY: none
  script:
    - echo "Testing SSH connection..."
    - ssh $SSH_CONNECTION "echo 'SSH connection successful'"

    - echo "Deploying to $SSH_CONNECTION..."
    - scp -o StrictHostKeyChecking=no -v code.zip $SSH_CONNECTION:/tmp/
    - |
      ssh $SSH_CONNECTION "
        set -e &&
        echo 'Starting deployment...' &&
        cd /tmp &&
        sudo unzip -o code.zip -d $DEPLOY_PATH &&
        # ... rest of your deployment script
      "
```

The SSH setup is handled automatically by the container entrypoint.

## Benefits

- No more package installation on every deployment
- Faster CI/CD pipeline execution
- Pre-configured environment for SSH deployments
