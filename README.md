# DevOps en vivo — Clase Arquitectura de Software · Utadeo 2026

Bienvenido. Este repo es tu punto de partida para las actividades de la clase.

## Lo que vas a hacer hoy

| Actividad | Qué aprenderás |
|---|---|
| **1 — Agregar un endpoint** | Cómo un cambio de código pasa por el pipeline y llega a "producción" |
| **2 — Romper el pipeline** | Por qué CI/CD existe: el robot bloquea código malo antes de que llegue a usuarios |

Todo desde el navegador. Sin instalar nada.

---

## Estructura del repo

```
src/index.js                    ← la app (aquí vas a agregar código)
tests/app.test.js               ← los tests automáticos
.github/workflows/ci-cd.yml     ← el pipeline (léelo, cada línea tiene comentarios)
Dockerfile                      ← cómo se empaca la app en un contenedor
k8s/deployment.yaml             ← cómo se despliega en Kubernetes (solo demo)
terraform/main.tf               ← infraestructura como código (solo demo)
```

---

## Actividad 1 — Agregar tu endpoint (Pipeline verde)

### Paso 1 — Haz fork de este repo

1. Arriba a la derecha: clic en **Fork** → **Create fork**
2. Ahora tienes tu propia copia del repo en tu cuenta

### Paso 2 — Abre el editor y agrega el endpoint

1. En tu fork, navega a `src/index.js`
2. Clic en el **lápiz** (Edit this file)
3. Busca el comentario que dice `ACTIVIDAD 1: agrega tu endpoint /aboutme aquí arriba`
4. Justo antes de ese comentario, agrega este bloque:

```js
if (req.url === '/aboutme') {
  res.statusCode = 200;
  res.end(JSON.stringify({
    nombre: 'TU NOMBRE AQUÍ',
    carrera: 'Arquitectura de Software',
    universidad: 'Utadeo',
    año: 2026
  }));
  return;
}
```

5. Personaliza el campo `nombre` con tu nombre real

### Paso 3 — Crea una rama y un Pull Request

1. Abajo, en lugar de "Commit directly to main", elige **"Create a new branch"**
2. Nómbrala: `feature/mi-aboutme`
3. Clic en **"Propose changes"**
4. En la siguiente pantalla: clic en **"Create pull request"**

### Paso 4 — Observa el pipeline

1. Ve a la pestaña **Actions** de tu repo
2. Verás el pipeline corriendo: Lint → Tests → Security → Build → Deploy
3. Espera ~2 minutos

**¿Todos los jobs están en verde?** → Haz merge del PR.

**¿Algún job está en rojo?** → Revisa el error, corrige el código, y haz commit en la misma rama. El pipeline corre de nuevo automáticamente.

### Cómo se ve el éxito

Después del merge, ve a Actions y verifica que el job **"5️⃣ Deploy a produccion"** corrió. Ese es el último eslabón de la cadena.

---

## Actividad 2 — Romper el pipeline (Pipeline rojo)

El objetivo: ver cómo CI/CD bloquea código malo antes de que llegue a producción.

### Paso 1 — Crea una rama con un bug

1. Ve a `tests/app.test.js`
2. Clic en el lápiz
3. En la rama que vas a crear, busca esta línea:
   ```js
   assert.strictEqual(res.statusCode, 200);
   ```
   (la primera que aparece, en el test de `GET /`)
4. Cámbiala por:
   ```js
   assert.strictEqual(res.statusCode, 999); // bug intencional
   ```
5. Crea una nueva rama: `demo/pipeline-roto`
6. Crea el Pull Request

### Paso 2 — Observa el pipeline rojo

En la pestaña **Actions** o en el PR verás:
- ✅ Job 1 (Lint): pasa
- ❌ Job 2 (Tests): **falla**
- ⏭️ Jobs 3, 4, 5: saltados

El código con el bug **no puede hacer merge**. El robot lo bloqueó.

### Paso 3 — Arregla el bug

1. En el mismo PR, ve al archivo `tests/app.test.js`
2. Clic en el lápiz
3. Vuelve a poner `200` en lugar de `999`
4. Commit en la misma rama `demo/pipeline-roto`
5. El pipeline corre de nuevo → ahora verde ✅
6. Haz merge

---

## Resultado final esperado

Al terminar las dos actividades, en la pestaña **Actions** de tu repo deberías ver al menos 3 ejecuciones del pipeline: una verde (Actividad 1), una roja (Actividad 2 antes del fix), y una verde final.

Eso es CI/CD funcionando en tu propio repositorio.
