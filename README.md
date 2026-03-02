LABORATORIO 1 – GESTIÓN DE PEDIDOS Y FACTURACIÓN EN RESTAURANTE
https://uninorte-my.sharepoint.com/:w:/g/personal/samuelpabuena_uninorte_edu_co/IQC3k-eAYKtZT4JiZQ7roj1WARcZD9IKm25SBHxUukPW2WE?e=Ws83IT

INFORMACIÓN GENERAL
Asignatura: Programación en Java
Lenguaje utilizado: Java (Processing - modo Java)
Tipo de persistencia: Archivos secuenciales (.txt)

---

OBJETIVO DEL PROYECTO

Desarrollar un sistema que permita administrar platos, mesas y pedidos de un restaurante utilizando archivos secuenciales para almacenar la información.

El proyecto busca aplicar:

* Análisis y diseño de software
* Manejo de archivos
* Validaciones
* Uso de estructuras de datos (ArrayList)
* Modularidad y organización del código

---

ARCHIVOS UTILIZADOS

Platos.txt
Mesas.txt
Pedidos.txt

Formato de almacenamiento:
campo1;campo2;campo3;...

---

ARQUITECTURA GENERAL

El sistema está organizado en:

1. Modelo

   * Clase Plato
   * Clase Mesa
   * Clase Pedido

2. Persistencia

   * Métodos para cargar datos desde archivo
   * Métodos para guardar datos en archivo

3. Lógica

   * Validaciones
   * Control de estados
   * Gestión de datos en memoria con ArrayList

4. Interfaz

   * Menú en consola (versión actual)
   * Futuro: implementación con interfaz gráfica

---

CHECKLIST DE REQUERIMIENTOS

REQUERIMIENTOS FUNCIONALES

[✓] RF1 - CRUD de Platos (Create y Read implementado)
[✓] RF2 - CRUD de Mesas (Create y Read implementado)
[✓] RF3 - Crear Pedido
[ ] RF4 - Agregar platos a un pedido
[ ] RF5 - Consultar pedido completo
[ ] RF6 - Cerrar pedido y generar factura
[ ] RF7 - Cancelar pedido
[ ] RF8 - Generar reportes
[✓] RF9 - Persistencia total en archivos

---

REQUERIMIENTOS NO FUNCIONALES

[✓] Validación de IDs duplicados
[✓] Validación de precio mayor a 0
[✓] Uso de ArrayList para manejo de datos
[✓] Manejo básico de archivo inexistente
[ ] Confirmaciones en operaciones críticas
[ ] Interfaz gráfica completa
[ ] Manejo robusto de excepciones (try-catch)
[ ] Separación completa por capas (modelo / lógica / persistencia / UI)

---

FUNCIONALIDADES IMPLEMENTADAS

* Crear plato
* Listar platos
* Crear mesa
* Listar mesas
* Crear pedido validando existencia de mesa
* Cambio automático de estado de mesa a OCUPADA
* Guardado automático en archivos

---

FUNCIONALIDADES PENDIENTES

* Actualizar y eliminar en CRUD
* Implementar archivo DetallePedido.txt
* Calcular subtotal automáticamente
* Generar archivo Facturas.txt
* Implementar reportes administrativos
* Mejorar interfaz gráfica
* Agregar validaciones avanzadas

---

ESTRUCTURAS DE DATOS UTILIZADAS

* ArrayList<Plato>
* ArrayList<Mesa>
* ArrayList<Pedido>

Las listas se cargan desde los archivos al iniciar el programa y se reescriben completamente al modificar datos.

---

CONCLUSIÓN

El sistema actual cumple con la base estructural del laboratorio, permitiendo la gestión inicial de platos, mesas y pedidos con persistencia en archivos.

La arquitectura implementada facilita la ampliación futura hacia facturación automática, generación de reportes y mejora de la experiencia de usuario.
