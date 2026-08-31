# infrastructure

Infraestructura como código de la plataforma.

Piloto multicloud — AWS, Azure y GCP. Todavía no hay nada acá: este repo
arranca vacío a propósito.

## Estructura

```
archie/golden-paths/     caminos gobernados, exportados como Terraform real
                         (un directorio por componente + manifiesto de orden
                         y cableado). No editar a mano.
```

Cualquier IaC propio vive fuera de `archie/`, y nada de lo que exporte la
plataforma lo toca.

## Reglas de la organización

Pendientes de definir. No hay historia previa de la cual deducirlas —
hay que decidirlas.
