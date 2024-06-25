# Protectora de Animales - CRUD con JSP


![Perros](imagen)

Este repositorio contiene un proyecto de una protectora de animales desarrollado con JSP (JavaServer Pages). El sistema permite la gestión de perros y usuarios, ofreciendo funcionalidades tanto para los administradores como para los usuarios.

## Tecnologías utilizadas
- **JSP**: Para la creación de páginas web dinámicas.
- **MySQL**: Para la gestión de la base de datos.
- **Bootstrap**: Para el diseño y la estructura responsive de la interfaz de usuario.
- **Apache Tomcat**: Como servidor de aplicaciones para desplegar la aplicación JSP.
- **JavaScript**: Para la ejecución asincrona en los formularios.

## Funcionalidades del Proyecto

### Funcionalidades del Administrador

- **Gestión de Perros**:
  - Alta de nuevos perros.
  - Modificación de datos de perros existentes.
  - Baja de perros.
  - Barra de busqueda.
  
- **Gestión de Adopciones**:
  - Aceptación de solicitudes de adopción.
  - Visualización del estado de los perros (adoptados/no adoptados).
  - Barra de busqueda.

- **Gestión de Usuarios**:
  - Listado de usuarios registrados.
  - Modificar usuarios.
  - Barra de busqueda

- **Consultas**:
  - Consulta de las últimas adopciones.
  - Consulta de los últimos favoritos marcados por los usuarios.

### Funcionalidades del Usuario

- **Gestión de Favoritos**:
  - Marcar y desmarcar perros como favoritos.
  - Ver un listado de los perros favoritos marcados.

- **Gestión de Adopciones**:
  - Solicitar la adopción de perros disponibles.

- **Gestión de Perfil**:
  - Modificar datos personales en el perfil.

- **Consultas**:
  - Consulta de las últimas adopciones.
  - Consulta de los últimos favoritos.

## Detalles del Modelo de Datos

### Perros
- **Nombre**: Nombre del perro.
- **Imagen**: Imagen del perro.
- **Descripción**: Descripción del perro.
- **Fecha de Nacimiento**: Fecha de nacimiento del perro.
- **Raza**: Raza del perro.
- **Sexo**: Sexo del perro.
- **Peso**: Peso del perro.
- **Contador de Favoritos**: Número de veces que el perro ha sido marcado como favorito.
- **Estado de Adopción**: Indica si el perro ha sido adoptado. Los perros adoptados no pueden ser solicitados para adopción.

### Usuarios
- **Gestión de Perfil**: Los usuarios pueden modificar sus datos personales.
- **Favoritos**: Los usuarios pueden marcar y desmarcar perros como favoritos y ver el listado de sus favoritos.
- **Adopciones**: Los usuarios pueden solicitar la adopción de perros disponibles.

## Instalación y Configuración

1. **Clonar el repositorio**:
   ```sh
   git clone https://github.com/JMGella/protectora.git
   cd protectora
   ```

2. **Configurar la base de datos**:
   - Crear una base de datos MySQL.
   - Importar el archivo `database.sql` para crear las tablas necesarias.
   - Configurar el archivo `db.properties` con los detalles de la base de datos (usuario, contraseña, URL).

3. **Desplegar la aplicación**:
   - Configurar un servidor Apache Tomcat.
   - Desplegar la aplicación en el servidor.

4. **Acceder a la aplicación**:
   - Abrir el navegador y dirigirse a `http://localhost:8082/ActividadAprendizaje`.

## Contribución

1. Realiza un fork del proyecto.
2. Crea una rama con tu nueva funcionalidad (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza los commits necesarios (`git commit -m 'Agregada nueva funcionalidad'`).
4. Sube los cambios a tu fork (`git push origin feature/nueva-funcionalidad`).
5. Crea un Pull Request al repositorio principal.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---

¡Gracias por contribuir a la Protectora de Animales! Si tienes alguna duda o sugerencia, no dudes en abrir un issue o contactar conmigo.
