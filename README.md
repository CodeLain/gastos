
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
python -m venv venv (dependiendo de la instalacion de python puede tener que ejecutar python3 -m venv venv)
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

5. Levantar el servidor y proyecto en si, el mismo queda disponible en http://127.0.0.1:8000/:

```bash
python manage.py runserver (recordatorio dependiendo de la instalacion de python puede ser python3 en vez de python, ej: python3 manage.py runserver)
```

---

##  Testing

### Tests unitarios con Django

```bash
python manage.py test gastos.tests --verbosity=2 (por lo anterior puede ser: python3 manage.py test gastos.tests --verbosity=2)
```

Los tests se encuentran en `gastos/tests/`

---

### Tests funcionales con Robot Framework

Se debe ejecutar el test tc0_init_user.robot para crear el usuario inicial, robot robot/resources/tc0_init_user.robot

Luego de ejecutados se deben eliminar los datos generados por los tests mediante:
- ingresar en http://127.0.0.1:8000/admin/ (visor web de la base de datos)
- loguearse con el superuser creado en 4. Migraciones y superusuario
- ingresar en Users, Categorias, Gastos. Seleccionar todo y en Action seleccionar Delete selected y presionar Go
- confirmar

#### 1. Instalar dependencias, por favor no olvidar rfbrowser init

```bash
pip install robotframework
pip install robotframework-browser
rfbrowser init  # Instala navegadores
```

#### 2. Ejecutar tests recordar ejecutar robot robot/resources/tc0_init_user.robot y luego de ejecutados borrar con los pasos mencionados anteriormente

```bash
robot robot/tests/
```

Si se desea ejecutar un caso en particular pero recordar que tienen dependencia de tc0_init_user.robot:

- robot robot/tests/tc0_init_user.robot
- robot robot/tests/tc001.robot
- robot robot/tests/tc002.robot
- robot robot/tests/tc006.robot
- robot robot/tests/tc009.robot
- robot robot/tests/tc010.robot
- robot robot/tests/tc012.robot
- robot robot/tests/tc015.robot

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

