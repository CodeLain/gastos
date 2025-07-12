
##  Requisitos

- Python 3.10+
- Node.js (para K6)
- entorno virtual
- Navegador Chromium (para tests Robot Framework con Browser)

---

## Instalación

1. Clonar el proyecto:

```bash
git clone https://github.com/CodeLain/gastos.git
cd gastos
```

2. Crear y activar entorno virtual:

```bash
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows
```

3. Instalar dependencias:

```bash
pip install -r requirements.txt
```

4. Migraciones y superusuario:

```bash
python manage.py migrate
python manage.py createsuperuser
```

5. Levantar el servidor:

```bash
python manage.py runserver
```

---

## 🧪 Testing

### ✅ Tests unitarios con Django

```bash
python manage.py test
```

Los tests se encuentran en `gastos/tests/`. Incluyen pruebas de vistas como `GastoListView`, `GastoCreateView`, entre otras.

---

### 🤖 Tests funcionales con Robot Framework

#### 1. Instalar dependencias

```bash
pip install robotframework
pip install robotframework-browser
rfbrowser init  # Instala navegadores
```

#### 2. Ejecutar tests

```bash
robot robot/tests/
```

Si se desea ejecutar un caso en particular:

- Login exitoso
- Crear gasto
- Editar gasto
- Cerrar sesión
- Crear categoría

Los archivos `.robot` están en la carpeta `tests/`.

---

### Pruebas de carga con K6

#### 1. Instalar K6

```bash
brew install k6  # macOS
choco install k6  # Windows
```

#### 2. Ejecutar prueba

```bash
k6 run loadTest2.js
k6 run loadTest.js
```

## Autores

- Federico Alberti, Gustavo Bertoletti, Rodrigo Torres
- GitHub: [CodeLain](https://github.com/CodeLain)

